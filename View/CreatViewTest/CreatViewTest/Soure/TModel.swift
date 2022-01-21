import Foundation 
import SwiftyJSON 
class TModel: HZModelProtocol {
    static var url: String = "11"
    
 init() { 
  } 
  var is_official_partner : Int = 0 
  var tag : String = "" 
  var guild_id : String = "" 
  var sort : Int = 0 
  var icon : String = "" 
  var custom_id : String = "" 
  var heat : Int = 0 
  var online_count : String = "" 
  var members_count : Int = 0 
  var desc : String = "" 
  var name : String = "" 
  var features : [FeaModel] = [] 
  var update_day_gap : Int = 0 
  var audit_status : Int = 0 
  var level : Int = 0 
  var banner : String = "" 
  var open_id : String = "" 
  var default_channel_id : String = "" 
  var status : Int = 0 
  required init(json: JSON) { 
    is_official_partner = json["is_official_partner"].intValue 
    tag = json["tag"].stringValue 
    guild_id = json["guild_id"].stringValue 
    sort = json["sort"].intValue 
    icon = json["icon"].stringValue 
    custom_id = json["custom_id"].stringValue 
    heat = json["heat"].intValue 
    online_count = json["online_count"].stringValue 
    members_count = json["members_count"].intValue 
    desc = json["desc"].stringValue 
    name = json["name"].stringValue 
    features = FeaModel.getModes(jsons: json["features"].arrayValue)
    update_day_gap = json["update_day_gap"].intValue 
    audit_status = json["audit_status"].intValue 
    level = json["level"].intValue 
    banner = json["banner"].stringValue 
    open_id = json["open_id"].stringValue 
    default_channel_id = json["default_channel_id"].stringValue 
    status = json["status"].intValue 
  } 
//复制自己 
  func copySelf() -> TModel { 
    var mo = TModel() 
    mo.is_official_partner = self.is_official_partner 
    mo.tag = self.tag 
    mo.guild_id = self.guild_id 
    mo.sort = self.sort 
    mo.icon = self.icon 
    mo.custom_id = self.custom_id 
    mo.heat = self.heat 
    mo.online_count = self.online_count 
    mo.members_count = self.members_count 
    mo.desc = self.desc 
    mo.name = self.name 
    mo.features = self.features 
    mo.update_day_gap = self.update_day_gap 
    mo.audit_status = self.audit_status 
    mo.level = self.level 
    mo.banner = self.banner 
    mo.open_id = self.open_id 
    mo.default_channel_id = self.default_channel_id 
    mo.status = self.status 
    return mo 
  }
//转为JSON 
  func toJson() -> JSON { 
    var json = JSON() 
    json["is_official_partner"] = JSON.init(is_official_partner) 
    json["tag"] = JSON.init(tag) 
    json["guild_id"] = JSON.init(guild_id) 
    json["sort"] = JSON.init(sort) 
    json["icon"] = JSON.init(icon) 
    json["custom_id"] = JSON.init(custom_id) 
    json["heat"] = JSON.init(heat) 
    json["online_count"] = JSON.init(online_count) 
    json["members_count"] = JSON.init(members_count) 
    json["desc"] = JSON.init(desc) 
    json["name"] = JSON.init(name) 
    var features_mos : [JSON] =  [] 
    for val in features { 
       features_mos.append(val.toJson())
    } 
    json["features"] = JSON(features_mos) 
    json["update_day_gap"] = JSON.init(update_day_gap) 
    json["audit_status"] = JSON.init(audit_status) 
    json["level"] = JSON.init(level) 
    json["banner"] = JSON.init(banner) 
    json["open_id"] = JSON.init(open_id) 
    json["default_channel_id"] = JSON.init(default_channel_id) 
    json["status"] = JSON.init(status) 
    return json 
  }
}
