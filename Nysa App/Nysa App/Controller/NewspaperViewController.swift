//
//  NewspaperViewController.swift
//  Nysa App
//
//  Created by Enes on 27.12.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewspaperViewController: UIViewController {

    @IBOutlet var newsTableView: UITableView!
    var newsPaperClass = NewspaperClass()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            self.newsTableView.delegate = self
            self.newsTableView.dataSource = self
            self.newsTableView.reloadData()
        }
        showData()
      
    }
    func showData(){
        AF.request(newsPaperClass.newsAPI.newspaperURL).responseJSON{ response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                print(json)
                print(json.count)
                let arrayCount = json.count
                for i in 0..<arrayCount {
                    self.newsPaperClass.titleArray.append(json["results"][i]["title"].rawValue as! String)
                    self.newsPaperClass.descArray.append(json["results"][i]["description"].rawValue as! String)
                    print(self.newsPaperClass.titleArray.count)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    


}

extension NewspaperViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsPaperClass.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.newsHead.text = newsPaperClass.titleArray[indexPath.row]
        cell.newsDesc.text = newsPaperClass.descArray[indexPath.row]
        return cell
    }
    
    
}
