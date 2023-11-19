//
//  ContentView.swift
//  weather-app
//
//  Created by Ali Kağan Yılmaz on 19.11.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var body: some View {
        VStack {
            WelcomeView()
                .environmentObject(locationManager)
        }
        .padding()
        .background(Color(hue: 0.537, saturation: 1.0, brightness: 1.0))
        .foregroundColor(.white)
    }
}

#Preview {
    ContentView()
}
