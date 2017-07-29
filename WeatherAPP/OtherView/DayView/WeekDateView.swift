//
//  WeekDateView.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit
@objc protocol WeekDateViewDelegate {
    
    //点击切换日期
    @objc optional
    func WeekDateView_DidClickBtnAction(date:String,week:String,tag:Int)
}
class WeekDateView: UIView {
    weak var delegate:WeekDateViewDelegate?
    let leftSpace = KAdaptedHeight(x: 15)
    let width = KAdaptedHeight(x: 45)
    var models = [[""]]
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(rgba: "#F0EBD5")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func reloadDataForMain(model:[[String]]){
        models = model
        let dateArray = model.first!
        let weekArray = model.last!
        for i in 0..<7{
            let view  = OneDayView()
            view.tag = i
            view.reloadData(week: weekArray[i], date:dateArray[i])
            view.frame = CGRect(x: leftSpace + width * CGFloat(i), y: leftSpace/2, width: width, height: KAdaptedHeight(x: 40))
            let tap = UITapGestureRecognizer(target: self, action: #selector(WeekDateView.touchViewClick(ges:)))
            view.addGestureRecognizer(tap)
            self.addSubview(view)
        }
    }
    func touchViewClick(ges:UIGestureRecognizer){
        let index = ges.view!.tag
        self.delegate?.WeekDateView_DidClickBtnAction!(date: models.first![index], week: models.last![index], tag: index)
    }
}
