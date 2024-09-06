//
//  BaseCollectionViewController.swift
//  StudyWithMe
//
//  Created by Tholg on 07/07/2024.
//

import Foundation
import UIKit

class ListSectionCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var ownerViewController: UIViewController?
    var dataProvider: ListSectionProvider? {
        didSet {
            oldValue?.mainCollectionView = nil
            dataProvider?.mainCollectionView = self
            dataProvider?.registerClasses()
        }
    }
    var handler: ListSectionHandler? {
        didSet {
            oldValue?.mainCollectionView = nil
            handler?.mainCollectionView = self
        }
    }
    
    init(
        frame: CGRect = .zero,
        collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout(),
        dataProvider: ListSectionProvider? = nil,
        handler: ListSectionHandler? = nil
    ) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.dataProvider = dataProvider
        self.handler = handler
        self.dataProvider?.mainCollectionView = self
        self.handler?.mainCollectionView = self
        self.dataProvider?.registerClasses()
        
        backgroundColor = .clear
        delegate = self
        dataSource = self
        contentInsetAdjustmentBehavior = .never
        alwaysBounceVertical = true
        
        // Register default classes for fallback state
        register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self)
        )
        register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: NSStringFromClass(UICollectionReusableView.self)
        )
        register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: NSStringFromClass(UICollectionReusableView.self)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Data provider
    
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        dataProvider?.numberOfSections(
            in: collectionView
        ) ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        dataProvider?.collectionView(
            collectionView,
            numberOfItemsInSection: section
        ) ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        dataProvider?.collectionView(
            collectionView,
            cellForItemAt: indexPath
        ) ?? collectionView.dequeueReusableCell(
            withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self),
            for: indexPath
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        dataProvider?.collectionView(
            collectionView,
            layout: collectionViewLayout,
            sizeForItemAt: indexPath
        ) ?? .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        dataProvider?.collectionView(
            collectionView,
            viewForSupplementaryElementOfKind: kind,
            at: indexPath
        ) ?? collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: NSStringFromClass(UICollectionReusableView.self),
            for: indexPath
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        dataProvider?.collectionView(
            collectionView,
            layout: collectionViewLayout,
            referenceSizeForHeaderInSection: section
        ) ?? .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        dataProvider?.collectionView(
            collectionView,
            layout: collectionViewLayout,
            referenceSizeForFooterInSection: section
        ) ?? .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        dataProvider?.collectionView(
            collectionView,
            layout: collectionViewLayout,
            insetForSectionAt: section
        ) ?? .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        dataProvider?.collectionView(
            collectionView,
            layout: collectionViewLayout,
            minimumLineSpacingForSectionAt: section
        ) ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        dataProvider?.collectionView(
            collectionView,
            layout: collectionViewLayout,
            minimumInteritemSpacingForSectionAt: section
        ) ?? 0
    }
    
    // MARK: - Handler
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        handler?.collectionView(
            collectionView,
            didSelectItemAt: indexPath
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        handler?.collectionView(
            collectionView,
            willDisplay: cell,
            forItemAt: indexPath
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        handler?.collectionView(
            collectionView,
            didEndDisplaying: cell,
            forItemAt: indexPath
        )
    }
    
    func scrollViewDidScroll(
        _ scrollView: UIScrollView
    ) {
        handler?.scrollViewDidScroll(
            scrollView
        )
    }
    
    func scrollViewWillBeginDragging(
        _ scrollView: UIScrollView
    ) {
        handler?.scrollViewWillBeginDragging(
            scrollView
        )
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        handler?.scrollViewWillEndDragging(
            scrollView,
            withVelocity: velocity,
            targetContentOffset: targetContentOffset
        )
    }
    
    func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        handler?.scrollViewDidEndDragging(
            scrollView,
            willDecelerate: decelerate
        )
    }
    
    func scrollViewDidEndDecelerating(
        _ scrollView: UIScrollView
    ) {
        handler?.scrollViewDidEndDecelerating(
            scrollView
        )
    }
    
    func scrollViewDidEndScrollingAnimation(
        _ scrollView: UIScrollView
    ) {
        handler?.scrollViewDidEndScrollingAnimation(
            scrollView
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint
    ) -> CGPoint {
        handler?.collectionView(
            collectionView,
            targetContentOffsetForProposedContentOffset: proposedContentOffset
        ) ?? proposedContentOffset
    }
    
}
