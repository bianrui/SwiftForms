//
//  JSFormModel.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/20.
//

import UIKit
import HandyJSON

enum JSCellType : Int {
    case FXCellTypeTextField = 0
    case FXCellTypeArrow
    case FXCellTypeLabel
    case FXCellTypeSwitch
    case FXCellTypeTextView
    case FXCellTypeRadioBox
    case FXCellTypeCheckBox
    case FXCellTypeMeida
}
class JSFormModel: HandyJSON {
    required init() {
            
    }

    var icon : String = ""             //左边的图片名称
    var name : String = ""             //左边的名称
    var cellType : Int = 0      //每行模型对应的cell样式
    var key : String?              //上传到服务器的key
    var cellID : String!           //每个模型对应的cellID
    var text : String = ""             //最终的输入、选择的数据
    var keyBordType : Int = 0    //输入框对应的键盘样式
    var texts : Array = [Any]()           //里面存放的是文本数组
    var items : Array = [JSBoxItem]()           //里面存放的是FXBoxItem对象
    var medias : Array = [JSMediaItem]()     //里面存放的是媒体数据(图片视频之类)
    var showInfo : Bool = false            //是否是显示详情数据
    var mustFill : Bool?            //模型所在这一行的cell数据是否是必填
    var height : CGFloat = 60           //模型所在这一行的cell高度
    
}
