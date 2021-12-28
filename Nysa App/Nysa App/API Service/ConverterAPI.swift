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
    let convertURL = "https://api.exchangeratesapi.io/v1/convert?access_key="
    let secondToken = "3f02fe0c54b33b2d45bbb4af9f9abdf8"
    
    func getExchange(from: String, to:String, amount: String)-> String{
        return convertURL + secondToken +  "&" + from + "&" + to + "&" + amount
    }

}
