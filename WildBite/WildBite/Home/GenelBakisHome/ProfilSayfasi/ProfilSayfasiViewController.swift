//
//  ProfilSayfasiViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 11.03.2023.
//

import UIKit
import CoreData

let profilSayfasiAppDelegate = UIApplication.shared.delegate as! AppDelegate
class ProfilSayfasiViewController: UIViewController {
   
    // MARK: - Variable
    let myContext = profilSayfasiAppDelegate.persistentContainer.viewContext
    var userInfo = [Users]()
    var  loginUserName = UserDefaults.standard.string(forKey: "GirisYapanKullanici")
    var userSaldiriOrani = 0
    @IBOutlet weak var myToplamGelirLabel: UILabel!
    @IBOutlet weak var userToplamSavasLabel: UILabel!
    @IBOutlet weak var userToplamGalibiyetLabel: UILabel!
    @IBOutlet weak var myToplamYenilgiLabel: UILabel!
    @IBOutlet weak var myToplamInsanAviLabel: UILabel!
    @IBOutlet weak var myToplamCanLabel: UILabel!
    @IBOutlet weak var myTecrubeLabel: UILabel!
    
    
    // güç
    @IBOutlet weak var myToplamGucLabel: UILabel!
    @IBOutlet weak var myGucArttirButtonLabel: UIButton!
    @IBOutlet weak var myGucArttirGoldLabel: UILabel!
    
    // savunma
    @IBOutlet weak var myToplamSavunmaLabel: UILabel!
    @IBOutlet weak var mySavunmaArttirButtonLabel: UIButton!
    @IBOutlet weak var mySavunmaArttirGoldLabel: UILabel!
    
    
    // MARK: - Lifecycle

      override func viewDidLoad() {
          super.viewDidLoad()
          print("viewDidLoad: ilk ve bir kez sayfa yuklendi")
          veriOkuma()
      }
      
      override func viewWillAppear(_ animated: Bool) {
          print("viewWillAppear: sayfa goruntulenicek")
           loginUserName = UserDefaults.standard.string(forKey: "GirisYapanKullanici")
          veriOkuma()
      }
      
      override func viewDidAppear(_ animated: Bool) {
          print("viewDidAppear: sayfa goruntulendi")
      }
      override func viewWillDisappear(_ animated: Bool) {
          print("viewWillDisappear: bu sayfadan cikildi baska sayfaya tiklandi yani")
      }
      deinit {
          print("deinit: Uygulama Kapatildi")
      }
      
    // MARK: - functions

    func veriOkuma(){
        do {
          
            userInfo = try myContext.fetch(Users.fetchRequest())
        }catch{
            print("Kişileri okuyamadı !")
            return
        }
        
       
        for i in userInfo {
            if(i.userName == loginUserName){
                print("Username : \(i.userName!)  Level : \(i.userLevel)  Exp : \(i.userExp) Tür : \(String(describing: i.userRace!)) Güç : \(i.userPow) Defans : \(i.userDef) Altin : \(i.userGold) Hp : \(i.userMaxHp) Enerji : \(i.userEnergy)")
                userSaldiriOrani = Int((i.userPow * 30) + (i.userDef * 15 ) + (i.userLevel * 100))
                myToplamGelirLabel.text = "💰 Toplam Gelir : \(i.userToplamGelir) "
                userToplamSavasLabel.text = "⚔️ Savaş : \(i.userToplamSavas)  "
                userToplamGalibiyetLabel.text = "😀 Galibiyet : \(i.userToplamGalibiyet) "
                myToplamYenilgiLabel.text = "😡 Yenilgi : \(i.userToplamYenilgi) "
                myToplamInsanAviLabel.text = "👁️ İnsan Avı : \(i.userToplamInsanAvi) "
                myToplamCanLabel.text = "❤️ Can : \(i.userCurrentHp) / \(i.userMaxHp) "
                //tecrube
                let tecrubeMax = i.userLevel * 100
                let tecrubeCur = i.userExp % (tecrubeMax)
                myTecrubeLabel.text = "🎖️ Tecrübe : \(tecrubeCur) / \(tecrubeMax) "
                myToplamGucLabel.text = "💪 Güç : \(i.userPow) "
                myToplamSavunmaLabel.text = "🛡️ Savunma : \(i.userDef) "
             
                myGucArttirGoldLabel.text = "(\(i.userGold) / \(userSaldiriOrani)) Altın"
                mySavunmaArttirGoldLabel.text = "(\(i.userGold) / \(userSaldiriOrani)) Altın"
                
                
                if(i.userGold >= userSaldiriOrani){
                    myGucArttirButtonLabel.tintColor = .systemGreen
                    myGucArttirGoldLabel.textColor = .systemGreen
                    mySavunmaArttirButtonLabel.tintColor = .systemGreen
                    mySavunmaArttirGoldLabel.textColor = .systemGreen
                    myGucArttirButtonLabel.isEnabled = true
                    mySavunmaArttirButtonLabel.isEnabled = true
                }else{
                    myGucArttirButtonLabel.tintColor = .systemRed
                    myGucArttirGoldLabel.textColor = .systemRed
                    mySavunmaArttirButtonLabel.tintColor = .systemRed
                    mySavunmaArttirGoldLabel.textColor = .systemRed
                    myGucArttirButtonLabel.isEnabled = false
                    mySavunmaArttirButtonLabel.isEnabled = false
                }

            }else {
                print("uygulamadan cik la")
            }
          
          
        
        }
    }
 
    @IBAction func myGucArttirButton(_ sender: Any) {
         
        for i in userInfo {
            if(i.userName == loginUserName){
                if(i.userGold < userSaldiriOrani){
                    myGucArttirButtonLabel.isEnabled = false
                }else{
                    myGucArttirButtonLabel.isEnabled = true
                    i.userPow += 1
                    i.userGold -= Int32(userSaldiriOrani)
                    i.userLevel = ( i.userExp / 100) + 1
                    myAppDelegate.saveContext()
                    veriOkuma()
                }
               
            }
            
          
        }
        
        
        print("--Guc artti")
         
    }
    @IBAction func myDefansArttirButton(_ sender: Any) {
        
        for i in userInfo {
            if(i.userName == loginUserName){
                if(i.userGold < userSaldiriOrani){
                    mySavunmaArttirButtonLabel.isEnabled = false
                }else{
                    mySavunmaArttirButtonLabel.isEnabled = true
                    i.userDef += 1
                    i.userGold -= Int32(userSaldiriOrani)
                    i.userLevel = ( i.userExp / 100) + 1
                    myAppDelegate.saveContext()
                    veriOkuma()
                }
            }
           
        }
        
        
        print("--Defans artti")
    }
    
}
