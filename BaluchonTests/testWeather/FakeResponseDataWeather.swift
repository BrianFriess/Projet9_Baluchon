//
//  FakeResponseDataWeather.swift
//  BaluchonTests
//
//  Created by Brian Friess on 14/06/2021.
//

import Foundation

@testable import Baluchon

class FakeResponseDataWeather{
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://api.openweathermap.org")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://api.openweathermap.org")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class WeatherError: Error {}
    static let error = WeatherError()
    
    static var weatherCorrectData: Data?{
        let bundle = Bundle(for: FakeResponseDataWeather.self)
        let url = bundle.url(forResource: "weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
        
        static var weatherFakeData: Data?{
            let bundle = Bundle(for: FakeResponseDataWeather.self)
            let url = bundle.url(forResource: "weatherFake", withExtension: "json")!
            return try! Data(contentsOf: url)
    }
    
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
    
    static let iconData = "03d".data(using: .utf8)!
    
    static let resultData : ResultWeather = .init(tempeture: 25.99, weather: "Clouds", icon: "03d".data(using: .utf8)!)
    
    //static let urlIcon = "http://openweathermap.org/img/w/"
}
