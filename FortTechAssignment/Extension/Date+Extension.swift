//
//  Date+Extension.swift
//  FortTechAssignment
//
//  Created by Priyanka Kumari on 24/09/23.
//

import Foundation

enum CustomDateFormat: String {
    case standardDateFormat = "MM/dd/yyyy\nHH:mm:ss a"
}

extension Date {
    
    private func getFormatter(customDateFormat: CustomDateFormat, timeZone: TimeZone?) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = customDateFormat.rawValue
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = timeZone ?? TimeZone.current
        return dateFormatter
    }
    
    public func getDateString() -> String? {
        let dateFormatter = getFormatter(customDateFormat: .standardDateFormat, timeZone: TimeZone.current)
        let standardDate = dateFormatter.string(from: self)
        return standardDate
    }
}
