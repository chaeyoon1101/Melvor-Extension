//
//  SettingUserDefaults.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/15/24.
//

import Foundation

final class SettingUserDefaults: ObservableObject {
    @UserDefaultsStorage(.speedMultiplier) var speedMultiplier: Double = 1.0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefaultsStorage(.lastURL) var lastURL: String = "https://wiki.melvoridle.com/w/Main_Page" {
        willSet {
            objectWillChange.send()
        }
    }
}
