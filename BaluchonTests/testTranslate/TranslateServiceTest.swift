//
//  TranslateServiceTest.swift
//  BaluchonTests
//
//  Created by Brian Friess on 28/06/2021.
//

import XCTest
@testable import Baluchon

class TranslateServiceTest: XCTestCase {

    var sut : TranslateService!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_GivenErrorNotNilAndResponseKO_WhenGetTrad_ThenHaveAnError(){
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        sut = TranslateService(session: URLSessionFake(data:nil , response: FakeResponseDataTranslate.responseKO, error: FakeResponseDataTranslate.error) )
        
        sut.getTrad("bonjour") { result in
            XCTAssertEqual(result, .failure(.errorDownload))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func test_GivenWrongURLTranslate_WhenGetTrad_ThenHaveAnError(){
        
        let str = String(
            bytes: [0xD8, 0x00] as [UInt8],
            encoding: String.Encoding.utf16BigEndian)!
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        sut = TranslateService(session: URLSessionFake(data:nil , response: FakeResponseDataTranslate.responseOK, error: FakeResponseDataTranslate.error) )
        
        sut.getTrad(str) { result in
            XCTAssertEqual(result, .failure(.errorTraduct))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func test_GivenWrongDecodable_WhenGetTrad_ThenHaveAnError(){
    
        let expectation = XCTestExpectation(description: "wait for queue change")
        sut = TranslateService(session: URLSessionFake(data:FakeResponseDataTranslate.translateIncorrectData , response: FakeResponseDataTranslate.responseOK, error: nil) )
        
        sut.getTrad("bonjour") { result in
            XCTAssertEqual(result, .failure(.errorDecode))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    
    func test_GivenDataAndResponseOK_WhenGetTrad_ThenOk(){
    
        let trueResponse = "Hello"
        
        let expectation = XCTestExpectation(description: "wait for queue change")
        
        sut = TranslateService(session: URLSessionFake(data:FakeResponseDataTranslate.translateCorrectData , response: FakeResponseDataTranslate.responseOK, error: nil) )
        
        sut.getTrad("bonjour") { result in
            XCTAssertEqual(result, .success(trueResponse))
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
