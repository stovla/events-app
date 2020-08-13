//
//  Date+Extensions.swift
//  EventsApp
//
//  Created by Vlastimir on 11/08/2020.
//

import Foundation

extension Date {
    func timeRemaining(until endDate: Date) -> String {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        return dateComponentsFormatter.string(from: self, to: endDate) ?? ""
    }
}
