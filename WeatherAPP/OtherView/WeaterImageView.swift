//
//  WeaterImageView.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

class WeaterImageView: UIView {
    lazy var weatherImage: UIImageView = {
        let w = UIImageView()
        return w
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(weatherImage)
        weatherImage.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    func reloadDataForMain(weather:String){
        let image = returnWeatherImage(str: weather)
        self.weatherImage.image = UIImage(named: image)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
