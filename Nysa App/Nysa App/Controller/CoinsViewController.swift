//
//  CoinsViewController.swift
//  Nysa App
//
//  Created by Enes on 3.01.2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import Lottie

class CoinsViewController: UIViewController {
    
    @IBOutlet weak var coinTableView: UITableView!
    @IBOutlet weak var animationView: AnimationView!
    var myArray : [CoinsModel] = []
    var coinsAPI = CoinsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinTableView.delegate = self
        coinTableView.dataSource = self
        animationView.isHidden = true
        getData()
    }
    
    
    func getData(){
        self.animationStart()
        DispatchQueue.main.async {
            AF.request(self.coinsAPI.coinsURL).responseJSON{ response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    let data = json["data"]
                    for i in 0..<data.count{
                      
                        let coinData = CoinsModel(name: data[i]["name"].stringValue, symbol: data[i]["symbol"].stringValue, price: data[i]["priceUsd"].stringValue)
                        self.myArray.append(coinData)
                        self.coinTableView.reloadData()
                        self.animationStop()
                    }
       
                case .failure(let error):
                    print(error)
                    let alert = UIAlertController(title: "Error", message: "Connection time out", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    func animationStart(){
        animationView = .init(name: "loading2")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
        
    }
    func animationStop(){
        animationView!.stop()
        animationView.isHidden = true
    }


}
extension CoinsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath) as! CoinTableViewCell
        let money = myArray[indexPath.row].price
        let index = money.index(money.startIndex, offsetBy: 7)
        
        cell.coinShortName.text = myArray[indexPath.row].symbol
        cell.coinName.text = myArray[indexPath.row].name
        cell.coinPrices.text = "$\(money.substring(to: index))"

        return cell
    }
    
    
    
}
