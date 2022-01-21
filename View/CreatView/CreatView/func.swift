//
//  func.swift
//  CreatView
//
//  Created by 忠良 on 2021/11/12.
//

import Foundation


//sketch resizingConstraint
/*
 59l 31t 62r 55b  61w  47h
 */

enum RT : Int{

    case left = 59
    case top = 31
    case right = 62
    case bottom = 55
    case width = 61
    case hight = 47

}

func checkRT(a:Int,b:RT) -> Bool{
    return (a & b.rawValue) == b.rawValue
}


func creatViewAttr(json:[String:Any],key:String,width:CGFloat) -> String{
    
    var str = ""
    var cr : CGFloat = 0
   
    
    let style = json["style"] as? [String : Any]  ?? [:]
    let fill = (style["fills"] as? [[String : Any]])?.first ?? [:]
    let color = fill["color"] as? [String : Any] ?? [:]
    var r : CGFloat = 0
    var g : CGFloat = 0
    var b : CGFloat = 0
    var a : CGFloat = 0
    r = color["red"] as? CGFloat ?? 0
    g = color["green"] as? CGFloat ?? 0
    b = color["blue"] as? CGFloat ?? 0
    a = color["alpha"] as? CGFloat ?? 0
    let point = (json["points"] as? [[String : Any]])?.first ??  [:]
    cr = point["cornerRadius"] as? CGFloat ?? 0
    
    if let cl = json["_class"] as? String ,cl == "oval" {
        cr = width / 2
    }
    
    str.append("    \(key).backgroundColor = UIColor.init(red: \(r), green: \(g), blue: \(b), alpha: \(a)) \n")
    str.append("    //\(key).theme_backgroundColor = \"newColors.\(rgbaToHex(r: r, g: g, b: b, a: a))\" \n")
    
    if cr > 0 {
        str.append("    \(key).clipsToBounds = true \n")
        str.append("    \(key).layer.cornerRadius = \(cr) \n")
    }
    
    return str
}

func creatLabelAttr(json:[String:Any],key:String) -> String{
    var str = ""
    
    var attributedString = json["attributedString"] as? [String:Any] ?? [:]
    
    var cont = attributedString["string"] as? String ?? ""
    
    var attributes = (attributedString["attributes"] as? [[String : Any]])?.first?["attributes"] as? [String : Any] ?? [:]
    
    var MSAttributedStringFontAttribute = (attributes["MSAttributedStringFontAttribute"] as? [String:Any])?["attributes"] as? [String : Any] ?? [:]
    var MSAttributedStringColorAttribute = attributes["MSAttributedStringColorAttribute"] as? [String:Any] ?? [:]
    var font = MSAttributedStringFontAttribute["name"] as? String ?? ""
    var size = MSAttributedStringFontAttribute["size"] as? Int ?? 0
    
    var r : CGFloat = 0
    var g : CGFloat = 0
    var b : CGFloat = 0
    var a : CGFloat = 0
    r = MSAttributedStringColorAttribute["red"] as? CGFloat ?? 0
    g = MSAttributedStringColorAttribute["green"] as? CGFloat ?? 0
    b = MSAttributedStringColorAttribute["blue"] as? CGFloat ?? 0
    a = MSAttributedStringColorAttribute["alpha"] as? CGFloat ?? 0
    
    str.append("    \(key).font = UIFont.init(name: \"\(font)\", size: \(size)) \n")
    str.append("    \(key).textColor = UIColor.init(red: \(r), green: \(g), blue: \(b), alpha: \(a)) \n")
    str.append("    //\(key).theme_textColor = \"newColors.\(rgbaToHex(r: r, g: g, b: b, a: a))\" \n")
    str.append("    \(key).text = \"\(cont)\" \n")
    
    return str
}



func rgbaToHex(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> String{
    
    var h1 = String(Int(round(r * 255)),radix: 16)
    var h2 = String(Int(round(g * 255)),radix: 16)
    var h3 = String(Int(round(b * 255)),radix: 16)
    
    if a < 1 {
        var a = String(Int(round(a * 255)),radix: 16)
        print(("#" + h1 + h2 + h3 + a).uppercased())
        return ("#" + h1 + h2 + h3 + a).uppercased()
    }
    print(("#" + h1 + h2 + h3).uppercased())
    return ("#" + h1 + h2 + h3).uppercased()
    
}


func androidRgbaToHex(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> String{
    
    var h1 = String(Int(round(r * 255)),radix: 16)
    var h2 = String(Int(round(g * 255)),radix: 16)
    var h3 = String(Int(round(b * 255)),radix: 16)
    
    if a < 1 {
        var a = String(Int(round(a * 255)),radix: 16)
        print(("#" + a + h1 + h2 + h3 ).uppercased())
        return ("#" + a + h1 + h2 + h3 ).uppercased()
    }
    print(("#" + h1 + h2 + h3).uppercased())
    return ("#" + h1 + h2 + h3).uppercased()
    
}




func creatAndroidAttr(json:[String:Any],key:String,width:CGFloat) -> String{
    
    var str = ""
    var cr : CGFloat = 0
   
    let style = json["style"] as? [String : Any]  ?? [:]
    let fill = (style["fills"] as? [[String : Any]])?.first ?? [:]
    let color = fill["color"] as? [String : Any] ?? [:]
    var r : CGFloat = 0
    var g : CGFloat = 0
    var b : CGFloat = 0
    var a : CGFloat = 0
    r = color["red"] as? CGFloat ?? 0
    g = color["green"] as? CGFloat ?? 0
    b = color["blue"] as? CGFloat ?? 0
    a = color["alpha"] as? CGFloat ?? 0
    let point = (json["points"] as? [[String : Any]])?.first ??  [:]
    cr = point["cornerRadius"] as? CGFloat ?? 0

    if let cl = json["_class"] as? String ,cl == "oval" {
        cr = width / 2
    }
    
    if cr > 0 {
        
        str.append("    android:background=\"@drawable/\(key)_radius\" \n")
        creatCornerRadiusXml(key: key, color: androidRgbaToHex(r: r, g: g, b: b, a: a), radius: cr)
    }else{
        
        str.append("    android:background=\"\(androidRgbaToHex(r: r, g: g, b: b, a: a))\" \n")
    }
    
    return str
}

func creatAndroidLabelAttr(json:[String:Any],key:String) -> String{
    var str = ""
    
    var attributedString = json["attributedString"] as? [String:Any] ?? [:]
    
    var cont = attributedString["string"] as? String ?? ""
    
    var attributes = (attributedString["attributes"] as? [[String : Any]])?.first?["attributes"] as? [String : Any] ?? [:]
    
    var MSAttributedStringFontAttribute = (attributes["MSAttributedStringFontAttribute"] as? [String:Any])?["attributes"] as? [String : Any] ?? [:]
    var MSAttributedStringColorAttribute = attributes["MSAttributedStringColorAttribute"] as? [String:Any] ?? [:]
    var font = MSAttributedStringFontAttribute["name"] as? String ?? ""
    var size = MSAttributedStringFontAttribute["size"] as? Int ?? 0
    
    var r : CGFloat = 0
    var g : CGFloat = 0
    var b : CGFloat = 0
    var a : CGFloat = 0
    r = MSAttributedStringColorAttribute["red"] as? CGFloat ?? 0
    g = MSAttributedStringColorAttribute["green"] as? CGFloat ?? 0
    b = MSAttributedStringColorAttribute["blue"] as? CGFloat ?? 0
    a = MSAttributedStringColorAttribute["alpha"] as? CGFloat ?? 0
    
    str.append("    android:textSize=\"\(size)sp\" \n")
    str.append("    android:textColor=\"\(androidRgbaToHex(r: r, g: g, b: b, a: a))\" \n")
    str.append("    android:text=\"\(cont)\" \n")
    
    return str
}



func creatCornerRadiusXml(key:String,color:String,radius:CGFloat){
    
    let str = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<shape xmlns:android=\"http://schemas.android.com/apk/res/android\"\nandroid:shape=\"rectangle\"\n>\n<corners android:radius=\"\(radius)dp\"/>\n<solid android:color=\"\(color)\" />\n</shape>\n"
    
    let file : FileManager = FileManager.default
    
    file.createFile(atPath: "\(path)Android/radius/\(key)_radius.xml", contents:str.data(using: .utf8) ?? Data() , attributes: nil)
    
}

func androidGetType(name:String) -> String{
    
    for type in viewTypes {
        if name.contains(type) {
            if type == "Image" {
                return "\(type)View"
            }else if type == "Label"{
                return "TextView"
             } else{
                return type
            }
        }
    }
    
    return "View"
}

func lowType(name:String) -> String{
    
    for type in viewTypes {
        if name.contains(type) {
            return type
        }
    }
    return "View"
}

