//
//  CoinTableViewCell.swift
//  Nysa App
//
//  Created by Enes on 3.01.2022.
//

import UIKit

class CoinTableViewCell: UITableViewCell {

    @IBOutlet weak var coinPrices: UILabel!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinShortName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
