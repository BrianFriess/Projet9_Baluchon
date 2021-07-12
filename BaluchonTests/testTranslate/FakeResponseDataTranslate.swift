//
//  FakeResponseDataTranslate.swift
//  BaluchonTests
//
//  Created by Brian Friess on 22/06/2021.
//

import Foundation

class FakeResponseDataTranslate{
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://translation.googleapis.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://translation.googleapis.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class TranslateError: Error {}
    static let error = TranslateError()
    
    static var translateCorrectData: Data?{
        let bundle = Bundle(for: FakeResponseDataTranslate.self)
        let url = bundle.url(forResource: "translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let translateIncorrectData = "erreur".data(using: .utf8)!
    
}
