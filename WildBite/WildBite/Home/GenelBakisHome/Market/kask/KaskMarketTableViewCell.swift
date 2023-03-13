//
//  MarketTableViewCell.swift
//  WildBite
//
//  Created by Yunus Gunduz on 14.03.2023.
//

import UIKit

class KaskMarketTableViewCell: UITableViewCell{

    @IBOutlet weak var myLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
