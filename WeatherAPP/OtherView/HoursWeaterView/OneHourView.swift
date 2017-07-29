//
//  OneHourView.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

class OneHourView: UIView {
    lazy var timeLabel: UILabel = {
        let t = UILabel()
        t.textColor = UIColor.init(rgba: "#FFFFFF")
        t.font = KFontSystemSize14
        t.textAlignment = .center
        return t
    }()
    lazy var weatherImageView: UIImageView = {
        let w = UIImageView()
        //w.image = UIImage(named: "zhongyu")
        return w
    }()
    lazy var temperatureLabel: UILabel = {
        let t = UILabel()
        t.font = KFontSystemSize14
        t.textColor = UIColor.init(rgba: "#FFFFFF")
        t.textAlignment = .center
        return t
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(timeLabel)
        self.addSubview(weatherImageView)
        self.addSubview(temperatureLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(KAdaptedHeight(x: 5))
            make.left.right.equalTo(0)
            make.height.equalTo(KAdaptedHeight(x: 20))
        }
        weatherImageView.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom)
            make.left.equalTo(KAdaptedHeight(x: 10))
            make.right.equalTo(KAdaptedHeight(x: -10))
            make.width.height.equalTo(KAdaptedHeight(x: 30))
        }
        temperatureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weatherImageView.snp.bottom).offset(5)
            make.left.equalTo(KAdaptedHeight(x: 12))
            make.right.equalTo(0)
            make.height.equalTo(20)
        }
    }
    func reloadDataForView(model:HoursWeaterItem){
        self.timeLabel.text = model.time
        self.temperatureLabel.text = "\(model.temp)°"
        self.weatherImageView.image = UIImage(named: returnWeatherImage(str: model.img))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
