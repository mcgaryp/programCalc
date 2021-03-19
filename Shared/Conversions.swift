//
//  Conversions.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/18/21.
//

import Foundation

class Conversions: ObservableObject {
    @Published var userHistory: Array<Entry> = []
    @Published var userInput: String = ""
    @Published var bin: String
    @Published var hex: String
    @Published var dec: String
    private var answer: String = "0"
    
    struct Entry: Identifiable, Hashable {
        var id: UUID
        var equation: String
        
        init(_ e: String) {
            equation = e
            id = UUID()
        }
        
        func getEquation() -> String {
            return self.equation
        }
    
    }
    
    init() {
        bin = "0"
        hex = "0"
        dec = "0"
    }
    
    func updateDisplayString(_ str: String, mode: CalcMode) -> Void {
        userInput += str
        if userInput.last == "\n" {
            // TODO: restructure the string for operations.
            // TODO: algorithm to decifer the string There needs to be a function for each operator <<, >>, ~, -, ^, |, &, x, /, +, -, -/+, =
            // TODO: Add anser to user input
            answer = calculate()
            userInput += "= \(answer)"
            // Add to history
            userHistory.append(Entry(userInput))
            // reset the user input
            userInput = ""
        }
    }
    
    func calculate() -> String {
        return "ANSWER HERE"
    }
    
    func convert(_ mode: CalcMode) -> Void {
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
