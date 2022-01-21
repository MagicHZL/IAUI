//
//  XlogModel.swift
//  CreatViewTest
//
//  Created by 忠良 on 2021/12/7.
//

import UIKit
import SwiftyJSON
import Alamofire
import AliyunOSSiOS

let KhlCachePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""

class XlogModel: NSObject {
    
    static var sourePath = KhlCachePath + "/xlog"
    
    var source : String = "appstore"
    var device : Int = 3
    var uuid : String = ""//UMConfigure.umidString()
    var session_id : String = ""//Defaults.sessionID
    var user_id : String = ""
    var version : String = ""
    var mtime : Int = 0
    var category : String = "" //此次针对语音
    var label : String = ""
    var value : JSON = JSON() //jsonStr
    
    override init() {
        super.init()
    }
    
    func xlog(la:String,va:[String:Any]) {
        
        self.label = la
        self.value = JSON(va)
        let xlogStr = "->" + self.toJsonString()
        print("xlogStr__\(xlogStr)")
        print(XlogModel.sourePath)
        XLogHelper.log(.debug, tag: "kaiheila", content: xlogStr)
        
    }
    
    func toJsonString() -> String {
        
        var json = JSON()
        json["source"] = JSON(source)
        json["device"] = JSON(device)
        json["uuid"] = JSON(uuid)
        json["session_id"] = JSON(session_id)
        json["user_id"] = JSON(user_id)
        json["version"] = JSON(version)
        json["mtime"] = JSON(mtime)
        json["category"] = JSON(category)
        json["label"] = JSON(label)
        json["value"] = value
        
        return json.rawString(options: .sortedKeys) ?? ""
    }
    
    
    class func upload(path:String){
        
        
        let uid = "576134093"
        let token = "60a3d9c98acaa5f566116a1ae2c82214cb78e432a8a4ead2bfe56056e7b0a664703-1638859817"
        
        let filePath = path
        
        if filePath.isEmpty {
            return
        }
        
        let fileUrl = URL.init(fileURLWithPath: filePath)
        let time = "\(Int(Date().timeIntervalSince1970 * 1000))"
        let md5Str = OSSUtil.fileMD5String(filePath) ?? ""
        
        if md5Str.isEmpty {
            return
        }
        
        let sign = "user=\(uid)&etag=\(md5Str)&time=\(time)"
        let signStr = OSSUtil.sha1(with: sign) ?? ""
        
        if signStr.isEmpty {
            return
        }
        
        print("sign__\(sign)__\(signStr)")
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(fileUrl, withName: "log")
            multipartFormData.append(time.data(using: .utf8)!, withName: "time")
            multipartFormData.append(signStr.data(using: .utf8)!, withName: "sign")
            
        },  usingThreshold: 0,to: "https://ttt.dev.chuanyuapp.com/api/v3/qos/experience-xlog", method: .post, headers: [
            "authorization":token,
            "user-agent":"KAIHEILA",
            "Content-Type":"form-data"
        ]) { result in
            
            switch result {
            
            case .success(let upload, _, _):
                upload
                    .uploadProgress { progress in
                        
                    }
                    .downloadProgress { progress in }
                    .responseString { response in
                        
                        let json = JSON.init(parseJSON: response.result.value ?? "")
                        print(json)
                        
                        delectPath(path: filePath)
                    }
            
            case .failure(let error):
                
                print(error)
                break
            }
            
        }
        
    }
    
    
    class func getYesterFile() -> String {
        
        let yesterStr = getYesterName()
        let paths = getLogs()
        for p in paths {
            if p.contains(yesterStr) {
                return sourePath + "/" + p
            }
        }
        return ""
    }
    
    class func getYesterName() -> String {

        let time = Date().timeIntervalSince1970
        let yester = time - 24 * 60 * 60
        let yesterStr =  khl_time(timev: yester,"yyyyMMdd")
        return yesterStr
    }
    
    class func getCurName() -> String {
        
        let time = Date().timeIntervalSince1970
        let curStr =  khl_time(timev: time,"yyyyMMdd")
        return curStr
    }
    
    class func testPath() -> String {
        
        return sourePath + "/kaihiela_20211204.xlog"
    }
    
    class func getLogs() -> [String] {
        
        let fileM = FileManager.default
        let strs = (try? fileM.contentsOfDirectory(atPath: sourePath)) ?? []
        
        let relStrs = strs.filter { val in
            return val.contains(".xlog")
        }
        print(relStrs)
        return relStrs
        
    }
    
    class func test(){
   
        upload(path: getYesterFile())
    }
    
    class func getOldLogNames() -> [String] {

        var olds : [String] = []
        
        let curName = getCurName()
        let yesterStr = getYesterName()
        let paths = getLogs()

        for p in paths {
            if !p.contains(curName),!p.contains(yesterStr) {
                olds.append(p)
            }
        }
        
        print(olds)
        return olds
        
    }
    
    
    class func khl_time(timev:TimeInterval,_ format:String = "yyyy-MM-dd HH:mm:ss:SSS") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date.init(timeIntervalSince1970: timev))
    }
    
    class func delectPath(path:String){
        let fileM = FileManager.default
        try? fileM.removeItem(atPath: path)
    }
    
    class func setupXlog(){
        //初始化
        XLogHelper.initKHXlogger()
        uploadY()
        uplodaO()
    }
    
    class func uploadY(){
        
//        if wifi {
            upload(path: getYesterFile())
//        }
        
    }
    
    class func uplodaO(){
            
        let olds = getOldLogNames()
        
        let oldPaths = olds.map { val in
            return sourePath + "/" + val
        }

        for p in oldPaths {
            upload(path: p)
        }
        
    }
    
    class func checkPath(path:String) -> Bool {
        
        let file = FileManager.default
        return file.fileExists(atPath: path)
    }
    
}


class XlogVoiceModel : XlogModel {
    
    override func xlog(la: String, va: [String:Any]) {
        self.category = "voice"
        super.xlog(la: la, va: va)

    }
    
}
