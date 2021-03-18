//
//  Conversions.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/18/21.
//

import Foundation

class Conversions: ObservableObject {
    @Published var displayString: String = ""
    @Published var bin: String
    @Published var hex: String
    @Published var dec: String
    
    init() {
        bin = "0"
        hex = "0"
        dec = "0"
    }
    
    func updateDisplayString(_ str: String, mode: CalcMode) -> Void {
        displayString += str
        convert(mode)
    }
    
    func convert(_ mode: CalcMode) -> Void {
        print("Converting in \(mode)")
        switch mode {
        case .bin:
            binTo()
            break
        case .dec:
            decTo()
            break
        case .hex:
            hexTo()
            break
        }
    }
    
    func hexTo() {
        bin = String(Int(hex, radix: 16) ?? -1, radix: 2)
        dec = String(Int(hex, radix: 16) ?? -1)
//        hex = hex
    }
    
    func binTo() {
        dec = String(Int(bin, radix: 2) ?? -1)
        hex = String(Int(bin, radix: 2) ?? -1, radix: 16)
//        bin = bin
    }
    
    func decTo() {
        hex = String(Int(dec) ?? -1, radix: 16)
        bin = String(Int(dec) ?? -1, radix: 2)
//        dec = dec
    }
}
