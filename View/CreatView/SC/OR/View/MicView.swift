import UIKit 
import SnapKit 
class MicView: UIView { 
  lazy var miciconimage_lthw0 : UIImageView  = { 
    return UIImageView() 
  }() 
  override init(frame: CGRect) { 
    super.init(frame: frame) 
    creatUI() 
  } 
  func creatUI(){ 
    addSubview(miciconimage_lthw0) 
    miciconimage_lthw0.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0) 
    //miciconimage_lthw0.theme_backgroundColor = "newColors.#0000" 
    miciconimage_lthw0.snp.makeConstraints { make in 
      make.left.equalTo(self.snp.left).offset(2) 
      make.top.equalTo(self.snp.top).offset(2) 
      make.height.equalTo(16) 
      make.width.equalTo(16) 
    } 
  } 
  required init?(coder: NSCoder) { 
    super.init(coder: coder) 
  } 
}