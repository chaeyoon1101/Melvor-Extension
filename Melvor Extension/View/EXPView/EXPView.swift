//
//  EXPView.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/11/24.
//

import SwiftUI

struct EXPView: View {
    @StateObject var viewModel = EXPViewModel()
    
    @State private var isPresentedModal = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if !viewModel.actions.isEmpty {
                    ForEach($viewModel.actions) { $action in
                        ActionDataView(actionID: $action.id)
                            .environmentObject(viewModel)
                            .onTapGesture { _ in
                                presentModal(isEditing: true, action: action)
                            }
                    }
                    
                } else {
                    Image("MelvorIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                    
                    Text("현재 진행 중인 작업이 없어요!")
                }
            }
            .font(.headline)
            .navigationTitle("EXP 계산")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("추가하기", systemImage: "plus.app") {
                        presentModal(isEditing: false)
                    }
                }
            }
            .sheet(isPresented: $isPresentedModal) {
                EXPModalView(isPresented: $isPresentedModal)
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            do {
                try viewModel.load()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func presentModal(isEditing: Bool, action: Action = .default) {
        viewModel.isEditing = isEditing
        viewModel.selectedAction = action
        self.isPresentedModal = true
    }
}

#Preview {
    EXPView()
}
