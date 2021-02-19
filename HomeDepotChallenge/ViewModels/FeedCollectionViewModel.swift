//
//  FeedCollectionViewModel.swift
//  HomeDepotChallenge
//
//  Created by John Stanford on 2/6/21.
//

import Foundation
import UIKit

class FeedCollectionViewModel {
    private var model: Track?
    init(_ model: Track) {
        self.model = model
    }
    func getTrackName() -> String {
        return model?.name ?? ""
    }
    func getArtistName() -> String {
        return model?.artistName ?? ""
    }
    func getReleaseDate() -> String {
        return model?.releaseDate ?? ""
    }
    func getArtwork() -> String {
        return model?.artworkUrl100 ?? ""
    }
}
