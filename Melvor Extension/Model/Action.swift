//
//  Action.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/11/24.
//

import Foundation

struct Action: Codable, Identifiable {
    var id: UUID = UUID()
    var startDate: Date
    var skill: Skill?
    var currentEXP: String
    var nextEXP: String
    var expPerAction: String
    var timePerAction: String
    var isNotificationEnabled: Bool
    
    static var `default`: Action {
        Action(id: UUID(), startDate: Date(), currentEXP: "", nextEXP: "", expPerAction: "", timePerAction: "", isNotificationEnabled: false)
    }
}
