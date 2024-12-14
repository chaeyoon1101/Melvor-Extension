//
//  EXPViewModel.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/11/24.
//

import Foundation

class EXPViewModel: ObservableObject {
    private let userDefaultsKey = "MELVOR_EXTENSION_EXP_ACTION_KEY"
    private let expManager = EXPManager()
    
    @Published var actions: [Action] = []
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
    
    func load() throws {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let loadedActions = try? JSONDecoder().decode([Action].self, from: savedData) {
            actions = loadedActions
            print("현재 작업중인 작업들: \(actions)")
            return
        }
        
        throw EXPError.loadError
    }
    
    func add() throws {
        actions.append(selectedAction)
        
        if let encodedData = try? JSONEncoder().encode(actions) {
            try saveUserDefaults(encodedData)
            
            let endTime = expManager.calculateEndTime(selectedAction)
            NotificationManager.instance.addNotification(at: endTime, action: selectedAction)
        } else {
            throw EXPError.addError
        }
    }
    
    func update() throws {
        let updatedActions = actions.map { // 저장하는 action(파라미터)과 같은 id가 있다면 변경된 action으로 업데이트
            $0.id == selectedAction.id ? selectedAction : $0
        }
        
        if let encodedData = try? JSONEncoder().encode(updatedActions) {
            try saveUserDefaults(encodedData)
            
            let endTime = expManager.calculateEndTime(selectedAction)
            NotificationManager.instance.updateNotification(
                at: endTime,
                action: selectedAction
            )
        } else {
            throw EXPError.updateError
        }
    }
    
    func delete() throws {
        let updatedAction = actions.filter {
            $0.id != selectedAction.id
        }
        
        if actions.count != updatedAction.count,
        let encodedData = try? JSONEncoder().encode(updatedAction) {
            try saveUserDefaults(encodedData)
            
            NotificationManager.instance.deleteNotification(action: selectedAction)
        } else {
            throw EXPError.deleteError
        }
    }
    
    private func saveUserDefaults(_ data: Data) throws {
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
        
        try load()
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
