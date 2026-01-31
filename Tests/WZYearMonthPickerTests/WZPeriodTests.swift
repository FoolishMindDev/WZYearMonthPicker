import Testing
@testable import WZYearMonthPicker

@Suite("WZPeriod 네비게이션 및 경계 테스트")
struct WZPeriodTests {

    @Test("경계가 없을 때 이전/다음 후보와 이동 동작")
    func testMoveNoBounds() {
        var p = WZPeriod(selected: WZYearMonth(year: 2020, month: 5))
        #expect(p.canMovePrevious() == true)
        #expect(p.canMoveNext() == true)
        #expect(p.previousCandidate() == WZYearMonth(year: 2020, month: 4))
        #expect(p.nextCandidate() == WZYearMonth(year: 2020, month: 6))

        #expect(p.moveToPreviousIfPossible() == true)
        #expect(p.selected == WZYearMonth(year: 2020, month: 4))
    }

    @Test("최소 경계에 도달했을 때 이전 이동 불가")
    func testMinBoundaryPreventsPrevious() {
        var p = WZPeriod(
            selected: WZYearMonth(year: 2020, month: 5),
            minimum: WZYearMonth(year: 2020, month: 5)
        )

        #expect(p.canMovePrevious() == false)
        #expect(p.previousCandidate() == nil)
        #expect(p.moveToPreviousIfPossible() == false)
    }

    @Test("최대 경계에 도달했을 때 다음 이동 불가")
    func testMaxBoundaryPreventsNext() {
        var p = WZPeriod(
            selected: WZYearMonth(year: 2020, month: 12),
            maximum: WZYearMonth(year: 2020, month: 12)
        )

        #expect(p.canMoveNext() == false)
        #expect(p.nextCandidate() == nil)
        #expect(p.moveToNextIfPossible() == false)
    }

    @Test("연 경계에서의 래핑 동작")
    func testYearWrap() {
        var p = WZPeriod(selected: WZYearMonth(year: 2020, month: 12))
        #expect(p.nextCandidate() == WZYearMonth(year: 2021, month: 1))
        #expect(p.moveToNextIfPossible() == true)
        #expect(p.selected == WZYearMonth(year: 2021, month: 1))

        p = WZPeriod(selected: WZYearMonth(year: 2020, month: 1))
        #expect(p.previousCandidate() == WZYearMonth(year: 2019, month: 12))
        #expect(p.moveToPreviousIfPossible() == true)
        #expect(p.selected == WZYearMonth(year: 2019, month: 12))
    }

    @Test("AvailableMonths: nil year returns empty")
    func testAvailableMonthsNilYear() {
        let p = WZPeriod(
            selected: WZYearMonth(year: 2020, month: 6),
            minimum: WZYearMonth(year: 2020, month: 5),
            maximum: WZYearMonth(year: 2021, month: 12)
        )
        #expect(p.availableMonths(for: nil) == [])
    }

    @Test("AvailableMonths: year == minimum")
    func testAvailableMonthsMinimum() {
        let p = WZPeriod(
            selected: WZYearMonth(year: 2020, month: 6),
            minimum: WZYearMonth(year: 2020, month: 5),
            maximum: WZYearMonth(year: 2022, month: 12)
        )
        let expected = Array((5...12).reversed())
        #expect(p.availableMonths(for: 2020) == expected)
    }

    @Test("AvailableMonths: year == maximum")
    func testAvailableMonthsMaximum() {
        let p = WZPeriod(
            selected: WZYearMonth(year: 2020, month: 6),
            minimum: WZYearMonth(year: 2019, month: 1),
            maximum: WZYearMonth(year: 2021, month: 8)
        )
        let expected = Array((1...8).reversed())
        #expect(p.availableMonths(for: 2021) == expected)
    }

    @Test("AvailableMonths: middle year returns full months")
    func testAvailableMonthsMiddle() {
        let p = WZPeriod(
            selected: WZYearMonth(year: 2020, month: 6),
            minimum: WZYearMonth(year: 2019, month: 1),
            maximum: WZYearMonth(year: 2021, month: 12)
        )
        let expected = Array((1...12).reversed())
        
        #expect(p.availableMonths(for: 2020) == expected)
    }

    @Test("AvailableMonths: year at both boundaries")
    func testAvailableMonthsYearAtBothBounds() {
        let p = WZPeriod(
            selected: WZYearMonth(year: 2020, month: 6),
            minimum: WZYearMonth(year: 2020, month: 5),
            maximum: WZYearMonth(year: 2020, month: 8)
        )
        let expected = Array((5...8).reversed())
        #expect(p.availableMonths(for: 2020) == expected)
    }

    @Test("AvailableMonths: year same as maximum but before minimum returns empty")
    func testAvailableMonthsYearSameAsMaximumBeforeMinimum() {
        let p = WZPeriod(
            selected: WZYearMonth(year: 2026, month: 2),
            minimum: WZYearMonth(year: 2019, month: 1),
            maximum: WZYearMonth(year: 2026, month: 1)
        )
        let expected: [Int] = [1]
        #expect(p.availableMonths(for: 2026) == expected)
    }

    @Test("AvailableMonths: outof bounds year returns empty")
    func testAvailableMonthsOutOfBoundsYear() {
        let p = WZPeriod(
            selected: WZYearMonth(year: 2020, month: 2),
            minimum: WZYearMonth(year: 2020, month: 1),
            maximum: WZYearMonth(year: 2020, month: 1)
        )
        let expected: [Int] = [1]
        #expect(p.availableMonths(for: 2020) == expected)
    }

    @Test("AvailableYears: boundary .all returns empty")
    func testAvailableYearsWithAllBoundary() {
        let p = WZPeriod(
            selected: WZYearMonth(year: 2020, month: 6),
            minimum: WZYearMonth.all,
            maximum: WZYearMonth(year: 2021, month: 12)
        )
        #expect(p.availableYears.isEmpty)
    }
}
