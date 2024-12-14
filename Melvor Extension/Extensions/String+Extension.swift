//
//  String+Extension.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import Foundation

extension String {
    var formattedNumber: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal    
        
        return formatter.string(for: Double(self)) ?? ""
    }
    
    var removedComma: String {
        return self.replacingOccurrences(of: ",", with: "")
    }
}


