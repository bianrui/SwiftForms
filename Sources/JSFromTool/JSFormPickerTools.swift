//
//  JSFormPickerTools.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/24.
//

import UIKit
import BRPickerView

class JSFormPickerTools: NSObject {

    
//    func showStringWithTitle(title:String,subtitles:Array<Any>,handler :(_ resultModel:BRResultModel)->Void) {
//
//    }


    static func showStringWithTitle(_ title:String, dataSourceArr subtitles:Array<Any>, handler:@escaping (_ resultModel:BRResultModel)->Void){

        let stringPickerView:BRStringPickerView = BRStringPickerView(pickerMode: .componentSingle)
            stringPickerView.title = title;
            stringPickerView.dataSourceArr = subtitles;
            stringPickerView.selectIndex = 0;
        stringPickerView.resultModelBlock = { resultModel in
            handler(resultModel!)
        }
        stringPickerView.show()
    }
    static func showAddressWithTitle(title:String,handler :@escaping(_ selectedValue:String)->Void) {
        
        let addressPickerView:BRAddressPickerView = BRAddressPickerView(pickerMode: BRAddressPickerMode.area)
        addressPickerView.resultBlock = { province,city,area in
            let selectedValue:String = province!.name! + (city?.name)! + area!.name!
                handler(selectedValue)
        }
        addressPickerView.show()
    }
    static func showDateWithTitle(title:String,handler :@escaping(_ selectedValue:String)->Void) {
        let datePickerView:BRDatePickerView = BRDatePickerView(pickerMode: .YMD)
        datePickerView.title = title
        datePickerView.minDate = NSDate.br_setYear(2000, month: 3, day: 12)
        
        let date:Date = Date()
         
        let dateformatter:DateFormatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
//        dateformatter.date(from: "yyyy")
        let thisYearString:String = dateformatter.string(from: date)
        let theyear:Int = Int(thisYearString)! + 5
        
        dateformatter.dateFormat = "MM"
        let currentMonth:Int = Int(dateformatter.string(from: date))!
        
        dateformatter.dateFormat = "dd"
        let currentDay:Int = Int(dateformatter.string(from: date))!
        datePickerView.maxDate = NSDate.br_setYear(theyear, month: currentMonth, day: currentDay)
        
        datePickerView.resultBlock = { selectDate, selectValue in
            handler(selectValue!)
        }
        datePickerView.show()
    }
}
