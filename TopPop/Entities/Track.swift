//  Track.swift
//  TopPop
//
//  Created by five on 14/03/2020.
//  Copyright © 2020 Pero. All rights reserved.
//
// MARK: - Track

struct Track: Codable, Equatable {
    let id: Int
    let title, titleShort: String
    let titleVersion: TitleVersion
    let link: String
    let duration, rank: Int
    let explicitLyrics: Bool
    let explicitContentLyrics, explicitContentCover: Int
    let preview: String
    let position: Int
    let artist: Artist
    let album: Album
    let type: ChartType

    enum CodingKeys: String, CodingKey {
        case id, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case link, duration, rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview, position, artist, album, type
    }
}
