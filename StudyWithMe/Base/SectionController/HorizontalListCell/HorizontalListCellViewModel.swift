//
//  HorizontalListCellViewModel.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import Foundation
import UIKit

class HorizontalListCellViewModel: NSObject {
    weak var collectionViewCell: UICollectionViewCell?
    
    private(set) weak var dataSource: UICollectionViewDataSource?
    private(set) weak var delegate: UICollectionViewDelegate?
    private(set) var flowLayout: UICollectionViewFlowLayout
    private(set) var registerHeaderClasses: [AnyClass] = []
    private(set) var registerFooterClasses: [AnyClass] = []
    var lastContentOffset: CGPoint = .zero
    
    init(
        dataSource: UICollectionViewDataSource?,
        delegate: UICollectionViewDelegate?,
        flowLayout: UICollectionViewFlowLayout? = nil,
        registerHeaderClasses: [AnyClass] = [],
        registerFooterClasses: [AnyClass] = []
    ) {
        self.dataSource = dataSource
        self.delegate = delegate
        if let flowLayout = flowLayout {
            self.flowLayout = flowLayout
        } else {
            let defaultFlowLayout = UICollectionViewFlowLayout()
            defaultFlowLayout.scrollDirection = .horizontal
            self.flowLayout = defaultFlowLayout
        }
        self.registerHeaderClasses = registerHeaderClasses
        self.registerFooterClasses = registerFooterClasses
    }
}

extension HorizontalListCellViewModel: CollectionViewCellViewModel {
    
    func getCellSize() -> CGSize {
        .zero
    }
    
    func cellClass() -> AnyClass {
        HorizontalListCell.self
    }
    
    func cellIdentifier() -> String? {
        NSStringFromClass(cellClass())
    }
    
}
