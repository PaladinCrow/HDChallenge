//
//  Configurable.swift
//  HomeDepotChallenge
//
//  Created by John Stanford on 2/6/21.
//

import Foundation
import UIKit

protocol ConfigurableCell where Self: UICollectionViewCell {
    func configure<T>(_ value: T)
}
