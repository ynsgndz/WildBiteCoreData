//
//  RakipAviViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 11.03.2023.
//

import UIKit
import CoreData

let appYuksekSkorDelegate = UIApplication.shared.delegate as! AppDelegate
class YuksekSkorViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let myContext = appYuksekSkorDelegate.persistentContainer.viewContext
    var userInfo = [Users]()
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("RakipAra sayfasi yuklendi : viewDidLoad ")
       
     }
    override func viewWillAppear(_ animated: Bool) {
        veriOkuma()
    }
    func veriOkuma(){
        do{
            userInfo = try myContext.fetch(Users.fetchRequest())
           
            for i in userInfo{
                print("Username : \(i.userName!) Pass: \(String(describing: i.userPassword!))  Level : \(i.userLevel)  Exp : \(i.userExp) Tür : \(String(describing: i.userRace!)) Güç : \(i.userPow) Defans : \(i.userDef) Altin : \(i.userGold) Hp : \(i.userCurrentHp) /\(i.userMaxHp)  Enerji : \(i.userEnergy)/\(i.userEnergyMax)")
               
            }
          myTableView.dataSource = self
            myTableView.delegate = self
            myTableView.reloadData()
        }catch{
            print("User tablosu okunamadi")
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Rakip tablosu userInfo.count \(userInfo.count)")
        return userInfo.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! YuksekSkorTableViewCell
        cell.myLabel.text = userInfo[indexPath.row].userName
        print("user tablosu \(String(describing: userInfo[indexPath.row].userName!))")
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(userInfo[indexPath.row].userName)
    }

}
