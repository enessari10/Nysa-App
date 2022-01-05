//
//  WeatherClass.swift
//  Nysa App
//
//  Created by Enes on 4.01.2022.
//

import Foundation

class WeatherClass{
    var weatherAPI = WeatherAPI()
    var weatherArray : [WeatherModel] = []
    var weatherCity : String = ""
    var weatherTemp : String = ""
    
    func urlEdit(url : String, lat : Double, long : Double, token : String) -> String{
        return url + "lat=" + String(lat) + "&lon=" + String(long) + "&appid=" + token + "&units=metric"
    }
}
