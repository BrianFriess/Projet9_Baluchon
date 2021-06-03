//
//  WeatherService.swift
//  Baluchon
//
//  Created by Brian Friess on 28/05/2021.
//

import Foundation



protocol  WeatherServiceProtocol {
    func getWeather(city : String, completion : @escaping (Result<ResultWeather, CityError>) -> Void)
}

enum CityError : Error{
    case errorCity
    case errorDownload
    case errorDecode
}

class WeatherService : WeatherServiceProtocol {
    
    private let baseUrl =  "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=ff3e43da662d54517fae410cfb40ad14&mode=json&q="
    
    func getWeather(city: String, completion: @escaping (Result<ResultWeather, CityError>) -> Void) {
        let session = URLSession(configuration: .default)
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let weatherUrl = URL(string: baseUrl + cityEncoded) else {
            completion(.failure(.errorCity))
            return
        }
        
        let task = session.dataTask(with: weatherUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.errorDownload))
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(DataDecodable.self, from: data),
                      let tempeture = responseJSON.main?.temp, let weather = responseJSON.weather?.first?.main else {
                    completion(.failure(.errorDecode))
                        return
                }
                
                let resultWeather = ResultWeather(tempeture: tempeture, weather: weather)
                completion(.success(resultWeather))
            }
        }
        task.resume()
    }
    
}

    
    
     /*func getWeather(city : String, callback : @escaping (Bool, ResultWeather?) -> Void) {
        let session = URLSession(configuration: .default)
        
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        guard let weatherUrl = URL(string: baseUrl + cityEncoded) else {
            callback(false, nil)
            return
        }
        
        let task = session.dataTask(with: weatherUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback (false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(DataDecodable.self, from: data),
                      let tempeture = responseJSON.main?.temp, let weather = responseJSON.weather?.first?.main else {
                        callback(false, nil)
                        return
                }
                let resultWeather = ResultWeather(tempeture: tempeture, weather: weather)
                callback(true, resultWeather)
            }
        }
        task.resume()
    }
}*/

//créer protocole pour que WeatherService se conforme à lui et utiliser getWeather() dans le controller (le controleur ne connait que le protocole)

struct DataDecodable : Decodable{
    var coord : CoordinateDecodable?
    var weather : [WeatherDecodable]?
    var main : TempetureDecodable?
    
    /*enum codingKeys : String, CodingKey{
        case coordinate = "coord"
        case weather = "weather"
        case temperature = "main"
    }*/
    //codingKey ne fonctionne pas ??
}

struct CoordinateDecodable : Decodable{
    var lon: Double?
    var lat : Double?
    
   /* enum codingKeys : String, CodingKey{
        case longitude = "lon"
        case latitude = "lat"
    }*/
}

struct WeatherDecodable : Decodable{
    var id : Int?
    var main : String?
    var description : String?
    var icon : String?
    
}

struct TempetureDecodable : Decodable{
    var temp : Double?
    var feels_like : Double?
    var temp_min : Double?
    var temp_max : Double?
    var pressure : Int?
    var humidity : Int?
}



