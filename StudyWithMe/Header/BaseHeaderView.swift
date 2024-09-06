//
//  BaseHeaderView.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import Foundation
import UIKit

enum BaseHeaderType {
    case basic
    case rightButton
    case bothButton
    case search
}

class BaseHeaderView: UIView {
    var type: BaseHeaderType {
        didSet {
            
        }
    }
    
    var actionLeft: () -> Void?
    var actionRight: () -> Void?
    
    func setupUI() {
        self.addSubview(mainStackView)
        bodyView.addSubview(titleLabel)
        mainStackView.addArrangedSubview(leftButton)
        mainStackView.addArrangedSubview(bodyView)
        mainStackView.addArrangedSubview(rightButton)
        
        leftButton.frame = .init(x: 0, y: 0, width: 40, height: 40)
        rightButton.frame = .init(x: 0, y: 0, width: 40, height: 40)
        
        let widthBodyView: CGFloat = Constants.screenWidth - 96
        bodyView.frame = .init(x: 0, y: 0, width: widthBodyView, height: 40)
        
//        titleLabel.frame = .init(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
    }
    
    lazy var leftButton: UIButton = {
       let button = UIButton()
        button.setImage(.init(named: "ic_trash_32"), for: .normal)
        button.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
       let button = UIButton()
        button.setImage(.init(named: "ic_trash_32"), for: .normal)
        button.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        return button
    }()
    
    @objc func leftButtonAction() {
        actionLeft()
    }
    
    @objc func rightButtonAction() {
        actionRight()
    }
    
    lazy var bodyView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    init(type: BaseHeaderType) {
        self.type = type
        self.actionLeft = {}
        self.actionRight = {}
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
