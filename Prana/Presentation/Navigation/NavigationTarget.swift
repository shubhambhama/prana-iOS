//
//  NavigationTarget.swift
//  Prana
//
//  Created by Shubham Bhama on 17/05/25.
//

import Foundation

enum NavigationTarget: Identifiable, Hashable {
    case breath

    var id: String {
        switch self {
        case .breath: return "breath"
        }
    }
}
