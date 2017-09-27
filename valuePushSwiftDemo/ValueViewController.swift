//
//  ValueViewController.swift
//  SwiftExerise
//
//  Created by lvshasha on 2017/9/27.
//  Copyright © 2017年 GXL. All rights reserved.
//

import UIKit

class ValueViewController: UIViewController, ValuePushDelegate {
    
    var dataArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "传值"
        self.view.backgroundColor = UIColor.blue
        dataArray = ["属性","代理","block","通知"]
        createButton(titleArray: dataArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createButton(titleArray:[String]) {
        for i in 0..<dataArray.count {
            let buttonzTitle = UIButton.init(type: .custom)
            buttonzTitle.frame = CGRect(x: 100, y: 40 * (i + 1) + 100 * i, width: 100, height: 100)
            buttonzTitle.backgroundColor = UIColor.blue
            buttonzTitle.setTitle(titleArray[i], for: .normal)
            buttonzTitle.setTitleColor(UIColor.white, for: .normal)
            buttonzTitle.tag = 1000 + i
            buttonzTitle.addTarget(self, action: #selector(buttonTap(_ :)), for:.touchUpInside)
            self.view.addSubview(buttonzTitle)
        }
    }
    
    @objc func buttonTap(_ button:UIButton) {
        if button.tag == 1000 {
            let valueCtrl = ValuePushViewController()
            valueCtrl.string = "属性传值"
            self.navigationController?.pushViewController(valueCtrl, animated: true)
        } else if button.tag == 1001 {
            let valueCtrl = ValuePushViewController()
            valueCtrl.string = "属性传值"
            // 协议带入
//            valueCtrl.delegate = self as ValuePushDelegate
            valueCtrl.delegate = self
            self.navigationController?.pushViewController(valueCtrl, animated: true)
        } else if button.tag == 1002 {
            let valueCtrl = ValuePushViewController()
            valueCtrl.string = "属性传值"
            valueCtrl.postValueBlock = {(str) in
                print(str)
            }
            self.navigationController?.pushViewController(valueCtrl, animated: true)
        }else {
            // 发送通知
            // 通知
            let NOTIFITION = NSNotification.Name.init("notifationTest")
            // 注册通知
            NotificationCenter.default.addObserver(self, selector: #selector(receiveNotifation(_ :)), name: NOTIFITION, object: nil)
            let valueCtrl = ValuePushViewController()
            self.navigationController?.pushViewController(valueCtrl, animated: true)
        }
    }
    
    // 使用@objc修饰后的类型，可以直接供 Objective-C 调用。
    @objc private func receiveNotifation(_ notification : Notification) {
        guard let usetInfo = notification.userInfo else {
            return
        }
        
        let age = usetInfo["age"] as? Int
        let key = usetInfo["key1"] as? String
        if key != nil && age != nil {
            print("\(age!)" + "-->" + key!)
        }
    }
    
    deinit {
        // 移除通知
        //        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("notifationTest"), object: nil)
    }
    
    func senValue(text: String) {
        print("text======= \(text)")
    }

}
