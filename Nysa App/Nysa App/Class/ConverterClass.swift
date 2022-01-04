//
//  ConverterClass.swift
//  Nysa App
//
//  Created by Enes on 4.01.2022.
//

import Foundation

class ConverterClass{
    var converterAPI = ConverterAPI()
    var usdArray : [String] = []
    var usdNameArray : [String] = ["TRY", "EURO", "EGP", "CZK"]
    var converterModelData : [ConverterModel] = []
    
    func getExchange(from: String, to:String, amount: String)-> String{
        return converterAPI.convertURL + converterAPI.secondToken +  "/pair/" + from + "/" + to + "/" + amount
    }
    
    func usdLatestURL() -> String{
        return converterAPI.latestURL + converterAPI.secondToken + "/latest/USD"
    }
}
