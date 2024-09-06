//
//  DefaultListSectionProvider.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import UIKit

class DefaultListSectionProvider: NSObject, ListSectionProvider {
    
    weak var mainCollectionView: ListSectionCollectionView?
    
    var sectionControllers: [SectionController] = []
    
    func registerClasses() {}
    
    func loadData() {}
    
    func sectionController(
        section: Int,
        collectionView: UICollectionView
    ) -> SectionController? {
        collectionView === mainCollectionView ? sectionControllers[section] : sectionControllers.first {
            $0.sectionId == collectionView.accessibilityIdentifier
        }
    }
    
    func sectionController(
        withId sectionId: String
    ) -> SectionController? {
        sectionControllers.first {
            $0.sectionId == sectionId
        }
    }
    
    func sectionId(
        sectionIndex: Int
    ) -> String? {
        sectionControllers[sectionIndex].sectionId
    }
    
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        (collectionView == mainCollectionView) ? sectionControllers.count : 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let sectionController = sectionController(section: section, collectionView: collectionView),
              sectionController.shouldShowThisSection() else {
            return 0
        }
        return sectionController.numberOfItemsInSection(for: collectionView)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        sectionController(
            section: indexPath.section,
            collectionView: collectionView
        )?.cellForItemAt(
            indexPath: indexPath,
            in: collectionView
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
        sectionController(
            section: indexPath.section,
            collectionView: collectionView
        )?.cellSizeAt(
            indexPath: indexPath,
            in: collectionView
        ) ?? .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        sectionController(
            section: indexPath.section,
            collectionView: collectionView
        )?.viewForSupplementaryElement(
            ofKind: kind,
            at: indexPath,
            in: collectionView
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
        sectionController(
            section: section,
            collectionView: collectionView
        )?.sizeForHeader(
            in: collectionView
        ) ?? .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        sectionController(
            section: section,
            collectionView: collectionView
        )?.sizeForFooter(
            in: collectionView
        ) ?? .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        sectionController(
            section: section,
            collectionView: collectionView
        )?.insetForSection(
            in: collectionView
        ) ?? .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        sectionController(
            section: section,
            collectionView: collectionView
        )?.minimumLineSpacingForSection(
            in: collectionView
        ) ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        sectionController(
            section: section,
            collectionView: collectionView
        )?.minimumInteritemSpacingForSection(
            in: collectionView
        ) ?? 0
    }
    
    // MARK: - Section Manipulations
    
    func replaceCurrentSections(
        with newSections: [SectionController]
    ) {
        self.sectionControllers = newSections
        self.mainCollectionView?.reloadData()
        self.mainCollectionView?.layoutIfNeeded()
    }
    
    func insertSection(
        section: SectionController,
        at index: Int,
        completion: ((Bool) -> Void)? = nil
    ) {
        mainCollectionView?.performBatchUpdates({ [weak self] in
            guard let self = self,
                  index >= 0,
                  index <= self.sectionControllers.count else {
                return
            }
            self.sectionControllers.insert(section, at: index)
            self.mainCollectionView?.insertSections([index])
        }, completion: completion)
    }
    
    func deleteSection(
        with sectionId: String,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard let sectionIndex = sectionControllers.firstIndex(
            where: {
                $0.sectionId == sectionId
            }
        ) else {
            return
        }
        deleteSection(at: sectionIndex, completion: completion)
    }
    
    func deleteSection(
        at index: Int,
        completion: ((Bool) -> Void)? = nil
    ) {
        mainCollectionView?.performBatchUpdates({ [weak self] in
            guard let self = self,
                  index >= 0,
                  index < self.sectionControllers.count else {
                return
            }
            self.sectionControllers.remove(at: index)
            self.mainCollectionView?.deleteSections([index])
        }, completion: completion)
    }

    func updateSections(
        _ updatedSections: [SectionController],
        completion: ((Bool) -> Void)? = nil
    ) {
        var updatedSectionIndexes = IndexSet()
        var sectionsAfterUpdates = self.sectionControllers
        
        for i in 0..<sectionsAfterUpdates.count {
            if let toBeUpdated = updatedSections.first(where: {
                $0.sectionId == sectionsAfterUpdates[i].sectionId
            }) {
                sectionsAfterUpdates[i] = toBeUpdated
                updatedSectionIndexes.insert(i)
            }
        }
        mainCollectionView?.performBatchUpdates({ [weak self] in
            guard let self = self else {
                return
            }
            self.sectionControllers = sectionsAfterUpdates
            self.mainCollectionView?.reloadSections(updatedSectionIndexes)
        }, completion: completion)
    }
    
    // MARK: - Section's Viewmodels Manipulations

    func appendViewModels(
        _ viewModels: [CollectionViewCellViewModel],
        toSectionWithId sectionId: String,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard !viewModels.isEmpty,
              let sectionIndex = sectionControllers.firstIndex(where: {
                  $0.sectionId == sectionId
              }) else {
            return
        }
        let sectionController = sectionControllers[sectionIndex]
        let collectionView: UICollectionView? = (sectionController as? HorizontalSectionController)?.innerCollectionView ?? mainCollectionView
        
        collectionView?.performBatchUpdates({
            let indexPaths = sectionController.appendViewModels(viewModels).map {
                IndexPath(row: $0, section: sectionIndex)
            }
            if !indexPaths.isEmpty {
                collectionView?.insertItems(at: indexPaths)
            }
        }, completion: completion)
    }
    
    func insertViewModels(
        _ viewModels: [CollectionViewCellViewModel],
        at index: Int,
        inSectionWithId sectionId: String,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard !viewModels.isEmpty,
              let sectionIndex = sectionControllers.firstIndex(where: {
                  $0.sectionId == sectionId
              }) else {
            return
        }
        let sectionController = sectionControllers[sectionIndex]
        let isHorizontalSection: Bool = sectionController is HorizontalSectionController
        let collectionView: UICollectionView? = isHorizontalSection ? (sectionController as? HorizontalSectionController)?.innerCollectionView : mainCollectionView
        
        collectionView?.performBatchUpdates({
            let insertIndexPaths = sectionController.insertViewModels(viewModels, at: index).map {
                IndexPath(row: $0, section: isHorizontalSection ? 0 : sectionIndex)
            }
            collectionView?.insertItems(at: insertIndexPaths)
        }, completion: completion)
    }
    
    func deleteViewModels(
        indexes: [Int],
        ofSectionWithId sectionId: String,
        shouldRemoveSectionOnEmpty: Bool = false,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard !indexes.isEmpty,
              let sectionIndex = sectionControllers.firstIndex(where: {
                  $0.sectionId == sectionId
              }) else {
            return
        }
        let sectionController = sectionControllers[sectionIndex]
        let isHorizontalSection: Bool = sectionController is HorizontalSectionController
        let collectionView: UICollectionView? = isHorizontalSection ? (sectionController as? HorizontalSectionController)?.innerCollectionView : mainCollectionView
        
        collectionView?.performBatchUpdates({ [weak self] in
            let deleteIndexPaths = sectionController.deleteViewModels(indexes: indexes).map {
                IndexPath(row: $0, section: isHorizontalSection ? 0 : sectionIndex)
            }
            if sectionController.viewModels.isEmpty && shouldRemoveSectionOnEmpty {
                self?.sectionControllers.remove(at: sectionIndex)
                self?.mainCollectionView?.deleteSections([sectionIndex])
            } else {
                collectionView?.deleteItems(at: deleteIndexPaths)
            }
        }, completion: completion)
    }
    
}
