//
//  UserDefultsManager.swift
//  Lottery
//
//  Created by apple on 2017/4/13.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

class UserDefultsManager: NSObject {
    // 删除
    class func removeObject(key:String){
        KUserDefaults.removeObject(forKey: key)
    }
    //字符串
    class func saveStr(str:String,key:String){
        KUserDefaults.set(str, forKey: key)
        KUserDefaults.synchronize()
    }
    class func readStr(key:String)->String{
        let str = KUserDefaults.object(forKey: key)
        return str as! String
    }
    //Bool
    class func saveBool(bool:Bool,key:String){
        KUserDefaults.set(bool, forKey: key)
        KUserDefaults.synchronize()
    }
    class func readBool(key:String)->Bool{
        return KUserDefaults.bool(forKey: key)
    }
    //字典
    class func saveDic(dic:NSDictionary,key:String){
        KUserDefaults.set(dic, forKey: key)
        KUserDefaults.synchronize()
    }
    class func readDic(key:String)->NSDictionary {
        var dicc = NSDictionary()
        if let dic = KUserDefaults.dictionary(forKey: key){
            dicc = dic as NSDictionary
        }
        return dicc
    }
    class func saveData(data:NSDate,key:String){
        KUserDefaults.set(data, forKey: key)
        KUserDefaults.synchronize()
    }
    class func readData(key:String) -> Data{
        return KUserDefaults.data(forKey: key)! as Data
    }
}
