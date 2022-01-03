//
//  CoinsViewController.swift
//  Nysa App
//
//  Created by Enes on 3.01.2022.
//

import UIKit

class CoinsViewController: UIViewController {

    
    @IBOutlet weak var coinTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        coinTableView.delegate = self
        coinTableView.dataSource = self
    }
    


}
extension CoinsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
}
