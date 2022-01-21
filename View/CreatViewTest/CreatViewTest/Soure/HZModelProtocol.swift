//
//  FuncModel.swift
//  CreatViewTest
//
//  Created by 忠良 on 2021/12/1.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

protocol HZModelProtocol {
    static var url: String { get }
    static var jsonPath: String { get } // 逗号分割的字符串
    init(json:JSON)
}

extension HZModelProtocol {
    
    static func afloadMos(method:HTTPMethod,param:Parameters? = nil,modles: @escaping ([Self])->()) {
        HZNetJson.netLoad(method, self.url, parameters: param) { json in
            modles(Self.getModes(jsons: [json]))
        }
              
    }
    
    static func afloadMo(method:HTTPMethod,param:Parameters? = nil,modle: @escaping (Self)->()) {
        HZNetJson.netLoad(method, self.url, parameters: param) { json in
            modle(Self.init(json: json))
        }
    }
    
    static func getModes(jsons:[JSON]) -> [Self]{
        
        var list : [Self] = []
        for json in jsons {
            list.append(Self.init(json: json))
        }
        return list
    }
    
}

/*
 TestModel.afloadMo(method: .get,param: ["ss":111]) { mo in
 }
 */

class TestModel : HZModelProtocol {
    
    static var url: String { return "2222" }
    required init(json:JSON) {}
}

class CccModel : HZModelProtocol {
    static var url : String {return "222"}
    required init(json: JSON) {}
}





