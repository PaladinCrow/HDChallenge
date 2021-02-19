//
//  ImageStore.swift
//  HomeDepotChallenge
//
//  Created by John Stanford on 2/6/21.
//

import Foundation
import UIKit

class ImageStore {
    private var imageCache = NSCache<NSString, UIImage>()
    static let shared = ImageStore()
    private init() {}
    func getImage(_ key: String, completion: @escaping (UIImage?) -> Void) {
        let nskey = NSString(string: key)
        if let cachedImage = imageCache.object(forKey: nskey) {
            // MARK: use cached Image in completion
            completion(cachedImage)
        } else {
            // MARK: download image and set object in ImageCache
            guard let url = URL(string: key) else {return}
            DispatchQueue.global(qos: .userInitiated).async {
                guard let data = try? Data(contentsOf: url) else {return}
                if let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: nskey)
                    // MARK: use new image in completion
                    completion(image)
                }
            }
        }
    }
}
