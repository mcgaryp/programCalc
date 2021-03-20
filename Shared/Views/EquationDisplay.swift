//
//  Calculations.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/18/21.
//

import SwiftUI

struct EquationDisplay: View {
    @Namespace var bottomId
    @ObservedObject var display: Conversions
    var calculatorMode: CalcMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                GeometryReader { geometry in
                    ScrollView {
                        ScrollViewReader { scroll in
                            VStack {
                                Spacer()
                                ForEach(display.userHistory, id: \.self) { entry in
                                    Text(entry.equation)
                                        .multilineTextAlignment(.trailing)
                                        .foregroundColor(.black)
                                        .padding(.horizontal)
                                        .padding(.bottom)
                                        .frame(width: geometry.size.width, alignment: .bottomTrailing)
                                }
                                .onChange(of: display.userHistory, perform: { _ in
                                    scroll.scrollTo(bottomId)
                                })
                                Text(display.userInput)
                                    .multilineTextAlignment(.trailing)
                                    .foregroundColor(.black)
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                    .frame(width: geometry.size.width, alignment: .bottomTrailing)
                                    .id(bottomId)
                            }
                        }
                        .frame(minHeight: geometry.size.height)
                    }
                    .background(Color.white)
                    .cornerRadius(20)
                }
                Spacer()
            }
            // The conversions
            TextRow(text: "DEC", number: display.dec)
            TextRow(text: "HEX", number: display.hex)
            TextRow(text: "BIN", number: display.bin)
        }
        .frame(maxWidth: 500)
    }
    
    /// TODO: Create functions to interpret the displaystring and do calculations
}

struct TextRow: View {
    var text: String
    var number: String
    var body: some View {
        HStack {
            Spacer()
            HStack {
                Text(text)
                    .foregroundColor(.white)
                Spacer()
                Text(number)
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }
}

struct Calculations_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            EquationDisplay(display: Conversions(), calculatorMode: .dec)
        }
    }
}
