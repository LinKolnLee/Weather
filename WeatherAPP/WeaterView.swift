//
//  WeaterView.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit
import SnapKit
import URWeatherView
class WeaterView: UIView {
    var mainView :URWeatherView!

    lazy var backImageView: UIImageView = {
        let b = UIImageView()
        b.isUserInteractionEnabled = true
        return b
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func reloadDataForMain(type:URWeatherType){
        let now = NSDate()
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        dformatter.dateFormat = "HH:mm:ss"
        let nowDate = dformatter.string(from: now as Date)
        let dateArr = nowDate.components(separatedBy: ":")
        let hours = Int(dateArr.first!)
        
        mainView = URWeatherView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        if hours! > 6 && hours! < 18{
             mainView.initView(mainWeatherImage:UIImage(named: "sun_1.png")!, backgroundImage: UIImage(named: "sun_1.png"))
        }else if hours! >= 18 && hours! < 21{
             mainView.initView(mainWeatherImage: UIImage(named: "moon-1")!, backgroundImage: UIImage(named: "moon-1"))
        }else{
             mainView.initView(mainWeatherImage: UIImage(named: "Blood")!, backgroundImage: UIImage(named: "Blood"))
        }
       
        self.addSubview(mainView)
        mainView.play()
        self.mainView.startWeatherSceneBulk(type)
        self.mainView.weatherGroundEmitterOptions = [URWeatherGroundEmitterOption(position: CGPoint(x: KMainScreenSize.width * 0.290, y: KMainScreenSize.height * 0.572)),
                                                     URWeatherGroundEmitterOption(position: CGPoint(x: KMainScreenSize.width * 0.237, y: KMainScreenSize.height * 0.530)),
                                                     URWeatherGroundEmitterOption(position: CGPoint(x: KMainScreenSize.width * 0.188, y: KMainScreenSize.height * 0.484)),
                                                     URWeatherGroundEmitterOption(position: CGPoint(x: KMainScreenSize.width * 0.101, y: KMainScreenSize.height * 0.475), rangeRatio: 0.042),
                                                     URWeatherGroundEmitterOption(position: CGPoint(x: KMainScreenSize.width * 0.752, y: KMainScreenSize.height * 0.748), rangeRatio: 0.094, degree: -27.0),
                                                     URWeatherGroundEmitterOption(position: CGPoint(x: KMainScreenSize.width * 0.829, y: KMainScreenSize.height * 0.602), rangeRatio: 0.094, degree: -27.0),
                                                     URWeatherGroundEmitterOption(position: CGPoint(x: KMainScreenSize.width * 0.663, y: KMainScreenSize.height * 0.556), rangeRatio: 0.078, degree: -27.0)]
    }

}
