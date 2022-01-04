//
//  NewspaperTableViewCell.swift
//  Nysa App
//
//  Created by Enes on 27.12.2021.
//

import UIKit
protocol NewspaperCollectionCellDelegate {
    func didSelectCell(atIndex:String)
    
}
class NewspaperTableViewCell: UITableViewCell {

    @IBOutlet var newspaperCollectionView: UICollectionView!
    var newspaperClass = NewspaperClass()
    var delegate : NewspaperCollectionCellDelegate?
    
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
        return newspaperClass.categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newspaperCollectionCell", for: indexPath) as! NewspaperCollectionViewCell
        cell.categoryLabel.text = newspaperClass.categoryArray[indexPath.row]
        cell.categoryImage.image = newspaperClass.categoryImages[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCell(atIndex: newspaperClass.categoryArray[indexPath.row])
    }
    
}
