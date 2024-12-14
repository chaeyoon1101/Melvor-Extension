//
//  BarGraphView.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import SwiftUI

struct BarGraphView: View {
    let value: CGFloat
    let barColor: Color
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(barColor.opacity(0.3))
                    .frame(width: proxy.size.width, height: proxy.size.height)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(barColor)
                    .frame(
                        width: min(proxy.size.width * (max(value / 100, 0)), proxy.size.width),
                        height: proxy.size.height - 4
                    )
                
            }
        }
        .frame(height: 18)
    }
}

#Preview {
    BarGraphView(value: 40, barColor: .cyan)
}
