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
    var moneyService : MoneyServiceProtocol! = MoneyService(session: URLSession(configuration: .default), url: UrlObject())
    var alerteManager = AlerteManager()
    var dataMoney = DataMoneyDecodable()
    
    
    
   
    //when we started the page, we call our network call
    override func viewDidLoad() {
        super.viewDidLoad()
        callCurrency()
    }
    
  
    func callCurrency(){
        moneyService.getMoney() { result in
            switch result{
            case .success(let resultMoney):
                //if the network call is a success, we give our result at dataMoney
                self.dataMoney = resultMoney
            case .failure(_):
                //else, we call an alerte
                self.alerteManager.alerteVc(.failedDownloadCurrency, self)
            }
        }
    }
    

    func setUpCurrency(){
        //when we call this function, we check if the textField is empty or not
        guard let currentMoney = Double(textFieldMoney.text!) else{
            return
        }
        //we take currentMoney in our textField and we use the function getValue in "dataMoney" for check our currency in tabCurrency with the range rangePickerView and multiply our conversion by currentMoney
        let result =  Double(dataMoney.rates?.getValue(tabCurrency[rangePickerView]) ?? 0) * currentMoney
        labelTextConvert.text = String(result)
    }
    
    //when we change the value in the textField, we call the function "setUpCurrency"
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setUpCurrency()
    }

}


//keyboard management

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
    
    // we return in the pickerView the value of tabCurrency and we give the row at rangePickerView
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        rangePickerView = row
        return tabCurrency[row]
    }
    
    //when we use the pickerView, we call the function setUpCurrency
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setUpCurrency()
    }
}




