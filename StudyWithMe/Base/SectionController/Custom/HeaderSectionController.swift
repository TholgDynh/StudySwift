//
//  HeaderSectionController.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import Foundation
import UIKit
class HeaderSectionController: SectionController {
    
    private(set) var headerConfig: HeaderConfiguration?
    
    init(
        headerConfig: HeaderConfiguration?,
        sectionId: String,
        viewModels: [CollectionViewCellViewModel],
        mainCollectionView: ListSectionCollectionView? = nil
    ) {
        self.headerConfig = headerConfig
        super.init(
            sectionId: sectionId,
            viewModels: viewModels,
            mainCollectionView: mainCollectionView
        )
    }
    
    override func viewForSupplementaryElement(ofKind: String, at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: NSStringFromClass(HeaderResuableView.self), for: indexPath
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
        headerConfig?.getHeaderSize() ?? .zero
    }
    
}
