//
//  researchWeathViewController.swift
//  Baluchon
//
//  Created by Brian Friess on 27/05/2021.
//

import UIKit

class researchWeatherViewController: UIViewController {
    
    @IBOutlet weak var resultCityStarted: UILabel!
    @IBOutlet weak var resultCityEnd: UILabel!
    var cityStarted : String!
    var cityEnd : String!
    
    override func viewDidLoad() {
        resultCityStarted.text = cityStarted
        resultCityEnd.text = cityEnd
    }
    
    


}
