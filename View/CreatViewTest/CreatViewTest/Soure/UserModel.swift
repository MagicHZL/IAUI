import Foundation 
import SwiftyJSON 
class UserModel: HZModelProtocol {
    static var url: String = ""
    init() {
    }
    var online : Bool = false
    var avatar : String = ""
    var roles : JSON = JSON()
    var nickname : String = ""
    var is_vip : Bool = false
    var id : String = ""
    var status : Int = 0
    var identify_num : String = ""
    var vip_avatar : String = ""
    var os : String = ""
    var username : String = ""
    var bot : Bool = false
    var banner : String = ""
    var tag_info : JSON = JSON()
    required init(json: JSON) {
        online = json["online"].boolValue
        avatar = json["avatar"].stringValue
        roles = json["roles"]
        nickname = json["nickname"].stringValue
        is_vip = json["is_vip"].boolValue
        id = json["id"].stringValue
        status = json["status"].intValue
        identify_num = json["identify_num"].stringValue
        vip_avatar = json["vip_avatar"].stringValue
        os = json["os"].stringValue
        username = json["username"].stringValue
        bot = json["bot"].boolValue
        banner = json["banner"].stringValue
        tag_info = json["tag_info"]
    }
    //复制自己
    func copySelf() -> UserModel {
        var mo = UserModel()
        mo.online = self.online
        mo.avatar = self.avatar
        mo.roles = self.roles
        mo.nickname = self.nickname
        mo.is_vip = self.is_vip
        mo.id = self.id
        mo.status = self.status
        mo.identify_num = self.identify_num
        mo.vip_avatar = self.vip_avatar
        mo.os = self.os
        mo.username = self.username
        mo.bot = self.bot
        mo.banner = self.banner
        mo.tag_info = self.tag_info
        return mo
    }
    //转为JSON
    func toJson() -> JSON {
        var json = JSON()
        json["online"] = JSON.init(online)
        json["avatar"] = JSON.init(avatar)
        json["roles"] = JSON.init(roles)
        json["nickname"] = JSON.init(nickname)
        json["is_vip"] = JSON.init(is_vip)
        json["id"] = JSON.init(id)
        json["status"] = JSON.init(status)
        json["identify_num"] = JSON.init(identify_num)
        json["vip_avatar"] = JSON.init(vip_avatar)
        json["os"] = JSON.init(os)
        json["username"] = JSON.init(username)
        json["bot"] = JSON.init(bot)
        json["banner"] = JSON.init(banner)
        json["tag_info"] = JSON.init(tag_info)
        return json
    }
    
}
