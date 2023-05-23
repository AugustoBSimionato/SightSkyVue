//
//  WeatherView.swift
//  SightSkyVue
//
//  Created by Augusto Simionato on 23/05/23.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Group {
                        Text(weather.name)
                            .bold()
                            .font(.title)
                        Text("Today, \(Date().formatted(.dateTime.day().month().hour().minute()))")
                            .fontWeight(.light)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.54))
                .cornerRadius(10)
                .shadow(color: .black, radius: 40, x: 5, y: 10)
                
                Spacer()
                
                VStack {
                    Text(weather.main.feelsLike.roundDouble() + "°")
                        .font(.system(size: 85))
                        .bold()
                        .padding(.top, 100)
                    
                    VStack(spacing: 20) {
                        Text(weather.weather[0].main)
                            .font(.system(size: 30))
                            .bold()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack {
                    HStack {
                        Text("Live")
                            .font(.system(size: 25))
                            .bold()
                        LiveIndicator()
                    }
                    .frame(alignment: .leading)
                    
                    HStack {
                        WeatherRowView(logo: "thermometer", name: "Maximum", value: (weather.main.tempMax.roundDouble() + "°"))
                        
                        Spacer()
                        
                        WeatherRowView(logo: "thermometer", name: "Minimum", value: (weather.main.tempMin.roundDouble() + "°"))
                    }
                    .padding()
                    HStack {
                        WeatherRowView(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                        
                        Spacer()
                        
                        WeatherRowView(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct LiveIndicator: View {
    @State private var isAnimating = false
    @State private var opacity: Double = 1.0

    var body: some View {
        Circle()
            .frame(width: 10, height: 10)
            .foregroundColor(.red)
            .opacity(opacity)
            .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true))
            .onAppear {
                isAnimating = true
                animateOpacity()
            }
    }

    func animateOpacity() {
        withAnimation {
            opacity = isAnimating ? 0.5 : 1.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            animateOpacity()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
