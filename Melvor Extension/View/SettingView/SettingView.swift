//
//  SettingView.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/11/24.
//

import SwiftUI

struct SettingView: View {
    @StateObject var settingUserDefaults = SettingUserDefaults()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Stepper(value: $settingUserDefaults.speedMultiplier) {
                        Text("배속: \(settingUserDefaults.speedMultiplier)x")
                    }
                } header: {
                    Text("EXP")
                }
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingView()
}
