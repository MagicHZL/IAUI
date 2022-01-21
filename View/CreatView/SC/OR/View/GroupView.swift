import UIKit 
import SnapKit 
class GroupView: UIView { 
  lazy var cardview_lthw0 : CardView  = { 
    return CardView() 
  }() 
  lazy var bgview_lthw1 : UIView  = { 
    return UIView() 
  }() 
  lazy var userimage_lthw2 : UIImageView  = { 
    return UIImageView() 
  }() 
  override init(frame: CGRect) { 
    super.init(frame: frame) 
    creatUI() 
  } 
  func creatUI(){ 
    addSubview(cardview_lthw0) 
    cardview_lthw0.backgroundColor = UIColor.init(red: 0.1098039215686274, green: 0.1176470588235294, blue: 0.1294117647058823, alpha: 1.0) 
    //cardview_lthw0.theme_backgroundColor = "newColors.#1C1E21" 
    cardview_lthw0.clipsToBounds = true 
    cardview_lthw0.layer.cornerRadius = 6.0 
    cardview_lthw0.snp.makeConstraints { make in 
      make.left.equalTo(self.snp.left).offset(8) 
      make.top.equalTo(self.snp.top).offset(118) 
      make.height.equalTo(94) 
      make.width.equalTo(167) 
    } 
    addSubview(bgview_lthw1) 
    bgview_lthw1.backgroundColor = UIColor.init(red: 0.3309233988077239, green: 0.4732483327628957, blue: 0.6867357336956522, alpha: 1.0) 
    //bgview_lthw1.theme_backgroundColor = "newColors.#5479AF" 
    bgview_lthw1.clipsToBounds = true 
    bgview_lthw1.layer.cornerRadius = 6.0 
    bgview_lthw1.snp.makeConstraints { make in 
      make.left.equalTo(self.snp.left).offset(8) 
      make.top.equalTo(self.snp.top).offset(221) 
      make.height.equalTo(77) 
      make.width.equalTo(167) 
    } 
    addSubview(userimage_lthw2) 
    userimage_lthw2.backgroundColor = UIColor.init(red: 0.847, green: 0.847, blue: 0.847, alpha: 1.0) 
    //userimage_lthw2.theme_backgroundColor = "newColors.#D8D8D8" 
    userimage_lthw2.clipsToBounds = true 
    userimage_lthw2.layer.cornerRadius = 30.0 
    userimage_lthw2.snp.makeConstraints { make in 
      make.left.equalTo(self.snp.left).offset(61) 
      make.top.equalTo(self.snp.top).offset(229) 
      make.height.equalTo(60) 
      make.width.equalTo(60) 
    } 
  } 
  required init?(coder: NSCoder) { 
    super.init(coder: coder) 
  } 
}