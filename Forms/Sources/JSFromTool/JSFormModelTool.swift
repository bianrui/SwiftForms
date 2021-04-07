//
//  JSFormModelTool.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/22.
//

import UIKit

import HandyJSON

class JSFormModelTool: NSObject {
    
    static let FXTextFieldCellID:String = "JSTextFieldCell"
    static let FXArrowCellID:String = "JSArrowCell"
    static let FXLabelCellID:String = "JSLabelCell"
    static let FXSwitchCellID:String = "JSSwitchCell"
    static let FXTextViewCellID:String = "JSTextViewCell"
    static let FXRadioBoxCellID:String = "JSRadioBoxCell"
    static let FXCheckBoxCellID:String = "JSCheckBoxCell"
    static let FXMediaViewCellID:String = "JSMediaViewCell"
    
    static func handeModelCellType(JSFormModel model:JSFormModel) {
        switch model.cellType {
        case JSCellType.FXCellTypeArrow.rawValue:
            model.cellID = FXArrowCellID;
            break;
        case JSCellType.FXCellTypeLabel.rawValue:
            model.cellID = FXLabelCellID;
            break;
        case JSCellType.FXCellTypeSwitch.rawValue:
            model.cellID = FXSwitchCellID;
            break;
        case JSCellType.FXCellTypeTextView.rawValue:
            model.cellID = FXTextViewCellID;
            break;
        case JSCellType.FXCellTypeRadioBox.rawValue:
            model.cellID = FXRadioBoxCellID;
            break;
        case JSCellType.FXCellTypeCheckBox.rawValue:
            model.cellID = FXCheckBoxCellID;
            break;
        case JSCellType.FXCellTypeMeida.rawValue:
            model.cellID = FXMediaViewCellID;
            break;
        default:
            model.cellID = FXTextFieldCellID;
            break;
        }
    }
    static func getFieldModelsWithFileName(fileName:String) -> NSArray {
        
        let isPlistFile:Bool = fileName.contains("plist")
        let isJsonFile:Bool = fileName.contains("json")
        //assert 第一个参数是false 的时候触发断言
        assert((isPlistFile || isJsonFile), "fileName必须是plist或者json文件(包含后缀名)")

        let path:String = Bundle.main.path(forResource: fileName, ofType: nil)!
        
        if (isPlistFile) {
            let arr = NSArray.init(contentsOfFile: path)
            
            //NSArray *arr = [NSArray arrayWithContentsOfFile:path];
            return getModelsWithDatas(arr!) as NSArray
        }else if (isJsonFile){
            
            let data:NSData = try! NSData.init(contentsOfFile: path)
            //            NSData *data = [[NSData alloc] initWithContentsOfFile:path];
            //            NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            let arr = try! JSONSerialization.jsonObject(with: data as Data, options: .init())
            return getModelsWithDatas(arr as! NSArray) as NSArray
        }else{
            assert((isPlistFile || isJsonFile), "fileName必须是plist或者json文件")
        }
        return [];
    }
    
    static func getModelsWithDatas(_ arr:NSArray) -> Array<AnyObject> {
        //        NSDictionary *dict = arr.firstObject;
        let dict:NSDictionary = arr.firstObject as! NSDictionary
        //        JSFormHeaderModel
        let keys:Array = dict.allKeys
        
        if keys.contains(where: { ($0 as AnyObject).caseInsensitiveCompare("header") == .orderedSame }) {
            
            let datas = JSONDeserializer<JSFormHeaderModel>.deserializeModelArrayFrom(array: arr) as! [JSFormHeaderModel]
            for header in datas {
                handeModelCellTypeWithModels(models: header.content)
            }
            
            return datas;
        }else{
            let modes = JSONDeserializer<JSFormModel>.deserializeModelArrayFrom(array: arr) as! [JSFormModel]
            handeModelCellTypeWithModels(models: modes)
            return modes;
        }
    }
    static func handeModelCellTypeWithModels(models : Array<JSFormModel>){
        for model in models {
            handeModelCellType(JSFormModel: model)
        }
    }
}
