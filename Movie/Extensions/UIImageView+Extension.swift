//
//  UIImageView+Extension.swift
//  Movie
//
//  Created by Ali Can Batur on 07/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import AlamofireImage

extension UIImageView {

    /// Download image with specified URL. AlamofireImage lets us to control all image operations, download, cache etc.
    func imageFromURL(url: URL?) {
        let placeholderImage = Constants.Image.noPhoto
        
        guard let url = url else {
            self.image = placeholderImage
            return
        }
        
        self.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }

}
