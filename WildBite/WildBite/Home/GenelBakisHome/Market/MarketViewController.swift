//
//  MarketViewController.swift
//  WildBite
//
//  Created by Yunus Gunduz on 14.03.2023.
//

import UIKit
import CoreData

let myMarketAppDellegate = UIApplication.shared.delegate as! AppDelegate
class MarketViewController: UIViewController {
    let myContext = myMarketAppDellegate.persistentContainer.viewContext
   var marketInfo = [Market]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            marketInfo = try myContext.fetch(Market.fetchRequest())
            print("Debug: MarketViewController viewDidLoad Market.fetchRequest run ")
        }catch{
            print("Debug: MarketViewController viewDidLoad Market.fetchRequest not run ")
            return
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if (marketInfo.count < 1){
           
            for i in 1...27{
                let marketIcerigi = Market(context: myContext)
                // zirh
                marketIcerigi.marketZirhName = "zirh\(i).png"
                marketIcerigi.marketZirhArtisi = 0
                marketIcerigi.marketZirhLeveli = Int32(i * 4)
                marketIcerigi.marketZirhGuc = 0
                marketIcerigi.marketZirhSavunma = Int32(i * 100)
                marketIcerigi.marketZirhParasi = Int32(i * 10000)
                
                // kask
                marketIcerigi.marketKaskName = "kask\(i).png"
                marketIcerigi.marketKaskArtisi = 0
                marketIcerigi.marketKaskLeveli = Int32(i * 4)
                marketIcerigi.marketKaskGuc = Int32(i * 25)
                marketIcerigi.marketKaskSavunma = Int32(i * 50)
                marketIcerigi.marketKaskParasi = Int32(i * 10000)
                
                // eldiven
                marketIcerigi.marketEldivenName = "eldiven\(i).png"
                marketIcerigi.marketEldivenArtisi = 0
                marketIcerigi.marketEldivenLeveli = Int32(i * 4)
                marketIcerigi.marketEldivenGuc = Int32(i * 50)
                marketIcerigi.marketEldivenSavunma = Int32(i * 25)
                marketIcerigi.marketEldivenParasi = Int32(i * 10000)
                
                // cizme
                marketIcerigi.marketCizmeName = "cizme\(i).png"
                marketIcerigi.marketCizmeArtisi = 0
                marketIcerigi.marketCizmeLeveli = Int32(i * 4)
                marketIcerigi.marketCizmeGuc = Int32(i * 50)
                marketIcerigi.marketCizmeSavunma = Int32(i * 50)
                marketIcerigi.marketCizmeParasi = Int32(i * 10000)
                
                // aksesuar
                marketIcerigi.marketAksesuarName = "aksesuar\(i).png"
                marketIcerigi.marketAksesuarArtisi = 0
                marketIcerigi.marketAksesuarLeveli = Int32(i * 4)
                marketIcerigi.marketAksesuarGuc = Int32(i * 50)
                marketIcerigi.marketAksesuarSavunma = 0
                marketIcerigi.marketAksesuarParasi = Int32(i * 10000)
                
                appDelegate.saveContext()
            }
            for i in 1...5{
                let marketIcerigi = Market(context: myContext)
                if i == 1 { // iksir 1, kucuk can şişesi eklenıyor
                    marketIcerigi.marketIksirName = "iksir\(i).png"
                    marketIcerigi.marketIksirCan = Int32(i * 100)
                    marketIcerigi.marketIksirEnerji = 0
                    marketIcerigi.marketIksirParasi = Int32(i * 1000)
                    appDelegate.saveContext()
                }
                if i == 2 { // iksir 2, kucuk enerji şişesi eklenıyor
                    marketIcerigi.marketIksirName = "iksir\(i).png"
                    marketIcerigi.marketIksirCan = 0
                    marketIcerigi.marketIksirEnerji = Int32(i * 100)
                    marketIcerigi.marketIksirParasi = Int32(i * 1000)
                    appDelegate.saveContext()
                }
                if i == 3 { // iksir 3, tombul can şişesi eklenıyor
                    marketIcerigi.marketIksirName = "iksir\(i).png"
                    marketIcerigi.marketIksirCan = Int32(i * 100)
                    marketIcerigi.marketIksirEnerji = 0
                    marketIcerigi.marketIksirParasi = Int32(i * 1000)
                    appDelegate.saveContext()
                }
                if i == 4 { // iksir 4, tombul enerji şişesi eklenıyor
                    marketIcerigi.marketIksirName = "iksir\(i).png"
                    marketIcerigi.marketIksirCan = 0
                    marketIcerigi.marketIksirEnerji = Int32(i * 100)
                    marketIcerigi.marketIksirParasi = Int32(i * 1000)
                    appDelegate.saveContext()
                }
                if i == 5 { // iksir 5, tombul can ve enerji şişesi eklenıyor
                    marketIcerigi.marketIksirName = "iksir\(i).png"
                    marketIcerigi.marketIksirCan = Int32(i * 100)
                    marketIcerigi.marketIksirEnerji = Int32(i * 100)
                    marketIcerigi.marketIksirParasi = Int32(i * 1000)
                    appDelegate.saveContext()
                }
                
            }
            
            print("Debug: MarketViewController viewWillAppear kaskinfo.count < 1  run ")
        }else{
            print("Debug: MarketViewController viewWillAppear kaskinfo.count > 1  run ")
        }
       
        
        
        
        
       

    }

    override func viewDidAppear(_ animated: Bool) {
        for i in marketInfo{
            print("Debug: MarketViewController viewWillAppear  marketZirh Name :  \(String(describing: i.marketZirhName)) ")
        }
    }

}
