//
//  GenelBakisHomeViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 11.03.2023.
//

import UIKit
import CoreData

let genelBakisHomeAppDelegate = UIApplication.shared.delegate as! AppDelegate
class GenelBakisHomeViewController: UIViewController {
    let myContext = genelBakisHomeAppDelegate.persistentContainer.viewContext
    var userInfo = [Users]()
    
    
    @IBOutlet weak var myUserSeviyeLabel: UILabel!
    @IBOutlet weak var myUserAdiLabel: UILabel!
    @IBOutlet weak var myUserTurLabel: UILabel!
    @IBOutlet weak var myUserHasarLabel: UILabel!
    @IBOutlet weak var myUserCanLabel: UILabel!
    @IBOutlet weak var myUserEnergyLabel: UILabel!
    @IBOutlet weak var myUserGoldLabel: UILabel!
  // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad: ilk ve bir kez sayfa yuklendi")
        veriOkuma()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear: sayfa goruntulenicek")
        veriOkuma()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear sayfa goruntulendi")
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
        var loginUserName = UserDefaults.standard.string(forKey: "GirisYapanKullanici")
       
        for i in userInfo {
            if(i.userName == loginUserName){
                print("Username : \(i.userName!)  Level : \(i.userLevel)  Exp : \(i.userExp) Tür : \(String(describing: i.userRace!)) Güç : \(i.userPow) Defans : \(i.userDef) Altin : \(i.userGold) Hp : \(i.userMaxHp) Enerji : \(i.userEnergy)")
                
                myUserGoldLabel.text = "Altın: \(i.userGold)"
                myUserEnergyLabel.text = "Enerji: \(i.userEnergy)"
                myUserCanLabel.text = "Can: \(i.userMaxHp)"
                myUserHasarLabel.text = "Hasar: \(i.userPow + i.userDef + i.userMaxHp)"
                myUserTurLabel.text = "Tür: \(String(describing: i.userRace!.uppercased()))"
                myUserAdiLabel.text = "Adı: \(String(describing: i.userName!))"
                myUserSeviyeLabel.text = "Seviye: \(i.userLevel)"
            }else {
                print("uygulamadan cik la")
            }
          
          
        
        }
    }
}

/*
  layoutlarla ilgili gerekirse aktif ederiz
override func viewWillLayoutSubviews() {
    print("viewWillLayoutSubviews")
}
override func viewDidLayoutSubviews() {
    print("viewDidLayoutSubviews")
}
buda baslangicta sorun cikartiyor
 override func loadView() {
      print("loadView")
    
  }
 
 */
