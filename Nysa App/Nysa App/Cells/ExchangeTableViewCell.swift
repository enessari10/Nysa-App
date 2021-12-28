//
//  ExchangeTableViewCell.swift
//  Nysa App
//
//  Created by Rozerin on 28.12.2021.
//

import UIKit

class ExchangeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var exchangeCollection: UICollectionView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
