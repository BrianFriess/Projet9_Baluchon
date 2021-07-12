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
    case errorIcon
    case errorReturnIcon
}

class WeatherService : WeatherServiceProtocol {
    

    
    private let baseUrl =  "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=ff3e43da662d54517fae410cfb40ad14&mode=json&q="
    //we create an UrlSession
    private var session : URLSession
    var iconService : WeatherIconService
    var resultIcon  = Data.init()

    //we create an init for session
    init (session : URLSession, iconService : WeatherIconService){
        self.session = session
        self.iconService = iconService
    }
    
    //this is our network call
    func getWeather(city: String, completion: @escaping (Result<ResultWeather, CityError>) -> Void) {
        
        // we use this to encode our URL in case if our city have a space
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let weatherUrl = URL(string: baseUrl + cityEncoded)  else {
            completion(.failure(.errorCity))
            return
        }
    
        //we create our task with our weatherUrl
        let task = session.dataTask(with: weatherUrl) { (data, response, error) in
            DispatchQueue.main.async {
                
                // we check if our response is ok
                guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.errorDownload))
                    return
                }
                
                //we retrieve the data we need in the JSON
                guard let responseJSON = try? JSONDecoder().decode(DataDecodable.self, from: data),
                      let tempeture = responseJSON.main?.temp, let weather = responseJSON.weather?.first?.main, let idIcon = responseJSON.weather?.first?.icon else {
                    completion(.failure(.errorDecode))
                    return
                }
                
                //we call the function getIcon to retrieve the logo in an other network call
                self.iconService.getIcon(idIcon : idIcon) { result in
                    switch result{
                    case .success(let dataIcon):
                        self.resultIcon = dataIcon
                        //we create an object with all the data we need
                        let resultWeather = ResultWeather(tempeture: tempeture, weather: weather, icon : self.resultIcon)
                        completion(.success(resultWeather))
                    case .failure(_):
                        completion(.failure(.errorReturnIcon))
                    }
                }
            }
        }
        task.resume()
    }
}

class WeatherIconService{
    
    private var session : URLSession
    private let baseUrlIcon = "http://openweathermap.org/img/w/"
    private let png = ".png"
    

    //we create an init for session
    init (session : URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    
        func getIcon(idIcon : String, completion: @escaping (Result<Data, CityError>) -> Void){
            guard let iconUrl = URL(string: baseUrlIcon + idIcon + png) else {
                completion(.failure(.errorIcon))
                return
            }
            
            let task = session.dataTask(with: iconUrl) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completion(.failure(.errorDownload))
                        return
                    }
                    completion(.success(data))
                }
            }
            task.resume()
        }
    
}





struct DataDecodable : Decodable{
    var coord : CoordinateDecodable?
    var weather : [WeatherDecodable]?
    var main : TempetureDecodable?
}

struct CoordinateDecodable : Decodable{
    var lon: Double?
    var lat : Double?
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



