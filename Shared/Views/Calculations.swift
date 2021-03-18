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
    @State private var dec: String = "15"
    @State private var hex: String = "F"
    @State private var bin: String = "1111"
    private let hexToBin = ["0":"0000", "1":"0001", "2":"0010", "3":"0011", "4":"0100", "5":"0101", "6":"0110", "7":"0111", "8":"1000", "9":"1001", "A":"1010", "B":"1011", "C":"1100", "D":"1101", "E":"1110", "F":"1111"]
    
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
            Button(action: {decTo()}, label: {
                Text("asl;dfjla;sg;la")
            })
            // Convert from hex
            // FIXME: Add if statements to present correct conversions
//            Group {
//                Text("Hex to...")
//                TextRow(text: "DEC", number: String(Int("123", radix: 16) ?? -1))
//                TextRow(text: "HEX", number: "123")
//                TextRow(text: "BIN", number: String(Int("123", radix: 16)!, radix: 2))
//            }
//            // Convert from decimal
//            Group {
//                Text("Decimal to...")
//                TextRow(text: "DEC", number: "291")
//                TextRow(text: "HEX", number: String(291, radix: 16))
//                TextRow(text: "BIN", number: String(291, radix: 2))
//            }
            
            // Convert from binary

//            Group {
//                Text("Binary to")
//                TextRow(text: "DEC", number: String(Int("100100011", radix: 2)!))
//                TextRow(text: "HEX", number: String(Int("100100011", radix: 2)!, radix: 16))
//                TextRow(text: "BIN", number: "100100011")
//            }

        }
        .frame(maxWidth: 500)
    }
    
    func hexTo() {
        bin = String(Int(hex, radix: 16)!, radix: 2)
     //convert to decimal
        dec = String(Int(hex, radix: 16)!)
    }
    
    func binTo() {
        dec = String(Int(bin, radix: 2)!)
        hex = String(Int(bin, radix: 2)!, radix: 16)
    }
    
    func decTo() {
        hex = String(Int(dec)!, radix: 16)
        bin = String(Int(dec)!, radix: 2)
        print(hex)
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
