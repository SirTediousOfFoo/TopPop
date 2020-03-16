//
//  TrackCell.swift
//  TopPop
//
//  Created by five on 15/03/2020.
//  Copyright © 2020 Pero. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    
    override func prepareForReuse() {
           super.prepareForReuse()
        positionLabel.text = nil
        titleLabel.text = nil
        artistLabel.text = nil
        durationLabel.text = nil
    }
}

//MARK: - Configure
extension TrackCell {
    func configure(with item: Track) {
        
        let minutes: Int = item.duration / 60
        let seconds: Int = item.duration - minutes * 60
        
        positionLabel.text = "\(item.position)"
        titleLabel.text = item.title
        artistLabel.text = "by: " + item.artist.name
        durationLabel.text = String(format: "%d:%02d", minutes, seconds)
    }
}
