//
//  HomeViewController.swift
//  Nysa App
//
//  Created by Enes on 27.12.2021.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet var homeTableVİew: UITableView!
    
    var weatherCity = "Ankara"
    var weatherTempe = "39"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableVİew.delegate = self
        homeTableVİew.dataSource = self
    
    }
    


}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
            cell.cityLabel.text = weatherCity
            cell.temperatureLabel.text = weatherTempe
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "newspaperCell", for: indexPath) as! NewspaperTableViewCell
            return cell
        }
        else{
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
