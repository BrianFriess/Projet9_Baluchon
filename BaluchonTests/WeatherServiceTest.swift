//
//  WeatherServiceTest.swift
//  BaluchonTests
//
//  Created by Brian Friess on 14/06/2021.
//

import XCTest
@testable import Baluchon

class WeatherServiceTest: XCTestCase {


    var weatherService : WeatherService!
    
    override func setUp() {
        super.setUp()
        weatherService = WeatherService()
    }
    
    //func testGetWeatherShouldPostFailedCallBackIfError(){
        //  let weatherServiceTest = WeatherService(
        //    weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseDataWeather.error))
    //}
    

}
