//
//  WeatherModelTest.swift
//  BaluchonTests
//
//  Created by Brian Friess on 21/06/2021.
//

import XCTest
@testable import Baluchon

class WeatherModelTest: XCTestCase {

    var weather: Weather!

    override func setUp() {
        super.setUp()
        weather = Weather()
    }

    func testIfNameCityStartedEqualNil_ReturnRejected(){
        
        weather.nameCityStarted = nil
        weather.nameCityEnd = "paris"
        
        switch weather.status{
        case .accepted:
            XCTAssert(false)
        case .rejected(_):
            XCTAssert(true)
        }
    }
    
    func testIfNameCityStartedEqualEmpty_ReturnRejected(){
        
        weather.nameCityStarted = ""
        weather.nameCityEnd = "paris"
        
        switch weather.status{
        case .accepted:
            XCTAssert(false)
        case .rejected(_):
            XCTAssert(true)
        }
    }
    
    func testIfNameCityEndEqualNil_ReturnRejected(){
        
        weather.nameCityStarted = "paris"
        weather.nameCityEnd = nil
        
        switch weather.status{
        case .accepted:
            XCTAssert(false)
        case .rejected(_):
            XCTAssert(true)
        }
    }
    
    func testIfNameCityEndEqualEmpty_ReturnRejected(){
        
        weather.nameCityStarted = "paris"
        weather.nameCityEnd = ""
        
        switch weather.status{
        case .accepted:
            XCTAssert(false)
        case .rejected(_):
            XCTAssert(true)
        }
    }
    
    func testIfNameCityEndEqualCity_ReturnAccepted(){
        
        weather.nameCityStarted = "paris"
        weather.nameCityEnd = "Londres"
        
        switch weather.status{
        case .accepted:
            XCTAssert(true)
        case .rejected(_):
            XCTAssert(false)
        }
    }
    
}
