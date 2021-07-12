//
//  Weather.swift
//  Baluchon
//
//  Created by Brian Friess on 27/05/2021.
//

import Foundation

struct Weather{
    var nameCityStarted : String?
    var nameCityEnd : String?
    var resultCityOne : ResultWeather?
    var resultCityTwo : ResultWeather?
    
    enum Status{
      case accepted
      case rejected(String)
    }

    //we check the value and we return a String for an alerte 
    var status: Status {
        if nameCityStarted == nil || nameCityStarted == "" {
            return .rejected("Il manque votre ville de départ !")
        } else if nameCityEnd == nil || nameCityEnd == "" {
          return .rejected("Il manque votre ville d'arrivée !")
        }
        return .accepted
    }
}

struct ResultWeather : Equatable{
    var tempeture : Double
    var weather : String
    var icon : Data
}
