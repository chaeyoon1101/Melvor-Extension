//
//  ActionInputType.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import Foundation

enum ActionInputType {
    case experience
    case level
    case seconds
    
    var abbr: String {
        switch self {
        case .experience: return "EXP"
        case .level     : return "LV"
        case .seconds   : return "Sec"
        }
    }
    
    var placeholder: String {
        switch self {
        case .experience: return "5,346,332"
        case .level     : return "90"
        case .seconds   : return "3.0"
        }
    }
}
