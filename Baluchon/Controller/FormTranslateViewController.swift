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
    var translate  : TranslateServiceProtocol! = TranslateService()
    var alerteManager = AlerteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func callTranslate(){
        translate.getTrad(textFieldTranslate.text!) { result in
            switch result{
            case .success(let resultTranslate):
                self.labelTranslate.text = resultTranslate
            case .failure(_):
                self.alerteManager.alerteVc(.failedDownloadTranslate, self)
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        callTranslate()
    }


}



extension FormTranslateViewController : UITextFieldDelegate{
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        textFieldTranslate.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldTranslate.resignFirstResponder()
        return true
    }
    
}


