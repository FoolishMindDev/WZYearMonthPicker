# WZYearMonthPicker

WZYearMonthPicker is a lightweight SwiftUI period picker component.

![Demo screenshot](Assets/screenshot.png)

**Features**
- Select periods by year and month
- Optional "All" (entire range) selection
- Optional year-only selection (e.g. "2025")

**Installation (Swift Package Manager)**
1. In Xcode choose `File > Add Packages...`.
2. Enter the repository URL and add the package to your project.

Or add it to your `Package.swift` dependencies.

**Quick Start**
```swift
import SwiftUI
import WZYearMonthPicker

struct ExampleView: View {
  @State private var period = WZPeriod(
    selected: .now,
    minimum: .yearMonth(year: 2023, month: 5),
    maximum: .yearMonth(year: 2026, month: 10)
  )

  var body: some View {
    HStack(spacing: 15) {
      Button(action: { period.moveToPreviousIfPossible() }) { Image(systemName: "chevron.left") }
      WZYearMonthPicker(period: $period)
      Button(action: { period.moveToNextIfPossible() }) { Image(systemName: "chevron.right") }
    }
  }
}
```

**Parameters**
- `WZYearMonthPicker(period: Binding<WZPeriod>, allowAllPeriod: Bool = false, allowYearAll: Bool = false)`
  - `allowAllPeriod`: Enables an "All" selection representing the entire range.
  - `allowYearAll`: Enables selecting a whole year (e.g. `2025`).

**Compact mode**
- `compact` (initializer): `WZYearMonthPicker(period: ..., compact: Bool = false, ...)` — when `true` the picker renders a tighter, space-saving layout. The default is `false`.
- `compactPicker()` (view modifier): an environment-based modifier that overrides the initializer value. Example: `WZYearMonthPicker(period: $p).compactPicker()`.

Behavior when compact is enabled:
- Reduced horizontal spacing and smaller emblem/icon sizes.
- Only a single trailing `chevron.down` is shown for the whole control (no repeated chevrons on each label).
- Year and month labels use compact numeric formats (no locale year/month suffixes) to save space.

Behavior in normal (non-compact) mode:
- Each label shows a chevron (for year) and localized month names; the year label may include the locale's year suffix (e.g. `년` for Korean, `年` for Chinese/Japanese) according to the system locale and calendar.

Examples:
```swift
// initializer-based compact
WZYearMonthPicker(period: $period, compact: true)

// environment modifier (overrides initializer)
WZYearMonthPicker(period: $period)
  .compactPicker() // forces compact mode via environment
```

`WZPeriod` supports early initializers such as `.now`, `.all`, `.year(YYYY)`, and `.yearMonth(year: YYYY, month: M)`. Helper methods like `moveToPreviousIfPossible()` and `moveToNextIfPossible()` are provided for navigation.

**Tutorial — three example configurations (from the example app)**

1) Default (no "All" selection)
```swift
@State private var period1 = WZPeriod(
  selected: .now,
  minimum: .yearMonth(year: 2023, month: 5),
  maximum: .yearMonth(year: 2026, month: 10)
)
WZYearMonthPicker(period: $period1)
```

2) Allow year-only selection
```swift
@State private var period2 = WZPeriod(
  selected: .year(2025),
  minimum: .yearMonth(year: 2023, month: 5),
  maximum: .yearMonth(year: 2026, month: 10)
)
WZYearMonthPicker(period: $period2, allowAllPeriod: false, allowYearAll: true)
```

3) Allow both "All" and year-only selections
```swift
@State private var period3 = WZPeriod(
  selected: .all,
  minimum: .yearMonth(year: 2023, month: 5),
  maximum: .yearMonth(year: 2026, month: 10)
)
WZYearMonthPicker(period: $period3, allowAllPeriod: true, allowYearAll: true)
```

**Running the example**
- Open `WZYearMonthPickerExample.xcodeproj` or the workspace in Xcode and run the example app.

**Contributing**
Bug reports, feature requests and pull requests are welcome.

---
README and example-based tutorial have been added. If you'd like a more detailed API reference, additional examples, or localized versions, tell me which you'd prefer next.

## Demo

<video src="Assets/demo.mov" controls style="max-width:100%"></video>
