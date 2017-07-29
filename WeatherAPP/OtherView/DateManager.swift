//
//  DateManager.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

class DateManager: NSObject {
    class func getSevenDate() ->[[String]]{
        var timers: [Int] = [] //  返回的数组
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        let month = comps.month!
        var dayNum = 30
        if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 {
            dayNum = 31
        }
        timers.append(comps.day!)                // 日
        timers.append(comps.weekday! - 1)      //星期
        var dataArray = [String]()
        var weekArray = [String]()
        let dateDay = timers.first!
        for i in 0..<7{
            var nextDay = dateDay + i
            if nextDay > dayNum{
                nextDay = nextDay - dayNum
            }
            dataArray.append(String(nextDay))
        }
        switch timers.last! {
        case 1:
            weekArray = ["Today","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        case 2:
            weekArray = ["Today","Wednesday","Thursday","Friday","Saturday","Sunday","Monday",]
        case 3:
            weekArray = ["Today","Thursday","Friday","Saturday","Sunday","Monday","Tuesday",]
        case 4:
            weekArray = ["Today","Friday","Saturday","Sunday","Monday","Tuesday","Wednesday"]
        case 5:
            weekArray = ["Today","Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday"]
        case 6:
            weekArray = ["Today","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"]
        case 7:
            weekArray = ["Today","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
        default:
            break
        }
        return[dataArray,weekArray]
    }
    
}
