//
//  WeatherAPI.swift
//  Nysa App
//
//  Created by Enes on 3.01.2022.
//

import Foundation

class WeatherAPI{
   let weatherToken =  "40e06b2385d59438103607113477a53d"
   var weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    func urlEdit(url : String, lat : Double, long : Double, token : String) -> String{
        return url + "lat=" + String(lat) + "&lon=" + String(long) + "&appid=" + token + "&units=metric"
    }
}
// https://api.openweathermap.org/data/2.5/weather?
//lat=37.785834&lon=-122.406417&appid=40e06b2385d59438103607113477a53d
