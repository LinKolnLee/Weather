//
//  HoursWeaterView.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

class HoursWeaterView: UIView {
    let leftSpace = KAdaptedHeight(x: 15)
    let width = KAdaptedHeight(x: 70)
    lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.showsHorizontalScrollIndicator = false
        s.showsVerticalScrollIndicator = false
        s.isPagingEnabled = true
        s.bounces = true
        s.alwaysBounceHorizontal = false
        return s
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func reloadDataForMain(models:NSMutableArray){
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.width)
        self.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: CGFloat(models.count) * width, height: self.frame.size.height)
        for i in 0..<models.count{
           let view = OneHourView()
           view.backgroundColor = UIColor.clear
           view.frame = CGRect(x: leftSpace + width * CGFloat(i), y: 0, width: KAdaptedHeight(x: 50), height: KAdaptedHeight(x: 80))
            if models.count != 0{
                let model = HoursWeaterItem(anyObject: models[i] as AnyObject)
                view.reloadDataForView(model: model)
            }
           scrollView.addSubview(view)
        }
    }
}
