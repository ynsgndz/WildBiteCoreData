//
//  AvSayfasiViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 11.03.2023.
//

import UIKit
import CoreData

let appAvDelegate = UIApplication.shared.delegate as! AppDelegate





class AvSayfasiViewController: UIViewController {
    var loginUserName = UserDefaults.standard.string(forKey: "GirisYapanKullanici")
    let myContext = appAvDelegate.persistentContainer.viewContext
    var userInfo = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        veriOkuma()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear: sayfa goruntulenicek")
       
         loginUserName = UserDefaults.standard.string(forKey: "GirisYapanKullanici")
      
            veriOkuma()
        
    }
    
    func veriOkuma(){
        do {
            userInfo = try myContext.fetch(Users.fetchRequest())
            for i in userInfo {
                if(i.userName == loginUserName){
                    
                   
                }
            }
            print("veriokuma")
        }catch{
            print("Kişileri okuyamadı !")
        }
        
        
    }
    

}
