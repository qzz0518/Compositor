import Foundation

nonisolated extension RawRepresentable where RawValue == String {
    /// The raw value, translated for display. Many enums use their English raw value as the name shown in the UI,
    /// and some of those values are saved in projects, so they stay as they are and the string catalog keys their
    /// translations by that same English text.
    var localizedName: String { String(localized: String.LocalizationValue(rawValue)) }
}
