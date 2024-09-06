//
//  HorizontalSectionController.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import UIKit

class HorizontalSectionController: SectionController {
    
    private var listCellViewModel: HorizontalListCellViewModel?
    private var listCellReuseId: String
    private(set) weak var innerCollectionView: UICollectionView?
    private(set) var maxHeight: CGFloat = 0
    
    init(
        sectionId: String,
        viewModels: [CollectionViewCellViewModel] = [],
        mainCollectionView: ListSectionCollectionView? = nil,
        collectionViewFlowLayout: UICollectionViewFlowLayout? = nil
    ) {
        let dataSource: UICollectionViewDataSource? = mainCollectionView
        let delegate: UICollectionViewDelegate? = mainCollectionView
        let listCellViewModel = HorizontalListCellViewModel(
            dataSource: dataSource,
            delegate: delegate,
            flowLayout: collectionViewFlowLayout,
            registerHeaderClasses: Self.innerHeaderClasses(),
            registerFooterClasses: Self.innerFooterClasses()
        )
        self.listCellViewModel = listCellViewModel
        self.listCellReuseId = "\(listCellViewModel.cellIdentifier())_\(sectionId)"
        self.maxHeight = viewModels.map { $0.getCellSize().height }.max() ?? 0
        super.init(
            sectionId: sectionId,
            viewModels: viewModels,
            mainCollectionView: mainCollectionView
        )
    }
    
    // MARK: - Override Data source
    
    override func numberOfItemsInSection(for collectionView: UICollectionView) -> Int {
        isInnerCollectionView(collectionView) ? viewModels.count : 1
    }
    
    override func cellForItemAt(indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        if isInnerCollectionView(collectionView) {
            return innerCellAt(indexPath: indexPath, in: collectionView)
        } else {
            collectionView.register(HorizontalListCell.self, forCellWithReuseIdentifier: listCellReuseId)
            guard let listCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: listCellReuseId,
                for: indexPath
            ) as? HorizontalListCell else {
                return collectionView.dequeueReusableCell(
                    withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self),
                    for: indexPath
                )
            }
            listCell.viewModel = listCellViewModel
            listCell.collectionView?.accessibilityIdentifier = sectionId
            self.innerCollectionView = listCell.collectionView
            return listCell
        }
    }
    
    var customInnerCellSize: CGSize?
    override func cellSizeAt(
        indexPath: IndexPath,
        in collectionView: UICollectionView
    ) -> CGSize {
        if isInnerCollectionView(collectionView) {
            return customInnerCellSize ?? super.cellSizeAt(indexPath: indexPath, in: collectionView)
        } else {
            return CGSize(width: Constants.screenWidth, height: maxHeight)
        }
    }
    
    func isInnerCollectionView(_ collectionView: UICollectionView) -> Bool {
        collectionView === innerCollectionView
    }
    
    var innerSectionInsets: UIEdgeInsets?
    override func insetForSection(in collectionView: UICollectionView) -> UIEdgeInsets {
        isInnerCollectionView(collectionView) ? (innerSectionInsets ?? .zero) : (sectionInsets ?? .zero)
    }
    
    override func minimumLineSpacingForSection(in collectionView: UICollectionView) -> CGFloat {
        isInnerCollectionView(collectionView) ? super.minimumLineSpacingForSection(in: collectionView) : 0
    }
    
    override func minimumInteritemSpacingForSection(in collectionView: UICollectionView) -> CGFloat {
        isInnerCollectionView(collectionView) ? super.minimumInteritemSpacingForSection(in: collectionView) : 0
    }
    
    // MARK: - For Inner Collection View
    
    /// Override this function to return inner collection view cells
    func innerCellAt(
        indexPath: IndexPath,
        in collectionView: UICollectionView
    ) -> UICollectionViewCell {
        super.cellForItemAt(indexPath: indexPath, in: collectionView)
    }
    
    /// Override this function to register header suplementary views
    class func innerHeaderClasses() -> [AnyClass] {
        []
    }
    
    /// Override this function to register footer suplementary views
    class func innerFooterClasses() -> [AnyClass] {
        []
    }
    
    func innerCollectionViewDidScroll(_ scrollView: UIScrollView) {
    }
    
    func innerCollectionViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    func innerCollectionViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
    }
    
}
