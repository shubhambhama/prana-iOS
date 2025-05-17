//
//  OpenAIModel.swift
//  Prana
//
//  Created by Shubham Bhama on 16/05/25.
//

import Foundation

struct ChatMessage: Encodable {
    let role: String
    let content: String
}

struct ChatRequest: Encodable {
    let model: String
    let messages: [ChatMessage]
    let temperature: Int
}

struct ChatResponse: Decodable {
    struct Choice: Decodable {
        let message: Message
    }

    struct Message: Decodable {
        let role: String
        let content: String
    }

    let choices: [Choice]
}
