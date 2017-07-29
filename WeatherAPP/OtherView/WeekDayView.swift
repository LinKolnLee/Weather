//
//  WeekDayView.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

class WeekDayView: UIView {
    lazy var lineView: UIView = {
        let l = UIView()
        l.backgroundColor = UIColor.init(rgba: "#DBDBDB")
        return l
    }()
    lazy var dateButton: UIButton = {
        let d = UIButton()
        d.backgroundColor = UIColor.init(rgba: "#FFFFFF")
        d.alpha = 0.3
        d.setTitleColor(UIColor.black, for: .normal)
        d.titleLabel?.font = KFontSystemSize14;
        d.layer.cornerRadius = 13
        d.layer.shadowOffset = CGSize(width: 1, height: 1)
        d.layer.shadowOpacity = 0.8
        d.layer.shadowColor = UIColor.black.cgColor
        return d
    }()
    lazy var temperatureBtn: UIButton = {
        let t = UIButton()
        t.setImage(UIImage(named: "thermometerNormal"), for: .normal)
        t.setImage(UIImage(named: "thermometerSelector"), for: .selected)
        return t
    }()
    lazy var humidityBtn: UIButton = {
        let t = UIButton()
        t.setImage(UIImage(named: "humidityNormal"), for: .normal)
        t.setImage(UIImage(named: "humiditySelector"), for: .selected)
        return t
    }()
    lazy var rainBtn: UIButton = {
        let t = UIButton()
        t.setImage(UIImage(named: "rainNormal"), for: .normal)
        t.setImage(UIImage(named: "rainSelector"), for: .selected)
        return t
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(dateButton)
        self.addSubview(lineView)
        self.addSubview(temperatureBtn)
        self.addSubview(humidityBtn)
        self.addSubview(rainBtn)
        dateButton.snp.makeConstraints { (make) in
            make.left.equalTo(KAdaptedHeight(x: 15))
            make.top.equalTo(KAdaptedHeight(x: 8))
            make.width.equalTo(KAdaptedHeight(x: 80))
            make.height.equalTo(KAdaptedHeight(x: 25))
        }
        temperatureBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateButton.snp.centerY)
            make.right.equalTo(KAdaptedHeight(x: -90))
            make.width.height.equalTo(KAdaptedHeight(x: 20))
        }
        humidityBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(temperatureBtn.snp.centerY)
            make.left.equalTo(temperatureBtn.snp.right).offset(KAdaptedHeight(x: 15))
            make.width.height.equalTo(KAdaptedHeight(x: 20))
        }
        rainBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(humidityBtn.snp.centerY)
            make.left.equalTo(humidityBtn.snp.right).offset(KAdaptedHeight(x: 15))
            make.width.height.equalTo(humidityBtn.snp.width)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(KAdaptedHeight(x: 15))
            make.right.equalTo(KAdaptedHeight(x: -15))
            make.bottom.equalTo(KAdaptedHeight(x: -1))
            make.height.equalTo(KAdaptedHeight(x: 1))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func reloadDataForMain(date:String,weather:String){
        self.dateButton.setTitle(date, for: .normal)
        if weather == "1"{
            self.temperatureBtn.isSelected = true
        }else{
            self.rainBtn.isSelected = true
        }
    }
}
