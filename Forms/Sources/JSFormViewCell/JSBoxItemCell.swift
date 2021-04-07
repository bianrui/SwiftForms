//
//  JSBoxItemCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/25.
//

import UIKit

class JSBoxItemCell: UICollectionViewCell {
    
    let kItemHeight = 40
    lazy var boxButton :UIButton = {
        var _boxButton = UIButton(type: .custom)
        _boxButton.titleLabel!.font = UIFont.systemFont(ofSize: 15.0)
        _boxButton.isUserInteractionEnabled = false;
        _boxButton.setTitleColor(UIColor(red: 123.0/255.0, green: 131.0/255.0, blue: 135.0/255.0, alpha: 1.0), for: .normal)
        return _boxButton
    }()
    var _boxItem: JSBoxItem = JSBoxItem()
    var boxItem : JSBoxItem {
        set{
            let _boxItem = newValue
            self.boxButton.isSelected = _boxItem.selected;
            self.boxButton.setImage(UIImage(named: _boxItem.icon), for: .normal)
            self.boxButton.setImage(UIImage(named: _boxItem.icon+"-sel"), for: .selected)
            self.boxButton.setTitle(_boxItem.name, for: .normal)
        }
        get{
            return _boxItem
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.boxButton.frame = self.bounds
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.boxButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
