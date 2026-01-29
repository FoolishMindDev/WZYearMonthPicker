import Testing
@testable import WZPeriodPicker

@Suite("WZPeriod 네비게이션 및 경계 테스트")
struct WZPeriodTests {

    @Test("경계가 없을 때 이전/다음 후보와 이동 동작")
    func testMoveNoBounds() {
        var p = WZPeriod(selected: WZYearMonth.yearMonth(year: 2020, month: 5))
        #expect(p.canMovePrevious() == true)
        #expect(p.canMoveNext() == true)
        #expect(p.previousCandidate() == WZYearMonth.yearMonth(year: 2020, month: 4))
        #expect(p.nextCandidate() == WZYearMonth.yearMonth(year: 2020, month: 6))

        #expect(p.moveToPreviousIfPossible() == true)
        #expect(p.selected == WZYearMonth.yearMonth(year: 2020, month: 4))
    }

    @Test("최소 경계에 도달했을 때 이전 이동 불가")
    func testMinBoundaryPreventsPrevious() {
        var p = WZPeriod(
            selected: WZYearMonth.yearMonth(year: 2020, month: 5),
            minimum: WZYearMonth.yearMonth(year: 2020, month: 5)
        )

        #expect(p.canMovePrevious() == false)
        #expect(p.previousCandidate() == nil)
        #expect(p.moveToPreviousIfPossible() == false)
    }

    @Test("최대 경계에 도달했을 때 다음 이동 불가")
    func testMaxBoundaryPreventsNext() {
        var p = WZPeriod(
            selected: WZYearMonth.yearMonth(year: 2020, month: 12),
            maximum: WZYearMonth.yearMonth(year: 2020, month: 12)
        )

        #expect(p.canMoveNext() == false)
        #expect(p.nextCandidate() == nil)
        #expect(p.moveToNextIfPossible() == false)
    }

    @Test("연 경계에서의 래핑 동작")
    func testYearWrap() {
        var p = WZPeriod(selected: WZYearMonth.yearMonth(year: 2020, month: 12))
        #expect(p.nextCandidate() == WZYearMonth.yearMonth(year: 2021, month: 1))
        #expect(p.moveToNextIfPossible() == true)
        #expect(p.selected == WZYearMonth.yearMonth(year: 2021, month: 1))

        p = WZPeriod(selected: WZYearMonth.yearMonth(year: 2020, month: 1))
        #expect(p.previousCandidate() == WZYearMonth.yearMonth(year: 2019, month: 12))
        #expect(p.moveToPreviousIfPossible() == true)
        #expect(p.selected == WZYearMonth.yearMonth(year: 2019, month: 12))
    }
}
