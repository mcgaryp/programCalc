//
//  Buttons.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/17/21.
//

import SwiftUI

// TODO: Make bench test
// TODO: Add ~ logic
// TODO: Add Floating point Division

struct Calculator: View {
    @ObservedObject private var display: Conversions = Conversions()
    @ObservedObject private var buttons: MyButtons = MyButtons()
    @State var selectedMode: String = CalcMode.dec.rawValue
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.init(white: 255, alpha: 0.2)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        ZStack {
            Color.cadet
                .ignoresSafeArea()
            VStack {
                HStack(spacing: 3) {
                    Spacer()
                    Picker("", selection: $selectedMode) {
                        ForEach(CalcMode.allCases) { mode in
                            Text(mode.rawValue.capitalized)
                        }
                    }
                    .onChange(of: selectedMode) { (value) in
                        buttons.objectWillChange.send()
                        updateButtons(value: CalcMode(rawValue: value)!)
                    }
                    .disabled(display.inCalculation)
                    .pickerStyle(SegmentedPickerStyle())
                    Spacer()
                }
                
                EquationDisplay(display: display, calculatorMode: CalcMode(rawValue: selectedMode)!)
                
                ForEach(buttons.buttons) { group in
                    ButtonRow(callback: display, group: group)
                }
                
                GeometryReader { geometry in
                    HStack(spacing: 3) {
                        Spacer()
                        MyButton(callback: display, button: ButtonState("&", .and, .symbol, false))
                        MyButton(callback: display, button: ButtonState("0", .zero, .number, false))
                            .frame(width: geometry.size.width * 0.555)
                        MyButton(callback: display, button: ButtonState("equal", .equals, .symbol, false))
//                        MyButton(callback: display, button: ButtonState("plus", .plus, .symbol, false)) TODO: Add Back
                        Spacer()
                    }
                }
                .frame(maxWidth: 500)
                .frame(height: 70)
            }
        }
    }
    
    /// Enable or disable the buttons as the value changes
    func updateButtons(value: CalcMode) -> Void {
        switch value {
        case .bin:
            /// Disabling 2-F
            for group in buttons.buttons {
                for button in group.group {
                    if ButtonAction.twoThroughF.contains(button.action) {
                        button.updateDisabled(val: true)
                    }
                }
            }
            break
        case .hex:
            /// Enabling all
            for group in buttons.buttons {
                for button in group.group {
                    if ButtonAction.allCases.contains(button.action) {
                        button.updateDisabled(val: false)
                    }
                }
            }
            break
        case .dec:
            for group in buttons.buttons {
                for button in group.group {
                    /// Enabling 2-9
                    if ButtonAction.twoThroughNine.contains(button.action) {
                        button.updateDisabled(val: false)
                    }
                    /// Disabliing A-F
                    if ButtonAction.aThroughF.contains(button.action) {
                        button.updateDisabled(val: true)
                    }
                }
            }
            break
        }
    }
    
    // Update the display from user input
    func display(action: ButtonAction) -> Void {
        display.objectWillChange.send()
        switch action {
        case .zero:
            updateString("0")
            break
        case .one:
            updateString("1")
            break
        case .two:
            updateString("2")
            break
        case .three:
            updateString("3")
            break
        case .four:
            updateString("4")
            break
        case .five:
            updateString("5")
            break
        case .six:
            updateString("6")
            break
        case .seven:
            updateString("7")
            break
        case .eight:
            updateString("8")
            break
        case .nine:
            updateString("9")
            break
        case .a:
            updateString("A")
            break
        case .b:
            updateString("B")
            break
        case .c:
            updateString("C")
            break
        case .d:
            updateString("D")
            break
        case .e:
            updateString("E")
            break
        case .f:
            updateString("F")
            break
        case .and:
            updateString(" & ")
            break
        case .or:
            updateString(" | ")
            break
        case .xor:
            updateString(" \u{22C0} ")
            break
        case .not:
            updateString(" ~ ")
            break
        case .rightShift:
            updateString(" \u{00BB} ")
            break
        case .leftShift:
            updateString(" \u{00AB} ")
            break
        case .delete:
            display.backspace()
            break
        case .multiply:
            updateString(" \u{00D7} ")
            break
        case .divide:
            updateString(" \u{00F7} ")
            break
        case .subtract:
            updateString(" - ")
            break
        case .plus:
            updateString(" + ")
            break
        case .clear:
            display.resetInput()
            break
        case .equals:
            updateString("\n")
            break
        case .decimal:
            updateString(".")
            break
        }
    }
    
    func updateString(_ str: String) {
        display.updateDisplayString(str, mode: CalcMode(rawValue: selectedMode)!)
    }
}

// Creates the view for every row of buttons
struct ButtonRow: View {
    var callback: (ButtonAction) -> Void
    var group: ButtonGroup
    var body: some View {
        HStack(spacing: 3) {
            Spacer()
            ForEach(group.group) { button in
                MyButton(callback: callback, button: button)
            }
            Spacer()
        }
        .frame(maxWidth: 500)
    }
}

// Creates the actual physical button
struct MyButton: View {
    var callback: (ButtonAction) -> Void
    var button: ButtonState
    var body: some View {
        let number: Color = Color.charcoal
        let symbol: Color = Color.bloodRed
        let disabled: Color = Color.charcoal.opacity(0.5)
        
        var buttonColor: Color = Color.white
        switch button.type {
        case .number:
            buttonColor = number
        case .symbol:
            buttonColor = symbol
        }
        
        if button.disabled {
            buttonColor = disabled
        }
        
        return Button(action: { callback(button.action) }, label: {
            if button.text.count < 4 {
                Text(button.text)
                    .opacity(button.disabled ? 0.5 : 1)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .minimumScaleFactor(0.001)
                    .frame(maxWidth: .infinity, minHeight: 25)
                    .padding()
                    .background(buttonColor)
                    .clipShape(Capsule())
            } else {
                Image(systemName: button.text)
                    .opacity(button.disabled ? 0.5 : 1)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .minimumScaleFactor(0.001)
                    .frame(maxWidth: .infinity, minHeight: 25)
                    .padding()
                    .background(buttonColor)
                    .clipShape(Capsule())
            }
        })
        .disabled(button.disabled)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Calculator()
            .preferredColorScheme(.dark)
    }
}
