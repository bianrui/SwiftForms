//
//  ViewController.swift
//  Forms
//
//  Created by 郭颢源 on 2021/4/6.
//

import UIKit


class ViewController: JSFormViewController {
    // MARK: - foo函数 func foo()
    
    // MARK:  foo函数 func foo()
    // TODO: - asdf
    // FIXME: - h dfgd
    lazy var iconBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .systemBlue
//        btn.contentHorizontalAlignment = .left
//            btn.setTitleColor(textClor, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
//        let image = UIImageView(image: UIImage(named: "iconFirst"))
//        view.addSubview(image)
//        image.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
        loadDataWithFileName(fileName: "Report.json")
        
//        self.view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
        view.addSubview(iconBtn)
        iconBtn.addTarget(self, action: #selector(click), for: .touchUpInside)
        iconBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 30))
        }
    }
    @objc func click()  {
        print(self.requestDict)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

