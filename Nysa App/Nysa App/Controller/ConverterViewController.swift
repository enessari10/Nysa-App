//
//  ConverterViewController.swift
//  Nysa App
//
//  Created by Enes on 28.12.2021.
//

import UIKit

class ConverterViewController: UIViewController{
    
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var toMoneyLabel: UILabel!
    @IBOutlet weak var fromMoneyLabel: UILabel!
    @IBOutlet weak var pickerViewButton: UIButton!
    
    var converterModel : [ConverterModel] = []
    var converterAPI = ConverterAPI()
    var pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    var screenWidth = UIScreen.main.bounds.width - 10
    var screenHeight = UIScreen.main.bounds.height / 2
    var selectedRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.isHidden = true
      
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
            self.toMoneyLabel.text = self.pickerData[self.selectedRow]
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
            self.fromMoneyLabel.text = self.pickerData[self.selectedRow]
        }))
        self.present(alert,animated: true,completion: nil)
    }
    @IBAction func convertPressedButton(_ sender: Any) {
        
    }
    
}
extension ConverterViewController :UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 10))
        label.text = pickerData[row]
        label.sizeToFit()
        return label
    }
    
    
}
