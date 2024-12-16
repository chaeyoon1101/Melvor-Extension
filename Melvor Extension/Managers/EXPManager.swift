//
//  MelvorEXPManager.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import Foundation

struct EXPManager {
    func calculateToEXP(From level: Int) -> String {
        let sum = (1..<level).reduce(0) { result, l in
            return result + (Double(l) + 300 * pow(2.0, Double(l) / 7.0))
        }
        
        let result = floor((1 / 4) * sum)
        
        
        return String(Int(result))
    }
    
    func calculateToLevel(from exp: String) -> String {
        var accumulatedEXP = 0.0
        var level = 1
        
        while true {
            // 레벨에 도달하기 위해 필요한 경험치 계산
            let requiredEXP = Double(level) + 300 * pow(2.0, Double(level) / 7.0)
            accumulatedEXP += requiredEXP
            
            // 경험치 합계가 주어진 경험치를 초과하면 루프 종료
            if Double((1 / 4) * accumulatedEXP) - 20 >= Double(exp)! {
                break
            }
            
            level += 1
        }
        
        return String(level)
    }
    
    func calculateProgress(_ start: Date, _ end: Date) -> Double {
        let startUnixTime = start.timeIntervalSince1970 * 1000
        let endUnixTime = end.timeIntervalSince1970 * 1000
        
        let nowUnixTime = Date().timeIntervalSince1970 * 1000
        
        
        let startEndDiff = endUnixTime - startUnixTime
        let nowEndDiff = nowUnixTime - startUnixTime
        
        return min(nowEndDiff / startEndDiff * 100, 100)
    }
    
    func calculateEndTime(_ action: Action) -> Date {
        guard let currentEXP = Double(action.currentEXP),
              let nextEXP = Double(action.nextEXP),
              let expPerAction = Double(action.expPerAction),
              let timePerAction = Double(action.timePerAction) else {
            return Date()
        }
        
        let speedMultiplier = SettingUserDefaults().speedMultiplier
        let levelDifference = nextEXP - currentEXP
        let seconds = Int(
            (levelDifference / expPerAction * timePerAction) / speedMultiplier
        )
        
        let calendar = Calendar.current
        let dateComponents = DateComponents(second: seconds)
        
        return calendar.date(byAdding: dateComponents, to: action.startDate)!
    }
    
    func calculateTimeLeft(_ end: Date) -> String {
        let currentDate = Date()
        
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.year, .day, .hour, .minute, .second], from: currentDate, to: end)
        
        let timeLeft = "\(difference.year! > 0 ? " \(difference.year!)y" : "")\(difference.day! > 0 ? " \(difference.day!)d" : "")\(difference.hour! > 0 ? " \(difference.hour!)h" : "")\(difference.minute! > 0 ? " \(difference.minute!)m" : "")\(difference.second! > 0 ? " \(difference.second!)s" : "0s")"
        
        return timeLeft
    }
}
