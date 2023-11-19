//
//  WeatherView.swift
//  weather-app
//
//  Created by Ali Kağan Yılmaz on 19.11.2023.
//

import SwiftUI

struct WeatherView: View {
    var weatherData: ResponseBody
    
    init(weatherData: ResponseBody) {
        self.weatherData = weatherData
    }
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text(weatherData.name)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 30))
                    Text("\(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.padding()
                Text("\(String(format: "%.1f",weatherData.main.feels_like-272.15))" + "°")
                    .font(.system(size: 50))
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .padding()
            }
            Spacer()
            GeometryReader {geometry in
                Image("weatherIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            }
            GeometryReader {geometry in
                VStack{
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 20) {
                          
                        Detail(logo:"tempIcon",value: "\(String(format: "%.1f",weatherData.main.temp_min-272.15))°",title: "Min Temp")
                        
                        Detail(logo:"tempIcon",value: "\(String(format: "%.1f",weatherData.main.temp_max-272.15))°",title: "Max Temp")
                        
                        Detail(logo:"humidityIcon",value: "\(String(format: "%.1f",weatherData.main.humidity))%",title: "Humidity")
                            
                        Detail(logo:"windIcon",value: "\(String(format: "%.1f", weatherData.wind.speed)) m/s",title: "Wind")
                            
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(alignment: .center)
                }
                
                .frame(maxWidth: geometry.size.width,maxHeight:geometry.size.height)
                .background(Color.clear)
                .clipShape(.rect(
                    topLeadingRadius: 30,
                    bottomLeadingRadius: 30,
                    bottomTrailingRadius: 30,
                    topTrailingRadius: 30
                ))
                
            }
            
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            
        }
    }
}

#Preview {
    WeatherView(weatherData: ResponseBody(coord: ResponseBody.CoordinatesResponse(lon: 0.0, lat: 0.0), weather:[
        ResponseBody.WeatherResponse(id:800,main:"Clear",description:"clearsky",icon:"01d"),ResponseBody.WeatherResponse(id: 701, main:"Mist",description: "mist", icon: "50d")
    ], main: ResponseBody.MainResponse(temp: 25.0, feels_like: 24.0, temp_min: 20.0, temp_max: 28.0, pressure: 1010.0, humidity: 50.0), name: "City", wind: ResponseBody.WindResponse(speed: 5.0, deg: 0.0)))
}
