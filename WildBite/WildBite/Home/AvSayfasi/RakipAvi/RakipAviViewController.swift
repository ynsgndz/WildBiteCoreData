//
//  RakipAviViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 12.03.2023.
//

import UIKit
import CoreData

let appRakipAviDelegate = UIApplication.shared.delegate as! AppDelegate
class RakipAviViewController: UIViewController {
    @IBOutlet weak var myUyariLabel: UILabel!
    var loginUserName = UserDefaults.standard.string(forKey: "GirisYapanKullanici")
    var myRage = ""
    let myContext = appRakipAviDelegate.persistentContainer.viewContext
   var userInfo = [Users]()
    
    @IBOutlet weak var myRakipPicture: UIImageView!
    
    @IBOutlet weak var myRakipTurAdiLabel: UILabel!
    @IBOutlet weak var myRakipLevelLabel: UILabel!
    
    
    @IBOutlet weak var myRakipHasarOraniLabel: UILabel!
    
    @IBOutlet weak var myRakipGucLabel: UILabel!
    
    @IBOutlet weak var myRakipSavunmaLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        print("Debug: RakipAviViewController viewWillAppear calisti")
        veriOkuma()
        
        for i in userInfo{
            if(i.userName == loginUserName){
                myRage = i.userRace ?? "none"
           
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("Debug: RakipAviViewController viewDidAppear calisti")
        rakipSecme()
    }
    func rakipSecme(){
        let randomNumber = Int.random(in: 0..<userInfo.count)
        print("Debug: RakipAviViewController  olusan Random Number \(randomNumber)")
        
        if(userInfo[randomNumber].userRace != myRage){
            myRakipTurAdiLabel.text = "\(String(describing: userInfo[randomNumber].userRace!)) \(String(describing: userInfo[randomNumber].userName!))"
            myRakipLevelLabel.text = "Level: \(userInfo[randomNumber].userLevel)"
            var rakipHasarOrani = userInfo[randomNumber].userPow + userInfo[randomNumber].userMaxHp + userInfo[randomNumber].userDef
            myRakipHasarOraniLabel.text = "Hasar Oranı: \(rakipHasarOrani)"
            myRakipGucLabel.text = "Güç: \(userInfo[randomNumber].userPow)"
            myRakipSavunmaLabel.text = "Savunma: \(userInfo[randomNumber].userDef)"
            myRakipPicture.image = UIImage(named: userInfo[randomNumber].userProfilResmi!)
            
            
            // savunma alani -
        var savunanHasarOrani =  userInfo[randomNumber].userPow + userInfo[randomNumber].userMaxHp + userInfo[randomNumber].userDef
        
        UserDefaults.standard.set(userInfo[randomNumber].userName, forKey: "savunanUserName")
        UserDefaults.standard.set(savunanHasarOrani, forKey: "savunanHasarOrani")
        UserDefaults.standard.set(userInfo[randomNumber].userMaxHp, forKey: "savunanMaxHp")
        UserDefaults.standard.set(userInfo[randomNumber].userCurrentHp, forKey: "savunanCurrentHp")
        UserDefaults.standard.set(userInfo[randomNumber].userPow, forKey: "savunanGuc")
        UserDefaults.standard.set(userInfo[randomNumber].userDef, forKey: "savunanDefans")
        UserDefaults.standard.set(userInfo[randomNumber].userGold, forKey: "savunanAltin")
        UserDefaults.standard.set(userInfo[randomNumber].userExp, forKey: "savunanTecrube")
           
            
            // savunma alani -
        }else{
            rakipSecme()
        }
        
    }
    func veriOkuma(){
        do {
            userInfo = try myContext.fetch(Users.fetchRequest())
            for i in userInfo{
                print("Username : \(i.userName!) Pass: \(String(describing: i.userPassword!))  Level : \(i.userLevel)  Exp : \(i.userExp) Tür : \(String(describing: i.userRace!)) Güç : \(i.userPow) Defans : \(i.userDef) Altin : \(i.userGold) Hp : \(i.userCurrentHp) /\(i.userMaxHp)  Enerji : \(i.userEnergy)/\(i.userEnergyMax)")
               // sadece verileri cektik
             
            }
        }catch{
            print("Debug: RakipAviViewController  Rakip okunamadi ! ")
        }
        print(userInfo.count)
        
    }
     
       
        
     
     
    @IBAction func mySaldirButton(_ sender: Any) {
        for i in userInfo{
            if(i.userName == loginUserName){
                if(i.userEnergy>10 && i.userCurrentHp >= 0){
                    i.userEnergy -= 10
                    myAppDelegate.saveContext()
                   
                    self.performSegue(withIdentifier: "rakibeSaldir", sender: nil)
                    myUyariLabel.text = "Enerjiniz : \(i.userEnergy)"
                    myUyariLabel.textColor = .systemGreen
                        // saldiri alani -
                    let saldiranHasarOrani = i.userPow + i.userMaxHp + i.userDef
                    
                    UserDefaults.standard.set(i.userName, forKey: "saldiranUserName")
                    UserDefaults.standard.set(saldiranHasarOrani, forKey: "saldiranHasarOrani")
                    UserDefaults.standard.set(i.userMaxHp, forKey: "saldiranMaxHp")
                    UserDefaults.standard.set(i.userCurrentHp, forKey: "saldiranCurrentHp")
                    UserDefaults.standard.set(i.userPow, forKey: "saldiranGuc")
                    UserDefaults.standard.set(i.userDef, forKey: "saldiranDefans")
                    UserDefaults.standard.set(i.userGold, forKey: "saldiranAltin")
                    UserDefaults.standard.set(i.userExp, forKey: "saldiranTecrube")

                        // saldiri alani -
                
                }else{
                    myUyariLabel.text = "Yetersiz:  Enerji(\(i.userEnergy)) veya Can(\(i.userCurrentHp))"
                    myUyariLabel.textColor = .systemRed
                }
              
            }
        }
    }
    
    
    @IBAction func myYenidenAraButton(_ sender: Any) {
        for i in userInfo{
            if(i.userName == loginUserName){
                if(i.userEnergy>0){
                    i.userEnergy -= 1
                    myAppDelegate.saveContext()
                    rakipSecme()
                    myUyariLabel.text = "Enerjiniz : \(i.userEnergy)"
                    myUyariLabel.textColor = .systemGreen
                }else{
                    myUyariLabel.text = "Arama için Enerjiniz yetersiz: \(i.userEnergy)"
                    myUyariLabel.textColor = .systemRed
                }
              
            }
        }
        
    }
    
}
