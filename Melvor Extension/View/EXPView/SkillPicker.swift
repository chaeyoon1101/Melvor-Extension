//
//  SkillPicker.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import SwiftUI

struct SkillPicker: View {
    @Binding var isPresented: Bool
    @Binding var selectedSkill: Skill?
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 5)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(Skill.allCases, id: \.rawValue) { skill in
                Image(skill.image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        selectedSkill = skill
                        isPresented = false
                    }
            }
        }
        .padding()
    }
}

#Preview {
    SkillPicker(isPresented: .constant(true), selectedSkill: .constant(.astrology))
}
