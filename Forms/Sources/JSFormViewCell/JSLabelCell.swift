//
//  JSLabelCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/24.
//

import UIKit

class JSLabelCell: JSBaseViewCell {
    lazy var label:UILabel = {
        var _label = UILabel();
        _label.font = self.textFont;
        _label.textColor = self.textClor;
        _label.textAlignment = .right;
        return _label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.label)
        self.label.snp.makeConstraints { (make) in
            make.right.equalTo(-self.cellMargin);
            make.centerY.equalTo(self.contentView.snp.centerY);
            make.height.equalTo(self.cellHeight - 20);
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func initWith(Model formModel: JSFormModel, VC ViewController: JSFormViewController) {
        super.initWith(Model: formModel, VC: ViewController)
        self.label.text = self.model.text;
        self.label.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconBtn.snp.right).offset(10)
        }
    }
}
