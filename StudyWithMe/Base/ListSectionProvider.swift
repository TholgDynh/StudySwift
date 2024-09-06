//
//  ListSectionProvider.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import UIKit

protocol ListSectionProvider: NSObjectProtocol {
    /// MUST be declared as WEAK property
    var mainCollectionView: ListSectionCollectionView? { get set }
    
    // For loading list
    func loadData()
    func loadMoreData()
    func reloadData()
    
    // CollectionView
    func registerClasses()
    func numberOfSections(in collectionView: UICollectionView) -> Int
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
}

extension ListSectionProvider {
    func loadData() { }
    func loadMoreData() { }
    func reloadData() { }
}
