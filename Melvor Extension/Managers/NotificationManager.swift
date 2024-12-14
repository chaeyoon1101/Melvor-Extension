//
//  NotificationViewModel.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import SwiftUI
import UserNotifications

final class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { isGranted, error in
            if isGranted {
                print("UserNotification authorization is granted")
            } else if let error = error {
                print("UserNotification Authorization 에러: ", error.localizedDescription)
            }
        }
    }
    
    func addNotification(at date: Date, action: Action) {
        let content = UNMutableNotificationContent()
        content.title = "\(action.skill?.name ?? "") 작업 완료!"
        content.subtitle = "LV.\(EXPManager().calculateToLevel(from: action.nextEXP)) 달성"
        content.sound = .default
        content.badge = 1
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: action.id.uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func deleteNotification(action: Action) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [action.id.uuidString])
    }
    
    func updateNotification(at date: Date, action: Action) {
        deleteNotification(action: action)
        
        addNotification(at: date, action: action)
    }
}
