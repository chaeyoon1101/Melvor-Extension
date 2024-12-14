//
//  SettingView.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/11/24.
//

import SwiftUI

struct SettingView: View {
    @State var speed: Int = UserDefaults.standard.integer(forKey: "speedMultiplier")
    @State var isLoadLastURLActive: Bool = UserDefaults.standard.bool(forKey: "loadLastURLActive")
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Stepper(value: $speed) {
                        Text("배속: \(speed)x")
                    }
                    .onChange(of: speed) { _, newValue in
                        UserDefaults.standard.set(newValue, forKey: "speedMultiplier")
                    }
                } header: {
                    Text("EXP")
                }

                Section {
                    Toggle("앱 시작 시 마지막 페이지 불러오기", isOn: $isLoadLastURLActive)
                        .onChange(of: isLoadLastURLActive) { _, newValue in
                            UserDefaults.standard.set(newValue, forKey: "loadLastURLActive")
                        }
                } header: {
                    Text("Wiki")
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
