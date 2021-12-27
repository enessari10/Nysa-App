//
//  NewsTableViewCell.swift
//  Nysa App
//
//  Created by Enes on 27.12.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsHead: UILabel!
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var newsDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
