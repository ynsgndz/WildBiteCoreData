//
//  MahalleAvViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 11.03.2023.
//

import UIKit
import CoreData

let appMahalleAvDelegate = UIApplication.shared.delegate as! AppDelegate



class MahalleAvViewController: UIViewController {
    
    @IBOutlet weak var mySaldirButton: UIButton!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myAvYapildimiLabel: UILabel!
    @IBOutlet weak var myUserInfoLabel: UILabel!
    var loginUserName = UserDefaults.standard.string(forKey: "GirisYapanKullanici")
    let myContext = appMahalleAvDelegate.persistentContainer.viewContext
    var userInfo = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Debug: Av MahalleAvViewController  viewDidLoad run")
            // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "gradientBG.png")!)
        veriOkuma()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("Debug: Av MahalleAvViewController  viewWillAppear run")
        
        
        veriOkuma()
        
    }
    
    func veriOkuma(){
        do {
            userInfo = try myContext.fetch(Users.fetchRequest())
            for i in userInfo {
                if(i.userName == loginUserName){
                    myUserInfoLabel.text =  "💰Para: \(i.userGold) ⚡️Enerji: \(i.userEnergy) / \(i.userEnergyMax) ❤️Can: \(i.userCurrentHp) /\(i.userMaxHp)"
                    
                }
            }
            print("veriokuma")
        }catch{
            print("Kişileri okuyamadı !")
        }
        
        
    }
    
    @IBAction func mySaldirButton(_ sender: Any) {
       
        for i in userInfo {
            if(i.userName == loginUserName){
                if(i.userEnergy >= 5 && i.userCurrentHp >= 20){
                    self.myAvYapildimiLabel.text = "Avlanılıyor.."
                    self.myAvYapildimiLabel.textColor  = .systemGray
                    self.myActivityIndicator.isHidden = false
                    mySaldirButton.isEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.mySaldirButton.isEnabled = true
                         i.userEnergy -= 5
                         i.userCurrentHp -= 20
                         i.userExp += 1
                         i.userGold += 10
                         i.userToplamGelir += 10
                         i.userLevel = ( i.userExp / 100) + 1
                         i.userMaxHp = i.userLevel * 1000
                         i.userToplamInsanAvi += 1
                         myAppDelegate.saveContext()
                        self.myUserInfoLabel.text = "💰Para: \(i.userGold) ⚡️Enerji: \(i.userEnergy) / \(i.userEnergyMax) ❤️Can: \(i.userCurrentHp) /\(i.userMaxHp)"
                        
                      
                        
                        self.myAvYapildimiLabel.text = "Av Başarılı   +1🎖️  +10💰 "
                        self.myActivityIndicator.isHidden = true
                        self.myAvYapildimiLabel.textColor  = .systemGreen
                    }
                    
                   
                    
                   
                }else{
                    myAvYapildimiLabel.text = "❤️Can veya ⚡️Enerji yetersiz"
                    myAvYapildimiLabel.textColor  = .systemRed
                }
                
            }
        }
        
    }
}
