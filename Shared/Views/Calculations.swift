//
//  Calculations.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/18/21.
//

import SwiftUI

struct Calculations: View {
    var displayString: String
    var calculatorMode: CalcMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(displayString)
                }
                Spacer()
            }
            // Convert from hex
            // FIXME: Add if statements to present correct conversions
            Group {
                Text("Hex to...")
                TextRow(text: "DEC", number: String(Int("123", radix: 16) ?? -1))
                TextRow(text: "HEX", number: "123")
                TextRow(text: "BIN", number: String(Int("123", radix: 16)!, radix: 2))
            }
            // Convert from decimal
            Group {
                Text("Decimal to...")
                TextRow(text: "DEC", number: "291")
                TextRow(text: "HEX", number: String(291, radix: 16))
                TextRow(text: "BIN", number: String(291, radix: 2))
            }
            
            // Convert from binary
            Group {
                Text("Binary to")
                TextRow(text: "DEC", number: String(Int("100100011", radix: 2)!))
                TextRow(text: "HEX", number: String(Int("100100011", radix: 2)!, radix: 16))
                TextRow(text: "BIN", number: "100100011")
            }
        }
        .frame(maxWidth: 500)
    }
    
    // TODO: Make functions for calculations
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
        Calculations(displayString: "1 x 1", calculatorMode: .dec)
    }
}
