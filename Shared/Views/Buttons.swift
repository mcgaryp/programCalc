//
//  Buttons.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/17/21.
//

import SwiftUI

struct Buttons: View {
    private let symbolsList: Array<Array<String>> = [
        ["LS", "D", "E", "F", "Del"],
        ["RS", "A", "B", "C", "X"],
        ["~", "7", "8", "9", "/"],
        ["^", "4", "5", "6", "-"],
        ["|", "1", "2", "3", "+"],
    ]
    var body: some View {
        VStack {
            Calculations()
            Spacer()
            ForEach(symbolsList, id: \.self) { symbols in
                Row(symbols: symbols)
            }
            
            GeometryReader { geometry in
                HStack(spacing: 3) {
                    Spacer()
                    MyButton(symbol: "&")
                    MyButton(symbol: "0")
                        .frame(width: geometry.size.width * 0.40)
                    MyButton(symbol: "+/-")
                    MyButton(symbol: "=")
                    Spacer()
                }
            }
        }
    }
}

struct Row: View {
    var symbols: Array<String>
    var body: some View {
        HStack(spacing: 3) {
            Spacer()
            ForEach(symbols, id: \.self) { symbol in
                MyButton(symbol: symbol)
            }
            Spacer()
        }
    }
}

struct MyButton: View {
//    var callback: CGFunction
    var symbol: String
    var body: some View {
        Button(action: {}, label: {
            Text(symbol)
                .foregroundColor(.white)
                .font(.system(size: 20))
                .minimumScaleFactor(0.001)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray)
                .clipShape(Capsule())
        })
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
