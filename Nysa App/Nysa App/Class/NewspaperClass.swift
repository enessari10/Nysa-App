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
    let categoryImages = [UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),]
    
    func searchNews(searchWord : String) -> String{
        return newspaperAPI.newspaperURL + newspaperAPI.token + newspaperAPI.search + searchWord
    }
}
