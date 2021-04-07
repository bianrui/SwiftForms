//
//  JSTextViewCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/24.
//

import UIKit

class JSTextViewCell: JSBaseViewCell,UITextViewDelegate {
    let kInputMaxNum = 200
    lazy var  textView :UITextView = {
        var _textView = UITextView()
        _textView.font = self.textFont
        _textView.textColor = self.textClor
        _textView.delegate = self
        _textView.backgroundColor = UIColor.groupTableViewBackground
        return _textView
    }()
    lazy var  placeHolderLabel :UILabel = {
        var _placeHolderLabel = UILabel()
        _placeHolderLabel.font = self.textFont
        _placeHolderLabel.textColor = .lightGray
        return _placeHolderLabel
    }()
    lazy var  textNumLabel :UILabel = {
        var _textNumLabel = UILabel()
        _textNumLabel.font = self.textFont;
        _textNumLabel.textAlignment = .right
        _textNumLabel.text = "0/" + String(kInputMaxNum)
        _textNumLabel.textColor = .lightGray
        _textNumLabel.backgroundColor = UIColor.groupTableViewBackground
        return _textNumLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.textView)
        self.contentView.addSubview(self.placeHolderLabel)
        self.contentView.addSubview(self.textNumLabel)
        
        self.textView.snp.makeConstraints { (make) in
            make.left.equalTo(self.cellMargin);
            make.right.equalTo(-self.cellMargin);
            make.top.equalTo(self.iconBtn.snp.bottom).offset(10);
            make.bottom.equalTo(-self.cellMargin);
        }
        self.placeHolderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.textView.snp.left).offset(5);
            make.top.equalTo(self.textView.snp.top).offset(7);
        }
        self.textNumLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.textView.snp.left);
            make.right.equalTo(self.textView.snp.right);
            make.top.equalTo(self.textView.snp.bottom);
            make.height.equalTo(self.cellMargin);
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func initWith(Model formModel: JSFormModel, VC ViewController: JSFormViewController) {
        super.initWith(Model: formModel, VC: ViewController)
        self.placeHolderLabel.text = "请输入"+model.name
        self.textView.isUserInteractionEnabled = !self.model.showInfo;
        self.textView.text = self.model.text;
    }
    func textViewDidChange(_ textView: UITextView) {
        self.placeHolderLabel.isHidden = textView.text.count>0
        let length:Int = textView.text.count
        if length >= kInputMaxNum {
            
            textView.text = textView.text[...kInputMaxNum]//string 扩展
            self.textNumLabel.text = String(kInputMaxNum)+"/"+String(kInputMaxNum)
        }else
        {
            self.textNumLabel.text = String(length)+"/"+String(kInputMaxNum)
        }
        self.model.text = textView.text;
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.parentVC.uploadDict[self.model.key!] = textView.text
    }
    
}
