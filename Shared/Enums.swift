//
//  Enums.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/18/21.
//

import Foundation

enum ButtonAction: Hashable {
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
    case plusMinus
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
}

enum CalcMode: String, CaseIterable, Identifiable {
    case bin, hex, dec
    
    var id: String{self.rawValue}
}
