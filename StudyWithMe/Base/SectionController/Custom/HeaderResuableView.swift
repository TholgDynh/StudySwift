//
//  HeaderResuableView.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import Foundation
import UIKit

class HeaderResuableView: UICollectionReusableView {
    
    var headerConfig: HeaderConfiguration? {
        didSet {
            guard let headerConfig = headerConfig else {
                return
            }
            
            titleLabel.text = headerConfig.title
            titleLabel.font = headerConfig.font
            titleLabel.textColor = headerConfig.textColor
            titleLabel.textAlignment = headerConfig.textALignment
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let headerConfig = headerConfig else {
            return
        }
        titleLabel.frame = bounds.inset(by: headerConfig.edgeInsets)
    }
    
}
