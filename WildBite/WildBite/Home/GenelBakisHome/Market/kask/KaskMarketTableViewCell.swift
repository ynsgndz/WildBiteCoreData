//
//  MarketTableViewCell.swift
//  WildBite
//
//  Created by Yunus Gunduz on 14.03.2023.
//

import UIKit

class KaskMarketTableViewCell: UITableViewCell{

    @IBOutlet weak var myKaskArtisiLabel: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myKaskImageView: UIImageView!
    @IBOutlet weak var myGucLabel: UILabel!
    @IBOutlet weak var mySavunmaLabel: UILabel!
    @IBOutlet weak var myFiyatLabel: UILabel!
    @IBOutlet weak var myGerekliSeviyeLAbel: UILabel!
    
    @IBOutlet weak var satinAlmaLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

     
}
