//
//  RakipAviOzetiViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 12.03.2023.
//

import UIKit
import CoreData

let appRakipAviOzetiDelegate = UIApplication.shared.delegate as! AppDelegate
class RakipAviOzetiViewController: UIViewController {

    let myContext = appRakipAviDelegate.persistentContainer.viewContext
    var userInfo = [Users]()
    
    @IBOutlet weak var kazananLabel: UILabel!
    
    @IBOutlet weak var kazananOdulLabel: UILabel!
    
    @IBOutlet weak var saldiranHasarOraniLabel: UILabel!
    @IBOutlet weak var saldiranUserNameLabel: UILabel!
    
    @IBOutlet weak var saldiranGucLabel: UILabel!
    
    @IBOutlet weak var mySaldiranProfilResmi: UIImageView!
    
    @IBOutlet weak var saldiranSavunmaLabel: UILabel!
    
    @IBOutlet weak var mySavunanProfilResmi: UIImageView!
    
    @IBOutlet weak var savunanUserNameLabel: UILabel!
    
    @IBOutlet weak var savunanHasarOraniLabel: UILabel!
    
    @IBOutlet weak var savunanGucLabel: UILabel!
    
    @IBOutlet weak var savunanSavunmaLabel: UILabel!
    
    var kazananUserName:String?
    //saldiran
    var saldiranUserName :String?
    var saldiranHasarOrani:Int32?
    var saldiranMaxHp :Int32?
    var saldiranCurrentHp :Int32?
    var saldiranGuc:Int32?
    var saldiranDefans :Int32?
    var saldiranAltin :Int32?
    var saldiranTecrube :Int32?
    
    //savunan
    var savunanUserName :String?
    var savunanHasarOrani:Int32?
    var savunanMaxHp :Int32?
    var savunanCurrentHp :Int32?
    var savunanGuc :Int32?
    var savunanDefans :Int32?
    var savunanAltin :Int32?
    var savunanTecrube :Int32?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         
    }
    override func viewWillAppear(_ animated: Bool) {
        print("Debug: RakipAviOzetiViewController viewWillAppear run ")
        saldiranUserName = "\(String(describing: UserDefaults.standard.value(forKey: "saldiranUserName")!    ))"
        saldiranHasarOrani = Int32(UserDefaults.standard.integer(forKey: "saldiranHasarOrani"))
        saldiranMaxHp =  Int32(UserDefaults.standard.integer(forKey: "saldiranMaxHp"))
        saldiranCurrentHp = Int32(UserDefaults.standard.integer(forKey: "saldiranCurrentHp"))
        saldiranGuc = Int32(UserDefaults.standard.integer(forKey: "saldiranGuc"))
        saldiranDefans = Int32(UserDefaults.standard.integer(forKey: "saldiranDefans"))
        saldiranAltin = Int32(UserDefaults.standard.integer(forKey: "saldiranAltin"))
        saldiranTecrube = Int32(UserDefaults.standard.integer(forKey: "saldiranTecrube"))
        
        
        savunanUserName = "\(String(describing:UserDefaults.standard.value(forKey: "savunanUserName")!))"
        savunanHasarOrani = Int32(UserDefaults.standard.integer(forKey: "savunanHasarOrani"))
         savunanMaxHp = Int32(UserDefaults.standard.integer(forKey: "savunanMaxHp"))
         savunanCurrentHp = Int32(UserDefaults.standard.integer(forKey: "savunanCurrentHp"))
         savunanGuc = Int32(UserDefaults.standard.integer(forKey: "savunanGuc"))
         savunanDefans = Int32(UserDefaults.standard.integer(forKey: "savunanDefans"))
         savunanAltin = Int32(UserDefaults.standard.integer(forKey: "savunanAltin"))
        savunanTecrube = Int32(UserDefaults.standard.integer(forKey: "savunanTecrube"))
      
       
        saldiranUserNameLabel.text = "Saldıran: \(saldiranUserName!)"
        savunanUserNameLabel.text = "Savunan: \(savunanUserName!)"
        
        saldiranHasarOraniLabel.text  = "Saldırı Hasarı: \(saldiranHasarOrani!)"
        savunanHasarOraniLabel.text = "Saldırı Hasarı: \(savunanHasarOrani!)"
        
        saldiranGucLabel.text = "Güç: \(saldiranGuc!)"
        savunanGucLabel.text = "Güç: \(savunanGuc!)"
        
        saldiranSavunmaLabel.text = "Savunma: \(saldiranDefans!)"
        savunanSavunmaLabel.text = "Savunma: \(savunanDefans!)"
        do{
            userInfo = try myContext.fetch(Users.fetchRequest())
            print("Debug:  userInfo  fetch in Users  run  ")
        }catch{
            print("Debug:  userInfo  fetch in Users Not run ! ")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        print("Debug:  RakipAviOzetiViewController viewDidAppear run ")
        saldiriSonucu()
    }

    func saldiriSonucu(){
        print("Debug: saldiriSonucu run \n")
        for i in userInfo{
            if(i.userName! == savunanUserName!){
                mySavunanProfilResmi.image = UIImage(named: i.userProfilResmi!)
            }
            if(i.userName! == saldiranUserName!){
                print("Debug: i.userName \(i.userName!)")
                print("Debug: saldiranUserName \(saldiranUserName!)")
                print("Debug: savunanUserName \(savunanUserName!) \n")
                
                let savasSonucu = saldiranHasarOrani! - savunanHasarOrani!
              
                print("Debug: saldiranHasarOrani \(String(describing: saldiranHasarOrani!))")
                print("Debug: savunanHasarOrani \(String(describing: savunanHasarOrani!))")
                print("Debug: savasSonucu \(savasSonucu) \n")
                mySaldiranProfilResmi.image = UIImage(named: i.userProfilResmi!)
                if(savasSonucu >= 0){
                    kazananLabel.text = "Kazanan: \(saldiranUserName!)"
                    kazananLabel.textColor = .systemGreen
                    let alinanHasar = ((savunanGuc! + savunanDefans!)*3)
                    let odulAltin = ((savunanAltin!*30)/100)
                    print("Debug: kalanCan \(alinanHasar) \n")
                    print("Debug: odulAltin \(odulAltin) \n")
                  
                    i.userEnergy += 15
                    i.userCurrentHp -= alinanHasar
                    i.userGold += odulAltin
                    i.userExp += 1
                    i.userToplamSavas += 1
                    i.userToplamGalibiyet += 1
                    i.userToplamGelir += odulAltin
                    kazananOdulLabel.text = "Sonuc : (Alınan Hasar: \(alinanHasar) )  (Enerji +15)  (Altin + \(odulAltin))"
                    
                    myAppDelegate.saveContext()
                }else{
                    kazananLabel.text = "Kazanan: \(savunanUserName!)"
                    kazananLabel.textColor = .systemRed
                    let alinanHasar = ((savunanGuc! + savunanDefans!)*3)
                    let kalanAltin = ((saldiranAltin!*30)/100)
                    print("Debug: alinanHasar \(alinanHasar) \n")
                    print("Debug: kalanAltin \(kalanAltin) \n")
                  
                    i.userEnergy -= 5
                    i.userCurrentHp -= alinanHasar
                    i.userGold -= kalanAltin
                   // i.userExp += 1
                    i.userToplamSavas += 1
                    i.userToplamYenilgi += 1
                  //  i.userToplamGelir += odulAltin
                    kazananOdulLabel.text = "Sonuc : (Alınan Hasar: \(alinanHasar) )  (Enerji -5)  (Altin - \(kalanAltin))"
                    
                    myAppDelegate.saveContext()
                }
               
                
            }
        }
        
       
    }
    
}
