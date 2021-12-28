//
//  NewspaperClass.swift
//  Nysa App
//
//  Created by Enes on 27.12.2021.
//

import Foundation
import UIKit

class NewspaperAPI{
    let token = "pub_3121274797e10456c52dbc3cecba68b4fdaa&"
    let countryCode = "language=tr"
    let newspaperURL = "https://newsdata.io/api/1/news?&apikey="
    
    let categoryArray = ["Business","Entertainment","Environment","Food","Health","Politics","Science","Sports","Technology","Top","World"]
    
    let categoryImages = [UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),UIImage(named: "sportImages"),]
}
