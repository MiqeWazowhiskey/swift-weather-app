//
//  WeatherManager.swift
//  weather-app
//
//  Created by Ali Kağan Yılmaz on 19.11.2023.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    func getWeatherData (longtitude: CLLocationDegrees, latitude: CLLocationDegrees)async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longtitude)&appid=\(DebugENV().API_KEY)"
        ) else {
            fatalError("Fatality")
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        let (responseBody, response) = try await URLSession.shared.data(for:request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Fatality")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: responseBody)
        
        return decodedData
        
    }
}




struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

class BaseENV {
    let dict: NSDictionary
    
    init(resourceName: String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath)
        else{
            fatalError("Fatality")
        }
        self.dict = plist
    }
}
protocol ApiKeyable {
    var API_KEY: String {get}
}
    
class DebugENV: BaseENV, ApiKeyable {
    init(){
        super.init(resourceName: "propertyList")
    }
    
    public var API_KEY:String {
        dict.object(forKey: "API_KEY") as! String
    }
}
