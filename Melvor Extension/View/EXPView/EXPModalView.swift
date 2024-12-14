//
//  EXPModalView.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import SwiftUI

struct EXPModalView: View {
    @EnvironmentObject var viewModel: EXPViewModel
    
    @Binding var isPresented: Bool
    
    @State private var currentEXPForm = ActionInputForm(fieldType: .currentEXP)
    @State private var nextEXPForm = ActionInputForm(fieldType: .nextEXP)
    @State private var expPerActionForm = ActionInputForm(fieldType: .expPerAction)
    @State private var timePerActionForm = ActionInputForm(fieldType: .timePerAction)
    
    @State private var isNotificationEnabled: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                SkillTypeView(selectedSkill: $viewModel.selectedAction.skill)
                
                ActionInputField(form: $currentEXPForm)
                
                ActionInputField(form: $nextEXPForm)
                
                ActionInputField(form: $expPerActionForm)
                
                ActionInputField(form: $timePerActionForm)
                
                Toggle("알림 받기", isOn: $isNotificationEnabled)
                    .onChange(of: isNotificationEnabled) { _, newValue in
                        if newValue == true {
                            NotificationManager.instance.requestAuthorization()
                        }
                    }
                    .padding(.trailing, 12)
                
                if viewModel.isEditing {
                    Button {
                        delete()
                        dismiss()
                    } label: {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.gray.opacity(0.2))
                            .frame(height: 40)
                            .overlay {
                                Text("작업 삭제")
                                    .foregroundStyle(.red)
                            }
                    }
                }
            }
            .onAppear {
                load()
            }
            .padding()
            .navigationTitle("작업 추가")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료") {
                        viewModel.selectedAction.startDate = Date()
                        saveAction()
                    }
                }
            }
            
            Spacer()
        }
    }
    
    func load() {
        currentEXPForm.value = viewModel.selectedAction.currentEXP
        nextEXPForm.value = viewModel.selectedAction.nextEXP
        expPerActionForm.value = viewModel.selectedAction.expPerAction
        timePerActionForm.value = viewModel.selectedAction.timePerAction
    }
    
    func saveAction() {
        let expManager = EXPManager()
        
        // Level로 입력했을 경우 exp로 계산하여 저장
        let currentEXP = currentEXPForm.selection == .level
            ? expManager.calculateToEXP(From: Int(currentEXPForm.value.removedComma) ?? 0)
            : currentEXPForm.value.removedComma
        
        let nextEXP = nextEXPForm.selection == .level
            ? expManager.calculateToEXP(From: Int(nextEXPForm.value.removedComma) ?? 0)
            : nextEXPForm.value.removedComma
        
        
        let saveAction = Action(
            id: viewModel.selectedAction.id,
            startDate: viewModel.selectedAction.startDate,
            skill: viewModel.selectedAction.skill,
            currentEXP: currentEXP,
            nextEXP: nextEXP,
            expPerAction: expPerActionForm.value.removedComma,
            timePerAction: timePerActionForm.value.removedComma,
            isNotificationEnabled: isNotificationEnabled
        )
        
        do {
            try viewModel.save(action: saveAction)
        } catch let error {
            print("Action save 에러: ", error.localizedDescription)
        }
        
        dismiss()
    }
    
    func delete() {
        do {
            try viewModel.delete()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func dismiss() {
        isPresented = false
    }
}

#Preview {
    EXPModalView(isPresented: .constant(true))
        .environmentObject(EXPViewModel())
}
