//
//  MockData.swift
//  GraficosApp
//
//  Created by Késia Silva Viana on 18/10/25.
//

import Foundation
import SwiftUI

struct ViewDado: Identifiable {
    let id = UUID()
    let date: Date
    let viewCount: Int
    
    static let mockData: [ViewDado] = [
        .init(date: Date.from(year: 2025, month: 01, day: 01), viewCount: 1340),
        .init(date: Date.from(year: 2025, month: 02, day: 01), viewCount: 3245),
        .init(date: Date.from(year: 2025, month: 03, day: 01), viewCount: 6785),
        .init(date: Date.from(year: 2025, month: 04, day: 01), viewCount: 2889),
        .init(date: Date.from(year: 2025, month: 05, day: 01), viewCount: 3472),
        .init(date: Date.from(year: 2025, month: 06, day: 01), viewCount: 7773),
        .init(date: Date.from(year: 2025, month: 07, day: 01), viewCount: 2203),
        .init(date: Date.from(year: 2025, month: 08, day: 01), viewCount: 6646),
        .init(date: Date.from(year: 2025, month: 09, day: 01), viewCount: 1030),
        .init(date: Date.from(year: 2025, month: 10, day: 01), viewCount: 3256),
        .init(date: Date.from(year: 2025, month: 11, day: 01), viewCount: 3321),
        .init(date: Date.from(year: 2025, month: 12, day: 01), viewCount: 3321)
    ]
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components)!
    }
}

