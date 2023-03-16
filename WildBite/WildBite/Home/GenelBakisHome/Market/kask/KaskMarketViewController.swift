//
//  MarketViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 14.03.2023.
//
import UIKit
import CoreData

let myMarketKaskAppDellegate = UIApplication.shared.delegate as! AppDelegate
class KaskMarketViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let myContext = myMarketKaskAppDellegate.persistentContainer.viewContext
    var marketInfo = [Market]()
    var userInfo = [Users]()
    var gosterilenKaskSayisi = 0
    var userLevel = 0
    var userGoldu = 0
    var satinAlinmisKask = ""
    let loginUserName = UserDefaults.standard.string(forKey: "GirisYapanKullanici")
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    
    
    @IBOutlet weak var myNavigationRightBaritem: UIBarButtonItem!
    
    @IBOutlet weak var myNavigationItem: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Debug: MarketViewController viewDidLoad run  ")
        do{
            marketInfo = try myContext.fetch(Market.fetchRequest())
            userInfo = try myContext.fetch(Users.fetchRequest())
            myTableView.delegate = self
            myTableView.dataSource = self
            print("Debug: MarketViewController viewDidLoad Market.fetchRequest run ")
        }catch{
            print("Debug: MarketViewController viewDidLoad Market.fetchRequest not run ")
            return
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("Debug: MarketViewController viewWillAppear run  ")
        for i in userInfo{
            if(i.userName == loginUserName){
                gosterilenKaskSayisi = Int(i.userLevel)
                userLevel = Int(i.userLevel)
                userGoldu = Int(i.userGold)
                satinAlinmisKask = i.useritemKaskName!.replacingOccurrences(of: ".png", with: "")
                myNavigationRightBaritem.title = "💰PARA: \(i.userGold)"
            }
        }
        for i in marketInfo{
            print("Kask adlari \(String(describing: i.marketKaskName))")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Debug: MarketViewController viewDidAppear run  ")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Debug: MarketViewController market  tablosu marketInfo.count \(marketInfo.count)")
        
        //return gosterilenKaskSayisi
        return 27
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! KaskMarketTableViewCell
        if(marketInfo[indexPath.row].marketKaskName != nil){
            cell.myLabel.text = "\(marketInfo[indexPath.row].marketKaskName!.replacingOccurrences(of: ".png", with: ""))"
            cell.myKaskImageView.image = UIImage(named: marketInfo[indexPath.row].marketKaskName!)
            cell.myGucLabel.text = "Güç: \(marketInfo[indexPath.row].marketKaskGuc)"
            cell.mySavunmaLabel.text = "Savunma: \(marketInfo[indexPath.row].marketKaskSavunma)"
            cell.myFiyatLabel.text = "Fiyat: \(marketInfo[indexPath.row].marketKaskParasi)"
            cell.myKaskArtisiLabel.text = "(+\(marketInfo[indexPath.row].marketKaskArtisi))"
            cell.myGerekliSeviyeLAbel.text = "Gerekli Seviye: \(marketInfo[indexPath.row].marketKaskLeveli)"
            if(userLevel >= marketInfo[indexPath.row].marketKaskLeveli && userGoldu >= marketInfo[indexPath.row].marketKaskParasi ){
                cell.satinAlmaLabel.text = "SATIN AL"
                
                cell.satinAlmaLabel.textColor = .systemGreen
                print("user level \(userLevel)")
                print("kask level \(marketInfo[indexPath.row].marketKaskLeveli)")
            }else{
                
                cell.satinAlmaLabel.text = "SATIN AL"
                
                cell.satinAlmaLabel.textColor = .systemGray
                print("userNot level \(userLevel)")
                print("kaskNot level \(marketInfo[indexPath.row].marketKaskLeveli)")
                
            }
            let satirdakiKaskAdi = marketInfo[indexPath.row].marketKaskName!.replacingOccurrences(of: ".png", with: "")
            if(satinAlinmisKask == satirdakiKaskAdi){
               
                cell.satinAlmaLabel.text = ""
                cell.myLabel.textColor = .systemGray
                cell.myLabel.text = "\(marketInfo[indexPath.row].marketKaskName!.replacingOccurrences(of: ".png", with: ""))(sahipsin)"
                cell.myGerekliSeviyeLAbel.text = ""
                cell.myFiyatLabel.text = ""
                
                
                
                
            }
            
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(marketInfo[indexPath.row].marketKaskName as Any)
        let alert = UIAlertController(title: "\(marketInfo[indexPath.row].marketKaskName!.replacingOccurrences(of: ".png", with: "").uppercased()) SATIN ALINSIN MI ? ", message: "Fiyatı: \(marketInfo[indexPath.row].marketKaskParasi) 💰", preferredStyle: .actionSheet)
      
        
        let tamamButonu = UIAlertAction(title: "Evet", style: .default) { [self] UIAlertAction in
            print("Evet")
            
            for i in userInfo {
                if(i.userName == loginUserName ){
                    i.userGold -= marketInfo[indexPath.row].marketKaskParasi
                    i.useritemKaskName = marketInfo[indexPath.row].marketKaskName!
                    i.useritemKaskArtisi = marketInfo[indexPath.row].marketKaskArtisi
                    i.useritemKaskGuc = marketInfo[indexPath.row].marketKaskGuc
                    i.useritemKaskSavunma = marketInfo[indexPath.row].marketKaskSavunma
                    self.performSegue(withIdentifier: "kaskToHome", sender: nil)
            
                    appDelegate.saveContext()
                }
            }

        }
        
        alert.addAction(tamamButonu)
        let hayirButonu = UIAlertAction(title: "Hayır", style: .default) { UIAlertAction in
            print("Hayir")
        }
        
        alert.addAction(hayirButonu)
        let satinAlinmaSirasindaKaskAdi = marketInfo[indexPath.row].marketKaskName!.replacingOccurrences(of: ".png", with: "")
        
        if(userLevel >= marketInfo[indexPath.row].marketKaskLeveli && userGoldu >= marketInfo[indexPath.row].marketKaskParasi  && satinAlinmisKask !=  satinAlinmaSirasindaKaskAdi ){
            present(alert,animated: true, completion: nil)
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    /*
     
     
     myContext.delete(i)
     appDelegate.saveContext()
     
     //----------------
     
     user.userGold = 100
     
     appDelegate.saveContext()
     */
}
