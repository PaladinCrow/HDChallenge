//
//  NewFeedCollectionViewCell.swift
//  HomeDepotChallenge
//
//  Created by John Stanford on 2/10/21.
//
// swiftlint:disable line_length

import UIKit

class NewFeedCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    var viewModel: FeedCollectionViewModel? {
        didSet {
            trackNameLabel.text = viewModel?.getTrackName()
            artistNameLabel.text = viewModel?.getArtistName()
            releaseDateLabel.text = viewModel?.getReleaseDate()
            ImageStore.shared.getImage(viewModel?.getArtwork() ?? "") { [weak self] (img) in
                DispatchQueue.main.async {
                    self?.trackArtwork.image = img
                    self?.trackArtwork.layer.cornerRadius = ((self?.trackArtwork.bounds.height ?? 100) + (self?.trackArtwork.bounds.width ?? 100)) / 8
                }
            }
        }
    }
    let trackNameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Helvetica", size: 15)
        return label
    }()
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Helvetica", size: 12)
        return label
    }()
    let trackArtwork: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    func configure<T>(_ value: T) {
        contentView.addSubviews(trackNameLabel, artistNameLabel, releaseDateLabel, trackArtwork)
        setupAllConstraints()
        viewModel = value as? FeedCollectionViewModel
    }
    func setupAllConstraints () {
        func setupTrackArtworkConstraints() {
            trackArtwork.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                trackArtwork.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
                trackArtwork.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
                trackArtwork.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
                trackArtwork.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
            ])
        }
        func setupTrackNameLabelConstraints() {
            trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                trackNameLabel.leadingAnchor.constraint(equalTo: trackArtwork.trailingAnchor, constant: 10),
                trackNameLabel.topAnchor.constraint(equalTo: trackArtwork.topAnchor, constant: 10),
                trackNameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
                trackNameLabel.heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
            ])
        }
        func setupArtistNameLabelConstraints() {
            artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                artistNameLabel.leadingAnchor.constraint(equalTo: trackNameLabel.leadingAnchor),
                artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor),
                artistNameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
                artistNameLabel.heightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2)
            ])
        }
        func setupReleaseDateLabelConstraints() {
            releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                releaseDateLabel.leadingAnchor.constraint(equalTo: trackNameLabel.leadingAnchor),
                releaseDateLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor),
                releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
                releaseDateLabel.bottomAnchor.constraint(equalTo: trackArtwork.bottomAnchor)
            ])
        }
        setupTrackArtworkConstraints()
        setupTrackNameLabelConstraints()
        setupArtistNameLabelConstraints()
        setupReleaseDateLabelConstraints()
    }
}
