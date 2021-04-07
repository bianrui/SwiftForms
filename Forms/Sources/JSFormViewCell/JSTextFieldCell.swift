//
//  JSTextFieldCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/23.
//

import UIKit

class JSTextFieldCell: JSBaseViewCell,UITextFieldDelegate {
    
    lazy var textField : UITextField = {
        var textField = UITextField()
        textField.delegate = self
        textField.font = self.textFont
        textField.textColor = self.textClor
        textField.textAlignment = .right
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 11.0
        
        return textField
    }()
    lazy var idCardView : JSIDCardKeyboardView = {
        var _idCardView = JSIDCardKeyboardView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 225))
        _idCardView.block = { (str:String) -> Void in
            self.textField.text = str
        }
        return _idCardView
    }()
    
    
    
    //    -(FXIDCardKeyboardView *)idCardView{
    //        if (_idCardView == nil) {
    //            _idCardView = [[FXIDCardKeyboardView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 225)];
    //            [_idCardView setValue:self.textField forKeyPath:@"_currentTextField"];
    //        }
    //        return _idCardView;
    //    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.textField)
        self.textField.snp.makeConstraints { (make) in
            make.right.equalTo(-self.cellMargin);
            make.left.equalTo(self.iconBtn.snp.right).offset(10)
            make.top.equalTo(self.contentView.snp.top).offset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10);
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.inputView = self.model.name.contains("身份证") ? self.idCardView : nil
        //        textField.keyboardType = .numberPad
    }
    
    //    - (void)textFieldDidBeginEditing:(UITextField *)textField{
    //        textField.inputView = [self.model.name containsString:@"身份证"] ? self.idCardView : nil;
    //    }
    
    override func initWith(Model model:JSFormModel,VC parentVC:JSFormViewController) {
        super.initWith(Model: model, VC: parentVC)
        
        self.textField.keyboardType = UIKeyboardType(rawValue: model.keyBordType)!
        textField.placeholder = "请输入" + model.name
        textField.isUserInteractionEnabled = !model.showInfo
        textField.text = model.text
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        model.text = textField.text!
        self.parentVC.uploadDict[self.model.key!] = textField.text
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
