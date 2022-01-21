import UIKit 
import SnapKit 
class NameView: UIView { 
  lazy var textlabel_lthw0 : UILabel  = { 
    return UILabel() 
  }() 
  override init(frame: CGRect) { 
    super.init(frame: frame) 
    creatUI() 
  } 
  func creatUI(){ 
    addSubview(textlabel_lthw0) 
    textlabel_lthw0.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0) 
    //textlabel_lthw0.theme_backgroundColor = "newColors.#0000" 
    textlabel_lthw0.font = UIFont.init(name: "PingFangSC-Medium", size: 12) 
    textlabel_lthw0.textColor = UIColor.init(red: 0.9019607843137255, green: 0.9176470588235294, blue: 0.9411764705882353, alpha: 1.0) 
    //textlabel_lthw0.theme_textColor = "newColors.#E6EAF0" 
    textlabel_lthw0.text = "啦1232222啦啦" 
    textlabel_lthw0.snp.makeConstraints { make in 
      make.left.equalTo(self.snp.left).offset(5) 
      make.top.equalTo(self.snp.top).offset(4) 
      make.height.equalTo(12) 
      make.width.equalTo(87) 
    } 
  } 
  required init?(coder: NSCoder) { 
    super.init(coder: coder) 
  } 
}