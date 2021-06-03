//
//  FormWeatherViewController.swift
//  Baluchon
//
//  Created by Brian Friess on 27/05/2021.
//

import UIKit

class FormWeatherViewController: UIViewController{

  
    @IBOutlet weak var TextFieldCityStarted: UITextField!
    @IBOutlet weak var TextFieldCityEnd: UITextField!
    var weather = Weather(nameCityStarted: "", nameCityEnd: "", resultCityOne : ResultWeather(tempeture: 0.0, weather: ""), resultCityTwo: ResultWeather(tempeture: 0.0, weather: ""))
    var weatherService : WeatherServiceProtocol!
    var alerteManager = AlerteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpWeatherService(weatherService : weatherService)
    }
    
    //when we click on the button
    @IBAction func validate() {
        recoverCity()
        checkStatus()
    }
    
    
    //we give the value to the "Weather" model
    private func recoverCity(){
        let nameCityStarted = TextFieldCityStarted.text
        let nameCityEnd = TextFieldCityEnd.text
        weather.nameCityStarted = nameCityStarted
        weather.nameCityEnd = nameCityEnd
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
        case .rejected(let error):
            //else, we launch an alert
            presentAlert(with: error)
        }
    }
    

    
    private func callWeatherCityOne(){
        guard let cityStarted = TextFieldCityStarted.text else {return}
        
        weatherService.getWeather(city : cityStarted){[weak self] result in
            switch result{
            case .success(let resultWeather):
                self?.weather.resultCityOne = resultWeather
                self?.callWeatherCityTwo()
                print("ok")
            case .failure(_):
                self?.alerteManager.alerteVc(.failedDownloadWeatherCityOne, self!)
            }
        }
    }
    
    private func callWeatherCityTwo(){
        guard let cityEnd = TextFieldCityEnd.text else {return}
        
        weatherService.getWeather(city : cityEnd){[weak self] result in
            switch result{
            case .success(let resultWeather):
                self?.weather.resultCityTwo = resultWeather
                self?.performSegue(withIdentifier: "segueToResearchWeather", sender: nil)
            case .failure(_):
                self?.alerteManager.alerteVc(.failedDownloadWeatherCityTwo, self!)
            }
        }
    }
    
    // ou appeler fonction callWeatherCityTwo dans la completion et lancer après le segue.
    //mettre en palace result dans l'appel réseau ( ça à l'air mdr )
    
    func setUpWeatherService (weatherService : WeatherServiceProtocol) {
        self.weatherService = weatherService
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
