//
//  FormTranslateViewController.swift
//  Baluchon
//
//  Created by Brian Friess on 27/05/2021.
//

import UIKit

class FormTranslateViewController: UIViewController {

    @IBOutlet weak var textFieldTranslate: UITextField!
    @IBOutlet weak var labelTranslate: UILabel!
    var translate  : TranslateServiceProtocol! = TranslateService(session: URLSession(configuration: .default))
    var alerteManager = AlerteManager()
    
    
    func callTranslate(){
        translate.getTrad(textFieldTranslate.text!) { result in
            switch result{
            case .success(let resultTranslate):
                //if our networkCall is a success, we give the result at the label
                self.labelTranslate.text = resultTranslate
            case .failure(_):
                self.alerteManager.alerteVc(.failedDownloadTranslate, self)
            }
        }
    }
    
    //we call the network call when the value of the textField change
    func textFieldDidChangeSelection(_ textField: UITextField) {
        callTranslate()
    }
}


//keyboard Management
extension FormTranslateViewController : UITextFieldDelegate{
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        textFieldTranslate.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldTranslate.resignFirstResponder()
        return true
    }
    
}


