//
//  PeriodPickerExampleView.swift
//  WZPeriodPicker
//
//  Created by Jaehoon Lee on 1/29/26.
//

import SwiftUI

struct WZPeriodPickerExampleView: View {
    @State private var period = WZPeriod(
        selected: .now,
        minimum: .yearMonth(year: 2023, month: 5),
        maximum: .now
    )
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(period.selected.description)")
                .font(.headline)
            
            HStack(spacing: 15) {
                // 이전 달 이동 버튼
                Button(action: moveToPrevious) {
                    Image(systemName: "chevron.left")
                        .padding(10)
                        .background(Color.secondary.opacity(0.1))
                        .clipShape(Circle())
                }
                .disabled(!canMovePrevious)
                
                // 우리가 만든 패키지 피커
                WZPeriodPicker(
                    period: $period,
                )
                
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
        .padding()
    }
}

extension WZPeriodPickerExampleView {
    private var canMovePrevious: Bool {
        return true
    }
    
    private var canMoveNext: Bool {
        return true
    }
    
    private func moveToPrevious() {
        period.selected = period.selected.previous()
    }
    
    private func moveToNext() {
        period.selected = period.selected.next()
    }
}

#Preview {
    WZPeriodPickerExampleView()
}
