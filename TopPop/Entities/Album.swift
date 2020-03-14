//
//  Album.swift
//  TopPop
//
//  Created by five on 14/03/2020.
//  Copyright © 2020 Pero. All rights reserved.
//

import Foundation

struct Album: Codable{
    let id: Int
    let title: String
    let coverUrl: String
    let tracklistUrl: String
}
