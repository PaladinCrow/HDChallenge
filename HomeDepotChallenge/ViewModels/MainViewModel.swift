//
//  MainViewModel.swift
//  HomeDepotChallenge
//
//  Created by John Stanford on 2/5/21.
//

import Foundation

class MainViewModel {
    private var model: Feed?
    init(_ model: Feed) {
        self.model = model
    }
    init() {}
    var updateViewClosure: (() -> Void)?
    func getData() {
        DataRequest.shared.getData(LinkStrings.root.rawValue,
                                   type: FeedWrapper.self,
                                   completion: { [weak self] (result) in
            do {
                let modelWrapper: FeedWrapper = try result.get()
                self?.model = modelWrapper.feed
            } catch {
                print("Error getting the model from the result")
                return
            }
            self?.sortTrackList()
            self?.updateViewClosure?()
        })
    }
    private func sortTrackList() {
        let sorted = model?.results?.sorted(by: {$0.dateFromString.compare($1.dateFromString) == .orderedDescending})
        model?.results = sorted
    }
    func getTrackListCount() -> Int {
        if let list = model?.results {
            return list.count
        }
        return 0
    }
    // swiftlint:disable:next identifier_name
    func getTrackViewModel(at: Int) -> FeedCollectionViewModel? {
        guard let list = model?.results else {return nil}
        return FeedCollectionViewModel(list[at])
    }
}
