//
//  UserDefaults+Extension.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/15/24.
//

import Foundation

extension UserDefaults {
    func removeObject(forkey key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    func encode<T: Codable>(_ value: T, forKey key: UserDefaultsKey) {
        let data = try? JSONEncoder().encode(value)
        
        self.set(data, forKey: key.rawValue)
    }
    
    func decode<T: Codable>(_ type: T.Type, forKey key: UserDefaultsKey) -> T? {
        guard let data = self.data(forKey: key.rawValue) else { return nil }
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
