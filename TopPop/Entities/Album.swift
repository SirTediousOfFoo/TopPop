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


//MARK: - Album TracklistTrack

struct TracklistTrack: Codable{
    let id: Int
    let readable: Bool
    let title, titleShort, titleVersion, isrc: String
    let link: String
    let duration, trackPosition, diskNumber, rank: Int
    let explicitLyrics: Bool
    let explicitContentLyrics, explicitContentCover: Int
    let preview: String
    let artist: AlbumArtist
    let type: String

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case isrc, link, duration
        case trackPosition = "track_position"
        case diskNumber = "disk_number"
        case rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview, artist, type
    }
}

//MARK: - AlbumArtist

struct AlbumArtist: Codable {
    let id: Int
    let name: String
    let tracklist: String
    let type: String
}

typealias Tracklist = [TracklistTrack]
