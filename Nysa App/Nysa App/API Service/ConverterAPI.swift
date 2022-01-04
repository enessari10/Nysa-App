//
//  ConverterAPI.swift
//  Nysa App
//
//  Created by Enes on 28.12.2021.
//

import Foundation

class ConverterAPI{
    let token = "61cb526f283c87.16166053"
    let converterSymbols = "https://eodhistoricaldata.com/api/exchanges-list/?api_token="
    let converterType = "&fmt=json"
    let convertURL = "https://v6.exchangerate-api.com/v6/"
    let secondToken = "2776f7792a09635a9e7f4c39"
    
    func getExchange(from: String, to:String, amount: String)-> String{
        return convertURL + secondToken +  "/pair/" + from + "/" + to + "/" + amount
    }
    
   
}
