//
//  WZPeriod.swift
//  WZPeriodPicker
//
//  Created by Jaehoon Lee on 1/30/26.
//
import Foundation

public struct WZPeriod {
    public var selected: WZYearMonth
    public var minimum: WZYearMonth
    public var maximum: WZYearMonth
    
    public init(selected: WZYearMonth, minimum: WZYearMonth? = nil, maximum: WZYearMonth? = nil) {
        self.selected = selected
        self.minimum = minimum ?? WZYearMonth.yearMonth(year: 1900, month: 1)
        self.maximum = maximum ?? WZYearMonth.now
    }
    
    mutating func setCurrentYearMonth(_ yearMonth: WZYearMonth) {
        selected = yearMonth
    }
}

// Navigation and query helpers that use stored bounds
extension WZPeriod {
    public func canMovePrevious() -> Bool {
        let prev = selected.previous()
        if prev == selected { return false }
        if let cmp = prev.compare(minimum) {
            return cmp != .orderedAscending
        }
        return false
    }

    public func canMoveNext() -> Bool {
        let nxt = selected.next()
        if nxt == selected { return false }
        if let cmp = nxt.compare(maximum) {
            return cmp != .orderedDescending
        }
        return false
    }

    func previousCandidate() -> WZYearMonth? {
        let prev = selected.previous()
        if prev == selected { return nil }
        if let cmp = prev.compare(minimum), cmp == .orderedAscending {
            return nil
        }
        return prev
    }

    func nextCandidate() -> WZYearMonth? {
        let nxt = selected.next()
        if nxt == selected { return nil }
        if let cmp = nxt.compare(maximum), cmp == .orderedDescending {
            return nil
        }
        return nxt
    }

    @discardableResult
    public mutating func moveToPreviousIfPossible() -> Bool {
        guard let candidate = previousCandidate() else { return false }
        selected = candidate
        return true
    }

    @discardableResult
    public mutating func moveToNextIfPossible() -> Bool {
        guard let candidate = nextCandidate() else { return false }
        selected = candidate
        return true
    }
}

// Helper to compute available months for a given year within the period bounds
public extension WZPeriod {
    func availableMonths(for year: Int?) -> [Int] {
        guard let year = year else { return [] }
        guard let minYear = minimum.yearComponent,
              let maxYear = maximum.yearComponent else { return [] }
        guard year >= minYear && year <= maxYear else { return [] }

        let startMonth: Int = (year == minYear) ? (minimum.monthComponent ?? 1) : 1
        let endMonth: Int = (year == maxYear) ? (maximum.monthComponent ?? 12) : 12

        guard startMonth <= endMonth else { return [] }
        return Array(startMonth...endMonth).reversed()
    }

    var availableYears: [Int] {
        guard let minY = minimum.yearComponent, let maxY = maximum.yearComponent else { return [] }
        return Array(minY...maxY).reversed()
    }
}

