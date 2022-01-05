//
//  ConverterViewController.swift
//  Nysa App
//
//  Created by Enes on 28.12.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ConverterViewController: UIViewController{
    
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var toMoneyLabel: UILabel!
    @IBOutlet weak var fromMoneyLabel: UILabel!
    @IBOutlet weak var pickerViewButton: UIButton!
    var converterClass = ConverterClass()
    var screenWidth = UIScreen.main.bounds.width - 10
    var screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCurrencySymbols()
    }
    
    func showCurrencySymbols(){
        DispatchQueue.main.async {
            AF.request(self.converterClass.converterAPI.converterSymbols + self.converterClass.converterAPI.token + self.converterClass.converterAPI.converterType).responseJSON{ response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    json.array?.forEach({(news) in
                        let news = ConverterModel(title: news["Currency"].stringValue)
                        self.converterClass.converterModelData.append(news)
                    })
                case .failure(let error):
                    print(error)
                    let alert = UIAlertController(title: "Error", message: "Currency Symbols API Error", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    
    @IBAction func toMoneyButtonPressed(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        let alert = UIAlertController(title: "Select from money", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = pickerViewButton
        alert.popoverPresentationController?.sourceRect = pickerViewButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler : { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler : { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            self.toMoneyLabel.text = self.converterClass.converterModelData[self.selectedRow].title
        }))
        self.present(alert,animated: true,completion: nil)
    }
    @IBAction func popUppicker(_ sender: Any) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        let alert = UIAlertController(title: "Select from money", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = pickerViewButton
        alert.popoverPresentationController?.sourceRect = pickerViewButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler : { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler : { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            self.fromMoneyLabel.text = self.converterClass.converterModelData[self.selectedRow].title
        }))
        self.present(alert,animated: true,completion: nil)
    }
    @IBAction func convertPressedButton(_ sender: Any) {
        
        DispatchQueue.main.async {
            AF.request(self.converterClass.getExchange(from: self.toMoneyLabel.text!, to: self.fromMoneyLabel.text!, amount: self.amountTextfield.text!)).responseJSON{ response in
                
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    let alert = UIAlertController(title: "Result", message: "\(json["conversion_result"].stringValue)", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                case .failure(let error):
                    print(error)
                    let alert = UIAlertController(title: "Error", message: "Convert API Error", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    
    
}
extension ConverterViewController :UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.converterClass.converterModelData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return converterClass.converterModelData[row].title
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        label.text = converterClass.converterModelData[row].title
        label.sizeToFit()
        return label
    }
    
    
}
