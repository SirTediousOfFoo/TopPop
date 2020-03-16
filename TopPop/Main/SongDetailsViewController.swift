//
//  AlbumViewController.swift
//  TopPop
//
//  Created by five on 16/03/2020.
//  Copyright © 2020 Pero. All rights reserved.
//

import UIKit
import Kingfisher
import PromiseKit

final class SongDetailsViewController: UIViewController {

    //MARK: - Properties
    
    var track: Track? = nil
    private var tracklist: [Track] = []
    
    //MARK: - Outlets
    
    @IBOutlet private weak var albumArt: UIImageView!
    @IBOutlet private weak var songTitleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var albumLabel: UILabel!
    @IBOutlet private weak var tracklistLabel: UILabel!
    
    //MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        getData()
    }
    
    private func initialSetup() {
        songTitleLabel.text = track!.title
        albumLabel.text = track!.album.title
        artistLabel.text = track!.artist.name
    }
    
    private func getData(){
        let albumArtURL = URL(string: track!.album.coverMedium)
        let tracklistURL = track!.album.tracklist
        
        albumArt.kf.setImage(with: albumArtURL)
        print(tracklistURL)
        
        firstly{
            APIManager.request(
                Tracklist.self,
                path: tracklistURL,
                keyPath: "data")
        }.done{ [weak self] tracklist in
            self?.setTracklist(with: tracklist)
        }.catch{ error in
            print(error.localizedDescription)
        }
    }
    
    private func setTracklist(with tracklist: Tracklist) {
        var trackString: [String] = []
        for track in tracklist{
            trackString.append(track.title)
        }
        
        if trackString.count > 1 {
            tracklistLabel.text = "Album tracklist: " + trackString.joined(separator: ", ")
        }
        else {
            tracklistLabel.text = "This album is a single"
        }
    }
}
