//
//  Detail.swift
//  weather-app
//
//  Created by Ali Kağan Yılmaz on 19.11.2023.
//

import SwiftUI

struct Detail: View {
    var logo: String
    var value: String
    var title: String
    
    var body: some View {
            HStack(){
                ZStack{
                    Image(logo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                        .frame(maxWidth:40)
                }
                .background(Color(hue: 1.0, saturation: 0.007, brightness: 0.881).opacity(0.2))
                .cornerRadius(100)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .foregroundColor(Color.white)
                    Text(value)
                        .foregroundColor(Color.white)
                }
                
            }
        
            .frame(minWidth: UIScreen.main.bounds.width*0.33)
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(30)
        }
}
    
#Preview {
    Detail(logo: "tempIcon", value: "0", title: "Max Temp")
}

