//
//  MainViewController.swift
//  HomeDepotChallenge
//
//  Created by John Stanford on 2/5/21.
//

import UIKit

class MainViewController: UIViewController {
    var viewModel: MainViewModel = MainViewModel()
    private var isGrid: Bool = false
    @IBOutlet weak var gridListLayoutButton: UIBarButtonItem!
    @IBOutlet weak var feedCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView.register(NewFeedCollectionViewCell.self, forCellWithReuseIdentifier: "newFeedCell")
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        setupClosure()
        updateCollection()
    }
    private func setupClosure() {
        viewModel.updateViewClosure = {
            DispatchQueue.main.async {
                self.feedCollectionView.reloadData()
            }
        }
    }
    private func updateCollection() {
        viewModel.getData()
    }
    @IBAction func refreshButton(_ sender: Any) {
        updateCollection()
    }
    @IBAction func gridListLayoutButtonAction(_ sender: Any) {
        guard let layout = feedCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
        if isGrid {
            isGrid = false
            gridListLayoutButton.title = "Grid"
            layout.scrollDirection = .vertical
        } else {
            isGrid = true
            gridListLayoutButton.title = "List"
            layout.scrollDirection = .horizontal
        }
        DispatchQueue.main.async {
            self.feedCollectionView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTrackListCount()
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "newFeedCell",
                                                                for: indexPath) as? ConfigurableCell else {
            return UICollectionViewCell()
        }
        cell.configure(viewModel.getTrackViewModel(at: indexPath.row))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !isGrid {
            return CGSize(width: feedCollectionView.bounds.width, height: 100.0)
        }
        return CGSize(width: (feedCollectionView.bounds.width / 2) - 10, height: 100.0)
    }
}
