//
//  ContentView.swift
//  Shared
//
//  Created by Porter McGary on 3/17/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Calculator(selectedMode: CalcMode.dec.rawValue)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
