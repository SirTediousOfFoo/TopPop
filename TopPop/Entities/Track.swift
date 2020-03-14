//
//  Song.swift
//  TopPop
//
//  Created by five on 14/03/2020.
//  Copyright © 2020 Pero. All rights reserved.
//

import Foundation

struct Track: Codable {
    let id: Int
    let title: String
    let duration: Int
    let position: Int
    let artist: Artist
    let album: Album
}
