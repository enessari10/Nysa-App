//
//  ExchangeTableViewCell.swift
//  Nysa App
//
//  Created by Rozerin on 28.12.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ExchangeTableViewCell: UITableViewCell {
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var exchangeCollection: UICollectionView!
    @IBOutlet weak var exchangeImage: UIImageView!
    
    var converterClass = ConverterClass()
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showData()
        exchangeCollection.delegate = self
        exchangeCollection.dataSource = self
       
    }
    func showData(){
        DispatchQueue.main.async {
            AF.request(self.converterClass.usdLatestURL()).responseJSON{ response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.converterClass.usdArray.append(json["conversion_rates"]["TRY"].stringValue)
                    self.converterClass.usdArray.append(json["conversion_rates"]["EUR"].stringValue)
                    self.converterClass.usdArray.append(json["conversion_rates"]["EGP"].stringValue)
                    self.converterClass.usdArray.append(json["conversion_rates"]["CZK"].stringValue)
                    self.exchangeCollection.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    
}

extension ExchangeTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.converterClass.usdArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exchangeCollectionCell", for: indexPath) as! ExchangeCollectionViewCell
        cell.exchangeName.text = converterClass.usdArray[indexPath.row]
        cell.exchangeSymbol.text = converterClass.usdNameArray[indexPath.row]
        return cell
    }
    
    
}
