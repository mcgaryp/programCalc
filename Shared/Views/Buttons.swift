//
//  Buttons.swift
//  Programming Calculator
//
//  Created by Porter McGary on 3/17/21.
//

import SwiftUI

struct Buttons: View {
    @State private var displayString: String = ""
    
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
            Spacer()
            Calculations(displayString: displayString)
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
        print("Button that was pressed is: \(action)")
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
