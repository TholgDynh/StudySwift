//
//  CollectionViewCellViewModel.swift
//  StudyWithMe
//
//  Created by Tholg on 06/09/2024.
//

import UIKit

protocol CollectionViewCellViewModel: AnyObject {
    var collectionViewCell: UICollectionViewCell? { get set }
    func getCellSize() -> CGSize
    func cellClass() -> AnyClass
    func cellIdentifier() -> String?
}

protocol CollectionViewCellWithViewModel: AnyObject {
    var viewModel: CollectionViewCellViewModel? { get set }
}
