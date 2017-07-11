//
//  UITableViewCell+Extension.swift
//  Movie
//
//  Created by Ali Can Batur on 06/07/2017.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {

    /// Use this to get reuseIdentifier for this tableViewCell
    class func cellReuseIdentifier() -> String {
        return String(describing: self)
    }
    
    /// Set seperator width equal to table view.
    func setFullWidthOfSeperator() {
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
    }

}
