//
//  RegisterViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 11.03.2023.
//

import UIKit
import CoreData
let myAppDelegate = UIApplication.shared.delegate as! AppDelegate

class RegisterViewController: UIViewController {
    var userRace:String = "kurtadam"
    let myContext = myAppDelegate.persistentContainer.viewContext
    @IBOutlet weak var myUserNameTextField: UITextField!
    var userInfo = [Users]()

    @IBOutlet weak var myUserPasswordTextField: UITextField!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
       
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func veriKaydi (){
    let user = Users(context: myContext)
        guard myUserPasswordTextField.text != nil else {return}
        guard myUserNameTextField.text != nil else{return}
        
        user.userRace = userRace
        user.userLevel = 1
        user.userExp = 0
        
        user.userPow = 10
        user.userDef = 10
        
        user.userPassword = myUserPasswordTextField.text
        user.userName = myUserNameTextField.text
      
        
            myAppDelegate.saveContext()
            
            print("Kayit Basarili ")
            self.performSegue(withIdentifier: "registerToHome", sender: nil)
         
        
    
      
     
    }
    
    @IBAction func mySegmentedControlButton(_ sender: UISegmentedControl) {
        
        switch mySegmentedControl.selectedSegmentIndex{
        case 0:
            userRace = "kurtadam"
        case 1:
            userRace = "vampir"
        default:
            userRace = "none"
            break
        }
    }
    
    @IBAction func myKayitOlButton(_ sender: Any) {
        veriKaydi()
        
    }
}
