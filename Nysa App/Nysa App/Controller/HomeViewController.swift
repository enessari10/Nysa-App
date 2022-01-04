//
//  HomeViewController.swift
//  Nysa App
//
//  Created by Enes on 27.12.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {

    @IBOutlet var homeTableVİew: UITableView!
    var newspaperClass = NewspaperClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeTableVİew.delegate = self
        self.homeTableVİew.dataSource = self
        navigationController?.navigationBar.backgroundColor = UIColor(named: "AccentColor")
    }
   
    


}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
            cell.cityLabel.text = "..."
            cell.temperatureLabel.text = "..."
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "newspaperCell", for: indexPath) as! NewspaperTableViewCell
            cell.delegate = self
            return cell
        }
        else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "exchangeCell", for: indexPath) as! ExchangeTableViewCell
            
            return cell
        }
        else{
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 200
            
        }
        else{
            return 200
        }
    }
    
}


extension HomeViewController: NewspaperCollectionCellDelegate{
    func didSelectCell(atIndex: String) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "NewspaperViewController") as! NewspaperViewController
        resultViewController.state =  .search
        self.newspaperClass.searchData =  atIndex
        resultViewController.title = atIndex
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
  
    
    
    
}
