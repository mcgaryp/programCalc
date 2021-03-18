//
//  Buttons.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/17/21.
//

import SwiftUI

struct Buttons: View {
    private let symbolsList: Array<Array<String>> = [
        ["chevron.left.two", "D", "E", "F", "delete.left.fill"],
        ["chevron.right.two", "A", "B", "C", "multiply"],
        ["~", "7", "8", "9", "divide"],
        ["^", "4", "5", "6", "minus"],
        ["|", "1", "2", "3", "plus"],
    ]
    
    var body: some View {
        VStack {
            Spacer()
            Calculations()
            Group {
                ForEach(symbolsList, id: \.self) { symbols in
                    ButtonRow(symbols: symbols)
                }
                
                GeometryReader { geometry in
                    HStack(spacing: 3) {
                        Spacer()
                        MyButton(symbol: "&")
                        MyButton(symbol: "0")
                            .frame(width: geometry.size.width * 0.40)
                        MyButton(symbol: "plus.slash.minus")
                        MyButton(symbol: "equal")
                        Spacer()
                    }
                }
                .frame(maxWidth: 500)
                .frame(height: 70)
            }
        }
    }
}

struct ButtonRow: View {
    var symbols: Array<String>
    var body: some View {
        HStack(spacing: 3) {
            Spacer()
            ForEach(symbols, id: \.self) { symbol in
                MyButton(symbol: symbol)
            }
            Spacer()
        }
        .frame(maxWidth: 500)
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
