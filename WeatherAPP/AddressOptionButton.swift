//
//  AddressOptionButton.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

class AddressOptionButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImage(UIImage(named: "adressOptionButton"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
