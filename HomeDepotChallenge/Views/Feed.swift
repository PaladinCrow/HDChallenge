//
//  Feed.swift
//  HomeDepotChallenge
//
//  Created by John Stanford on 2/5/21.
//
// swiftlint:disable identifier_name

import Foundation

struct FeedWrapper: Decodable {
    let feed: Feed?
}

struct Feed: Decodable {
    let title: String?
    let id: String?
    let author: Author?
    let links: [Link]?
    let copyright: String?
    let country: String?
    let icon: String?
    let updated: String?
    var results: [Track]?
}

struct Author: Decodable {
    let name: String?
    let url: String?
}

struct Link: Decodable {
    enum CodingKeys: String, CodingKey {
        case primary = "self"
        case alternate
    }
    let primary: String?
    let alternate: String?
}

struct Track: Decodable {
    let artistName: String?
    let id: String?
    let releaseDate: String?
    let name: String?
    let kind: String?
    let copyright: String?
    let artistId: String?
    let contentAdvisoryRating: String?
    let artistUrl: String?
    // swiftlint:disable:next unused_closure_parameter
    var artworkUrl100: String? {didSet {ImageStore.shared.getImage(artworkUrl100 ?? "", completion: {img in})}}
    let genres: [Genre]?
    let url: String?
    var dateFromString: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: self.releaseDate ?? "") ?? Date()
        print(date)
        return date
    }
}

struct Genre: Decodable {
    let genreId: String?
    let name: String?
    let url: String?
}
