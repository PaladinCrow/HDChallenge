//
//  HomeDepotChallengeTests.swift
//  HomeDepotChallengeTests
//
//  Created by John Stanford on 2/5/21.
//
// swiftlint:disable all

import XCTest
@testable import HomeDepotChallenge

class HomeDepotChallengeTests: XCTestCase {
    
    var sut: MainViewModel?
    var feedViewModel: FeedCollectionViewModel?
    let testModel: Feed = Feed(title: "testTitle",
                               id: "testID",
                               author: Author(name: "testAuthorName",
                                              url: "testAuthorURL"),
                               links: [Link(primary: "primaryTestLink",
                                            alternate: "alternateTestLink")],
                               copyright: "testCopyright",
                               country: "testCountry",
                               icon: "testIcon",
                               updated: "testUpdated",
                               results: [Track(artistName: "testTrackArtistName",
                                               id: "testTrackID",
                                               releaseDate: "testTrackReleaseDate",
                                               name: "testTrackName",
                                               kind: "testTrackKind",
                                               copyright: "testTrackCopyright",
                                               artistId: "testTrackArtistID",
                                               contentAdvisoryRating: "testTrackContentAdvisory",
                                               artistUrl: "testTrackArtistURL",
                                               artworkUrl100: "testTrackArtwork",
                                               genres: [Genre(genreId: "testGenreID",
                                                              name: "testGenreName",
                                                              url: "testGenreURL")],
                                               url: "testTrackURL")])

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = MainViewModel(testModel)
    }
    
    func testGetData() {
        let promise = expectation(description: "fetchedVM should not have an empty TrackList")
        var fetchedVM: MainViewModel?
        sut?.updateViewClosure = {
            fetchedVM = self.sut
            promise.fulfill()
        }
        sut?.getData()
        wait(for: [promise], timeout: 10)
        XCTAssert(fetchedVM?.getTrackListCount() != 1 && fetchedVM?.getTrackListCount() != 0)
    }

    func testHasData() {
        XCTAssertNotNil(sut)
    }
    
    func testGetTrackCount() {
        let count = sut?.getTrackListCount()
        XCTAssertEqual(count, 1)
    }
    
    func testGetTrackViewModel() {
        feedViewModel = sut?.getTrackViewModel(at: 0)
        XCTAssertNotNil(feedViewModel)
    }
    
    func testGetTrackName() {
        feedViewModel = sut?.getTrackViewModel(at: 0)
        let name = feedViewModel?.getTrackName()
        XCTAssert(name == "testTrackName")
    }
    
    func testGetArtistName() {
        feedViewModel = sut?.getTrackViewModel(at: 0)
        let name = feedViewModel?.getArtistName()
        XCTAssert(name == "testTrackArtistName")
    }
    
    func testGetReleaseDate() {
        feedViewModel = sut?.getTrackViewModel(at: 0)
        let dateString = feedViewModel?.getReleaseDate()
        XCTAssert(dateString == "testTrackReleaseDate")
    }
    
    func testGetArtwork() {
        feedViewModel = sut?.getTrackViewModel(at: 0)
        let artworkString = feedViewModel?.getArtwork()
        XCTAssert(artworkString == "testTrackArtwork")
    }
}
