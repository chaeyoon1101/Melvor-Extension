//
//  ContentView.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/11/24.
//

import SwiftUI

struct ContentView: View {
    @State var selection: MelvorTab = .wiki
    
    var body: some View {
        TabView(selection: $selection) {
            Tab("Wiki", systemImage: "book", value: .wiki) {
                WikiView()
            }
            
            Tab("EXP", systemImage: "hourglass.bottomhalf.filled", value: .exp) {
                EXPView()
            }
            
            Tab("Setting", systemImage: "gearshape", value: .setting) {
                SettingView()
            }
        }
    }
}

enum MelvorTab {
    case wiki, exp, setting
}

#Preview {
    ContentView()
}
