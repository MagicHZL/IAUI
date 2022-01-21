//
//  HZCellProtocol.swift
//  CreatViewTest
//
//  Created by 忠良 on 2021/12/1.
//

import UIKit

struct HZCell <T> {
    var cell : T
    init(c:T) {
        self.cell = c
    }
}

protocol HZCellProtocol {
//    var hzc : HZCell<Self> {get}
    func showWithMo<T:HZModelProtocol>(mo:T)
}

extension HZCellProtocol {
    func showWithMo<T:HZModelProtocol>(mo:T){}
    var hzc : HZCell<Self> {
        return HZCell(c:self)
    }
}



class ACell : UITableViewCell {
    weak var vc : UIView?
    weak var mo : TestModel?

    
}

extension ACell {
    
}

