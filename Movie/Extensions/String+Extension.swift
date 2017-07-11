//
//  String+Extension.swift
//  Movie
//
//  Created by Ali Can Batur on 07/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation

extension String {

    /// Encode to prepare url
    func encode() -> String {
        guard let encoded = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return "" }
        return encoded
    }
    
}
