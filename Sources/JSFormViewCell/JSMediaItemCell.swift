//
//  JSMediaItemCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/25.
//

import UIKit
import Kingfisher

protocol FXMediaItemCellDelegate: AnyObject {
    //    -(void)mediaItemCellDeleted:(FXMediaItemCell *_Nullable)itemCell;
    func mediaItemCellDeleted(itemCell:JSMediaItemCell)
}
class JSMediaItemCell: UICollectionViewCell {
    
    weak var delegate:FXMediaItemCellDelegate?
   lazy var deletedBtn:UIButton = {
        var _deletedBtn = UIButton(type: .custom);
        _deletedBtn.bounds = CGRect(x: 0, y: 0, width: 20, height: 20);
    _deletedBtn.addTarget(self, action: #selector(deletedAction), for: .touchUpInside)
//        [_deletedBtn addTarget:self action:@selector(deletedAction) forControlEvents:UIControlEventTouchUpInside];
//        [_deletedBtn setBackgroundImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
        _deletedBtn.setBackgroundImage(UIImage(named: "del"), for: .normal)
        return _deletedBtn;
    }()
   lazy var imageView:UIImageView = {
        var _imageView = UIImageView()
        return _imageView
    }()
    var media:JSMediaItem = JSMediaItem(){
        didSet{
            //UI 操作
            self.imageView.contentMode = media.isAddImage ? UIImageView.ContentMode.scaleToFill : UIImageView.ContentMode.scaleAspectFill;
            
            self.imageView.layer.masksToBounds = !media.isAddImage;
            if media.imageData!.count > 0 {
                self.imageView.image = UIImage(data: media.imageData!)
            }else if media.url.count > 0
            {
                setImageViewContentModel()
                self.imageView.kf.setImage(with: URL(string: media.url),
                                           placeholder: UIImage(named: "placeholder"),
                                           options: [])
            }
            self.deletedBtn.isHidden = !media.isEdit;
        }
        willSet{
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.deletedBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width - 5, height: self.bounds.size.height);
        self.deletedBtn.frame = CGRect(x: self.bounds.size.width - self.deletedBtn.bounds.size.width, y: -5, width: self.deletedBtn.bounds.size.width, height: self.deletedBtn.bounds.size.height);
    }
    
    func setImageViewContentModel() {
        
    }
    @objc func deletedAction() {
        delegate?.mediaItemCellDeleted(itemCell: self)
    }
    //    -(void)deletedAction{
    //        if ([self.delegate respondsToSelector:@selector(mediaItemCellDeleted:)]) {
    //            [self.delegate mediaItemCellDeleted:self];
    //        }
    //    }
}
