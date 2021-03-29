//
//  Conversions.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/18/21.
//

import Foundation

class Conversions: ObservableObject {
    // Array of past values and calculations of the user
    @Published var userHistory: Array<Entry> = []
    // Current input and calculation determined by the user
    @Published var userInput: String = ""
    // values displayed of the answer in hex, dec, or binary
    @Published var bin: String
    @Published var hex: String
    @Published var dec: String
    // Boolean used to tell if the user is in the middle of a calculation
    @Published var inCalculation: Bool = false
    // Calculated answer
    private var answer: String = ""
    
    // The entry of the user history
    struct Entry: Identifiable, Hashable {
        var id: UUID
        var equation: String // current format "1+2\n=3"
        // TODO: answer string?
        
        // Init for structure
        init(_ e: String) {
            equation = e
            id = UUID()
        }
        
        // Get function
        func getEquation() -> String {
            return self.equation
        }
    
    }
    
    // Initializer for class
    init() {
        bin = "0"
        hex = "0"
        dec = "0"
    }
    
    // Update string of the current equation the user is creating
    func updateDisplayString(_ str: String, mode: CalcMode) -> Void {
        userInput += str
        // if the user selects = operator
        if userInput.last == "\n" {
            // the user only entered equals... do nothing
            if userInput.count == 1 {
                resetInput()
                return
            }
            // Calculate the input
            answer = calculate(mode)
            // convert the answer
            convert(mode)
            // update the input
            userInput += answer != "-1" ? "= \(answer)" : "ERROR"
            // Add to history
            userHistory.append(Entry(userInput))
            // reset the user input
            resetInput()
        }
        checkLengthOfInput()
    }
    
    func clearHistory() {
        userHistory.removeAll(keepingCapacity: false)
        dec = "0"
        hex = "0"
        bin = "0"
        userInput = ""
        checkLengthOfInput()
    }
    
    // Checks the length of the input string to let the calculation in display or not
    func checkLengthOfInput() {
        if userInput.isEmpty {
            inCalculation = false
        } else {
            inCalculation = true
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
        // check if last is a symbol or a number
        if var last = splitTemp.last {
            if let o = symbolToOperator(String(last)) {
                if ButtonAction.operators.contains(o) {
                    // remove the item
                    splitTemp.removeLast()
                }
            } else {
                // remove the last digit
                last.removeLast()
                // remove the whole digit
                splitTemp.removeLast()
                // add the new last number to the split one
                splitTemp.append(last)
            }
        }
        // put the string back together
        var joined = splitTemp.joined(separator: " ")
        // add back an extra space if the last character is a operator
        if let last = joined.last {
            if let o = symbolToOperator(String(last)) {
                if ButtonAction.operators.contains(o) {
                    joined += " "
                }
            }
        }
        // update the input field
        userInput = joined
        
        checkLengthOfInput()
    }
    
    // Reset the input string to nothing
    func resetInput() -> Void {
        userInput = ""
        checkLengthOfInput()
    }
    
    // Calculate what the awnser is right here
    func calculate(_ mode: CalcMode) -> String {
        // Numbers array and operators array
        var numbers: Array<Int> = []
        var operators: Array<ButtonAction> = []
        // separate the operators from the numbers
        let temp = userInput // "1 + 2 \n"
        let trimmed = temp.replacingOccurrences(of: "\n", with: "") // "1 + 2"
        
        // check valid equation
        if !checkValidity(trimmed) {
            return "ERROR"
        }
        
        let operatorsAndNumbers = trimmed.split(separator: " ") // ["1", "+" ,"2"]

        // Do the simple conversions
        operatorsAndNumbers.forEach({ on in // Operator or Number = on -> string value
            var number:Optional<Int> = nil // if the on is a number then save the number else make it null
            if mode == .bin {
                number = Int(String(on), radix: 2) ?? nil
            }
            if mode == .hex {
                number = Int(String(on), radix: 16) ?? nil
            }
            if mode == .dec {
                number = Int(on) ?? nil
            }
            // if a number then add to numbers
            if number != nil {
                numbers.append(number!)
            }
            else {    // Add to operators because it is that
                if let option = symbolToOperator(String(on)) {
                    operators.append(option)
                }
                else {
                    print("ERROR >> Not an operator or a number")
                }
            }
        })
        
        // based on the mode in Do some math
        switch mode {
        case .dec:
            return doTheDecMath(operators, numbers)
        case .bin:
            return String(Int(doTheDecMath(operators, numbers), radix: 10)!, radix: 2)
        case .hex:
            return String(Int(doTheDecMath(operators, numbers), radix: 10)!, radix: 16)
        }
    }
    
    func symbolToOperator(_ on: String) -> Optional<ButtonAction> {
        switch on {
        case "&":
            return .and
        case "|":
            return .or
        case "\u{22C0}":
            return .xor
        case "~":
            return .not
        case "\u{00BB}":
            return .rightShift
        case "\u{00AB}":
            return .leftShift
        case "\u{00D7}":
            return .multiply
        case "\u{00F7}":
            return .divide
        case "-":
            return .subtract
        case "+":
            return .plus
        default:
            return nil
        }
    }
    
    // TODO: Checks the equation to make sure it is in the correct format
    func checkValidity(_ equation: String) -> Bool {
        // create equation
        // digits -> \d+
        // number -> [~]?digits
        // symbol -> [+-\u{00F7}\u{00D7}\u{00AB}\u{00BB}\u{22C0}|&]
        // equation -> number[symbolnumber]+
//        let regex = try! NSRegularExpression(pattern: "")
//        print(equation, regex.matches(equation))
        
//        return regex.matches(equation)
        return true
    }
    
    // The math is only for dec... so no other operations work yet like bin or hex
    func doTheDecMath(_ operators: Array<ButtonAction>, _ numbers: Array<Int>) -> String {
        // take the lhs of the operations and the operations index
        var lhs = -1
        var operatorIndex = -1
            
        // loop through the numbers
        numbers.forEach({ number in // [1, 2] [+]
            if operatorIndex < 0 {
                // first time through the loop set the number to the lhs
                lhs = number
                // lets start to look at the operators after this loop
                operatorIndex = 0
            } else {
                // what is the operator? go to the right function.
                switch operators[operatorIndex] {
                case .plus:
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
                case .not:
                    // TODO: Inverse function
                    lhs = ~lhs
                    break
                case .or:
                    // Or function
                    lhs |= number
                    break
                case .and:
                    // And function
                    lhs &= number
                    break
                case .xor: //not working in BIN
                    // xor function
                    lhs = lhs ^ number
                    break
                case .leftShift:
                    // Shift left function
                    lhs = lhs << number
                    break
                case .rightShift:
                    // Shift Right function
                    lhs = lhs >> number
                    break
                default:
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

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
