//
//  NSString+Extensions.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import Foundation
import UIKit

extension NSString {
    
    class func width(for text: String?, with font: UIFont?) -> CGFloat {
            guard let text = text,
                  let font = font else {
                return 0
            }
            let textSize = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
            return textSize.width
        }
    
    class func size(for text: String?, with font: UIFont?) -> CGSize {
            guard let text = text,
                  let font = font else {
                return CGSize.zero
            }
            let textSize = (text as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
            return textSize
        }
    
    class func height(for text: String, font: UIFont, maxWidth: CGFloat) -> CGFloat {
            guard !text.isEmpty else {
                return 0
            }
            
            let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
            let attributes: [NSAttributedString.Key: Any] = [.font: font]
            
            let boundingRect = text.boundingRect(
                with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude),
                options: options,
                attributes: attributes,
                context: nil
            )
            
            return ceil(boundingRect.height)
        }
}
