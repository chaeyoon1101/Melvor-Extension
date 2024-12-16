//
//  EXPViewModel.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/11/24.
//

import Foundation

class EXPViewModel: ObservableObject {
    private let expManager = EXPManager()
    
    @UserDefaultsStorage(.expActions) var actions: [Action] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    @Published var selectedAction: Action = .default
    @Published var isEditing: Bool = false
    
    func save(action: Action) throws {
        selectedAction = action
        
        if isEditing {
            try update()
        } else {
            try add()
        }
    }
    
    func add() throws {
        actions.append(selectedAction)
        
        let endTime = expManager.calculateEndTime(selectedAction)
        NotificationManager.instance.addNotification(at: endTime, action: selectedAction)
    }
    
    func update() throws {
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
    
    func delete() throws {
        actions = actions.filter {
            $0.id != selectedAction.id
        }
        
        NotificationManager.instance.deleteNotification(action: selectedAction)
    }
    
    func updateSelectedAction(_ action: Action) {
        selectedAction = action
    }
}

enum EXPError: LocalizedError {
    case loadError
    case addError
    case updateError
    case deleteError
    
    var errorDescription: String? {
        switch self {
        case .loadError:
            return "작업 로드 실패"
        case .addError:
            return "작업 추가 실패"
        case .updateError:
            return "작업 업데이트 실패"
        case .deleteError:
            return "작업 삭제 실패"
        }
    }
}
