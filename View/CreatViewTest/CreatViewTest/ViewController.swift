//
//  ViewController.swift
//  CreatViewTest
//
//  Created by 忠良 on 2021/11/12.
//

func randColor() -> UIColor {
    return UIColor.init(red:CGFloat(arc4random_uniform(255))/CGFloat(255.0), green:CGFloat(arc4random_uniform(255))/CGFloat(255.0), blue:CGFloat(arc4random_uniform(255))/CGFloat(255.0) , alpha: 1)
}

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
   
//
//    var table : UITableView = UITableView.init(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let popView = hao.init()
//        view.addSubview(table)
//        table.snp.makeConstraints { make in
//            make.edges.equalTo(view).inset(UIEdgeInsets.zero)
//        }
//        table.register(ACell.self, forCellReuseIdentifier: "A")
//        table.dataSource = self
        
        
//        var xlog = XlogVoiceModel()
//
//        xlog.xlog(la: "11", va: JSON(["1":"2"]))

//        XlogModel.upload()
        
        XlogModel.test()

        
    }


    @IBAction func btnAction(_ sender: Any) {

        self.present(HhhhController(), animated: true) {
            
        }
        
    }
    
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "A", for: indexPath) as! ACell
//
//        var mo = TestModel(json: JSON())
//        cell.vc = self
//        cell.mo = mo
//
//        return cell
//    }
    
    
    
    
}

