//
//  WeatherModel.swift
//  Nysa App
//
//  Created by Enes on 3.01.2022.
//

import Foundation

struct WeatherModel{
    var name : String
    var weather : [Weather]
    var main : [Main]
}

struct Weather{
    var main : String
    var description : String
    var icon : String
}

struct Main{
    var temp : String
}
