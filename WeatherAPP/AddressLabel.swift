//
//  AddressLabel.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

class AddressLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .center
        self.textColor = UIColor.white
        self.font = KFontSystemSize28
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
