//
//  JSArrowCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/24.
//

import UIKit

class JSArrowButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let space : CGFloat = 2.0
        var labelWidth : CGFloat = 0.0
        var labelHeight : CGFloat = 0.0
        let imageWith = self.imageView?.frame.size.width
        _ = self.imageView?.frame.size.height
        let vue = (UIDevice.current.systemVersion) as NSString
        if vue.doubleValue >= 8.0 {

            labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
            labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
        }else {
            labelWidth = (self.titleLabel?.frame.size.width)!
            labelHeight = (self.titleLabel?.frame.size.height)!
        }
        
        self.contentHorizontalAlignment = .right
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith!-space/2.0, bottom: 0, right: imageWith!+space/2.0)
        
    }
    
}
class JSArrowCell: JSBaseViewCell {
    lazy var arrowButton : JSArrowButton = {
        var _arrowButton = JSArrowButton(type: .custom)
        _arrowButton.isUserInteractionEnabled = false
        _arrowButton.titleLabel?.font = self.textFont
        _arrowButton.setTitleColor(self.textClor, for: .normal)
        _arrowButton.setImage(self.arrowImage, for: .normal)
        
        return _arrowButton;
    }()
   lazy var arrowImage : UIImage = {
        var image = UIImage(named: "arrow_right")
        return image!
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.arrowButton)
        self.arrowButton.snp.makeConstraints { (make) in
            make.right.equalTo(-self.cellMargin);
            make.left.equalTo(self.iconBtn.snp.right).offset(10);
            make.centerY.equalTo(self.contentView.snp.centerY);
            make.height.equalTo(self.cellHeight - 20);
        }
//        arrowButton.backgroundColor = .random
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func initWith(Model formModel: JSFormModel, VC ViewController: JSFormViewController) {

//        [self.arrowButton setTitle:self.model.text.length ? self.model.text : [self showTitleName] forState:UIControlStateNormal];
//        [self.arrowButton setImage:self.model.showInfo ? nil : self.arrowImage forState:UIControlStateNormal];
//        [self.arrowButton setTitleColor:self.model.text.length ? self.textClor :[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        super.initWith(Model: formModel, VC: ViewController)
        let title = self.model.text.count>0 ? self.model.text:showTitleName()
        self.arrowButton.setTitle(title, for: .normal)
        let image = !self.model.showInfo ? self.arrowImage:nil
        self.arrowButton.setImage(image, for: .normal)
        
        let color = self.model.text.count>0 ? self.textClor:.lightGray
        self.arrowButton.setTitleColor(color, for: .normal)
        
        
    }

    override func doSomething() {
        if self.model.name.contains("日期") {
//            JSFormModelTool()
            JSFormPickerTools.showDateWithTitle(title: showTitleName()) { (selectedValue) in

                self.setArrowCellTextWith(text: selectedValue)
            }
        }else if self.model.name.contains("区域")
        {

            JSFormPickerTools.showAddressWithTitle(title: showTitleName()) { (selectedValue) in

                self.setArrowCellTextWith(text: selectedValue)
            }
        }else if self.model.name.contains("收入")
        {
//            JSFormPickerTools.showStringWithTitle(title: showTitleName(), subtitles: self.model.texts) { (make) in
//                print("收入")
//            }
            
            JSFormPickerTools.showStringWithTitle(showTitleName(), dataSourceArr: self.model.texts) { (resultModel) in
                print("收入")
                self.setArrowCellTextWith(text: resultModel.value!)
            }
        }
    }
    func setArrowCellTextWith(text:String) {
        self.arrowButton.setTitle(text, for: .normal)
        self.arrowButton.setTitleColor(self.textClor, for: .normal)
        self.model.text = text;
    }
    func showTitleName() -> String {
        return "请选择"+self.model.name
    }


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
