import Testing
import Foundation
@testable import WZYearMonthPicker

@Suite("WZYearMonth 기본 동작 테스트")
struct WZYearMonthTests {

    @Test("컴포넌트 분해")
    func testComponents() {
        let ym = WZYearMonth.yearMonth(year: 2024, month: 5)
        #expect(ym.yearComponent == 2024)
        #expect(ym.monthComponent == 5)
        #expect(ym.yearMonthComponent?.0 == 2024)
        #expect(ym.yearMonthComponent?.1 == 5)

        let y = WZYearMonth.year(1999)
        #expect(y.yearComponent == 1999)
        #expect(y.monthComponent == nil)

        let a = WZYearMonth.all
        #expect(a.yearComponent == nil)
        #expect(a.monthComponent == nil)
    }

    @Test("Next/Previous 경계 동작")
    func testNextPrevious() {
        let dec = WZYearMonth.yearMonth(year: 2023, month: 12)
        #expect(dec.next() == WZYearMonth.yearMonth(year: 2024, month: 1))

        let jan = WZYearMonth.yearMonth(year: 2024, month: 1)
        #expect(jan.previous() == WZYearMonth.yearMonth(year: 2023, month: 12))

        let y = WZYearMonth.year(2020)
        #expect(y.next() == WZYearMonth.year(2021))
        #expect(y.previous() == WZYearMonth.year(2019))
    }

    @Test("비교 및 순서")
    func testCompareAndOrdering() {
        let early = WZYearMonth.yearMonth(year: 2023, month: 11)
        let late = WZYearMonth.yearMonth(year: 2023, month: 12)
        #expect(early.compare(late) == .orderedAscending)
        #expect(early.isBefore(late))
        #expect(late.isAfter(early))

        // Different years
        let older = WZYearMonth.yearMonth(year: 2022, month: 12)
        let newer = WZYearMonth.yearMonth(year: 2023, month: 1)
        #expect(older.compare(newer) == .orderedAscending)

        // Comparing with `.all` yields nil
        #expect(WZYearMonth.all.compare(older) == nil)
        #expect(older.compare(.all) == nil)
    }

    @Test("Granularity 확인")
    func testGranularity() {
        #expect(WZYearMonth.all.granularity == WZPeriodGranularity.all)
        #expect(WZYearMonth.year(2020).granularity == WZPeriodGranularity.year)
        #expect(WZYearMonth.yearMonth(year: 2020, month: 6).granularity == WZPeriodGranularity.month)
    }

    @Test("Date 기반 초기화")
    func testInitFromDate() {
        var comps = DateComponents()
        comps.year = 2001
        comps.month = 7
        let cal = Calendar.current
        let date = cal.date(from: comps)!

        let fromDate = WZYearMonth(date: date)
        #expect(fromDate.yearComponent == 2001)
        #expect(fromDate.monthComponent == 7)

        // init?(year: Date) should produce a `year` case
        let yearOnly = WZYearMonth(year: date)
        #expect(yearOnly == .year(2001))
    }
}
