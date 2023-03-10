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

    let context = appDelegate.persistentContainer.viewContext
    var userInfo = [Users]()
    
    @IBOutlet weak var myUserNameTextField: UITextField!
    
    @IBOutlet weak var myUserPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
         veriOkuma()
        
        // veriSil()
        // veriGuncelle()
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func veriOkuma(){
        do {
            userInfo = try context.fetch(Users.fetchRequest())
        }catch{
            print("Kişileri okuyamadı !")
        }
        
        for i in userInfo {
            print(" Kisi ad : \(i.userName!)")
        }
    }
    
    func veriSil(){
        let user = userInfo[0]
        context.delete(user)
        appDelegate.saveContext()
    }
    
    func veriGuncelle(){
        let user = userInfo[0]
        user.userName = "Zeynep İrem ADIGÜZEL"
     
        appDelegate.saveContext()
    }

    @IBAction func myGirisButton(_ sender: Any) {
        print("Giris Butonu tiklandi")
       
        for i in userInfo {
            if(myUserNameTextField.text == i.userName && myUserPasswordTextField.text == i.userPassword){
                self.performSegue(withIdentifier: "loginToHome", sender: nil)
                print("Kullanici bilgileri dogru")
            }else{
                print("Kullanici bilgileri yanlis")
             
                myUserNameTextField.placeholder = "tekrar deneyin "
                myUserPasswordTextField.placeholder = "tekrar deneyin "
            }
        }
    }
}

