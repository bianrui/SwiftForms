//
//  UICollectionViewLeftAlignedLayout.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/24.
//

import UIKit


extension UICollectionViewLayoutAttributes{

    func leftAlignFrameWithSectionInset(inset:UIEdgeInsets) {
        var frame:CGRect = self.frame
        frame.origin.x = inset.left
        self.frame = frame
    }
}
protocol UICollectionViewDelegateLeftAlignedLayout:UICollectionViewDelegateFlowLayout {

}
class UICollectionViewLeftAlignedLayout: UICollectionViewFlowLayout {
//    layoutAttributesForElementsInRect
//    weak var delegate:UICollectionViewDelegateLeftAlignedLayout?
//    var numRow:Int = 0;//行数
//    var numCol:Int = 0;//列数
//    var contentInsets: UIEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    //所有cell的布局属性
//    var layoutAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]();
//
////    layoutAttributesForItem
//
//
    override init() {
        super.init();
        self.itemSize = CGSize(width: 70, height: 70);  //这里可以根据自己的需求设置大小
        self.scrollDirection = .horizontal
//        self.numRow = 7;
//        self.numCol = 4;
//        self.contentInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    }
//
//
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


//    //计算布局
//    override func prepare() {
//
//    let numsection = self.collectionView!.numberOfSections;
//    let itemNum: Int = self.collectionView!.numberOfItems(inSection: 0)
//        layoutAttributes.removeAll();
//        for i in 0..<numsection{
//            for j in 0..<itemNum{
//                let layout = self.layoutAttributesForItem(at: IndexPath(item: j, section: i))!;
//                self.layoutAttributes.append(layout);
//            }
//        }
//
//    }
    
    /**
       用来计算出rect这个范围内所有cell的UICollectionViewLayoutAttributes，
       并返回。
       */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let originalAttributes:Array = super.layoutAttributesForElements(in: rect)!
        var updatedAttributes:Array = super.layoutAttributesForElements(in: rect)!
        for attributes in originalAttributes {
            if (attributes.representedElementKind != nil) {
                let index = updatedAttributes.firstIndex(of: attributes)
                updatedAttributes[index!] = self.layoutAttributesForItem(at: attributes.indexPath)!
            }
        }
        return updatedAttributes
        
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let currentItemAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as! UICollectionViewLayoutAttributes
        let sectionInset = evaluatedSectionInsetForItemAtIndex(index: indexPath.section)
        let isFirstItemInSection:Bool = indexPath.item == 0;
        let layoutWidth:CGFloat = (self.collectionView?.frame.width)! - sectionInset.left - sectionInset.right;
        if isFirstItemInSection {
//            [currentItemAttributes leftAlignFrameWithSectionInset:sectionInset];
            currentItemAttributes.leftAlignFrameWithSectionInset(inset: sectionInset)
            return currentItemAttributes;
        }
        
        let previousIndexPath:IndexPath = IndexPath(item: indexPath.item-1, section: indexPath.section)
        
//            [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
        let previousFrame:CGRect = self.layoutAttributesForItem(at: previousIndexPath)!.frame
//            [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
        let previousFrameRightPoint:CGFloat = previousFrame.origin.x + previousFrame.size.width;
        let currentFrame:CGRect = currentItemAttributes.frame;
        let strecthedCurrentFrame:CGRect = CGRect(x: sectionInset.left,
                                                  y: currentFrame.origin.y,
                                                  width: layoutWidth,
                                                  height: currentFrame.size.height);
        // if the current frame, once left aligned to the left and stretched to the full collection view
        // widht intersects the previous frame then they are on the same line
        let isFirstItemInRow:Bool = !previousFrame.intersects(strecthedCurrentFrame)

        if isFirstItemInRow {
            // make sure the first item on a line is left aligned
            currentItemAttributes.leftAlignFrameWithSectionInset(inset: sectionInset)
            return currentItemAttributes;
        }

        var frame:CGRect = currentItemAttributes.frame;
        frame.origin.x = previousFrameRightPoint + evaluatedMinimumInteritemSpacingForSectionAtIndex(sectionIndex: indexPath.section)
//            [self evaluatedMinimumInteritemSpacingForSectionAtIndex:indexPath.section];
        currentItemAttributes.frame = frame;
        return currentItemAttributes;
    }
    
//    - (UIEdgeInsets)evaluatedSectionInsetForItemAtIndex:(NSInteger)index
//    {
//        if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
//            id<UICollectionViewDelegateLeftAlignedLayout> delegate = (id<UICollectionViewDelegateLeftAlignedLayout>)self.collectionView.delegate;
//
//            return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
//        } else {
//            return self.sectionInset;
//        }
//    }
//    - (CGFloat)evaluatedMinimumInteritemSpacingForSectionAtIndex:(NSInteger)sectionIndex
//    {
//        if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
//            id<UICollectionViewDelegateLeftAlignedLayout> delegate = (id<UICollectionViewDelegateLeftAlignedLayout>)self.collectionView.delegate;
//
//            return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:sectionIndex];
//        } else {
//            return self.minimumInteritemSpacing;
//        }
//    }
//    optional func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    func evaluatedMinimumInteritemSpacingForSectionAtIndex(sectionIndex:NSInteger) -> CGFloat {
        weak var delegate = self.collectionView!.delegate as? UICollectionViewDelegateLeftAlignedLayout
        if delegate != nil {
            return (delegate?.collectionView?(collectionView!, layout: self, minimumLineSpacingForSectionAt: sectionIndex))!
        }else
        {
            return self.minimumInteritemSpacing
        }

        
    }
    func evaluatedSectionInsetForItemAtIndex(index:NSInteger) -> UIEdgeInsets {
        weak var delegate = self.collectionView!.delegate as? UICollectionViewDelegateLeftAlignedLayout
        if delegate != nil {
            return (delegate?.collectionView?(self.collectionView!, layout: self, insetForSectionAt: index))!
        } else {
            return self.sectionInset;
        }
        
    }
}


