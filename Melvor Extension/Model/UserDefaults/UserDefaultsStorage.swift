//
//  UserDefaultsStroage.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/15/24.
//

import Foundation

@propertyWrapper
struct UserDefaultsStorage<T: Codable> {
    private var value: T
    private let key: UserDefaultsKey
    
    init(wrappedValue: T, _ key: UserDefaultsKey) {
        self.value = UserDefaults.standard.decode(T.self, forKey: key) ?? wrappedValue
        self.key = key
    }
    
    var wrappedValue: T {
        get { value }
        set {
            value = newValue
            UserDefaults.standard.encode(newValue, forKey: key)
            
            print(key, newValue)
        }
    }
}

