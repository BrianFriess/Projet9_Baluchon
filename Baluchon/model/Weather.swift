//
//  Weather.swift
//  Baluchon
//
//  Created by Brian Friess on 27/05/2021.
//

import Foundation

struct Weather{
    var cityStarted : String?
    var cityEnd : String?
    
    enum Status{
      case accepted
      case rejected(String)
    }

    var status: Status {
        if cityStarted == nil || cityStarted == "" {
            return .rejected("Il manque votre ville de départ !")
        } else if cityEnd == nil || cityEnd == "" {
          return .rejected("Il manque votre ville d'arrivée !")
        }
        return .accepted
    }

}
