//
//  NetModel.swift
//  CreatViewTest
//
//  Created by 忠良 on 2021/12/1.
//

import UIKit
import SwiftyJSON
import Alamofire

class HZNetJson {
    
    static var baseUrl : String = "www"
    
    init() {
    }

    static func netLoad(_ method:HTTPMethod ,_ url : String,parameters:Parameters? = nil, jsonBlock:@escaping (JSON)->()){
        
        let relUrl = baseUrl + url
//        AF.request(relUrl, method: method, parameters: parameters).responseString { strRe in
//            switch strRe.result {
//            case .success(let str):
//                let json = JSON.init(parseJSON: str)
//                jsonBlock(json)
//                break
//            case.failure(_):
//                break
//            }
//        }
    }
    
    
    
}
