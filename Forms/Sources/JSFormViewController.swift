//
//  JSFormViewController.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/20.
//

import UIKit

class JSFormViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var isEdit = false//判断tableview是否是在编辑状态
    var requestDict : NSMutableDictionary = {
        var dict = NSMutableDictionary()
        return dict
        
    }()
    var uploadDict : NSMutableDictionary = {
        var dict = NSMutableDictionary()
        return dict
    }()
    var haveHeader : Bool = false
    fileprivate lazy var datas:NSMutableArray = {
        var array = NSMutableArray()
        //        for i in 1...22{
        //            array.add(NSNumber(value: i).stringValue)
        //        }
        return array
        
    }()
    lazy var tableView:UITableView = {
        var table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false//垂直滚动指示器
        table.showsHorizontalScrollIndicator = false//水平滚动指示器
        //        table.bounces = false//弹簧效果
        //        table.separatorStyle = .none//分割线
        table.estimatedRowHeight = 0//预设行高
        table.estimatedSectionFooterHeight = 0//预设分区头高度
        table.estimatedSectionHeaderHeight = 0
        table.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.always
        }
        return table
        
    }()
    
    
    
    public func loadDataWithFileName(fileName: String) {

        self.datas.addObjects(from: JSFormModelTool.getFieldModelsWithFileName(fileName: fileName) as! [Any])
        self.haveHeader = self.datas.firstObject is JSFormHeaderModel
//        haveHeader = (datas.firstObject != nil)
//        let tmp = datas.firstObject
//        haveHeader = (NSStringFromClass(tmp as! JSFormModel).compare("JSFormHeaderModel").rawValue != 0)
        
    }
    
    typealias RequestBlock = (_ name:String)->Void;
    var block : RequestBlock?;
    
    func checkHaveEmptyField(block:RequestBlock) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkHaveEmptyField { (String) in
        
        }
        view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.register(JSTextFieldCell.self, forCellReuseIdentifier: "JSTextFieldCell")
        self.tableView.register(JSArrowCell.self, forCellReuseIdentifier: "JSArrowCell")
        self.tableView.register(JSLabelCell.self, forCellReuseIdentifier: "JSLabelCell")
        self.tableView.register(JSSwitchCell.self, forCellReuseIdentifier: "JSSwitchCell")
        self.tableView.register(JSTextViewCell.self, forCellReuseIdentifier: "JSTextViewCell")
        self.tableView.register(JSRadioBoxCell.self, forCellReuseIdentifier: "JSRadioBoxCell")
        self.tableView.register(JSCheckBoxCell.self, forCellReuseIdentifier: "JSCheckBoxCell")
        self.tableView.register(JSMediaViewCell.self, forCellReuseIdentifier: "JSMediaViewCell")
    
        //        self.datas.add("s");
        //        self.datas.add("s");
        //        self.datas.add("s");
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    func rightBarButtonItemClicked()  {
        if isEdit {
            self.tableView.setEditing(false, animated: true)
            isEdit = false
        } else {
            self.tableView.setEditing(true, animated: true)
            isEdit = true
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.haveHeader ? self.datas.count : 1
//        return datas.count
    }
    ///UITableViewDataSource
    //返回cell的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.haveHeader {
            let headerModel = self.datas[section] as! JSFormHeaderModel
            return headerModel.content.count
        }
        return self.datas.count
    }
    //返回cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let Identifier:String = "UITableViewCell"
        //        var cell = tableView.dequeueReusableCell(withIdentifier: Identifier)
        //
        //        //        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier, for: indexPath)
        //        if cell==nil {
        //            cell = UITableViewCell(style: .default, reuseIdentifier: Identifier)
        //            //cell = tableViewCell
        //        }
        //        cell?.textLabel?.text = self.datas[indexPath.row] as? String
        //        //        cell?.imageView?.image = UIImage(named: self.datas[indexPath.row] as! String)
        //        return cell!;
        let model:JSFormModel = getCurrentFormModel(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellID as String, for: indexPath) as! JSBaseViewCell
        cell.initWith(Model: model, VC: self)
        
        return cell
    }
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let model:JSFormModel = getCurrentFormModel(indexPath);
        return model.height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print(indexPath)
        let cell : JSBaseViewCell = tableView.cellForRow(at: indexPath) as! JSBaseViewCell
        
        //        JSBaseViewCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
        let model = getCurrentFormModel(indexPath)
        if (model.showInfo) {
            return;
        }
        self.view.endEditing(true)
        cell.doSomething()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        FXFormHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:"FXFormHeaderViewID"];
        //        if (self.haveHeader) {
        //            JSFormHeaderModel *headerModel = self.datas[section];
        //            headerView.model = headerModel.header;
        //        }
        
        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FXFormHeaderViewID") as? JSFormHeaderView
        if headerView == nil {
            headerView = JSFormHeaderView(reuseIdentifier: "FXFormHeaderViewID")
        }
        
        let headerModel = self.datas[section] as? JSFormHeaderModel
        headerView?.model = headerModel?.header;
        return headerView;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.haveHeader ? 45 : 0.001;
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = getCurrentFormModel(indexPath)
     
            print(model.name)
            print(model.height)
   
        return  model.height
    }
    func getCurrentFormModel(_ indexPath : IndexPath) -> JSFormModel {
        var model:JSFormModel = JSFormModel();
        if (self.haveHeader) {
            let headerModel = self.datas[indexPath.section] as? JSFormHeaderModel
            model = headerModel!.content[indexPath.row] ;
        }else{
            model = self.datas[indexPath.row] as! JSFormModel;
        }
        return model;
    }
    //    (_ name:String)->Void;
    func checkHaveEmptyField(block1 : (_ result:Bool,_ message : String)->Void){
        
        for field in self.datas {
            let field = field as? JSFormModel
            if field?.cellType == JSCellType.FXCellTypeMeida.rawValue {
                if field?.medias.count == 1 {
                    block1(true, "请上传"+field!.name)
                    return
                }
            }else
            {
                if (field?.text.count)!<=0 {
                    let prefix:String = (field?.cellType == JSCellType.FXCellTypeArrow.rawValue || field?.cellType == JSCellType.FXCellTypeCheckBox.rawValue) ? "请选择" : "请输入"
                    block1(true, prefix+field!.name)
                    return
                }else
                {
                    self.uploadDict.setValue(field?.text, forKey: (field?.key)!)
                }
            }

        }
        block1(false,"")
    }
    //    //可被编辑
    //    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    //    //确定编辑模式（默认是滑动删除模式）
    //    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    //        return UITableViewCellEditingStyle.delete
    //    }
    //
    //    //具体编辑操作（默认删除操作）
    //    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //        //
    //        self.dataArray.removeObject(at: indexPath.row)
    //        //
    //        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
    //    }
    //    //允许移动某一行
    //    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
    //
    //    //实现排序
    //    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    //        //后面加as。。。
    //        let object:AnyObject = self.dataArray[sourceIndexPath.row] as AnyObject
    //        //
    //        self.dataArray.removeObject(at: sourceIndexPath.row)
    //        self.dataArray.insert(object, at: destinationIndexPath.row)
    //
    //
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
