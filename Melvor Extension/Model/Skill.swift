//
//  SkillType.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import SwiftUI

enum Skill: String, CaseIterable, Codable {
    case woodcutting
    case fishing
    case firemaking
    case cooking
    case mining
    case smithing
    case thieving
    case fletching
    case crafting
    case runecrafting
    case herblore
    case agility
    case summoning
    case astrology
    case alternativeMagic
    
    var name: String {
        switch self {
        case .woodcutting:
            return "벌목"
        case .fishing:
            return "낚시"
        case .firemaking:
            return "불붙이기"
        case .cooking:
            return "요리"
        case .mining:
            return "채광"
        case .smithing:
            return "대장 작업"
        case .thieving:
            return "절도"
        case .fletching:
            return "궁시 제작"
        case .crafting:
            return "제작"
        case .runecrafting:
            return "룬 제작"
        case .herblore:
            return "약초학"
        case .agility:
            return "민첩성"
        case .summoning:
            return "소환"
        case .astrology:
            return "점성술"
        case .alternativeMagic:
            return "대체 마법"
        }
    }
    
    var image: String {
        let skillAssetsPath = "skillAssets/"
        
        return skillAssetsPath + self.rawValue + "/icon"
    }
    
    var color: String {
        let skillAssetsPath = "skillAssets/"
        
        return skillAssetsPath + self.rawValue + "/color"
    }
}
