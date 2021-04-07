//
//  JSMediaItem.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/24.
//

import UIKit
import HandyJSON
class JSMediaItem: HandyJSON {
    required init() {
    }
    
    var url :String = ""
    var fileName :String = ""
    var isEdit :Bool = false
    var imageData :Data?
    /// 等于 true 的时候可以添加图片
    var isAddImage :Bool = true
}
