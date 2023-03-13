//
//  MarketViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 14.03.2023.
//
import UIKit
import CoreData

let appMarketDelegate = UIApplication.shared.delegate as! AppDelegate
class KaskMarketViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let myContext = appMarketDelegate.persistentContainer.viewContext
    var marketInfo = [Market]()
   
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Debug: MarketViewController viewDidLoad run  ")
        for i in marketInfo{
            print("kask name \( String(describing: i.marketKaskName))")
        }
     }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("Debug: MarketViewController viewWillAppear run  ")
        veriOkuma()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Debug: MarketViewController viewDidAppear run  ")
    }
    func veriOkuma(){
        do{
            marketInfo = try myContext.fetch(Market.fetchRequest())
            
           
           
          myTableView.dataSource = self
            myTableView.delegate = self
            myTableView.reloadData()
        }catch{
            print("Debug: MarketViewController market tablosu okunamadi")
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Debug: MarketViewController market  tablosu marketInfo.count \(marketInfo.count)")
        return marketInfo.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! KaskMarketTableViewCell
        
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(userInfo[indexPath.row].userName as Any)
    }

}


/*
 
    
 myContext.delete(i)
appDelegate.saveContext()
 
 //----------------
 
 user.userGold = 100
 
 appDelegate.saveContext()
 */
