//
//  HeaderHorizontalSectionController.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import Foundation
import UIKit

class HeaderHorizontalSectionController: HorizontalSectionController {
    
    private(set) var headerConfig: HeaderConfiguration?
    
    init(
        headerConfig: HeaderConfiguration?,
        sectionId: String,
        viewModels: [CollectionViewCellViewModel],
        mainCollectionView: ListSectionCollectionView? = nil,
        collectionViewFlowLayout: UICollectionViewFlowLayout? = nil
    ) {
        self.headerConfig = headerConfig
        super.init(
            sectionId: sectionId,
            viewModels: viewModels,
            mainCollectionView: mainCollectionView,
            collectionViewFlowLayout: collectionViewFlowLayout
        )
    }
    
    override func viewForSupplementaryElement(ofKind: String, at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionReusableView {
        guard !isInnerCollectionView(collectionView),
              let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: NSStringFromClass(HeaderResuableView.self),
                for: indexPath
              ) as? HeaderResuableView else {
            return collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: NSStringFromClass(UICollectionReusableView.self),
                for: indexPath
            )
        }
        header.headerConfig = headerConfig
        return header
    }
    
    override func sizeForHeader(in collectionView: UICollectionView) -> CGSize {
        isInnerCollectionView(collectionView) ? .zero : (headerConfig?.getHeaderSize() ?? .zero)
    }
    
    override class func innerHeaderClasses() -> [AnyClass] {
        [
            HeaderResuableView.self,
            UICollectionReusableView.self
        ]
    }
}
