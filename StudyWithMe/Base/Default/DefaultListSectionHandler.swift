//
//  DefaultListSectionHandler.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import UIKit

class DefaultListSectionHandler: NSObject, ListSectionHandler {
    
    weak var mainCollectionView: ListSectionCollectionView?
    
    func sectionController(
        section: Int,
        collectionView: UICollectionView
    ) -> SectionController? {
        guard let dataProvider = mainCollectionView?.dataProvider as? DefaultListSectionProvider else {
            return nil
        }
        return dataProvider.sectionController(
            section: section,
            collectionView: collectionView
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        sectionController(
            section: indexPath.section,
            collectionView: collectionView
        )?.didSelectItemAt(
            indexPath: indexPath,
            in: collectionView
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        sectionController(
            section: indexPath.section,
            collectionView: collectionView
        )?.willDisplayCell(
            cell,
            at: indexPath,
            in: collectionView
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        sectionController(
            section: indexPath.section,
            collectionView: collectionView
        )?.didEndDisplaying(
            cell,
            at: indexPath,
            in: collectionView
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint
    ) -> CGPoint {
        proposedContentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {}
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {}
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {}
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {}
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {}
}
