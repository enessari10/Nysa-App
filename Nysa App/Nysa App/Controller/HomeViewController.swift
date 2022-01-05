//
//  HomeViewController.swift
//  Nysa App
//
//  Created by Enes on 27.12.2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation


class HomeViewController: UIViewController,CLLocationManagerDelegate{

    @IBOutlet var homeTableVİew: UITableView!
    var newspaperClass = NewspaperClass()
    let locationManager = CLLocationManager()
    var weatherClass = WeatherClass()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeTableVİew.delegate = self
        self.homeTableVİew.dataSource = self
        setupLocationManager()
    }
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if location.horizontalAccuracy > 0 {
                locationManager.stopUpdatingLocation()
                DispatchQueue.main.async {
                    AF.request(self.weatherClass.urlEdit(url: self.weatherClass.weatherAPI.weatherURL, lat: location.coordinate.latitude, long: location.coordinate.longitude, token: self.weatherClass.weatherAPI.weatherToken)).responseJSON{ response in
                        switch response.result{
                        case .success(let value):
                            let json = JSON(value)
                            let wData = WeatherModel(name: json["name"].stringValue, weather: [Weather(main: json["weather"][0]["main"].stringValue, description: json["weather"][0]["description"].stringValue, icon: json["weather"][0]["icon"].stringValue)], main: [Main(temp: json["main"]["temp"].stringValue)])
                            
                            self.weatherClass.weatherArray.append(wData)
                            let temp = self.weatherClass.weatherArray[0].main[0].temp
                            let index = temp.index(temp.startIndex, offsetBy: 2)
                            self.weatherClass.weatherCity = self.weatherClass.weatherArray[0].name
                            self.weatherClass.weatherTemp = "\(String(temp.prefix(upTo: index)))°"
                            self.homeTableVİew.reloadData()
                        case .failure(let error):
                            print(error)
                            let alert = UIAlertController(title: "Error", message: "Weather API Error", preferredStyle: UIAlertController.Style.alert)
                            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {_ in
                                
                            }
                            alert.addAction(okAction)
                           
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                    
                }
                
            }
        }
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed, \(error)")
        let alert = UIAlertController(title: "Error", message: "Location update failed", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {_ in
            
            
        }
        alert.addAction(okAction)
       
        self.present(alert, animated: true, completion: nil)
        
    }


}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
            cell.cityLabel.text = self.weatherClass.weatherCity
            cell.temperatureLabel.text = self.weatherClass.weatherTemp
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
