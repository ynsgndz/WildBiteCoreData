//
//  HomeViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 11.03.2023.
//

import UIKit
import CoreData

let myHomeAppDelegate = UIApplication.shared.delegate as! AppDelegate
class HomeViewController: UIViewController {
    let myContext = myHomeAppDelegate.persistentContainer.viewContext
    var userInfo = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        veriOkuma()
    }
    
    func veriOkuma(){
        do {
            userInfo = try myContext.fetch(Users.fetchRequest())
        }catch{
            print("Kişileri okuyamadı !")
            return
        }
      
        for i in userInfo {
          
            print("Username : \(i.userName!)  Level : \(i.userLevel)  Exp : \(i.userExp) Tür : \(String(describing: i.userRace!)) Güç : \(i.userPow) Defans : \(i.userDef)")
        }
    }
}
