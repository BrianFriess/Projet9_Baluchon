//
//  AlerteManager.swift
//  Baluchon
//
//  Created by Brian Friess on 31/05/2021.
//

import Foundation
import UIKit

struct AlerteManager{
    
    //we create an enumeration for our message alerteVC
    enum AlerteType{
        case failedDownloadWeatherCityOne
        case failedDownloadWeatherCityTwo
    

        
        var description : String{
            switch self{
            case .failedDownloadWeatherCityOne:
                return "Veuillez verifier le nom de la ville de départ ou votre connexion internet"
            case .failedDownloadWeatherCityTwo:
                return "Veuillez verifier le nom de la ville d'arrivée ou votre connexion internet"
            }
        }
    }
    

    
    func alerteVc(_ message: AlerteType, _ controller : UIViewController){
        let alertVC = UIAlertController(title: "Zéro!", message: "\(message.description)", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alertVC, animated: true, completion: nil)
        }
}
