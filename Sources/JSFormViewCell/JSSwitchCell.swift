//
//  JSSwitchCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/24.
//

import UIKit

class JSSwitchCell: JSBaseViewCell {
    lazy var switchView:UISwitch = {
        var _switch = UISwitch()
//        #selector(switchDidChange),
        _switch.addTarget(self, action: #selector(changeValue), for: .touchUpInside)
        return _switch
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.switchView)
        self.switchView.snp.makeConstraints { (make) in
            make.right.equalTo(-self.cellMargin);
            make.centerY.equalTo(self.contentView.snp.centerY);
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func initWith(Model formModel: JSFormModel, VC ViewController: JSFormViewController) {
        super.initWith(Model: formModel, VC: ViewController)
//        self.switchView.setOn(Bool(self.model.text)!, animated: true)
        self.switchView.isUserInteractionEnabled = !self.model.showInfo
        changeValue(switchView: self.switchView)
    }
    @objc func changeValue(switchView:UISwitch) {
        self.model.text = String(switchView.isOn)
    }


}
