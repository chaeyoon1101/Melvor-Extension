//
//  ActionDataView.swift
//  Melvor Extension
//
//  Created by 임채윤 on 12/12/24.
//

import SwiftUI

struct ActionDataView: View {
    @EnvironmentObject var viewModel: EXPViewModel
    var actionID: UUID
    
    @State var progress: Double = 0.0
    @State var timeLeft: String = "0s"
    @State var timer: Timer?
    
    let expManager = EXPManager()
    
    var body: some View {
        if let action = viewModel.actions.first(where: { $0.id == actionID }) {
            VStack(alignment: .leading) {
                // 스킬 정보
                let currentLevel = "LV." + expManager.calculateToLevel(from: action.currentEXP)
                let nextLevel = "LV." + expManager.calculateToLevel(from: action.nextEXP)
                HStack {
                    Image(action.skill?.image ?? "MelvorIcon")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(alignment: .leading) {
                        Text(action.skill?.name ?? "스킬이름")
                        HStack(spacing: 4) {
                            Text(currentLevel)
                            Image(systemName: "arrow.right")
                            Text(nextLevel)
                        }
                    }
                }
                .padding()
                
                VStack(alignment: .center, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(action.startDate, formatter: Date.dateFormatter)
                        Text("\(currentLevel), \(action.currentEXP.formattedNumber) EXP")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                    
                    
                    Image(systemName: "arrow.down")
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(expManager.calculateEndTime(action), formatter: Date.dateFormatter)
                        Text("\(nextLevel), \(action.nextEXP.formattedNumber) EXP")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text(String(format: "%.2f", progress) + "%")
                    BarGraphView(
                        value: progress,
                        barColor: .mint
                    )
                }
                .padding(.horizontal)
                
                Text("etc: \(timeLeft)")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
            }
            .onAppear {
                DispatchQueue.main.async {
                    timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                        guard let action = viewModel.actions.first(where: { $0.id == actionID }) else {
                            timer?.invalidate()
                            timer = nil
                            
                            return
                        }
                        
                        let endTime = expManager.calculateEndTime(action)
                        progress = expManager.calculateProgress(action.startDate, endTime)
                        timeLeft = expManager.calculateTimeLeft(endTime)
                    }
                }
            }
            .onDisappear {
                timer?.invalidate()
                timer = nil
            }
            .frame(width: UIScreen.width - 20, height: 400, alignment: .leading)
            .background(Color.mint.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .padding()
        }
    }
}
