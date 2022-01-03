//
//  WeatherViewController.swift
//  Nysa App
//
//  Created by Enes on 3.01.2022.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var weatherAPI = WeatherAPI()
    var weatherArray : [WeatherModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                       print(self.weatherAPI.urlEdit(url: self.weatherAPI.weatherURL, lat: location.coordinate.latitude, long: location.coordinate.longitude, token: self.weatherAPI.weatherToken))
                       AF.request(self.weatherAPI.urlEdit(url: self.weatherAPI.weatherURL, lat: location.coordinate.latitude, long: location.coordinate.longitude, token: self.weatherAPI.weatherToken)).responseJSON{ response in
                           switch response.result{
                           case .success(let value):
                               let json = JSON(value)
                               let wData = WeatherModel(name: json["name"].stringValue, weather: [Weather(main: json["weather"][0]["main"].stringValue, description: json["weather"][0]["description"].stringValue, icon: json["weather"][0]["icon"].stringValue)], main: [Main(temp: json["main"]["temp"].stringValue)])
                               
                               self.weatherArray.append(wData)
                               let temp = self.weatherArray[0].main[0].temp
                               let index = temp.index(temp.startIndex, offsetBy: 2)
                               self.cityName.text = self.weatherArray[0].name
                               self.mainLabel.text = self.weatherArray[0].weather[0].main
                               self.descLabel.text = self.weatherArray[0].weather[0].description
                               self.tempLabel.text = "\(String(temp.prefix(upTo: index)))°"
                  
                           case .failure(let error):
                               print(error)
                               let alert = UIAlertController(title: "Error", message: "Connection time out", preferredStyle: UIAlertController.Style.alert)
                               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                               self.present(alert, animated: true, completion: nil)
                           }
                       }
                       
                   }
                   
               }
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("Location update failed, \(error)")
       }

}
