//
//  Enums.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/18/21.
//

import Foundation

enum ButtonAction: CaseIterable, Hashable {
    case leftShift
    case rightShift
    case not
    case xor
    case or
    case and
    case delete
    case multiply
    case divide
    case subtract
    case plus
    case equals
    case clear
    case decimal
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case a
    case b
    case c
    case d
    case e
    case f
    
    static var allCases: [ButtonAction] {
        return [.zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .a, .b, .c, .d, .e, .f]
    }
    
    static var twoThroughF: [ButtonAction] {
        return [.two, .three, .four, .five, .six, .seven, .eight, .nine, .a, .b, .c, .d, .e, .f]
    }
    
    static var aThroughF: [ButtonAction] {
        return [.a, .b, .c, .d, .e, .f]
    }
    
    static var twoThroughNine: [ButtonAction] {
        return [.two, .three, .four, .five, .six, .seven, .eight, .nine]
    }
    
    static var operators: [ButtonAction] {
        return [.leftShift, .rightShift, .not, .xor, .or, .and, .delete, .multiply, .divide, .subtract, .plus, .equals]
    }
}

enum ButtonType {
    case symbol, number
}

enum CalcMode: String, CaseIterable, Identifiable {
    case bin, hex, dec
    
    var id: String{self.rawValue}
}

