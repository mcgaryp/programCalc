//
//  Buttons.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/18/21.
//

import Foundation

class MyButtons: ObservableObject {
    @Published var buttons: Array<ButtonGroup>
    
    init() {
        buttons = [
            ButtonGroup([
                ButtonState("chevron.left.2", .leftShift, .symbol, false),
                ButtonState("D", .d, .number, false),
                ButtonState("E", .e, .number, false),
                ButtonState("F", .f, .number, false),
                ButtonState("trash", .clear, .symbol, false)
            ]),
            ButtonGroup([
                ButtonState("chevron.right.2", .rightShift, .symbol, false),
                ButtonState("A", .a, .number, false),
                ButtonState("B", .b, .number, false),
                ButtonState("C", .c, .number, false),
                ButtonState("delete.left.fill", .delete, .symbol, false)
            ]),
            ButtonGroup([
                ButtonState("~", .not, .symbol, false),
                ButtonState("7", .seven, .number, false),
                ButtonState("8", .eight, .number, false),
                ButtonState("9", .nine, .number, false),
                ButtonState("multiply", .multiply, .symbol, false)
            ]),
            ButtonGroup([
                ButtonState("\u{22C0}", .xor, .symbol, false),
                ButtonState("4", .four, .number, false),
                ButtonState("5", .five, .number, false),
                ButtonState("6", .six, .number, false),
                ButtonState("divide", .divide, .symbol, false)
            ]),
            ButtonGroup([
                ButtonState("|", .or, .symbol, false),
                ButtonState("1", .one, .number, false),
                ButtonState("2", .two, .number, false),
                ButtonState("3", .three, .number, false),
                ButtonState("minus", .subtract, .symbol, false)
            ]),
        ]
    }
    
}

class ButtonGroup: ObservableObject, Identifiable {
    var id = UUID()
    @Published var group: Array<ButtonState>
    
    init(_ array: Array<ButtonState>) {
        group = array
    }
}

class ButtonState: ObservableObject, Identifiable {
    @Published var disabled: Bool
    var id = UUID()
    let text: String
    let action: ButtonAction
    let type: ButtonType
    
    init(_ text: String, _ action: ButtonAction, _ type: ButtonType, _ disabled: Bool) {
        self.text = text
        self.action = action
        self.disabled = disabled
        self.type = type
    }
    
    func updateDisabled(val: Bool) -> Void {
        disabled = val
    }
}
