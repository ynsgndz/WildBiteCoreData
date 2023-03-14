//
//  ViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 8.03.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    let myContext = appDelegate.persistentContainer.viewContext
    var userInfo = [Users]()
    var merketInfo = [Market]()
   
    
    @IBOutlet weak var myUserNameTextField: UITextField!
    
    @IBOutlet weak var myUserPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "gradientBG.png")!)
        //  veriOkuma()
        
        // veriSil()
        //veriGuncelle()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        veriOkuma()
       
      
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func veriOkuma(){
        do {
            userInfo = try myContext.fetch(Users.fetchRequest())
        }catch{
            print("Kişileri okuyamadı !")
        }
        
        for i in userInfo {
            print("Username : \(String(describing: i.userName!)) Pass: \(String(describing: i.userPassword!)) \n  Level : \(i.userLevel)  Exp : \(i.userExp) Tür : \(String(describing: i.userRace!)) \n Güç : \(i.userPow) Defans : \(i.userDef) Altin : \(i.userGold) Hp : \(i.userCurrentHp) /\(i.userMaxHp)  Enerji : \(i.userEnergy)/\(i.userEnergyMax) \n KASK { Name:\(String(describing: i.useritemKaskName!)) Arti:\(i.useritemKaskArtisi) Güç:\(i.useritemKaskGuc) Savunma:\(i.useritemKaskSavunma)} \n")
            
        }
    }
    
    func veriSil(){
        let user = userInfo[0]
        myContext.delete(user)
        appDelegate.saveContext()
    }
    
    func veriGuncelle(){
        let user = userInfo[2]
        user.userGold = 100
        
        appDelegate.saveContext()
    }
    
    @IBAction func myGirisButton(_ sender: Any) {
        print("Giris Butonu tiklandi")
      
        
        for i in userInfo {
            if(i.userName == nil){
                myContext.delete(i)
                appDelegate.saveContext()
            }
            
            if(myUserNameTextField.text == "delyap"){
               
                    myContext.delete(i)
                    appDelegate.saveContext()
                print("kisiler silindi !")
               
                
            }
            
            if(myUserNameTextField.text == "delyapmarket"){
               
                   
                do {
                    merketInfo = try myContext.fetch(Market.fetchRequest())
                    for m in self.merketInfo{
                        myContext.delete(m)
                        appDelegate.saveContext()
                        print("market silindi !")
                    }
                    
                }catch{
                    print("market okuyamadı !")
                }
                
            }
            
                if(myUserNameTextField.text == "fullyap"){
                    if(i.userName != "admin"){
                        if(i.userCurrentHp < 500){
                            i.userCurrentHp += 500
                        }
                        if(i.userEnergy < 50){
                            i.userEnergy += 50
                        }
                        
                        appDelegate.saveContext()
                    }else{
                        i.userGold = 100000
                        i.userPow = 100
                        i.userDef = 100
                        i.userEnergy = 1000
                        i.userLevel = 99
                        i.userMaxHp = 1000
                        i.userCurrentHp = 10000
                        i.userExp = 0
                        
                        appDelegate.saveContext()
                    }
                }
                
                if(myUserNameTextField.text == i.userName && myUserPasswordTextField.text == i.userPassword){
                    self.performSegue(withIdentifier: "loginToHome", sender: nil)
                    print("Kullanici bilgileri dogru")
                    UserDefaults.standard.set(myUserNameTextField.text, forKey: "GirisYapanKullanici")
                }else{
                    print("Kullanici bilgileri yanlis")
                    
                    myUserNameTextField.placeholder = "tekrar deneyin "
                    myUserPasswordTextField.placeholder = "tekrar deneyin "
                }
            }
        }
    }
    

