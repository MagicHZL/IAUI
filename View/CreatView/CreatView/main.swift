//
//  main.swift
//  CreatView
//
//  Created by 忠良 on 2021/11/11.
//

import Foundation

/***
 此自动化脚本 基于SWiftSnp
 
 需要在设计时以组为概念
 命名规范  此列举几个后缀  Label(文字) View(视图) Button(按钮) Image(图片) TCell(流式列表) CCell(块式列表) 基本这几个就差不多够用  注意：命名不要和后缀相同
 相对位置 l左 r右 t上 b下 x水平居中 y垂直居中 w宽 h高 c居中  这些限制相对父图层
 
 ***/

//_class = group 则需生成新的  则父停止寻找此group下的字view

//以 sketch 的第一个group开始


#if DEBUG
var path : String = "/Users/xiaoyang/Desktop/Y/View/CreatView/SC/OR/" //需修改为自己项目地址
#else
var bp = Bundle.main.bundlePath
var path : String = bp + "/OR/"
print(bp + path)
#endif


func firstName(name:String) -> String{
    return name.components(separatedBy: "_").first ?? ""
}

func secondName(name:String) -> String{
    return name.components(separatedBy: "_").last ?? ""
}

var viewTypes : [String] = ["Label" ,"View" ,"Button" ,"Image","TCell","CCell"]

var creatDic : [String : [[String : Any]]] = [:]
var creatFram : [String : Any] = [:]

func getCreatParam(orJson:[String : Any]) -> [[String : Any]]{
    
    var classCreatDic : [[String : Any]] = []
    var orJson = orJson
    
    if var name = orJson["name"] as? String , let  layers = orJson["layers"] as? [[String : Any]] {
    
        if allName.count > 0 {
            name = allName[name] ?? name
            orJson["name"] = name
        }
        
        for item in layers {
            
            var vItem = item
            
            if let subClass = item["_class"] as? String , var subName = item["name"] as? String {
                
                if allName.count > 0 {
                    subName = allName[subName] ?? subName
                    vItem["name"] = subName
                }
                
                if subClass == "group" {
                    if let sublayers = item["layers"] as? [[String:Any]] , var last = sublayers.first {
                        last["hzl_G"] = subName
                        last["hzl_A"] = subName
                        last["frame"] = item["frame"]
                         
                        if allName.count > 0 , var lastname = last["name"] as? String {
                            lastname = allName[lastname] ?? lastname
                            last["name"] = lastname
                        }
                        classCreatDic.append(last)
                    }
                    if subName.contains("_") {
                        creatFram[subName] = item["frame"]
                        creatDic[subName] = getCreatParam(orJson: item)
                    }
                    
                }else{
                    if name != subName {
                        for type in viewTypes {
                            if subName.contains(type) {
                                if type == "Image" {
                                    vItem["hzl_G"] = "UI\(type)View"
                                }else if type == "cCell"{
                                    vItem["hzl_G"] = "UICollectionViewCell"
                                } else if type == "tCell"{
                                    vItem["hzl_G"] = "UITableViewCell"
                                } else{
                                    vItem["hzl_G"] = "UI\(type)"
                                }
                                break
                            }
                        }
                        classCreatDic.append(vItem)
                    }
                }
            }
        }
        
      
        creatFram[name] = orJson["frame"]
        creatDic[name] = classCreatDic
    }
    
    return classCreatDic
}

var jsonPath = "\(path)orJson.json"

var dataJson = try Data.init(contentsOf: URL.init(fileURLWithPath: jsonPath))

var jsonDic = try JSONSerialization.jsonObject(with: dataJson , options: .allowFragments) as? [String : Any]

var relJsonDic : [String : Any ] = jsonDic ?? [:]

//得到名字
getAllname()

while(true){
    
    if let cname = relJsonDic["_class"] as? String , let name = relJsonDic["name"] as? String{
        
        if cname != "group" || name.contains("页面"){
            
            relJsonDic = (relJsonDic["layers"] as? [Any])?.first as? [String : Any] ?? [:]
            if relJsonDic.count == 0 {
                break
            }
        }  else {
            
            break
        }
    }
    
}



_  = getCreatParam(orJson: relJsonDic)

//var classCreatDic : [String : Any] = ["layers" : [["name":"UserLabel" ,"frame":["x":1,"y":3,"width":30,"height":30]]]]



func creatViwe(className:String , layers:[[String:Any]]){
    var str : String = ""
    var baseClass : String  = "UIView"
    
    for type in viewTypes {
        if className.contains(type) {
            var str = ""
            if type == "Image" {
                str = "UI\(type)View"
            }else if type == "CCell"{
                str = "UICollectionViewCell"
            } else if type == "TCell"{
                str = "UITableViewCell"
            } else{
                str = "UI\(type)"
            }
            baseClass = str
            break
        }
    }
    
    let cname = firstName(name: className)
    
    str.append("import UIKit \n")
    str.append("import SnapKit \n")
    str.append("class \(cname): \(baseClass) { \n")
    
    var sizeWidth : Int = 0 // group
    var sizeHeight : Int = 0
    
    let frame = creatFram[className] as? [String : Any]
    sizeWidth = frame?["width"] as? Int ?? 0
    sizeHeight = frame?["height"] as? Int ?? 0
    
    //插入属性
    for (i,val) in layers.enumerated() {
        
        let name = (val["name"] as? String) ?? ""
//        let cname = firstName(name: name)
        let key = name.lowercased() + String(i)
        
        var type = "UIView"
        if let g = val["hzl_G"] as? String {
            type = firstName(name: g)
        }
        
        str.append("  lazy var \(key) : \(type)  = { \n")
        str.append("    return \(type)() \n")
        str.append("  }() \n")
        
    }
    
    str.append("  override init(frame: CGRect) { \n")
    str.append("    super.init(frame: frame) \n")
    str.append("    creatUI() \n")
    str.append("  } \n")

    str.append("  func creatUI(){ \n")
    //插入逻辑
    
    for (i,val) in layers.enumerated() {
        if let f = val["frame"] as? [String : Any] , let name = val["name"] as? String{
            
            let key = (val["name"] as? String ?? "").lowercased() + String(i)
            str.append("    addSubview(\(key)) \n")
            
            
            
            let x  : Int = f["x"] as? Int ?? 0
            let y : Int = f["y"] as? Int ?? 0
            let width : Int = f["width"] as? Int ?? 0
            let height :Int = f["height"] as? Int ?? 0
            
            //属性
            str.append(creatViewAttr(json: val, key: key,width: CGFloat(width) ))
            if key.contains("label") {
                str.append(creatLabelAttr(json: val, key: key))
            }
            
            
            let rt = val["resizingConstraint"] as? Int ?? 63
            
            str.append("    \(key).snp.makeConstraints { make in \n")
            //方案一
//            if rt != 63 {
//                if checkRT(a: rt, b:.top ) {// s == "t"
//                    str.append("      make.top.equalTo(self.snp.top).offset(\(y)) \n")
//                }
//                if checkRT(a: rt, b: .bottom) {//s == "b"
//                    str.append("      make.bottom.equalTo(self.snp.bottom).offset(\(y + height - sizeHeight)) \n")
//                }
//                if checkRT(a: rt, b: .left) {//s == "l"
//                    str.append("      make.left.equalTo(self.snp.left).offset(\(x)) \n")
//                }
//                if checkRT(a: rt, b: .right) {//s == "r"
//                    str.append("      make.right.equalTo(self.snp.right).offset(\(x + width - sizeWidth)) \n")
//                }
//                if checkRT(a: rt, b: .hight) {//s == "h"
//                    str.append("      make.height.equalTo(\(height)) \n")
//                }
//                if checkRT(a: rt, b: .width) {//s == "w"
//                    str.append("      make.width.equalTo(\(width)) \n")
//                }
//            }
                        
            // 方案2  t b l r h w x y c e
            let nn = name.components(separatedBy: "_")
            if nn.count > 1 , let n = nn.last {
                for s in n {
                    if s == "t" {
                        str.append("      make.top.equalTo(self.snp.top).offset(\(y)) \n")
                    }else if s == "b" {
                        str.append("      make.bottom.equalTo(self.snp.bottom).offset(\(y + height - sizeHeight)) \n")
                    }else if s == "l" {
                        str.append("      make.left.equalTo(self.snp.left).offset(\(x)) \n")
                    }else if s == "r" {
                        str.append("      make.right.equalTo(self.snp.right).offset(\(x + width - sizeWidth)) \n")
                    }else if s == "h" {
                        str.append("      make.height.equalTo(\(height)) \n")
                    }else if s == "w" {
                        str.append("      make.width.equalTo(\(width)) \n")
                    }else if s == "x" {
                        str.append("      make.centerX.equalTo(self) \n")
                    }else  if s == "y" {
                        str.append("      make.centerY.equalTo(self) \n")
                    }else if s == "c" {
                        str.append("      make.center.equalTo(self) \n")
                    }else if s == "e" {
                        str.append("     //需要手动添加布局 \n")
                    }
                }
            }else {
                str.append("      make.top.equalTo(self.snp.top).offset(\(y)) \n")
                str.append("      make.left.equalTo(self.snp.left).offset(\(x)) \n")
                str.append("      make.width.equalTo(\(width)) \n")
                str.append("      make.height.equalTo(\(height)) \n")
            }
            
            
            str.append("    } \n")
 
//            str.append("    \(key).frame = CGRect.init(x: \(f["x"] ?? 0), y: \(f["y"] ?? 0), width: \(f["width"] ?? 0), height: \(f["height"] ?? 0)) \n")

        }
    }
    
    str.append("  } \n")
    
    str.append("  required init?(coder: NSCoder) { \n")
    str.append("    super.init(coder: coder) \n")
    str.append("  } \n")
    str.append("}") //end
    
    let file : FileManager = FileManager.default
    
    file.createFile(atPath: "\(path)View/\(cname).swift", contents:str.data(using: .utf8) ?? Data() , attributes: nil)
    
}

for (key,val) in creatDic {
    creatViwe(className: key, layers: val)
    creatAndroidViwe(className: key, layers: val)
}









