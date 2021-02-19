//
//  Extensions.swift
//  HomeDepotChallenge
//
//  Created by John Stanford on 2/10/21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
