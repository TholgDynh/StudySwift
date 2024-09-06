//
//  HorizontalListCell.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import Foundation
import UIKit

class HorizontalListCell: UICollectionViewCell, CollectionViewCellWithViewModel {
    
    var viewModel: CollectionViewCellViewModel? {
        didSet {
            guard let viewModel = self.viewModel as? HorizontalListCellViewModel else {
                return
            }
            viewModel.collectionViewCell = self
            
            if collectionView == nil {
                collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: viewModel.flowLayout)
                collectionView?.backgroundColor = .clear
                collectionView?.showsVerticalScrollIndicator = false
                collectionView?.showsHorizontalScrollIndicator = false
                // Register default classes for fallback state
                collectionView?.register(
                    UICollectionViewCell.self,
                    forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self)
                )
                collectionView?.register(
                    UICollectionReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: NSStringFromClass(UICollectionReusableView.self)
                )
                collectionView?.register(
                    UICollectionReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: NSStringFromClass(UICollectionReusableView.self)
                )
                // Register additional classes
                viewModel.registerHeaderClasses.forEach {
                    collectionView?.register(
                        $0,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: NSStringFromClass($0)
                    )
                }
                viewModel.registerFooterClasses.forEach {
                    collectionView?.register(
                        $0,
                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                        withReuseIdentifier: NSStringFromClass($0)
                    )
                }
                contentView.addSubview(collectionView!)
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.collectionView?.dataSource = viewModel.dataSource
                self.collectionView?.delegate = viewModel.delegate
                self.collectionView?.reloadData()
                self.collectionView?.contentOffset = viewModel.lastContentOffset
                self.clvOffsetObservation = self.collectionView?.observe(\.contentOffset, options: .new) { _, change in
                    (self.viewModel as? HorizontalListCellViewModel)?.lastContentOffset = change.newValue ?? .zero
                }
            }
        }
    }
    
    private var clvOffsetObservation: NSKeyValueObservation?

    var collectionView: UICollectionView?
    
    // MARK: - Init
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bounds = contentView.bounds
        collectionView?.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        clvOffsetObservation?.invalidate()
        clvOffsetObservation = nil
    }
    
}
