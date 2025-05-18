//
//  BreatheType.swift
//  Prana
//
//  Created by Shubham Bhama on 18/05/25.
//

import SwiftUI

struct BreatheTypeModel: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let title: String
    let color: Color
}

let SampleType: [BreatheTypeModel] = [
    .init(title: "Anger", color: .mint),
    .init(title: "Iritation", color: .brown),
    .init(title: "Sadness", color: Color("Purple")),
]
