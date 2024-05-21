//
//  Post.swift
//  Pollexa
//
//  Created by Emirhan Erdogan on 13/05/2024.
//

import UIKit

struct Post: Decodable {
    
    // MARK: - Properties
    let id: String?
    let createdAt: String?
    let content: String?
    var options: [Option]?
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case content
        case options
        case user
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.content = try container.decode(String.self, forKey: .content)
        self.options = try container.decode([Option].self, forKey: .options)
        self.user = try container.decode(User.self, forKey: .user)

        var date = Date()
        if let decoder = decoder as? JSONDecoder {
            decoder.dateDecodingStrategy = .iso8601
            date = try container.decode(Date.self, forKey: .createdAt)
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        self.createdAt = formatter.string(from: date)
    }
}
