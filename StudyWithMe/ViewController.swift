//
//  ViewController.swift
//  StudyWithMe
//
//  Created by Tholg on 07/07/2024.
//

import UIKit

class ViewController: UIViewController {

    var mainView = UIView()
    var mainScrollView = UIScrollView()
    var containView = UIView()
    
    var mainCollectionView: ListSectionCollectionView = {
        let collectionView = ListSectionCollectionView(dataProvider: TestDataProvider(),
                                                       handler: TestHandler())
        return collectionView
    }()
    
    func setupUI() {
        mainView.frame = view.bounds
        mainScrollView.frame = mainView.bounds
        containView.frame = mainScrollView.frame
        mainCollectionView.frame = containView.bounds
    }
    
    func setupChildView() {
        view.addSubview(mainView)
        mainView.addSubview(mainScrollView)
        mainScrollView.addSubview(containView)
        containView.addSubview(mainCollectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildView()
        setupUI()
        mainCollectionView.dataProvider?.loadData()
        // Do any additional setup after loading the view.
    }

}


class TestDataProvider: DefaultListSectionProvider {
    override func loadData() {
        let vms = [TestCellViewModel(),
                   TestCellViewModel(),
                   TestCellViewModel(),
                   TestCellViewModel(),
                   TestCellViewModel(),
                   TestCellViewModel(),
                   TestCellViewModel(),
                   TestCellViewModel()]
        
        sectionControllers = [SectionController(sectionId: "Test.1.2", viewModels: vms, mainCollectionView: mainCollectionView)]
        mainCollectionView?.reloadData()
    }
}

class TestHandler: DefaultListSectionHandler {
    
}

class TestCellViewModel: NSObject, CollectionViewCellViewModel {
    var collectionViewCell: UICollectionViewCell?
    
    func getCellSize() -> CGSize {
        .init(width: Constants.screenWidth, height: 100)
    }
    
    func cellClass() -> AnyClass {
        TestCell.self
    }
    
    func cellIdentifier() -> String? {
        nil
    }
    
}

class TestCell: UICollectionViewCell, CollectionViewCellWithViewModel {
    var viewModel: CollectionViewCellViewModel?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Thong thong thong thong"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.frame = .init(x: 10, y: 10, width: 200, height: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
