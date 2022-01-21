//
//  Android.swift
//  CreatView
//
//  Created by 忠良 on 2021/11/16.
//

import Foundation

func creatAndroidViwe(className:String , layers:[[String:Any]]){
    
    var androidStr = ""
    
    let cname = firstName(name: className)
    
    androidStr.append("<?xml version=\"1.0\" encoding=\"utf-8\"?> \n")
    androidStr.append("<androidx.constraintlayout.widget.ConstraintLayout xmlns:android=\"http://schemas.android.com/apk/res/android\" \n")
    androidStr.append("  android:layout_width=\"match_parent\" \n")
    androidStr.append("  android:layout_height=\"match_parent\" \n")
    androidStr.append("  xmlns:app=\"http://schemas.android.com/apk/res-auto\"> \n")
    
    
    var sizeWidth : Int = 0 // group
    var sizeHeight : Int = 0
    
    let frame = creatFram[className] as? [String : Any]
    sizeWidth = frame?["width"] as? Int ?? 0
    sizeHeight = frame?["height"] as? Int ?? 0
    
    //插入逻辑
    
    for (i,val) in layers.enumerated() {
    
                
        if let f = val["frame"] as? [String : Any] , let name = val["name"] as? String{
            
            func creatLayout(){
                
                let x  : Int = f["x"] as? Int ?? 0
                let y : Int = f["y"] as? Int ?? 0
                let width : Int = f["width"] as? Int ?? 0
                let height :Int = f["height"] as? Int ?? 0

//                if key.contains("label") {
//                    str.append(creatLabelAttr(json: val, key: key))
//                }
            
                // 方案2  t b l r h w x y c e
                let nn = name.components(separatedBy: "_")
                if nn.count > 1 , let n = nn.last {
                    for s in n {
                        if s == "t" {
                            androidStr.append("    app:layout_constraintTop_toTopOf=\"parent\" \n    android:layout_marginTop=\"\(y)dp\" \n")
                        }else if s == "b" {
                            androidStr.append("    app:layout_constraintBottom_toBottomOf=\"parent\" \n   android:layout_marginBottom=\"\(y + height - sizeHeight)dp\" \n")
                        }else if s == "l" {
                            androidStr.append("    app:layout_constraintLeft_toLeftOf=\"parent\" \n    android:layout_marginLeft=\"\(x)dp\" \n")
                        }else if s == "r" {
                            androidStr.append("    app:layout_constraintRight_toRightOf=\"parent\" \n   android:layout_marginRight=\"\(x + width - sizeWidth)dp\") \n")
                        }else if s == "h" {
                            androidStr.append("    android:layout_height=\"\(height)dp\"\n")
                        }else if s == "w" {
                            androidStr.append("    android:layout_width=\"\(width)dp\" \n")
                        }else if s == "x" {
//                            androidStr.append("      make.centerX.equalTo(self) \n")
                        }else  if s == "y" {
//                            androidStr.append("      make.centerY.equalTo(self) \n")
                        }else if s == "c" {
//                            androidStr.append("      make.center.equalTo(self) \n")
                        }else if s == "e" {
                            androidStr.append("     <!--需要手动添加布局--> \n")
                        }
                    }
                    
                }
    
            }
            
            let key = (name).lowercased() + String(i)

            var type = androidGetType(name: firstName(name: name))
            
            if let g = val["hzl_A"] as? String {
                
                type = firstName(name: g)
                
                androidStr.append("  <FrameLayout \n")
                
//                androidStr.append("android:layout_width=\"match_parent\"")
//                androidStr.append("android:layout_height=\"match_parent\"")
                creatLayout()
                androidStr.append(creatAndroidAttr(json: val, key: key, width: CGFloat(sizeWidth)))

                androidStr.append("   > \n")
                androidStr.append("  <include \n")
                androidStr.append("    android:id=\"@+id/\(key)\" \n")
                
                let lowt = lowType(name: type)
                var atype = type.replacingOccurrences(of:lowt, with: "_\(lowt)")
                atype = atype.lowercased()
                androidStr.append("    layout=\"@layout/\(atype)\"")
                androidStr.append("  /> \n")
                androidStr.append("  </FrameLayout> \n")
                
            }else{
                androidStr.append("  <\(type) \n")
                androidStr.append("    android:id=\"@+id/\(key)\"")
//                androidStr.append("android:layout_width=\"match_parent\"")
//               crea androidStr.append("android:layout_height=\"match_parent\"")
                creatLayout()
                androidStr.append(creatAndroidAttr(json: val, key: key, width: CGFloat(sizeWidth)))
                if type == "TextView" {
                    androidStr.append(creatAndroidLabelAttr(json: val, key: key))
                }
                
                androidStr.append("  /> \n")
            }

        }
    }
//
//    str.append("  } \n")
//
//    str.append("  required init?(coder: NSCoder) { \n")
//    str.append("    super.init(coder: coder) \n")
//    str.append("  } \n")
//    str.append("}") //end
    
    androidStr.append("</androidx.constraintlayout.widget.ConstraintLayout>")
    
    var lowt = lowType(name: cname)
    var acname = cname.replacingOccurrences(of: lowt, with: "_\(lowt)")
    
    acname = acname.lowercased()
    
    let file : FileManager = FileManager.default
    
    file.createFile(atPath: "\(path)Android/\(acname).xml", contents:androidStr.data(using: .utf8) ?? Data() , attributes: nil)
    
}



