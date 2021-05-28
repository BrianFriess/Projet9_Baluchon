//
//  FormWeatherViewController.swift
//  Baluchon
//
//  Created by Brian Friess on 27/05/2021.
//

import UIKit

class FormWeatherViewController: UIViewController {

  
    @IBOutlet weak var TextFieldCityStarted: UITextField!
    @IBOutlet weak var TextFieldCityEnd: UITextField!
    var weather : Weather!
    
    //when we click on the button
    @IBAction func validate() {
        recoverCity()
        checkStatus()
        WeatherService.getWeather()
    }
    
    
    //we give the value to the "Weather" model
    private func recoverCity(){
        let cityStarted = TextFieldCityStarted.text
        let cityEnd = TextFieldCityEnd.text
        weather = Weather(cityStarted: cityStarted, cityEnd: cityEnd)
    }
    
    //we give the value to the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToResearchWeather"{
            let successVC = segue.destination as! researchWeatherViewController
            successVC.cityStarted = weather.cityStarted
            successVC.cityEnd = weather.cityEnd
        }
    }
    
    //we check the return value of the model
    private func checkStatus(){
        switch weather.status{
        case .accepted:
            //if it's ok, we launch the next page
            performSegue(withIdentifier: "segueToResearchWeather", sender: nil)
        case .rejected(let error):
            //else, we launch an alert
            presentAlert(with: error)
        }
    }
}




//gestion du clavier dans cette extension

extension FormWeatherViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TextFieldCityStarted.resignFirstResponder()
        TextFieldCityEnd.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        TextFieldCityStarted.resignFirstResponder()
        TextFieldCityEnd.resignFirstResponder()
    }
}


// alert controller
extension FormWeatherViewController{
    func presentAlert(with error : String){
        let alerteVC = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alerteVC.addAction(action)
        present(alerteVC, animated: true, completion: nil)
    }
}
