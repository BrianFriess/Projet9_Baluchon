//
//  WeatherServiceTest.swift
//  BaluchonTests
//
//  Created by Brian Friess on 14/06/2021.
//

import XCTest
@testable import Baluchon

class WeatherServiceTest: XCTestCase {


    var sut : WeatherService!
    var sutIcon : WeatherService!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_GivenErrorNotNilAndResponseKO_WhenGetWeather_ThenHaveAnError(){
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        sut = WeatherService(session: URLSessionFake(data:nil , response: FakeResponseDataWeather.responseKO, error: FakeResponseDataWeather.error), iconService: WeatherIconService(session: URLSessionFake(data: nil, response: nil, error: nil)))
        
        sut.getWeather(city: "paris") { result in
            XCTAssertEqual(result, .failure(.errorDownload))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func test_GivenWrongURLCity_WhenGetWeather_ThenHaveAnError(){
        
        let str = String(
            bytes: [0xD8, 0x00] as [UInt8],
            encoding: String.Encoding.utf16BigEndian)!
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        sut = WeatherService(session: URLSessionFake(data:nil , response: FakeResponseDataWeather.responseOK, error: FakeResponseDataWeather.error), iconService: WeatherIconService(session: URLSessionFake(data: nil, response: nil, error: nil)))
        
        sut.getWeather(city: str) { result in
            XCTAssertEqual(result, .failure(.errorCity))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func test_GivenWrongDecodable_WhenGetWeather_ThenHaveAnError(){
    
        let expectation = XCTestExpectation(description: "wait for queue change")
        sut = WeatherService(session: URLSessionFake(data:FakeResponseDataWeather.weatherIncorrectData , response: FakeResponseDataWeather.responseOK, error: nil), iconService: WeatherIconService(session: URLSessionFake(data: nil, response: nil, error: nil)))
        
        sut.getWeather(city: "Paris") { result in
            XCTAssertEqual(result, .failure(.errorDecode))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func test_GivenDataAndResponseOk_WhenGetWeather_ThenOKAndGetIconOKToo(){
    
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        sut = WeatherService(session: URLSessionFake(data:FakeResponseDataWeather.weatherCorrectData , response: FakeResponseDataWeather.responseOK, error: nil), iconService: WeatherIconService(session: URLSessionFake(data: FakeResponseDataWeather.iconData, response: FakeResponseDataWeather.responseOK, error: nil)))

        sut.getWeather(city: "Paris") { result in
            XCTAssertEqual(result, .success(FakeResponseDataWeather.resultData))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func test_GivenDataAndResponseOk_WhenGetWeather_ThenOKAndGetIconResponseNok(){
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        sut = WeatherService(session: URLSessionFake(data:FakeResponseDataWeather.weatherCorrectData , response: FakeResponseDataWeather.responseOK, error: nil), iconService: WeatherIconService(session: URLSessionFake(data: FakeResponseDataWeather.iconData, response: FakeResponseDataWeather.responseKO, error: nil)))

        sut.getWeather(city: "Paris") { result in
            XCTAssertEqual(result, .failure(.errorReturnIcon))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func test_GivenDataAndResponseOk_WhenGetWeather_ThenOKAndGetIconUrlNok(){

        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        sut = WeatherService(session: URLSessionFake(data:FakeResponseDataWeather.weatherFakeData , response: FakeResponseDataWeather.responseOK, error: nil), iconService: WeatherIconService(session: URLSessionFake(data: nil, response: FakeResponseDataWeather.responseKO, error: FakeResponseDataWeather.error)))

        sut.getWeather(city: "Paris") { result in
               XCTAssertEqual(result, .failure(.errorReturnIcon))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
