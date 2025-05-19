//
//  HomeCardType.swift
//  Prana
//
//  Created by Shubham Bhama on 18/05/25.
//

import Foundation

enum HomeCardType {
    case equalBreathing
    case boxBreathing
    case fourSevenEightBreathing
    case breathHolding

    var parameters: (inhale: CGFloat, inhaleHold: CGFloat, exhale: CGFloat, exhaleHold: CGFloat) {
        switch self {
        case .equalBreathing:
            return (inhale: 4.0, inhaleHold: 0.0, exhale: 4.0, exhaleHold: 0.0)
        case .boxBreathing:
            return (inhale: 4.0, inhaleHold: 4.0, exhale: 4.0, exhaleHold: 4.0)
        case .fourSevenEightBreathing:
            return (inhale: 4.0, inhaleHold: 7.0, exhale: 8.0, exhaleHold: 0.0)
        case .breathHolding:
            return (inhale: 5.0, inhaleHold: 1000.0, exhale: 5.0, exhaleHold: 0.0)
        }
    }
}

