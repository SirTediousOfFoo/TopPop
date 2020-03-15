//
//  Artist.swift
//  TopPop
//
//  Created by five on 14/03/2020.
//  Copyright © 2020 Pero. All rights reserved.
//

// MARK: - Artist
struct Artist: Codable, Equatable {
    let id: Int
    let name: String
    let link, picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let radio: Bool
    let tracklist: String
    let type: ArtistType

    enum CodingKeys: String, CodingKey {
        case id, name, link, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, type
    }
}

enum ArtistType: String, Codable, Equatable {
    case artist = "artist"
}
