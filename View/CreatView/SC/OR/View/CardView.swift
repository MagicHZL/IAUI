import UIKit 
import SnapKit 
class CardView: UIView { 
  lazy var cardiconimage_lthw0 : UIImageView  = { 
    return UIImageView() 
  }() 
  lazy var micview_lthw1 : MicView  = { 
    return MicView() 
  }() 
  lazy var nameview_lthw2 : NameView  = { 
    return NameView() 
  }() 
  override init(frame: CGRect) { 
    super.init(frame: frame) 
    creatUI() 
  } 
  func creatUI(){ 
    addSubview(cardiconimage_lthw0) 
    cardiconimage_lthw0.backgroundColor = UIColor.init(red: 0.847, green: 0.847, blue: 0.847, alpha: 1.0) 
    //cardiconimage_lthw0.theme_backgroundColor = "newColors.#D8D8D8" 
    cardiconimage_lthw0.clipsToBounds = true 
    cardiconimage_lthw0.layer.cornerRadius = 30.0 
    cardiconimage_lthw0.snp.makeConstraints { make in 
      make.left.equalTo(self.snp.left).offset(54) 
      make.top.equalTo(self.snp.top).offset(17) 
      make.height.equalTo(60) 
      make.width.equalTo(60) 
    } 
    addSubview(micview_lthw1) 
    micview_lthw1.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) 
    //micview_lthw1.theme_backgroundColor = "newColors.#000" 
    micview_lthw1.clipsToBounds = true 
    micview_lthw1.layer.cornerRadius = 4.0 
    micview_lthw1.snp.makeConstraints { make in 
      make.left.equalTo(self.snp.left).offset(143) 
      make.top.equalTo(self.snp.top).offset(4) 
      make.height.equalTo(20) 
      make.width.equalTo(20) 
    } 
    addSubview(nameview_lthw2) 
    nameview_lthw2.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) 
    //nameview_lthw2.theme_backgroundColor = "newColors.#000" 
    nameview_lthw2.clipsToBounds = true 
    nameview_lthw2.layer.cornerRadius = 4.0 
    nameview_lthw2.snp.makeConstraints { make in 
      make.left.equalTo(self.snp.left).offset(5) 
      make.top.equalTo(self.snp.top).offset(67) 
      make.height.equalTo(22) 
      make.width.equalTo(102) 
    } 
  } 
  required init?(coder: NSCoder) { 
    super.init(coder: coder) 
  } 
}