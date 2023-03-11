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
    
    @IBOutlet weak var myAvYapildimiLabel: UILabel!
    @IBOutlet weak var myUserInfoLabel: UILabel!
    var loginUserName = UserDefaults.standard.string(forKey: "GirisYapanKullanici")
    let myContext = appMahalleAvDelegate.persistentContainer.viewContext
    var userInfo = [Users]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Av saygasissi mah")
        veriOkuma()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear: sayfa goruntulenicek")
        
        
        
        veriOkuma()
        
    }
    
    func veriOkuma(){
        do {
            userInfo = try myContext.fetch(Users.fetchRequest())
            for i in userInfo {
                if(i.userName == loginUserName){
                    myUserInfoLabel.text = "Gold: \(i.userGold)    Enerji: \(i.userEnergy) / \(i.userEnergyMax)   Can: \(i.userCurrentHp) / \(i.userMaxHp)"
                    
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
                    i.userEnergy -= 5
                    i.userCurrentHp -= 20
                    i.userExp += 1
                    i.userGold += 10
                    i.userToplamGelir += 10
                    i.userLevel = ( i.userExp / 100) + 1
                    i.userMaxHp = i.userLevel * 1000
                    myAppDelegate.saveContext()
                    myUserInfoLabel.text = "  Gold: \(i.userGold)    Enerji: \(i.userEnergy) / \(i.userEnergyMax)   Can: \(i.userCurrentHp) / \(i.userMaxHp)"
                    i.userToplamInsanAvi += 1
                    myAvYapildimiLabel.text = "Av Başarılı"
                    myAvYapildimiLabel.textColor  = .systemGreen
                }else{
                    myAvYapildimiLabel.text = "Can veya Enerjiniz yetersiz"
                    myAvYapildimiLabel.textColor  = .systemRed
                }
                
            }
        }
        
    }
}
