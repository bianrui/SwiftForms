//
//  JSCheckBoxCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/25.
//

import UIKit

class JSCheckBoxCell: JSBoxViewCell {
    var selectedItemNames:NSMutableArray = NSMutableArray()
//    let kItemHeight:CGFloat = 40
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout.minimumLineSpacing = 2
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(self.cellMargin)
            make.right.equalTo(-self.cellMargin);
            make.top.equalTo(self.iconBtn.snp.bottom).offset(0);
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func initWith(Model formModel: JSFormModel, VC ViewController: JSFormViewController) {
        super.initWith(Model: formModel, VC: ViewController)
        self.collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(getCollectionViewHeight());
        }
        self.collectionView.reloadData()
    }
    
    func getCollectionViewHeight() -> CGFloat {
        //        NSMutableArray *itemWidths = [self.model.items valueForKeyPath:@"width"];
        var row:Int = 1;
        var width:CGFloat = self.cellMargin * 2 + (CGFloat(self.model.items.count) - 1) * self.layout.minimumInteritemSpacing;
        for item in self.model.items {
            let itemWidth = item.width
            if width+itemWidth>UIScreen.main.bounds.width {
                row+=1
                width = itemWidth
            }else
            {
                width += itemWidth
            }
        }
        let totalHeight:CGFloat = CGFloat((row - 1)) * self.layout.minimumLineSpacing + CGFloat(row) * kItemHeight + self.layout.sectionInset.top + self.layout.sectionInset.bottom
        self.model.height = totalHeight + self.cellHeight * 0.5 + self.iconBtnImageHeight * 0.5
        return totalHeight;
        
    }
    //    #pragma mark --获取FXCheckBoxCollectionView的高度
    //    -(CGFloat)getCollectionViewHeight{
    //        NSMutableArray *itemWidths = [self.model.items valueForKeyPath:@"width"];
    //        int row = 1;
    //        CGFloat width = self.cellMargin * 2 + (itemWidths.count - 1) * self.layout.minimumInteritemSpacing;
    //        for (NSNumber *number in itemWidths) {
    //            CGFloat itemWidth = [number floatValue];
    //            if ((width + itemWidth) > [UIScreen mainScreen].bounds.size.width) {
    //                row += 1;
    //                width = itemWidth;
    //            }else{
    //                width += itemWidth;
    //            }
    //        }
    //        CGFloat totalHeight = (row - 1) * self.layout.minimumLineSpacing + row * kItemHeight + self.layout.sectionInset.top + self.layout.sectionInset.bottom;
    //        self.model.height = totalHeight + self.cellHeight * 0.5 + self.iconBtnImageHeight * 0.5 ;
    //        return totalHeight;
    //    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem:JSBoxItem = self.model.items[indexPath.item]
        selectedItem.selected = !selectedItem.selected;
        self.collectionView.reloadData()
        if selectedItem.selected {
            self.selectedItemNames.add(selectedItem.name)
            
        }else if ((self.selectedItemNames.contains(selectedItem.name))){
            self.selectedItemNames.remove(selectedItem.name)
            
        }
        self.model.text = (self.selectedItemNames.componentsJoined(by: ","))
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
