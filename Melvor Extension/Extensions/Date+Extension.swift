//
//  Date+Extension.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import Foundation

extension Date {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일 HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "KST")
        return formatter
    }
}
