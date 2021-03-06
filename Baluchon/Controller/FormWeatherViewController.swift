//
//  FormWeatherViewController.swift
//  Baluchon
//
//  Created by Brian Friess on 27/05/2021.
//

import UIKit

class FormWeatherViewController: UIViewController{

  
    @IBOutlet weak var buttonValidate: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var TextFieldCityStarted: UITextField!
    @IBOutlet weak var TextFieldCityEnd: UITextField!
    var weather = Weather(nameCityStarted: "", nameCityEnd: "", resultCityOne : ResultWeather(tempeture: 0.0, weather: "", icon: Data.init()), resultCityTwo: ResultWeather(tempeture: 0.0, weather: "", icon: Data.init()))
    var weatherService : WeatherServiceProtocol! = WeatherService(session: URLSession(configuration: .default), iconService: WeatherIconService())
    var alerteManager = AlerteManager()
    

    
    //when we click on the button, we call the function recoverCity and checkStatus
    @IBAction func validate() {
        recoverCity()
        checkStatus()
    }
    
    enum ButtonHidden{
        case buttonIsHidden
        case buttonIsVisible
    }
    //we use this function for hide the button or not
    func setButton(_ style : ButtonHidden){
        switch style{
        case .buttonIsHidden:
            buttonValidate.isHidden = true
            activityIndicator.isHidden = false
        case .buttonIsVisible:
            buttonValidate.isHidden = false
            activityIndicator.isHidden=true
        }
    }
    
    
    //we give the value of the textFiled to the "Weather" model
    private func recoverCity(){
        weather.nameCityStarted = TextFieldCityStarted.text
        weather.nameCityEnd = TextFieldCityEnd.text
    }
    
    //we give the value to the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToResearchWeather"{
            let successVC = segue.destination as! researchWeatherViewController
            successVC.cityStarted = weather.nameCityStarted
            successVC.cityEnd = weather.nameCityEnd
            successVC.resultCityOne = weather.resultCityOne
            successVC.resultCityTwo = weather.resultCityTwo
        }
    }
    
    //we check the return value of the model
    private func checkStatus(){
        switch weather.status{
        case .accepted:
            //if it's ok, we call the network call
            callWeatherCityOne()
           setButton(.buttonIsHidden)
           
        case .rejected(let error):
            //else, we launch an alert
            presentAlert(with: error)
        }
    }
    

    
    private func callWeatherCityOne(){
        guard let cityStarted = TextFieldCityStarted.text else {return}
        
        weatherService.getWeather(city : cityStarted){ result in
            switch result{
            case .success(let resultWeather):
                //if the network call is a success, we give the result at the model and we call an other network call for the 2nd city
                self.weather.resultCityOne = resultWeather
                self.callWeatherCityTwo()
            case .failure(_):
                //else, we call an alerte
                self.alerteManager.alerteVc(.failedDownloadWeatherCityOne, self)
                self.setButton(.buttonIsVisible)
            }
        }
    }
    
    private func callWeatherCityTwo(){
        guard let cityEnd = TextFieldCityEnd.text else {return}
        
        weatherService.getWeather(city : cityEnd){result in
            switch result{
            case .success(let resultWeather):
                //if the network call is a success, we give the result at the model and we take the value to the segue
                self.weather.resultCityTwo = resultWeather
                self.performSegue(withIdentifier: "segueToResearchWeather", sender: nil)
                self.setButton(.buttonIsVisible)
            case .failure(_):
                self.alerteManager.alerteVc(.failedDownloadWeatherCityTwo, self)
                self.setButton(.buttonIsVisible)
            }
        }
    }
}




//keyBoar dManagement

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
