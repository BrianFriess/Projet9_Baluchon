//
//  MoneyServiceTest.swift
//  BaluchonTests
//
//  Created by Brian Friess on 23/06/2021.
//

import XCTest
@testable import Baluchon

class MoneyServiceTest: XCTestCase {
    
    var sut : MoneyService!


    override func tearDown(){
        super.tearDown()
        sut = nil
    }

    func test_GivenErrorNotNilAndResponseKO_WhenGetMoney_ThenHaveAnError(){
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        sut = MoneyService(session: URLSessionFake(data:nil , response: FakeResponseDataMoney.responseKO, error: FakeResponseDataMoney.error), url: UrlObjectMock.init(url: "http://data.fixer.io") )
        
        sut.getMoney { result in
            XCTAssertEqual(result, .failure(.errorDownload))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func test_GivenErrorNilAndIncorrectData_WhenGetMoney_ThenHaveAnError(){
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
    
        sut = MoneyService(session: URLSessionFake(data:FakeResponseDataMoney.moneyIncorrectData , response: FakeResponseDataMoney.responseOK , error: nil), url: UrlObjectMock.init(url: "http://data.fixer.io") )
        
        
        sut.getMoney { result in
            XCTAssertEqual(result, .failure(.errorDecode))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    
    func test_GivenErrorNilAndCorrectData_WhenGetMoney_ThenHaveASuccess(){
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        sut = MoneyService(session: URLSessionFake(data:FakeResponseDataMoney.moneyCorrectData , response: FakeResponseDataMoney.responseOK , error: nil), url: UrlObjectMock.init(url: "http://data.fixer.io") )
        
            sut.getMoney { result in
                XCTAssertEqual(result, .success(FakeResponseDataMoney.moneyData))
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func test_GivenKoUrl_WhenGetMoney_ThenHaveAnError(){
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        sut = MoneyService(session: URLSessionFake(data:FakeResponseDataMoney.moneyCorrectData , response: FakeResponseDataMoney.responseKO , error: nil), url: UrlObjectMock.init(url: "") )
        
            sut.getMoney { result in
                XCTAssertEqual(result, .failure(.errorMoney))
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func test_GiverErrorNilAndCorrectData_whenGetValue_ThenHaveSuccess(){

        let valueUsd = 1.190639
        let valueRub = 87.063939
        let valueJpy = 131.893071
        

        XCTAssertEqual(FakeResponseDataMoney.moneyData.rates?.getValue("USD"), valueUsd)
        XCTAssertEqual(FakeResponseDataMoney.moneyData.rates?.getValue("JPY"), valueJpy)
        XCTAssertEqual(FakeResponseDataMoney.moneyData.rates?.getValue("RUB"), valueRub)
        XCTAssertEqual(FakeResponseDataMoney.moneyData.rates?.getValue(""), 0.0)

            
    }
    
}





