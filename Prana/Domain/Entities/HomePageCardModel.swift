//
//  HomePageCardModel.swift
//  Prana
//
//  Created by Shubham Bhama on 16/05/25.
//

import Foundation
import SwiftUI

struct HomePageCardModel {
    let id: UUID
    let title: String
    let subtitle: String
    let backgroundColor: String
    let footerAction: String?
    let homeCardType: HomeCardType
    
    init(title: String, subtitle: String, backgroundColor: String, footerAction: String? = nil, homeCardType: HomeCardType) {
        self.id = UUID()
        self.title = title
        self.subtitle = subtitle
        self.backgroundColor = backgroundColor
        self.footerAction = footerAction
        self.homeCardType = homeCardType
    }
}
