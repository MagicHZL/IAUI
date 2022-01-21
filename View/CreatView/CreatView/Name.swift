//
//  Name.swift
//  CreatView
//
//  Created by 郝忠良 on 2021/11/14.
//

import Foundation

var allName : [String : String] = [:]

func getAllname(){
    
    var allnameJson = (try? Data.init(contentsOf: URL.init(fileURLWithPath: path + "name.json"))) ?? Data()
    
    var allnameDic = (try? JSONSerialization.jsonObject(with: allnameJson , options: .allowFragments)) as? [String : String] ?? [:]

    allName =  allnameDic
    
    print(allName)
}




