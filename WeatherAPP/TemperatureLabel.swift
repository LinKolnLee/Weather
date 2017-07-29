//
//  TemperatureLabel.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

class TemperatureLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .center
        self.textColor = UIColor.white
        self.font = KFontSystemSize38
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
