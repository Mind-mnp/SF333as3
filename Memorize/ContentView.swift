//
//  ContentView.swift
//  Memorize
//
//  Created by Class Demo on 5/10/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var isButtonTapped = false
    let weather_icon = ["☀️", "❄️", "🌧️", "🌈", "🌪️", "☃️", "🎄","🌸","☀️", "❄️", "🌧️", "🌈", "🌪️", "☃️", "🎄","🌸", ].shuffled()
    let sport_icon = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🏉","🎱", "⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🏉","🎱"].shuffled()
    let vehicles_icon = ["🚗", "⛵️", "🚌", "🏎️", "🛵", "✈️", "🚀","🛸", "🚗", "⛵️", "🚌", "🏎️", "🛵", "✈️", "🚀","🛸",].shuffled()

    @State private var current_theme_icon: [String] = []
    @State var cardCount = 16
    @State private var currentTheme = "Weather"

    init() {
        _current_theme_icon = State(initialValue: weather_icon)
    }

    var body: some View {
        VStack {
            Text("Memorize")
                .font(.custom("Adelle Sans Devanagari Bold", fixedSize: 45))
                .foregroundColor(Color(red: 93/255, green: 109/255, blue: 126/255))

            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 66))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: current_theme_icon[index])
                    .aspectRatio(5/7, contentMode: .fit)
            }
        }
        .foregroundColor(Color(red: 93/255, green: 109/255, blue: 126/255))
    }

    func cardCountAdjuster(by theme: String, symbol: String) -> some View {
        Button(action: {
            currentTheme = theme
            switch theme {
                case "Weather":
                    current_theme_icon = weather_icon
                case "Sport":
                    current_theme_icon = sport_icon
                case "Vehicles":
                    current_theme_icon = vehicles_icon
                default:
                    break
            }
        }, label: {
            VStack {
                //Image(systemName: symbol)
                //Image(currentTheme == theme ? systemName: symbol.fill : systemName: symbol)
                Image(systemName: currentTheme == theme ? "\(symbol).fill" : symbol)
                    .foregroundColor(Color(red: 93/255, green: 109/255, blue: 126/255))

                Text(theme).font(.system(size: 24))
                    .foregroundColor(Color(red: 93/255, green: 109/255, blue: 126/255))
            }
        })
    }
    //เรียกbutton
    var cardCountAdjusters: some View {
        HStack {
            cardCountAdjuster(by: "Weather", symbol: "cloud.rainbow.half")
            Spacer()
            cardCountAdjuster(by: "Sport", symbol: "basketball")
            Spacer()
            cardCountAdjuster(by: "Vehicles", symbol: "car")
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
}

struct CardView: View {
    let content: String
    
    @State var isFaceUp = true

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            withAnimation {
                isFaceUp.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
