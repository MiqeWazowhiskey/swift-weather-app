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
            if (locationManager.isLoading){
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            if(locationManager.location == nil && locationManager.isLoading==false){
                WelcomeView()
                    .environmentObject(locationManager)
            }
            else{
                if weather != nil {
                    WeatherView(weatherData: weather!)
                }
                else{
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .task {
                            do{
                                weather = try await weatherManager.getWeatherData(longtitude:
                                                locationManager.location!.longitude, latitude: locationManager.location!.latitude)
                            }
                            catch {
                                print("Something went wrong.")
                            }
                        }
                }
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
