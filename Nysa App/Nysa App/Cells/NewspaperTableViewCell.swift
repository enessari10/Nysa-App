//
//  NewspaperTableViewCell.swift
//  Nysa App
//
//  Created by Enes on 27.12.2021.
//

import UIKit

class NewspaperTableViewCell: UITableViewCell {

    @IBOutlet var newspaperCollectionView: UICollectionView!
    var newspaperAPI = NewspaperAPI()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newspaperCollectionView.delegate = self
        newspaperCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

extension NewspaperTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newspaperAPI.categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newspaperCollectionCell", for: indexPath) as! NewspaperCollectionViewCell
        cell.categoryLabel.text = newspaperAPI.categoryArray[indexPath.row]
        cell.categoryImage.image = newspaperAPI.categoryImages[indexPath.row]
        return cell
    }
    
    
}
