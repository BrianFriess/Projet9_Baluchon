//
//  FormMonneyViewController.swift
//  Baluchon
//
//  Created by Brian Friess on 27/05/2021.
//

import UIKit

class FormMoneyViewController: UIViewController{

    
    @IBOutlet weak var textFieldMoney: UITextField!
    
    @IBOutlet weak var labelTextConvert: UILabel!
    
    var rangePickerView = 0
    let tabCurrency = ["","USD","JPY","RUB"]
    var moneyService : MoneyServiceProtocol! = MoneyService()
    var alerteManager = AlerteManager()
    var DataMoney = DataMoneyDecodable()
    var result = 0.0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        callCurrency()
    }
    
  
    func callCurrency(){
        moneyService.getMoney() { [self]  result in
            switch result{
            case .success(let resultMoney):
                DataMoney = resultMoney
            case .failure(_):
                self.alerteManager.alerteVc(.failedDownloadCurrency, self)
            }
        }
    }
    

    func setUpCurrency(){
        guard let currentMoney = Double(textFieldMoney.text!) else{
            return
        }
        result =  Double(DataMoney.rates?.getValue(tabCurrency[rangePickerView]) ?? 0) * currentMoney
        labelTextConvert.text = String(result)
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setUpCurrency()
    }

}




extension FormMoneyViewController : UITextFieldDelegate  {
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textFieldMoney.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldMoney.resignFirstResponder()
        return true
    }
}





extension FormMoneyViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tabCurrency.count
    }
    
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        rangePickerView = row
        return tabCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setUpCurrency()
    }
}




