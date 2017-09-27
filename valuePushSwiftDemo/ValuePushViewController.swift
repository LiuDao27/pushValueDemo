//
//  ValuePushViewController.swift
//  SwiftExerise
//
//  Created by lvshasha on 2017/9/27.
//  Copyright © 2017年 GXL. All rights reserved.
//

import UIKit

// 闭包传值
typealias valueBlock = (String) -> Void

// 如果是可选方法，需要在protocol和func前都加上@objc
// 代理传值
protocol ValuePushDelegate:NSObjectProtocol { // (不写NSObjectProtocol暂时不会报错, 写属性是无法写weak
    //
    func senValue(text:String)
}

class ValuePushViewController: UIViewController {

    // 属性传值
    var string: String!
    
    // 声明
    weak var delegate: ValuePushDelegate?
    
    // 声明block
    var postValueBlock:valueBlock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "测试"
        print("str============\(string)")
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 通知
        let NOTIFITION = NSNotification.Name.init("notifationTest")
        NotificationCenter.default.post(name: NOTIFITION, object: self, userInfo: ["key1":"传递","age":19])
        
        /*
         if ([self.delegate respondsToSelector:@selector(sendValue:text)]) {
         [self.delegate sendValue:text];
         }
         */
        // '?'代替了responsed
        self.delegate?.senValue(text: "代理传值")
        self.navigationController?.popViewController(animated: true)
        
        // block
        guard let postValueBlock = postValueBlock else {
            return
        }
        postValueBlock("block传值")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
