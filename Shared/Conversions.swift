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
    private var answer: String = ""
    
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
            // Calculate the input
            answer = calculate(mode)
            // conver the anwset
            convert(mode)
            // update the input
            userInput += "= \(answer)"
            // Add to history
            userHistory.append(Entry(userInput))
            // reset the user input
            resetInput()
        }
    }
    
    // Appropriately subtract numbers
    func backspace() -> Void {
        // if the string is empty don't do anything
        if userInput.isEmpty {
            return
        }
        
        let temp = userInput
        // split the string
        var splitTemp = temp.split(separator: " ")
        // remove the last part
        splitTemp.removeLast()
        // put the string back together
        userInput = splitTemp.joined(separator: " ")
    }
    
    // Reset the input string to nothing
    func resetInput() -> Void {
        userInput = ""
    }
    
    // Calculate what the awnser is right here
    func calculate(_ mode: CalcMode) -> String {
        // Numbers array and operators array
        var numbers: Array<Int> = []
        var operators: Array<OperatorType> = []
        // separate the operators from the numbers
        let temp = userInput
        let trimmed = temp.replacingOccurrences(of: "\n", with: "")
        let operatorsAndNumbers = trimmed.split(separator: " ")
        // Do the simple conversions
        operatorsAndNumbers.forEach({ on in
            let number = Int(on) ?? nil
            // if a number then add to numbers
            if number != nil {
                numbers.append(number!)
            } else {    // Add to operators because it is that
                switch on {
                case "&":
                    operators.append(.and)
                    break
                case "|":
                    operators.append(.or)
                    break
                case "\u{22C0}":
                    operators.append(.xor)
                    break
                case "~":
                    operators.append(.inverse)
                    break
                case "\u{00BB}":
                    operators.append(.shiftRight)
                    break
                case "\u{00AB}":
                    operators.append(.shiftLeft)
                    break
                case "\u{00D7}":
                    operators.append(.multiply)
                    break
                case "\u{00F7}":
                    operators.append(.divide)
                    break
                case "-":
                    operators.append(.subtract)
                    break
                case "+":
                    operators.append(.add)
                    break
                default:
                    break
                }
            }
        })
        
        // based on the mode in Do some math
        switch mode {
        case .dec:
            return doTheDecMath(operators, numbers)
        case .bin: // TODO:
            return "0"
        case .hex: // TODO:
            return "0"
        }
    }
    
    // TODO: The math is only for dec... so no other operations work yet like bin or hex
    func doTheDecMath(_ operators: Array<OperatorType>, _ numbers: Array<Int>) -> String {
        // take the lhs of the operations and the operations index
        var lhs = -1
        var operatorIndex = -1
        // loop through the numbers
        numbers.forEach({ number in
            if operatorIndex < 0 {
                // first time through the loop set the number to the lhs
                lhs = number
                // lets start to look at the operators after this loop
                operatorIndex = 0
            } else {
                // what is the operator? go to the right function.
                switch operators[operatorIndex] {
                case .add:
                    // Add function
                    lhs += number
                    break
                case .subtract:
                    // Subtract function
                    lhs -= number
                    break
                case .multiply:
                    // multiply function
                    lhs *= number
                    break
                case .divide:
                    // divide function
                    lhs = lhs / number
                    break
                case .inverse:
                    // TODO: Inverse function
                    break
                case .or:
                    // Or function
                    lhs |= number
                    break
                case .and:
                    // And function
                    lhs &= number
                    break
                case .xor:
                    // xor function
                    lhs = lhs ^ number
                    break
                case .shiftLeft:
                    // Shift left function
                    lhs = lhs << number
                    break
                case .shiftRight:
                    // Shift Right function
                    lhs = lhs >> number
                    break
                }
                operatorIndex += 1
            }
        })
        
        return String(lhs)
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
        bin = String(Int(answer, radix: 16) ?? -1, radix: 2)
        dec = String(Int(answer, radix: 16) ?? -1)
        hex = answer
    }
    
    func binTo() {
        dec = String(Int(answer, radix: 2) ?? -1)
        hex = String(Int(answer, radix: 2) ?? -1, radix: 16)
        bin = answer
    }
    
    func decTo() {
        hex = String(Int(answer) ?? -1, radix: 16)
        bin = String(Int(answer) ?? -1, radix: 2)
        dec = answer
    }
}
