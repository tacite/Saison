//
//  File.swift
//  
//
//  Created by David Tacite on 14/07/2023.
//

import Foundation

public enum FoodType: String, Codable {
    case Fruit
    case Vegetable
}

public struct Element: Identifiable, Codable {
    public var id = UUID()
    public var name: String
    public var months: [Int]
    public var type: FoodType
    public var emoji: String
    public var local: Bool
    
    public init(id: UUID = UUID(), name: String, months: [Int], type: FoodType, emoji: String, local: Bool) {
        self.id = id
        self.name = name
        self.months = months
        self.type = type
        self.emoji = emoji
        self.local = local
    }
    
    enum CodingKeys: CodingKey {
        case name
        case type
        case months
        case emoji
        case local
    }
}

