//
//  ContentView.swift
//  weather-app
//
//  Created by Ali Kağan Yılmaz on 19.11.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @State var weather: ResponseBody?
    var weatherManager = WeatherManager()

    
    var body: some View {
        
        VStack {
            if let currentWeather = weather  {
                WeatherView(weatherData: currentWeather)
            }
            else if let location = locationManager.location {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .task {
                        do{weather = try await weatherManager.getWeatherData(longtitude:location.longitude, latitude: location.latitude)
                        }
                        catch {
                            print("Something went wrong.")
                        }
                    }
            }
            else if locationManager.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else{
                WelcomeView()
                    .environmentObject(locationManager)
            }
        }
        .padding()
        .background(Color(hue: 0.537, saturation: 1.0, brightness: 1.0))
        .foregroundColor(.white)
    }
}

#Preview {
    ContentView()
}
