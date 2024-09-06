//
//  SectionController.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import UIKit

class SectionController: NSObject {
    
    private(set) var sectionId: String
    // Use ONLY viewController or mainCollectionView as a reference to the owner object
    private(set) weak var mainCollectionView: ListSectionCollectionView?
    var viewModels: [CollectionViewCellViewModel]
    
    init(
        sectionId: String,
        viewModels: [CollectionViewCellViewModel] = [],
        mainCollectionView: ListSectionCollectionView? = nil
    ) {
        self.sectionId = sectionId
        self.viewModels = viewModels
        self.mainCollectionView = mainCollectionView
        super.init()
    }
    
    // MARK: - Data Source
    
    func shouldShowThisSection() -> Bool {
        true
    }

    func numberOfItemsInSection(for collectionView: UICollectionView) -> Int {
        viewModels.count
    }
    
    func cellForItemAt(
        indexPath: IndexPath,
        in collectionView: UICollectionView
    ) -> UICollectionViewCell {
        let viewModel: CollectionViewCellViewModel? = viewModels[indexPath.row]
        let cellClass: AnyClass = viewModel?.cellClass() ?? UICollectionViewCell.self
        let cellId: String = viewModel?.cellIdentifier() ?? NSStringFromClass(cellClass)
        collectionView.register(cellClass, forCellWithReuseIdentifier: cellId)
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellId,
            for: indexPath
        ) as? (UICollectionViewCell & CollectionViewCellWithViewModel) else {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self),
                for: indexPath
            )
        }
        cell.viewModel = viewModel
        return cell
    }
    
    func cellSizeAt(
        indexPath: IndexPath,
        in collectionView: UICollectionView
    ) -> CGSize {
        viewModels[indexPath.row].getCellSize() 
    }
    
    func viewForSupplementaryElement(
        ofKind kind: String,
        at indexPath: IndexPath,
        in collectionView: UICollectionView
    ) -> UICollectionReusableView {
        collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: NSStringFromClass(UICollectionReusableView.self),
            for: indexPath
        )
    }
    
    var minimumLineSpacing: CGFloat?
    func minimumLineSpacingForSection(in collectionView: UICollectionView) -> CGFloat {
        minimumLineSpacing ?? 0
    }
    
    var minimumInteritemSpacing: CGFloat?
    func minimumInteritemSpacingForSection(in collectionView: UICollectionView) -> CGFloat {
        minimumInteritemSpacing ?? 0
    }
    
    var sectionInsets: UIEdgeInsets?
    func insetForSection(in collectionView: UICollectionView) -> UIEdgeInsets {
        sectionInsets ?? .zero
    }
    
    func sizeForHeader(in collectionView: UICollectionView) -> CGSize {
        .zero
    }
    
    func sizeForFooter(in collectionView: UICollectionView) -> CGSize {
        .zero
    }
    
    // MARK: - CLV Delegate
    
    /// Override this function in subclasses
    func didSelectItemAt(
        indexPath: IndexPath,
        in collectionView: UICollectionView
    ) {
    }
    
    /// Override this function in subclasses
    func willDisplayCell(
        _ cell: UICollectionViewCell,
        at indexPath: IndexPath,
        in collectionView: UICollectionView
    ) {
    }
    
    /// Override this function in subclasses
    func didEndDisplaying(
        _ cell: UICollectionViewCell,
        at indexPath: IndexPath,
        in collectionView: UICollectionView
    ) {
    }
    
    // MARK: - ViewModels Manipulation
    
    @discardableResult
    func appendViewModels(_ viewModels: [CollectionViewCellViewModel]) -> [Int] {
        insertViewModels(viewModels, at: self.viewModels.endIndex)
    }
    
    @discardableResult
    func insertViewModels(
        _ viewModels: [CollectionViewCellViewModel],
        at index: Int
    ) -> [Int] {
        let start = index
        let end = start + viewModels.count - 1
        self.viewModels.insert(contentsOf: viewModels, at: index)
        return (start...end).map { $0 }
    }
    
    @discardableResult
    func deleteViewModels(indexes: [Int]) -> [Int] {
        self.viewModels = self.viewModels.enumerated().filter {
            !indexes.contains($0.offset)
        }.map { $0.element }
        return indexes
    }
    
}
