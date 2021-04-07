//
//  JSBaseViewCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/22.
//

import UIKit
import SnapKit

class JSBaseViewCell: UITableViewCell {

    
    var model : JSFormModel = JSFormModel()
    
    lazy var iconBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = textFont
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: kTitleMarginToImage, bottom: 0, right: 0)
        btn.contentHorizontalAlignment = .left
        btn.setTitleColor(textClor, for: .normal)
        return btn
    }()
    
    var iconBtnImageWidth : CGFloat = 0.0
    var iconBtnImageHeight : CGFloat  = 0.0
    
//    {
//        get{
//            return (self.iconBtn.currentImage?.size.height)!
//        }
//    }
   
    var parentVC : JSFormViewController!
    var cellMargin : CGFloat = 15.0

    var cellHeight : CGFloat = 60.0
   

    var textFont : UIFont
    {
        get{
            return UIFont.systemFont(ofSize: 15.0);
        }
    }
    var textClor : UIColor{
        get{
            return UIColor(red: 123.0/255.0, green: 131.0/255.0, blue: 135.0/255.0, alpha: 1.0)
        }
    }


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.contentView.addSubview(self.iconBtn)
    
    }

    func initWith(Model formModel : JSFormModel, VC ViewController : JSFormViewController) {
        
        self.model = formModel;
        self.parentVC = ViewController;
        
        self.iconBtn.setImage(UIImage(named: model.icon), for: .normal)
        self.iconBtn.setTitle(model.name, for: .normal)
        iconBtnImageHeight = (self.iconBtn.currentImage?.size.height)!
        iconBtnImageWidth = (self.iconBtn.currentImage?.size.width)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let kTitleMarginToImage:CGFloat = 5
    override func layoutSubviews() {
        super.layoutSubviews()
        let nameWidth:CGFloat = widthWithFont(self.textFont, constrainedToHeight: self.iconBtnImageHeight, text: self.model.name) + self.iconBtnImageWidth + 2*kTitleMarginToImage
        self.iconBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.cellMargin);
            make.width.equalTo(nameWidth);
            make.top.equalTo(self.cellHeight * 0.5 - self.iconBtnImageHeight * 0.5);
            make.height.equalTo(self.iconBtnImageHeight);
        }

    }
    func doSomething() {
        
    }
    



//    - (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height text:(NSString *)text{
//        CGSize size = CGSizeMake(MAXFLOAT, height);
//         NSDictionary *attr = @{NSFontAttributeName : font};
//         CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
//         return rect.size.width;
//    }
    func widthWithFont(_ font:UIFont,constrainedToHeight height:CGFloat,text:String) -> CGFloat {
//        [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor : UIColor.green]
        let size:CGSize = CGSize(width: CGFloat(MAXFLOAT), height: height)
        let attr:Dictionary = [NSAttributedString.Key.font:font]
//         NSDictionary *attr = @{NSFontAttributeName : font};

        let rect :CGRect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr, context: nil)

         return rect.size.width;
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
