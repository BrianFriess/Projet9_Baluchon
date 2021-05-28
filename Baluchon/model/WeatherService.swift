//
//  WeatherService.swift
//  Baluchon
//
//  Created by Brian Friess on 28/05/2021.
//

import Foundation

class WeatherService{
    
    var cityStartService = "londres"
    var cityEndService = "paris"
    
    
    
    private static let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=ff3e43da662d54517fae410cfb40ad14&mode=json&q=londres")!

    
    static func getWeather() {
        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode(DataDecodable.self, from: data),
                       let tempeture = responseJSON.main?.temp, let weather = responseJSON.weather?.first?.main{
                            print(tempeture)
                            print(weather)
                    }
                }
            }
        }
        task.resume()
    }
}

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
