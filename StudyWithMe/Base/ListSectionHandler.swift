//
//  ListSectionHandler.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import Foundation
import UIKit

protocol ListSectionHandler: NSObjectProtocol {
    /// MUST be declared as WEAK property
    var mainCollectionView: ListSectionCollectionView? { get set }
    
    // CollectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint
    
    // ScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
}
