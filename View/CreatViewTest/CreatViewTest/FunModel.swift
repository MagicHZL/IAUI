//
//  FunModel.swift
//  CreatViewTest
//
//  Created by 忠良 on 2021/12/1.
//

import UIKit

struct FuncModel<Base> {
    
    var base : Base
    
    init(ba:Base) {
        self.base = ba
    }
}

protocol FuncProtocol {
}

extension FuncProtocol {
    
    var fun : FuncModel<Self> {
        get{
            return FuncModel(ba: self)
        }
        set{
        }
    }
}

extension NSObject : FuncProtocol{}

extension FuncModel where Base == UIView {
    func changeHiden() -> [Base] {
//        self.base.isHidden = !self.base.isHidden
        return []
    }
}


extension ACell {
    
    //样式
    func showModel(){
        
    }
    
    //触发逻辑
    @objc func aaaAction(){
        
    }
    
}




