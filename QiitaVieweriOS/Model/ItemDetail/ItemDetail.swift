//
//  ItemDetail.swift
//  QiitaVieweriOS
//
//  Created by subta on 2019/04/28.
//  Copyright © 2019 subta90. All rights reserved.
//

import Foundation

struct ItemDetail: Codable {
    let title: String
    let createdAt: String
    let tags: [Tag]
    let user: User
    let renderedBody: String

    private enum CodingKeys: String, CodingKey {
        case title
        case createdAt = "created_at"
        case tags
        case user
        case renderedBody = "rendered_body"
    }

    init(title: String,
         createdAt: String,
         tags: [Tag],
         user: User,
         renderedBody: String) {
        self.title = title
        self.createdAt = createdAt
        self.tags = tags
        self.user = user
        self.renderedBody = renderedBody
    }
}

struct Tag: Codable {
    let name: String
    let versions: [String]

    private enum CodingKeys: String, CodingKey {
        case name
        case versions
    }

    init(name: String, versions: [String]) {
        self.name = name
        self.versions = versions
    }
}
