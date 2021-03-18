//
//  Buttons.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/17/21.
//

import SwiftUI

struct Buttons: View {
    @State private var displayString: String = ""
    @State private var selectedMode:String = CalcMode.bin.rawValue
    
    private let symbolsList: Array<Array<ButtonData>> = [
        [
            ButtonData("chevron.left.2", .leftShift),
            ButtonData("D", .d),
            ButtonData("E", .e),
            ButtonData("F", .f),
            ButtonData("delete.left.fill", .delete)],
        [
            ButtonData("chevron.right.2", .rightShift),
            ButtonData("A", .a),
            ButtonData("B", .b),
            ButtonData("C", .c),
            ButtonData("multiply", .multiply)
        ],
        [
            ButtonData("~", .not),
            ButtonData("7", .seven),
            ButtonData("8", .eight),
            ButtonData("9", .nine),
            ButtonData("divide", .divide)
        ],
        [
            ButtonData("^", .xor),
            ButtonData("4", .four),
            ButtonData("5", .five),
            ButtonData("6", .six),
            ButtonData("minus", .subtract)
        ],
        [
            ButtonData("|", .or),
            ButtonData("1", .one),
            ButtonData("2", .two),
            ButtonData("3", .three),
            ButtonData("plus", .plus)
        ],
    ]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Picker("", selection: $selectedMode) {
                    ForEach(CalcMode.allCases) { mode in
                        Text(mode.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
            }
            Spacer()
            
            Calculations(displayString: displayString, calculatorMode: CalcMode(rawValue: selectedMode)!)
            
            Group {
                ForEach(symbolsList, id: \.self) { symbols in
                    ButtonRow(callback: display, symbols: symbols)
                }
                
                GeometryReader { geometry in
                    HStack(spacing: 3) {
                        Spacer()
                        MyButton(callback: display, data: ButtonData("&", .and))
                        MyButton(callback: display, data: ButtonData("0", .zero))                            .frame(width: geometry.size.width * 0.37)
                        MyButton(callback: display, data: ButtonData("plus.slash.minus", .plusMinus))
                        MyButton(callback: display, data: ButtonData("equal", .equals))
                        Spacer()
                    }
                }
                .frame(maxWidth: 500)
                .frame(height: 70)
            }
        }
    }
    
    func display(action: ButtonAction) {
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
            updateString(" ^ ")
            break
        case .not:
            // FIXME: adjust the location of this string added to the array
            updateString(" ~ ")
            break
        case .rightShift:
            updateString(" >> ")
            break
        case .leftShift:
            updateString(" << ")
            break
        case .delete:
            if !displayString.isEmpty {
                displayString.removeLast()
            }
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
        case .plusMinus:
            // FIXME: Add a minus to the front of the letter
            updateString(" -")
            break
        case .equals:
            // FIXME: Do something to signal calculate
            updateString("\n")
            break
        }
    }
    
    func updateString(_ str: String) {
        displayString += str
    }
}

struct ButtonRow: View {
    var callback: (ButtonAction) -> Void
    var symbols: Array<ButtonData>
    var body: some View {
        HStack(spacing: 3) {
            Spacer()
            ForEach(symbols, id: \.self) { data in
                MyButton(callback: callback, data: data)
            }
            Spacer()
        }
        .frame(maxWidth: 500)
    }
}

struct MyButton: View {
    var callback: (ButtonAction) -> Void
    var data: ButtonData
    var body: some View {
        Button(action: { callback(data.action) }, label: {
            if data.text.count < 3 {
                Text(data.text)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .minimumScaleFactor(0.001)
                    .frame(maxWidth: .infinity, minHeight: 25)
                    .padding()
                    .background(Color.gray)
                    .clipShape(Capsule())
            } else {
                Image(systemName: data.text)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .minimumScaleFactor(0.001)
                    .frame(maxWidth: .infinity, minHeight: 25)
                    .padding()
                    .background(Color.gray)
                    .clipShape(Capsule())
            }
        })
    }
}

struct ButtonData: Hashable {
    var text: String
    var action: ButtonAction
    
    init(_ text: String, _ action: ButtonAction) {
        self.text = text
        self.action = action
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
