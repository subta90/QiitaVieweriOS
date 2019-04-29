//
//  Item.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/03/16.
//  Copyright © 2019 subta90. All rights reserved.
//

import Foundation

struct Item: Codable {
    let id: String
    let title: String
    let user: User

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case user
    }

    init(id: String, title: String, user: User) {
        self.id = id
        self.title = title
        self.user = user
    }
}

struct User: Codable {
    let id: String
    let profileImageUrl: String

    private enum CodingKeys: String, CodingKey {
        case id
        case profileImageUrl = "profile_image_url"
    }

    init(id: String, profileImageUrl: String) {
        self.id = id
        self.profileImageUrl = profileImageUrl
    }
}
