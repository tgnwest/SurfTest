//
//  Data.swift
//  test
//
//  Created by Alexey Tregubov on 09.02.2023.
//

import Foundation

struct Data {
    static func getTags() -> [Tag] {
        return [
            Tag(title: "IOS"),
            Tag(title: "Android"),
            Tag(title: "Design"),
            Tag(title: "Flutter"),
            Tag(title: "QA"),
            Tag(title: "PM"),
            Tag(title: "Backend"),
            Tag(title: "Frontend"),
            Tag(title: "Testing"),
            Tag(title: "Sprint"),
        ]
    }
}
