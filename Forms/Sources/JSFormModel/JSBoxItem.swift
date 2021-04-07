//
//  JSBoxItem.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/24.
//

import UIKit
import HandyJSON

class JSBoxItem: HandyJSON {
    required init() {
    }
    var name :String = ""
    var icon :String = ""
    var width :CGFloat = 0.0
    var selected :Bool = false
}
