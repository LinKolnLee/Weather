//
//  ViewController.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit
import CoreLocation
import NotificationBannerSwift
class ViewController: UIViewController,WeekDateViewDelegate {
    lazy var weaterView: WeaterView = {
        let w = WeaterView()
        return w
    }()
    lazy var temperatureLabel: TemperatureLabel = {
        let t = TemperatureLabel()
        t.text = ""
        return t
    }()
    lazy var addressLabel: AddressLabel = {
        let a = AddressLabel()
        a.text  = "正在定位..."
        return a
    }()
    lazy var weekDayView: WeekDayView = {
        let w = WeekDayView()
        return w
    }()
    lazy var weatherImage: WeaterImageView = {
        let w = WeaterImageView()
        return w
    }()
    lazy var hoursWeaterView: HoursWeaterView = {
        let h = HoursWeaterView()
        return h
    }()
    lazy var weatherLabel: UILabel = {
        let w = UILabel()
        w.font = KFontSystemSize38
        w.textAlignment = .center
        w.textColor = UIColor.white
        return w
    }()
    lazy var personBtn: UIButton = {
        let p = UIButton()
        p.setImage(UIImage(named: "preson"), for: .normal)
        p.layer.cornerRadius = KAdaptedHeight(x: 20)
        p.layer.masksToBounds = true
        return p
    }()
    
    var weekSelectorDayView = WeekDateView()
    //城市
    var city = ""
    
    /// 位置
    var locationManager = CLLocationManager()
    
    /// 当前位置
    var currLocation:CLLocation?
    
    // 收回日期选择
    var showDataSeelctor = false
    
    // 7天日期数据
    var sevenDataModel = [DayWeaterItem]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadLocation()
        self.setupSubview()
        self.requestWeater()

    }
    func setupSubview(){
        self.view.addSubview(weaterView)
        self.view.addSubview(personBtn)
        self.view.addSubview(temperatureLabel)
        self.view.addSubview(addressLabel)
        self.view.addSubview(weatherLabel)
        self.view.addSubview(weekDayView)
        self.view.addSubview(hoursWeaterView)
        weaterView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        personBtn.snp.makeConstraints { (make) in
            make.top.equalTo(KAdaptedHeight(x: 24))
            make.right.equalTo(KAdaptedHeight(x: -20))
            make.width.height.equalTo(KAdaptedHeight(x: 30))
        }
        temperatureLabel.snp.makeConstraints { (make) in
            make.left.equalTo((KMainScreenSize.width - KAdaptedHeight(x: 120))/2 + KAdaptedHeight(x: 30))
            make.top.equalTo(KAdaptedHeight(x: 64))
            make.width.equalTo(KAdaptedHeight(x: 120))
            make.height.equalTo(KAdaptedHeight(x: 70))
        }
        addressLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(weaterView.snp.centerX)
            make.top.equalTo(temperatureLabel.snp.bottom).offset(KAdaptedHeight(x: 10))
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(KAdaptedHeight(x: 50))
        }
        weatherLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(weaterView.snp.centerX)
            make.top.equalTo(addressLabel.snp.bottom).offset(KAdaptedHeight(x: 33))
            make.width.equalTo(KAdaptedHeight(x: 150))
            make.height.equalTo(KAdaptedHeight(x: 50))
        }
        weekDayView.snp.makeConstraints { (make) in
            make.bottom.equalTo(KAdaptedHeight(x: -100))
            make.left.right.equalTo(0)
            make.height.equalTo(KAdaptedHeight(x: 40))
        }
        hoursWeaterView.snp.makeConstraints { (make) in
             make.top.equalTo(weekDayView.snp.bottom).offset(KAdaptedHeight(x: 10))
            make.left.equalTo(KAdaptedHeight(x: 0))
            make.right.equalTo(KAdaptedHeight(x: 0))
            make.height.equalTo(KAdaptedHeight(x: 80))
        }
        weekDayView.dateButton.addTarget(self, action: #selector(dateSelector(sender:)), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.doubleTapClick(ges:)))
        tap.numberOfTapsRequired = 2
        self.weaterView.addGestureRecognizer(tap)
        personBtn.addTarget(self, action: #selector(ViewController.presonButtonClick(sender:)), for: .touchUpInside)
    }
    
    /// 日期按钮点击方法
    ///
    /// - Parameter sender: UIButton
    func dateSelector(sender:UIButton){
        
        let array = DateManager.getSevenDate()
        weekSelectorDayView = WeekDateView()
        weekSelectorDayView.delegate = self
        weekSelectorDayView.frame = CGRect(x: KAdaptedHeight(x: 50), y: KAdaptedHeight(x: 1200), width: KMainScreenSize.width - KAdaptedHeight(x: 100), height: KAdaptedHeight(x: 100))
        weekSelectorDayView.layer.cornerRadius = KAdaptedHeight(x: 10)
        weekSelectorDayView.layer.masksToBounds = true
        weekSelectorDayView.reloadDataForMain(model: array)
        self.view.addSubview(weekSelectorDayView)
        UIView.animate(withDuration: 0.25) {
            self.weekSelectorDayView.frame = CGRect(x: KAdaptedHeight(x: 10), y: KAdaptedHeight(x: 580), width: KMainScreenSize.width - KAdaptedHeight(x: 20), height: KAdaptedHeight(x: 80))
        }
        sender.isUserInteractionEnabled = false
        showDataSeelctor = true
    }
    //网络请求
    func requestWeater(){
        let strArr = self.addressLabel.text?.components(separatedBy: "·")
        let params = ["?city":strArr?.first]
        //这个接口有点慢
        NetworkingClient.requestWeaterInfo(params: params as! [String:String], callback: { (result) in
            if let item = result?.model?.response{
                if item.count != 0{
                    KGCD.async_in_main {
                        self.weaterView.reloadDataForMain(type: returnWeatherType(str: item[0].img))
                        self.temperatureLabel.text = "\(item[0].temp)°"
                        let str = returnEnglishWeek(str: item[0].week)
                        self.weekDayView.reloadDataForMain(date: str, weather: item[0].img)
                        self.weatherLabel.text = item[0].weather
                        let array = item[0].hourly
                        self.hoursWeaterView.reloadDataForMain(models: array)
                        self.sevenDateModel(model: item[0].daily)
                    }
                 }else{
                    self.requestWeater()
                }
            }else{
                self.requestWeater()
            }
        }) { (error) in
            self.showBannerView()
        }
    }
    //点击日期的代理方法
    func WeekDateView_DidClickBtnAction(date: String,week:String,tag:Int) {
        self.weekDayView.dateButton.setTitle(week, for: .normal)
        self.temperatureLabel.text = "\(self.sevenDataModel[tag].temphigh)°"
        self.weatherLabel.text = self.sevenDataModel[tag].weather
        self.weatherImage.reloadDataForMain(weather: self.sevenDataModel[tag].img)
        UIView.animate(withDuration: 0.25, animations: {
            self.weekSelectorDayView.frame = CGRect(x: KAdaptedHeight(x: 50), y: KAdaptedHeight(x: 700), width: KMainScreenSize.width - KAdaptedHeight(x: 100), height: KAdaptedHeight(x: 100))
        }) { (succeed) in
            self.weekSelectorDayView.removeFromSuperview()
            self.weekDayView.dateButton.isUserInteractionEnabled = true
        }
        
    }
    //点击其他位置收回日期选择
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if showDataSeelctor{
            UIView.animate(withDuration: 0.25, animations: {
                self.weekSelectorDayView.frame = CGRect(x: KAdaptedHeight(x: 50), y: KAdaptedHeight(x: 700), width: KMainScreenSize.width - KAdaptedHeight(x: 100), height: KAdaptedHeight(x: 100))
            }) { (succeed) in
                self.weekSelectorDayView.removeFromSuperview()
                self.weekDayView.dateButton.isUserInteractionEnabled = true
            }
            showDataSeelctor = false
        }
        
    }
    
    func doubleTapClick(ges:UIGestureRecognizer){
        self.requestWeater()
    }
    func sevenDateModel(model:NSMutableArray){
        for i in 0..<7{
            let info = DayWeaterItem(anyObject: model[i] as AnyObject)
            self.sevenDataModel.append(info)
        }
    }
    func presonButtonClick(sender:UIButton){
        if (KUserDefaults.object(forKey: KADDRESS) != nil){
            let herVC = HerViewController()
            herVC.address = UserDefultsManager.readStr(key: KADDRESS)
            self.navigationController?.pushViewController(herVC, animated: false)
        }else{
            let setVC = SettingViewController()
            self.navigationController?.pushViewController(setVC, animated: false)
        }
    }
    func showBannerView(){
        let banner = NotificationBanner(title: "网络出现问题", subtitle: "双击界面重新请求数据", style: .warning)
        banner.duration = 1.5
        banner.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ViewController: CLLocationManagerDelegate {
    
    //打开定位
    func loadLocation()
    {
        locationManager.delegate = self
        //定位方式
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //iOS8.0以上才可以使用
        //始终允许访问位置信息
        locationManager.requestAlwaysAuthorization()
        //使用应用程序期间允许访问位置数据
        locationManager.requestWhenInUseAuthorization()
        //开启定位
        locationManager.startUpdatingLocation()
    }
    
    //获取定位信息
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //取得locations数组的最后一个
        let location:CLLocation = locations[locations.count-1]
        currLocation = locations.last
        //判断是否为空
        if(location.horizontalAccuracy > 0){
            LonLatToCity()
            //停止定位
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    //出现错误
    func locationManager(_ manager: CLLocationManager, didFinishDeferredUpdatesWithError error: Error?) {
        //print(error)
    }
    
    ///将经纬度转换为城市名
    func LonLatToCity() {
        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currLocation!) { (placemark, error) -> Void in
            
            if(error == nil)
            {
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                //城市
                let city = (mark.addressDictionary! as NSDictionary).value(forKey: "City") as! String
                //具体位置
                //let detailLoaction = (mark.addressDictionary! as NSDictionary).value(forKey: "Name") as! String
                
                //区
                let subLocality = (mark.addressDictionary! as NSDictionary).value(forKey: "SubLocality") as! String
                self.city = city
                self.addressLabel.text = city + "·" + subLocality
            }
        }
    }
}
