//
//  OneDayView.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

class OneDayView: UIView {
    lazy var weekLabel: UILabel = {
        let w = UILabel()
        w.font = KFontSystemSize10
        w.textAlignment = .center
        //w.text = "mounday"
        return w
    }()
    lazy var dateLabel: UILabel = {
        let d = UILabel()
        d.font = KFontSystemSize18
        d.textAlignment = .center
        //d.text = "18"
        return d
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(weekLabel)
        self.addSubview(dateLabel)
        weekLabel.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(KAdaptedHeight(x: 25))
        }
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weekLabel.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(KAdaptedHeight(x: 30))
            
        }
    }
    func reloadData(week:String,date:String){
        self.dateLabel.text = date
        self.weekLabel.text = week
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
