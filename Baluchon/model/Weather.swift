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

    var status: Status {
        if nameCityStarted == nil || nameCityStarted == "" {
            return .rejected("Il manque votre ville de départ !")
        } else if nameCityEnd == nil || nameCityEnd == "" {
          return .rejected("Il manque votre ville d'arrivée !")
        }
        return .accepted
    }
}
