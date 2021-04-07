//
//  JSBoxViewCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/25.
//

import UIKit

class JSBoxViewCell: JSBaseCollectionCell {
    let FXBoxItemCellID:String = "FXBoxItemCell"
    let kItemHeight:CGFloat = 40
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item:JSBoxItem = self.model.items[indexPath.item];
        return CGSize(width: item.width, height: kItemHeight);
    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return self.model.items.count
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.items.count
    }
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:JSBoxItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: FXBoxItemCellID, for: indexPath) as! JSBoxItemCell
//            [collectionView dequeueReusableCellWithReuseIdentifier:FXBoxItemCellID forIndexPath:indexPath]
        cell.boxItem = self.model.items[indexPath.item]
        return cell;
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.collectionView)

        self.collectionView.register(JSBoxItemCell.self, forCellWithReuseIdentifier: FXBoxItemCellID)
        self.collectionView.isUserInteractionEnabled = !self.model.showInfo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    -(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//        if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
//            [self.collectionView registerClass:[FXBoxItemCell class] forCellWithReuseIdentifier:FXBoxItemCellID];
//            self.collectionView.userInteractionEnabled = !self.model.showInfo;
//            [self.contentView addSubview:self.collectionView];
//        }
//        return self;
//    }

    override func initWith(Model formModel: JSFormModel, VC ViewController: JSFormViewController) {
        super.initWith(Model: formModel, VC: ViewController)
        for item in self.model.items {
            if item.width == 0.0 {
//                item.width = [UIImage imageNamed:item.icon].size.width + [self widthWithFont:self.textFont constrainedToHeight:kItemHeight text:item.name];
                item.width = (UIImage(named: item.icon)?.size.width)! + widthWithFont(self.textFont, constrainedToHeight: kItemHeight, text: item.name)
            }
        }
    }
//    -(void)initWithModel:(FXFormModel *)model parentVC:(FXFormViewController *)parentVC{
//        [super initWithModel:model parentVC:parentVC];
//        for (FXBoxItem *item in self.model.items) {
//            if (!item.width) {
//                item.width = [UIImage imageNamed:item.icon].size.width + [self widthWithFont:self.textFont constrainedToHeight:kItemHeight text:item.name];
//            }
//        }
//    }
//    func widthWithFont(font:UIFont,height:CGFloat,text:String) -> CGFloat {
//        var size:CGSize = CGSize(width: CGFloat(MAXFLOAT), height: height)
//        var attr = [NSFontAttributeName : font]
//        NSDictionary *attr = @{NSFontAttributeName : font};
//    }
//    - (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height text:(NSString *)text{
//        CGSize size = CGSizeMake(MAXFLOAT, height);
//         NSDictionary *attr = @{NSFontAttributeName : font};
//         CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
//         return rect.size.width;
//    }

    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
