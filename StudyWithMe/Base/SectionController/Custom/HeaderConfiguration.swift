//
//  HeaderConfiguration.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import Foundation
import UIKit
 
class HeaderConfiguration: NSObject {
    
    var title: String
    var font: UIFont
    var textColor: UIColor
    var textALignment: NSTextAlignment
    var edgeInsets: UIEdgeInsets
    
    init(
        title: String,
        font: UIFont,
        textColor: UIColor = .black,
        textALignment: NSTextAlignment = .left,
        edgeInsets: UIEdgeInsets = .zero
    ) {
        self.title = title
        self.font = font
        self.textColor = textColor
        self.textALignment = textALignment
        self.edgeInsets = edgeInsets
    }
    
    func getHeaderSize() -> CGSize {
        var height: CGFloat = 0
        height += edgeInsets.top
        height += NSString.height(for: title, font: font, maxWidth: Constants.screenWidth - edgeInsets.left - edgeInsets.right)
        height += edgeInsets.bottom
        return CGSize(width: Constants.screenWidth, height: height)
    }
    
}
