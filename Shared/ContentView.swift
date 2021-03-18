//
//  ContentView.swift
//  Shared
//
//  Created by Porter McGary on 3/17/21.
//

import SwiftUI

struct ContentView: View {
//    let items = 1...50
//
//        let rows = [
//            GridItem(.fixed(50)),
//            GridItem(.fixed(50)),
//            GridItem(.fixed(50)),
//            GridItem(.fixed(50)),
//            GridItem(.fixed(50))
//        ]
//
//        var body: some View {
////            ScrollView {
//                LazyVGrid(columns: rows, spacing: 20) {
//                    ForEach(items, id: \.self) { item in
//                        Image(systemName: "\(item).circle.fill")
//                            .font(.largeTitle)
//                    }
//                }
//                .frame(maxHeight: 3000)
////            }
//        }
    var body: some View {
        Buttons()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
