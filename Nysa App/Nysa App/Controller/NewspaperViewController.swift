//
//  NewspaperViewController.swift
//  Nysa App
//
//  Created by Enes on 27.12.2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import Lottie
import SafariServices

enum NewspaperPageState {
    case search
    case normal
}

class NewspaperViewController: UIViewController {
    
    @IBOutlet var newsTableView: UITableView!
    @IBOutlet var animationView: AnimationView!
    var newspaperClass = NewspaperClass()
    var state: NewspaperPageState = .normal
    var search : String = ""

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        print(state)
        if state == .normal{
            showData()
        }else{
            showSearchData()
        }
    }
    
    func showSearchData(){
        print("ENESS \(self.newspaperClass.searchData)")
        animationStart()
        DispatchQueue.main.async {
            AF.request(self.newspaperClass.searchNews(searchWord: self.search)).responseJSON{ response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    let data = json["results"]
                    data.array?.forEach({(news) in
                        let news = NewspaperModel(title: news["title"].stringValue, desc: news["description"].stringValue, image: news["image_url"].stringValue, link: news["link"].stringValue)
                        self.newspaperClass.newspaperData.append(news)
                    })
                    self.newsTableView.reloadData()
                    self.animationStop()
                    
                case .failure(let error):
                    print(error)
                    let alert = UIAlertController(title: "Error", message: "Newspaper API Error", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
        
    }
    func showData(){
        animationStart()
        DispatchQueue.main.async {
            AF.request(self.newspaperClass.newspaperAPI.newspaperURL+self.newspaperClass.newspaperAPI.token+self.newspaperClass.newspaperAPI.countryCode).responseJSON{ response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    let data = json["results"]
                    data.array?.forEach({(news) in
                        let news = NewspaperModel(title: news["title"].stringValue, desc: news["description"].stringValue, image: news["image_url"].stringValue, link: news["link"].stringValue)
                        self.newspaperClass.newspaperData.append(news)
                    })
                    self.newsTableView.reloadData()
                    self.animationStop()
                    
                case .failure(let error):
                    print(error)
                    let alert = UIAlertController(title: "Error", message: "Newspaper API Error", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
        
    }
    
    func animationStart(){
        animationView = .init(name: "loading")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
        
    }
    func animationStop(){
        animationView!.stop()
        animationView.isHidden = true
    }
    
    
}

extension NewspaperViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newspaperClass.newspaperData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"newsCell", for: indexPath) as! NewsTableViewCell? else {
            fatalError()
        }
        cell.newsHead.text = newspaperClass.newspaperData[indexPath.row].title
        cell.newsDesc.text = newspaperClass.newspaperData[indexPath.row].desc
        let urlImage = newspaperClass.newspaperData[indexPath.row].image
        
        if urlImage == "null"{
            cell.newsImageView.image = UIImage(named: "404")
        }else{
            AF.request(urlImage).responseImage { response in
                if case .success(let getImage) = response.result {
                    cell.newsImageView.image = getImage
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myUrl = newspaperClass.newspaperData[indexPath.row].link
        let vc = SFSafariViewController(url: URL(string: myUrl)!)
        present(vc,animated: true)
        
        
    }
    
}



