//
//  Models.swift
//  qocHealthAssesment
//
//  Created by Waleed Azhar on 2018-09-24.
//  Copyright © 2018 Waleed Azhar. All rights reserved.
//

import Foundation

struct FeedString: Codable {
    var label: String?
    var attributes: FeedAttributes?
}

struct EndpointResponse:Codable {
    var feed: Feed
}

struct Feed: Codable {
    var entry: [AppDetail]
    var title: FeedString
}

struct FeedAttributes: Codable {
    var amount: String?
    var currency: String?
    var term: String?
    var href: String?
    var label: String?
}

struct FeedImage: Codable {
    var label: String
}

struct AppDetail: Codable {
    
    var name: FeedString
    var images: [FeedString]
    var releaseDate: FeedString
    var summary: FeedString
    var price: FeedString
    var category: FeedString
    var link: FeedString
    var artist: FeedString
    
    private enum CodingKeys: String, CodingKey {
        case name = "im:name"
        case images = "im:image"
        case releaseDate = "im:releaseDate"
        case summary = "summary"
        case price = "im:price"
        case category = "category"
        case link = "link"
        case artist = "im:artist"
    }

}


