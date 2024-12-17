//
//  EXPViewModel.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/11/24.
//

import Foundation

class EXPViewModel: ObservableObject {
    @UserDefaultsStorage(.expActions) var actions: [Action] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    private let expManager = EXPManager()
    
    @Published var selectedAction: Action = .default
    @Published var isEditing: Bool = false
    
    func handle(operation: EXPOperation, for action: Action) {
        selectedAction = action
        
        switch operation {
        case .add:
            add()
        case .update:
            update()
        case .delete:
            delete()
        }
    }
    
    private func add() {
        actions.append(selectedAction)
        
        let endTime = expManager.calculateEndTime(selectedAction)
        NotificationManager.instance.addNotification(at: endTime, action: selectedAction)
    }
    
    private func update() {
        actions = actions.map { // 업데이트하는 action과 같은 id가 있다면 변경 된 action으로 업데이트
            let isUpdatingAction = $0.id == selectedAction.id
            
            return isUpdatingAction ? selectedAction : $0
        }
        
        let endTime = expManager.calculateEndTime(selectedAction)
        NotificationManager.instance.updateNotification(
            at: endTime,
            action: selectedAction
        )
    }
    
    private func delete() {
        actions = actions.filter {
            $0.id != selectedAction.id
        }
        
        NotificationManager.instance.deleteNotification(action: selectedAction)
    }
}
