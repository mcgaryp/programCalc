//
//  Calculations.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/18/21.
//

import SwiftUI

struct EquationDisplay: View {
    @ObservedObject var display: Conversions
    var calculatorMode: CalcMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    Spacer()
                    /// TODO add a clear button
                    Text(display.displayString)
                        
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
                Spacer()
                Text(number)
            }
            Spacer()
        }
    }
}

struct Calculations_Previews: PreviewProvider {
    static var previews: some View {
        EquationDisplay(display: Conversions(), calculatorMode: .dec)
    }
}
