//
//  Welcome.swift
//  weather-app
//
//  Created by Ali Kağan Yılmaz on 19.11.2023.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        VStack{
            Spacer()
            Text("Weather App")
                .font(.largeTitle)
                .fontWeight(.light)
            Text("Please share your location to see weather.")
                .bold()
                .padding()
            
            LocationButton(.shareCurrentLocation){
                locationManager.getCurrentLocation()
            }
            .cornerRadius(50)
            .foregroundColor(.white)
            Spacer()
            Image("weatherIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .multilineTextAlignment(.center)
        
    }
    
}

#Preview {
    WelcomeView()
}
