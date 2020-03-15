//
//  Time.swift
//  TopPop
//
//  Created by five on 15/03/2020.
//  Copyright © 2020 Pero. All rights reserved.
//

import Foundation

struct Time {
    var seconds = 0
    private var minutes: Int = 0
    
    var asString: String {
        return String(format: "%d:%02d", minutes, seconds)
    }
}
