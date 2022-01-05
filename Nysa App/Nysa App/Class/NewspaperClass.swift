//
//  NewspaperClass.swift
//  Nysa App
//
//  Created by Enes on 4.01.2022.
//

import Foundation
import UIKit

class NewspaperClass{
    var newspaperAPI = NewspaperAPI()
    var newspaperData : [NewspaperModel] = []
    var searchData : String = ""
    
    let categoryArray = ["Business","Entertainment","Environment","Food","Health","Politics","Science","Sports","Technology","Top","World"]
    let categoryImages = [UIImage(named: "briefcase"),UIImage(named: "home-entertainment-system"),UIImage(named: "city"),UIImage(named: "diet"),UIImage(named: "healthcare"),UIImage(named: "politics"),UIImage(named: "science"),UIImage(named: "running-man"),UIImage(named: "technology"),UIImage(named: "top-rated"),UIImage(named: "earth"),]
    
    func searchNews(searchWord : String) -> String{
        return newspaperAPI.newspaperURL + newspaperAPI.token + newspaperAPI.search + searchWord
    }
}
