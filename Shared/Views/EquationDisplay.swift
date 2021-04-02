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
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    GeometryReader { geometry in
                        ScrollView {
                            ScrollViewReader { scroll in
                                VStack {
                                    Spacer()
                                    ForEach(display.userHistory, id: \.self) { entry in
                                        HStack {
                                            Text(entry.mode.rawValue.uppercased())
                                                .padding(.horizontal)
                                                .padding(.bottom)
                                                .foregroundColor(.cadet)
                                                .opacity(0.5)
                                            Spacer()
                                            Text(entry.equation)
                                                .multilineTextAlignment(.trailing)
                                                .foregroundColor(.black)
                                                .padding(.horizontal)
                                                .padding(.bottom)
//                                                .frame(width: geometry.size.width, alignment: .bottomTrailing)
                                        }
                                        Divider()
                                    }
                                    .onChange(of: display.userHistory, perform: { _ in
                                        scroll.scrollTo(bottomId)
                                    })
                                    .onChange(of: display.userInput, perform: { _ in
                                        scroll.scrollTo(bottomId)
                                    })
                                    .onAppear(perform: {
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
                TextRow(text: "HEX", number: display.hex.uppercased())
                TextRow(text: "BIN", number: display.bin)
            }
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Button(action: display.clearHistory, label: {
                        Text("Clear")
                            .font(.caption)
                            .padding(8)
                            .background(Color.cadet)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .opacity(0.8)
                    })
                    .padding(.leading)
                    .padding(.top, 8)
                    Spacer()
                }
                Spacer()
            }
        }
    }
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
