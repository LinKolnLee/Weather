//
//  GlobalDefine.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/14.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit
import SwiftyJSON
import URWeatherView
import DispatchFramework
let AppCode = "APPCODE 346d03b5ecc243a9882d8e12739190e5"
let KBaseUrl = "http://jisutqybmf.market.alicloudapi.com/weather/query"
let KMainScreenSize = UIScreen.main.bounds.size
/// 比例尺 基于4.7'宽
let KADDRESS = "address"
let KNAME = "name"
let KNUMBER = "phonenumber"
func KAdaptedHeight(x:CGFloat)->CGFloat{
    if TARGET_OS_IPHONE==1{
        let ff = KMainScreenSize.width / 375.0
        let xx = x * ff
        return xx
    }else{
        return x
    }
}
//本地存储类
var KUserDefaults = UserDefaults.standard
// 字体名称
enum KFontName:String{
    case STHeitiSCMedium = "Tensentype-XiangSiF"
    case Helvetica = "Helvetica"
    case HelveticaBold = "Helvetica-Bold"
    case STHeitiSCLight = "STHeitiSC-Light"
    case Menlo_Regular = "Menlo-Regular"
    case Menlo_Bold = "Menlo-Bold"
    
}
struct KGCD{
    static func async_in_main(_ closure: @escaping DispatchClosure) {
        //gcd.async(.main, closure: closure)
        Dispatch.async(closure)
    }
}
let Height: CGFloat = 1334
let K_IS_GREATER_47_INCH_SCREEN = (UIScreen.main.currentMode?.size.height)! >= Height ? true : false
func KFontWithSTHeitiSCLight(fontSize:CGFloat)->UIFont{
    return UIFont(name: KFontName.STHeitiSCMedium.rawValue, size: fontSize)!
}
func KFontWithSTHeitiSCTwo(fontSize:CGFloat)->UIFont{
    return UIFont(name: KFontName.STHeitiSCLight.rawValue, size: fontSize)!
}
let KFontSystemSizeTwo48 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSCTwo(fontSize: 48) : UIFont.systemFont(ofSize: 48)
let KFontSystemSizeTwo14 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSCTwo(fontSize: 14) : UIFont.systemFont(ofSize: 14)
let KFontSystemSize10 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSCLight(fontSize: 10) : UIFont.systemFont(ofSize: 10)
let KFontSystemSize12 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSCLight(fontSize: 12) : UIFont.systemFont(ofSize: 12)
let KFontSystemSize14 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSCLight(fontSize: 14) : UIFont.systemFont(ofSize: 14)
let KFontSystemSize18 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSCLight(fontSize: 18) : UIFont.systemFont(ofSize: 18)
let KFontSystemSize20 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSCLight(fontSize: 20) : UIFont.systemFont(ofSize: 20)
let KFontSystemSize24 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSCLight(fontSize: 24) : UIFont.systemFont(ofSize: 24)
let KFontSystemSize28 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSCLight(fontSize: 28) : UIFont.systemFont(ofSize: 28)
let KFontSystemSize38 = K_IS_GREATER_47_INCH_SCREEN ? KFontWithSTHeitiSCLight(fontSize: 48) : UIFont.systemFont(ofSize: 48)
func returnEnglishWeek(str:String) -> String{
    var week = ""
    switch str {
    case "星期一":
        week = "Monday"
    case "星期二":
        week = "Tuesday"
    case "星期三":
        week = "Wednesday"
    case "星期四":
        week = "Thursday"
    case "星期五":
        week = "Friday"
    case "星期六":
        week = "Saturday"
    case "星期天":
        week = "Sunday"
    default:
        break
    }
    return week
}
func returnWeatherImage(str:String)->String{
    var image = ""
    switch str {
    case "0","1","2","3","4","6","7","8","9","10","13","14","15","18","19","20":
        image = str
    case "5":
        image = "4"
    case "11","12":
        image = "10"
    case "16","17":
        image = "15"
    case "21","22","23","24","25":
        image = "8"
    case "26","27","28":
        image = "21"
    case "301":
        image = "7"
    case "302":
        image = "13"
    default:
        break
    }
    return image
}
func returnWeatherType(str:String)->URWeatherType{
    var type : URWeatherType?
    switch str {
    case "0","1":
        type = .cloudy
    case "2":
        type = .lightning
    case "3","4","5","6","7","8","9","10","11","12","19","21","22","23","24","25","301":
        type = .rain
    case "13","14","15","16","17","25","26","27","28","302":
        type = .snow
    case "31","32","49","53","54","55","56","57","58":
        type = .dust
    case "20","29","30":
        type = .dust2
    default:
        break
    }
    return type!
}
class GlobalDefine: NSObject {
    class func valueForKeyToString(obj:AnyObject,key:String) -> String{
        return JSON(obj)[key].stringValue
    }
    class func valueForKeyPathToArray(_ obj:AnyObject,key:String)->[JSON]{
        
        return JSON(obj)[key].array!
    }
    
    class func valueForKeyPathToInt(_ obj:AnyObject,key:String)->Int{
        
        return JSON(obj)[key].intValue
    }
    
    class func valueForKeyPathToDouble(_ obj:AnyObject,key:String)->Double{
        
        return JSON(obj)[key].doubleValue
    }
    
    class func valueForKeyPathToFloat(_ obj:AnyObject,key:String)->Float{
        
        return JSON(obj)[key].floatValue
    }
    
    class func valueForKeyPathToBool(_ obj:AnyObject,key:String)->Bool{
        
        return JSON(obj)[key].boolValue
    }
    
    class func valueForKeyPathToObject(_ obj:AnyObject,key:String)->AnyObject{
        
        return JSON(obj)[key].object as AnyObject
    }
    class func valueForkeyPathToDic(_ obj:AnyObject,key:String)->NSDictionary{
        return JSON(obj)[key].dictionaryObject! as NSDictionary
    }
}
