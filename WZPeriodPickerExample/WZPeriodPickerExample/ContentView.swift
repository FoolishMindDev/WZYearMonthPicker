//
//  ContentView.swift
//  WZPeriodPickerExample
//
//  Created by Jaehoon Lee on 1/29/26.
//

import SwiftUI
import WZPeriodPicker

struct ContentView: View {
    @State private var period = WZPeriod(
        selected: .now,
        minimum: .yearMonth(year: 2023, month: 5),
        maximum: .yearMonth(year: 2026, month: 10)
    )

    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(period.selected.description)")
                .font(.headline)
            Text("During : \(period.minimum.description) ~ \(period.maximum.description)")

            
            HStack(spacing: 15) {
                // 이전 달 이동 버튼
                Button(action: moveToPrevious) {
                    Image(systemName: "chevron.left")
                        .padding(10)
                        .background(Color.secondary.opacity(0.1))
                        .clipShape(Circle())
                }
                .disabled(!canMovePrevious)
                
                // WZPeriodPicker 사용
                WZPeriodPicker(period: $period)
                
                // 다음 달 이동 버튼
                Button(action: moveToNext) {
                    Image(systemName: "chevron.right")
                        .padding(10)
                        .background(Color.secondary.opacity(0.1))
                        .clipShape(Circle())
                }
                .disabled(!canMoveNext)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)).shadow(radius: 2))
        }
    }
}

extension ContentView {
    private var canMovePrevious: Bool {
        period.canMovePrevious()
    }
    
    private var canMoveNext: Bool {
        period.canMoveNext()
    }
    
    private func moveToPrevious() {
        period.moveToPreviousIfPossible()
    }
    
    private func moveToNext() {
        period.moveToNextIfPossible()
    }
}

#Preview {
    ContentView()
}
