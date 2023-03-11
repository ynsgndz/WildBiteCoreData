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
    
    @IBOutlet weak var myUserNameTextField: UITextField!
    
    @IBOutlet weak var myUserPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
         veriOkuma()
        
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
            print(" Kisi ad : \(String(describing: i.userName)) Gold :  \(i.userGold)")
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
            if(i.userName == "admin"){
                i.userGold = 1000000
                i.userPow = 1000
                i.userDef = 1000
                i.userEnergy = 1000
                i.userLevel = 99
                i.userMaxHp = 1000000
                i.userCurrentHp = 1000000
                
                appDelegate.saveContext()
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

 
