//
//  NavigationTarget.swift
//  Prana
//
//  Created by Shubham Bhama on 17/05/25.
//

import Foundation

enum NavigationTarget: Identifiable, Hashable {
    case breath(CGFloat, CGFloat, CGFloat, CGFloat)

    var id: String {
        switch self {
        case let .breath(inhale, inhaleHold, exhale, exhaleHold): return "breath_\(inhale)_\(inhaleHold)_\(exhale)_\(exhaleHold)"
        }
    }
}
