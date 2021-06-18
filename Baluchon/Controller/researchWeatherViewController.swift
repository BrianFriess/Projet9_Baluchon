//
//  researchWeathViewController.swift
//  Baluchon
//
//  Created by Brian Friess on 27/05/2021.
//

import UIKit

class researchWeatherViewController: UIViewController {
    
    @IBOutlet weak var resultCityStarted: UILabel!
    @IBOutlet weak var weatherCityStarted: UILabel!
    @IBOutlet weak var tempetureCityStarted: UILabel!
    @IBOutlet weak var iconCityStarted: UIImageView!
    
    @IBOutlet weak var resultCityEnd: UILabel!
    @IBOutlet weak var weatherCityEnd: UILabel!
    @IBOutlet weak var tempetureCityEnd: UILabel!
    @IBOutlet weak var iconCityEnd: UIImageView!
    

    var cityStarted : String!
    var cityEnd : String!
    var resultCityOne : ResultWeather!
    var resultCityTwo : ResultWeather!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultCityStarted.text = cityStarted
        resultCityEnd.text = cityEnd
        updateLabelCityOne(resultWeather: resultCityOne)
        updateLabelCityTwo(resultWeather: resultCityTwo)
    }
    
    func updateLabelCityOne(resultWeather : ResultWeather){
        tempetureCityStarted.text = String(resultWeather.tempeture)
        weatherCityStarted.text = resultWeather.weather
        iconCityStarted.image = UIImage(data : resultWeather.icon)
    }
    
    func updateLabelCityTwo(resultWeather : ResultWeather){
        tempetureCityEnd.text = String(resultWeather.tempeture)
        weatherCityEnd.text = resultWeather.weather
        iconCityEnd.image = UIImage(data : resultWeather.icon)
    }
}
