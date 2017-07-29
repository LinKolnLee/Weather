//
//  WeaterModel.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit
class WeaterListItem: NSObject {
    
    /// 天气
    var weather = ""
    
    /// 天气对应图片
    var img = ""
    
    ///  温度
    var temp = ""
    
    /// 日期
    var week = ""
    
    var hourly = NSMutableArray()
    var daily = NSMutableArray()
    func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["hourly":"HoursWeaterItem","daily":""]
    }
}
class HoursWeaterItem:KResponseItemSerializable{
    /// 时间
    var time = ""
    
    /// 天气
    var img = ""
    
    /// 温度
    var temp = ""
    
    
    required init(anyObject: AnyObject) {
        self.time = GlobalDefine.valueForKeyToString(obj: anyObject, key: "time")
        self.img = GlobalDefine.valueForKeyToString(obj: anyObject, key: "img")
        self.temp = GlobalDefine.valueForKeyToString(obj: anyObject, key: "temp")
    }
}
class DayWeaterItem:KResponseItemSerializable{
    /// 天气
    var weather = ""
    
    /// 时间
    var time = ""
    
    /// 天气
    var img = ""
    
    /// 温度
    var temphigh  = ""
    required init(anyObject: AnyObject) {
        let dic = GlobalDefine.valueForkeyPathToDic(anyObject, key: "day")
        self.time = GlobalDefine.valueForKeyToString(obj: dic, key: "time")
        self.img = GlobalDefine.valueForKeyToString(obj: dic, key: "img")
        self.temphigh = GlobalDefine.valueForKeyToString(obj: dic, key: "temphigh")
        self.weather = GlobalDefine.valueForKeyToString(obj: dic, key: "weather")

    }
}
class WeaterModel: RequestResultModelV20 {
    var model : KRequestBaseListWithJSON<WeaterListItem>?
    required init(anyObject: AnyObject?) {
        super.init(anyObject: anyObject)
        if let v = anyObject{
            if let r = v.value(forKeyPath: "result"){
                model = KRequestBaseListWithJSON<WeaterListItem>(anyObject:r as AnyObject)
            }
        }
    }
}
