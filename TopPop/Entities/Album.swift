//
//  Album.swift
//  TopPop
//
//  Created by five on 14/03/2020.
//  Copyright © 2020 Pero. All rights reserved.
//

// MARK: - Album

struct Album: Codable, Equatable {
    let id: Int
    let title: String
    let cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String
    let tracklist: String
    let type: AlbumType

    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case tracklist, type
    }
}

//MARK: - AlbumType

enum AlbumType: String, Codable, Equatable {
    case album = "album"
}
