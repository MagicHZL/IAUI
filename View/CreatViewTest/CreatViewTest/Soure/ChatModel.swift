import Foundation 
import SwiftyJSON 
class ChatModel: HZModelProtocol {
    static var url: String = ""
    
 init() { 
  } 
  var target_info : UserModel = UserModel() 
  var last_read_time : Int = 0 
  var ws_type : Int = 0 
  var last_msg_content : String = "" 
  var code : String = "" 
  var latest_msg_time : Int = 0 
  var unread_count : Int = 0 
  required init(json: JSON) { 
    target_info = UserModel(json: json["target_info"]) 
    last_read_time = json["last_read_time"].intValue 
    ws_type = json["ws_type"].intValue 
    last_msg_content = json["last_msg_content"].stringValue 
    code = json["code"].stringValue 
    latest_msg_time = json["latest_msg_time"].intValue 
    unread_count = json["unread_count"].intValue 
  } 
//复制自己 
  func copySelf() -> ChatModel { 
    var mo = ChatModel() 
    mo.target_info = self.target_info 
    mo.last_read_time = self.last_read_time 
    mo.ws_type = self.ws_type 
    mo.last_msg_content = self.last_msg_content 
    mo.code = self.code 
    mo.latest_msg_time = self.latest_msg_time 
    mo.unread_count = self.unread_count 
    return mo 
  }
//转为JSON 
  func toJson() -> JSON { 
    var json = JSON() 
    json["target_info"] = target_info.toJson() 
    json["last_read_time"] = JSON.init(last_read_time) 
    json["ws_type"] = JSON.init(ws_type) 
    json["last_msg_content"] = JSON.init(last_msg_content) 
    json["code"] = JSON.init(code) 
    json["latest_msg_time"] = JSON.init(latest_msg_time) 
    json["unread_count"] = JSON.init(unread_count) 
    return json 
  }
}
