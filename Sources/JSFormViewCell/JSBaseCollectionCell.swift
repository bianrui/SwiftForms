//
//  FXBaseCollectionCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/24.
//

import UIKit

class JSBaseCollectionCell: JSBaseViewCell,
                            UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UICollectionViewDelegateFlowLayout
{

    
    lazy var collectionView :UICollectionView = {
        var _collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = .white;
        return _collectionView
    }()
    lazy var layout :UICollectionViewLeftAlignedLayout = {
        var _layout = UICollectionViewLeftAlignedLayout()
        _layout.minimumLineSpacing = 9
        _layout.minimumInteritemSpacing = 9
        _layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return _layout
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.items.count
    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return self.model.medias.count
//    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//    }

}
