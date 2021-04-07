//
//  JSMediaViewCell.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/25.
//

import UIKit
import TZImagePickerController
import GKPhotoBrowser

class JSMediaViewCell: JSBaseCollectionCell,
                       FXMediaItemCellDelegate,
                       TZImagePickerControllerDelegate
{
    
    let kPictureCount = 5
    let FXMediaItemCellID:String = "FXMediaItemCell"
    lazy var addImage:UIImage = {
        var _addImage = UIImage(named: "media_add")
        return _addImage!
    }()
    lazy var addItem:JSMediaItem = {
        var _addItem = JSMediaItem()
        
        _addItem.imageData = UIImage.pngData(self.addImage)()
        _addItem.isAddImage = true
        return _addItem
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layout.itemSize = CGSize(width: UIScreen.main.bounds.width * self.addImage.size.width / 375, height: UIScreen.main.bounds.height  * self.addImage.size.height / 667)
        self.collectionView.register(JSMediaItemCell.self, forCellWithReuseIdentifier: FXMediaItemCellID)
        
        self.collectionView.isUserInteractionEnabled = !self.model.showInfo
        self.contentView.addSubview(self.collectionView)
        
        self.collectionView.snp.updateConstraints { (make) in
            make.left.equalTo(self.cellMargin);
            make.right.equalTo(-self.cellMargin);
            make.top.equalTo(self.iconBtn.snp.bottom).offset(0);
            make.bottom.equalTo(self.contentView.snp.bottom).offset(0);
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:JSMediaItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: FXMediaItemCellID, for: indexPath) as! JSMediaItemCell
        cell.media = self.model.medias[indexPath.item]
        cell.delegate = self
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.medias.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let media:JSMediaItem = self.model.medias[indexPath.item]
        if media.isAddImage {
            showPickerContoller()
        }else{
            showMedias(indexPath: indexPath)
        }
    }
    /// --FXMediaItemCellDelegate
    func mediaItemCellDeleted(itemCell: JSMediaItemCell) {
        
        let indexPath:IndexPath = self.collectionView.indexPath(for: itemCell)!
        self.model.medias.remove(at: indexPath.item)
        self.model.height = calculationModelheight()
        
        let currentIndexPath:IndexPath = self.parentVC.tableView.indexPath(for: self)!
        
        //会重新走initWithModel方法检查有没有+图片
        //        [self.parentVC.tableView reloadRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        self.parentVC.tableView.reloadRows(at: [currentIndexPath], with: .none)
    }
    func calculationModelheight() -> CGFloat {
        let rows:Int =  Int(ceil(Double(self.model.medias.count) / 3.0))
        let tmp1:CGFloat = self.cellHeight * 0.5 + self.iconBtnImageHeight * 0.5
        let tmp2:CGFloat = self.layout.sectionInset.top + self.layout.sectionInset.bottom + CGFloat(rows) * self.layout.itemSize.height
        let tmp3:CGFloat = CGFloat((rows - 1)) * self.layout.minimumLineSpacing
        let totalHeight:CGFloat = tmp1 + tmp2 + tmp3
        //        return totalHeight
        return 160
    }
    //    {
    //        int rows =  ceil(self.model.medias.count / 3.0);
    //        CGFloat totalHeight = self.cellHeight * 0.5 + self.iconBtnImageHeight * 0.5 + self.layout.sectionInset.top + self.layout.sectionInset.bottom + rows * self.layout.itemSize.height + (rows - 1) * self.layout.minimumLineSpacing;
    //        return totalHeight;
    //    }
    
    
    //    -(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    //        if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    ////            self.layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.addImage.size.width / 375, [UIScreen mainScreen].bounds.size.height  * self.addImage.size.height / 667);
    ////            [self.collectionView registerClass:[FXMediaItemCell class] forCellWithReuseIdentifier:FXMediaItemCellID];
    ////            self.collectionView.userInteractionEnabled = !self.model.showInfo;
    //            [self.contentView addSubview:self.collectionView];
    //            [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
    //                make.left.mas_equalTo(self.cellMargin);
    //                make.right.mas_equalTo(-self.cellMargin);
    //                make.top.equalTo(self.iconBtn.mas_bottom).offset(0);
    //                make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    //            }];
    //        }
    //        return self;
    //    }
    override func initWith(Model formModel: JSFormModel, VC ViewController: JSFormViewController) {
        super.initWith(Model: formModel, VC: ViewController)
        let firstItem = self.model.medias.first
        
        if firstItem == nil || (firstItem?.isAddImage == false && self.model.medias.count < kPictureCount){
            self.model.medias.insert(self.addItem, at: 0)
        }
        
        
        self.model.height = calculationModelheight()
        self.collectionView.reloadData()
    }
    
    ///--弹出图片选择器
    func showPickerContoller() {
        
        let maxNum:Int = kPictureCount - self.model.medias.count + 1
        
        let imagePickController:TZImagePickerController = TZImagePickerController(maxImagesCount: maxNum, delegate: self)

        imagePickController.allowPickingImage = true
        imagePickController.allowPickingMultipleVideo = false
        imagePickController.allowPickingVideo = false
        self.parentVC.present(imagePickController, animated: true, completion: nil)

    }
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
//        for (int index = 0; index < photos.count; index++) {
        for index in 0..<photos.count {
            let media:JSMediaItem = JSMediaItem()
            media.isAddImage = false
            let image:UIImage = photos[index]
            let sset:PHAsset = assets[index] as! PHAsset
//             media.imageData = UIImageJPEGRepresentation(image, 0.6)
            media.imageData = UIImage.jpegData(image)(compressionQuality: 0.6)
//            media.imageData = UIImage.pngData(image)()
            media.isEdit = true
            media.fileName = sset.value(forKey: "filename") as! String
            self.model.medias.insert(media, at: 1)
            
        
        }
        if (self.model.medias.count > kPictureCount) {//超出5个删除addModel
//            [self.model.medias removeLastObject];
            self.model.medias.removeFirst()
        }
//        self.model.height = [self calculationModelheight];
        
        self.parentVC.tableView.reloadData()
    
    
    }
    // 取出某个对象的地址
    func sg_getAnyObjectMemoryAddress(object: AnyObject) -> String {
        let str = Unmanaged<AnyObject>.passUnretained(object).toOpaque()
        return String(describing: str)
    }
    
    // 对比两个对象的地址是否相同
    func sg_equateableAnyObject(object1: AnyObject, object2: AnyObject) -> Bool {
        let str1 = sg_getAnyObjectMemoryAddress(object: object1)
        let str2 = sg_getAnyObjectMemoryAddress(object: object2)
        
        if str1 == str2 {
            return true
        } else {
            return false
        }
    }
    //MARK: - -显示媒体浏览器
    func showMedias(indexPath:IndexPath) {
        var photos:Array = Array<GKPhoto>()
        for media in self.model.medias {
            
            
            if !sg_equateableAnyObject(object1: media, object2: self.addItem) {
                let photo:GKPhoto = GKPhoto()
                if media.imageData!.count>0 {
                    photo.image = UIImage(data: media.imageData!)
                }else if media.url.count > 0
                {
                    photo.url = URL(string: media.url)!
                }
                photos.append(photo)
            }
        }
        
        let browser:GKPhotoBrowser = GKPhotoBrowser(photos: photos,currentIndex: indexPath.row-1)
        browser.showStyle = GKPhotoBrowserShowStyle(rawValue: 0)!
        browser.show(fromVC: self.parentVC)
    }
    //    #pragma mark ----显示媒体浏览器
    //    -(void)showMedias:(NSIndexPath *)indexPath{
    //        NSMutableArray *photos = [NSMutableArray array];
    //        for (FXMediaItem *media in self.model.medias) {
    //            if(![media isEqual:self.addItem]){
    //                GKPhoto *photo = [[GKPhoto alloc]init];
    //                if (media.imageData) {
    //                    photo.image = [UIImage imageWithData:media.imageData];
    //                }else if (media.url){
    //                    photo.url = [NSURL URLWithString:media.url];
    //                }
    //                [photos addObject:photo];
    //            }
    //        }
    //        GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:indexPath.row];
    //        browser.showStyle = GKPhotoBrowserShowStyleNone;
    //        [browser showFromVC:self.parentVC];
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
