//
//  WebViewButton.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import SwiftUI

struct WebViewButton: ButtonStyle {
    @Binding var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.BG)
            .padding()
            .background(configuration.isPressed ? .FG.opacity(0.8) : .FG)
            .clipShape(Circle())
            .shadow(radius: 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .disabled(!isEnabled)
    }
}
