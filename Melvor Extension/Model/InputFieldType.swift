//
//  InputFieldType.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import Foundation

enum InputFieldType {
    case currentEXP
    case nextEXP
    case expPerAction
    case timePerAction
    
    var title: String {
        switch self {
        case .currentEXP: 
            return "현재스킬 경험치"
        case .nextEXP:
            return "목표스킬 경험치"
        case .expPerAction:
            return "작업당 얻는 경험치"
        case .timePerAction: 
            return "작업당 소요되는 시간"
        }
    }
    
    var selections: [ActionInputType] {
        switch self {
        case .currentEXP:
            return [.experience, .level]
        case .nextEXP:
            return [.experience, .level]
        case .expPerAction:
            return [.experience]
        case .timePerAction:
            return [.seconds]
        }
    }
}
