//
//  JSRadioBoxCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/25.
//

import UIKit

class JSRadioBoxCell: JSBoxViewCell {
    var tempRadioItem :JSBoxItem = JSBoxItem()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.tempRadioItem = [[FXBoxItem alloc]init];
        
        self.collectionView.snp.makeConstraints { (make) in
            make.right.equalTo(-self.cellMargin);
            make.centerY.equalTo(self.contentView.snp.centerY);
            make.height.equalTo(self.cellHeight);
        }
//        self.collectionView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initWith(Model formModel: JSFormModel, VC ViewController: JSFormViewController) {
        super.initWith(Model: formModel, VC: ViewController)
        for item in self.model.items {
            if item.selected {
                self.tempRadioItem = item
                self.model.text = item.name
            }
        }
        self.collectionView.snp.makeConstraints { (make) in
            make.width.equalTo(getCollectionViewWidth())
        }
        self.collectionView.reloadData()
    }

    func getCollectionViewWidth() -> CGFloat {
        let interitemSpacings:CGFloat = CGFloat((self.model.items.count - 1)) * self.layout.minimumInteritemSpacing;
        var totalItemWidth:CGFloat = 0.1;
        for item in self.model.items {
            totalItemWidth += item.width;
        }
        return interitemSpacings + totalItemWidth;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = self.model.items[indexPath.item];
        if selectedItem.selected {
            return;
        }
        self.tempRadioItem.selected = false;
        selectedItem.selected = !selectedItem.selected;
        self.model.text = selectedItem.name;
        self.tempRadioItem = selectedItem;
        self.collectionView.reloadData()
    }
//    #pragma mark --获取FXRadioBoxCollectionView的宽度
//    -(CGFloat)getCollectionViewWidth{
//        CGFloat interitemSpacings = (self.model.items.count - 1) * self.layout.minimumInteritemSpacing;
//        CGFloat totalItemWidth = 0.1;
//        for (FXBoxItem *item in self.model.items) {
//            totalItemWidth += item.width;
//        }
//        return interitemSpacings + totalItemWidth;
//    }

//    -(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//
//        FXBoxItem *selectedItem = self.model.items[indexPath.item];
//        if (selectedItem.selected) {
//            return;
//        }
//        self.tempRadioItem.selected = NO;
//        selectedItem.selected = !selectedItem.selected;
//        self.model.text = selectedItem.name;
//        self.tempRadioItem = selectedItem;
//        [self.collectionView reloadData];
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
