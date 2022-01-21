import Foundation 
import SwiftyJSON 
class FeaModel: HZModelProtocol {
    static var url: String = ""
    
 init() { 
  } 
  required init(json: JSON) { 
  } 
//复制自己 
  func copySelf() -> FeaModel { 
    var mo = FeaModel() 
    return mo 
  }
//转为JSON 
  func toJson() -> JSON { 
    var json = JSON() 
    return json 
  }
}
