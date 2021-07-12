//
//  TraductService.swift
//  Baluchon
//
//  Created by Brian Friess on 10/06/2021.
//

protocol TranslateServiceProtocol {
    func getTrad(_ quote : String, completion: @escaping (Result<String,TradError>) -> Void)
}

enum TradError : Error{
    case errorTraduct
    case errorDownload
    case errorDecode
}

import Foundation

class TranslateService : TranslateServiceProtocol{
    
    //we create an UrlSession
    private var session : URLSession
    
    private let baseUrl  = "https://translation.googleapis.com/language/translate/v2/?target=en&key=AIzaSyD-QkVIg5Ww2FNL8JBI1vflmAel0_IJJDU&q="
    
    //we create an init for session
    init (session : URLSession){
        self.session = session
    }
    
    //this is our network call
    func getTrad(_ quote : String, completion: @escaping (Result<String,TradError>) -> Void) {
    
        // we use this to encode our URL in case if our quote have a space
        guard let quoteEncoded = quote.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let quoteUrl = URL(string: baseUrl + quoteEncoded) else {
            completion(.failure(.errorTraduct))
            return
        }
        
        //we create our task with our quoteUrl
        let task = session.dataTask(with: quoteUrl) { (data, response, error) in
            DispatchQueue.main.async {
                
                // we check if our response is ok
                guard let data = data , error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                    completion(.failure(.errorDownload))
                    return
                }
                //we retrieve the data we need in the JSON
                guard let responseJSON = try? JSONDecoder().decode(DataTranslateDecodable.self, from: data), let translate = responseJSON.data?.translations?.first?.translatedText else{
                    completion(.failure(.errorDecode))
                    return
                }
                
                completion(.success(translate))
            }
        }
        task.resume()
    }
 
}

struct DataTranslateDecodable : Decodable {
    var data : TranslationDecodable?
}

struct TranslationDecodable : Decodable{
    var translations : [TranslatedTextDecodable]?
    
}

struct TranslatedTextDecodable : Decodable {
    var translatedText : String?
    var detectedSourceLanguage : String?
}
