//
//  SkillTypeView.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import SwiftUI

struct SkillTypeView: View {
    @Binding var selectedSkill: Skill?
    
    @State private var showSkillPicker = false
    
    var body: some View {
        HStack(spacing: 16) {
            Image(selectedSkill?.image ?? "defaultSkill")
                .resizable()
                .frame(width: 48, height: 48)
            
            Text(selectedSkill?.name ?? "스킬 선택")
                .font(.title2)
                .bold()
        }
        .onTapGesture {
            showSkillPicker = true
        }
        .sheet(isPresented: $showSkillPicker) {
            SkillPicker(isPresented: $showSkillPicker, selectedSkill: $selectedSkill)
                .presentationDetents([.height(220)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(24)
        }
    }
}

#Preview {
    SkillTypeView(selectedSkill: .constant(.herblore))
}
