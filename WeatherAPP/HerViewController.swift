//
//  HerViewController.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit
import NotificationBannerSwift
//导入头文件
import MessageUI
class HerViewController: UIViewController,WeekDateViewDelegate {
    var address = ""
    lazy var backButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "back1"), for: .normal)
        return b
    }()
    
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
        p.setImage(UIImage(named: "message"), for: .normal)
        p.layer.cornerRadius = KAdaptedHeight(x: 10)
        p.layer.masksToBounds = true
        return p
    }()
    
    var weekSelectorDayView = WeekDateView()
    //城市
    var city = ""
    
    
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
        self.requestWeater()
        self.setupSubview()
    }
    func setupSubview(){
        self.view.addSubview(weaterView)
        self.view.addSubview(backButton)
        self.view.addSubview(personBtn)
        self.view.addSubview(temperatureLabel)
        self.view.addSubview(addressLabel)
        self.view.addSubview(weatherLabel)
        self.view.addSubview(weekDayView)
        self.view.addSubview(hoursWeaterView)
        
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(KAdaptedHeight(x: 24))
            make.left.equalTo(KAdaptedHeight(x: 20))
            make.width.height.equalTo(30)
        }
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
            make.left.equalTo(KAdaptedHeight(x: 10))
            make.right.equalTo(KAdaptedHeight(x: -10))
            make.height.equalTo(KAdaptedHeight(x: 80))
        }
        addressLabel.text = address
        weekDayView.dateButton.addTarget(self, action: #selector(dateSelector(sender:)), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.doubleTapClick(ges:)))
        tap.numberOfTapsRequired = 2
        self.weaterView.addGestureRecognizer(tap)
        personBtn.addTarget(self, action: #selector(HerViewController.presonButtonClick(sender:)), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(HerViewController.back(sender:)), for: .touchUpInside)
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
        UIView.animate(withDuration: 0.5) {
            self.weekSelectorDayView.frame = CGRect(x: KAdaptedHeight(x: 10), y: KAdaptedHeight(x: 580), width: KMainScreenSize.width - KAdaptedHeight(x: 20), height: KAdaptedHeight(x: 80))
        }
        sender.isUserInteractionEnabled = false
        showDataSeelctor = true
    }
    //网络请求
    func requestWeater(){
        //let strArr = self.addressLabel.text?.components(separatedBy: "·")
        if self.address == ""{
            self.address = UserDefultsManager.readStr(key: KADDRESS)
        }
        let params = ["?city":self.address]
        NetworkingClient.requestWeaterInfo(params: params , callback: { (result) in
            if let item = result?.model?.response{
                if item.count != 0{
                    self.weaterView.reloadDataForMain(type: returnWeatherType(str: item[0].img))
                    self.temperatureLabel.text = "\(item[0].temp)°"
                    let str = returnEnglishWeek(str: item[0].week)
                    self.weekDayView.reloadDataForMain(date: str, weather: item[0].img)
                    self.weatherLabel.text = item[0].weather
                    let array = item[0].hourly
                    self.hoursWeaterView.reloadDataForMain(models: array)
                    self.sevenDateModel(model: item[0].daily)
                }else{
                    self.showBannerView()
                }
            }else{
                self.showBannerView()
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
        UIView.animate(withDuration: 0.5, animations: {
            self.weekSelectorDayView.frame = CGRect(x: KAdaptedHeight(x: 50), y: KAdaptedHeight(x: 1200), width: KMainScreenSize.width - KAdaptedHeight(x: 100), height: KAdaptedHeight(x: 100))
        }) { (succeed) in
            self.weekSelectorDayView.removeFromSuperview()
            self.weekDayView.dateButton.isUserInteractionEnabled = true
        }
        
    }
    //点击其他位置收回日期选择
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if showDataSeelctor{
            UIView.animate(withDuration: 0.5, animations: {
                self.weekSelectorDayView.frame = CGRect(x: KAdaptedHeight(x: 50), y: KAdaptedHeight(x: 1200), width: KMainScreenSize.width - KAdaptedHeight(x: 100), height: KAdaptedHeight(x: 100))
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
        //设置联系人
        let str = UserDefultsManager.readStr(key: KNAME)
        //创建一个弹出框提示用户
        let alertController = UIAlertController(title: "发短信", message: "是否给\(str)发送短信?", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let sendAction = UIAlertAction(title: "确定", style: .default) { (alertController) in
            //判断设备是否能发短信(真机还是模拟器)
            if MFMessageComposeViewController.canSendText() {
                let controller = MFMessageComposeViewController()
                //短信的内容,可以不设置
                controller.body = "亲爱的\(str)你那里今天的温度是:\(self.temperatureLabel.text!) 你那里今天天气是:\(String(describing: self.weatherLabel.text!))"
                //联系人列表
                controller.recipients = [UserDefultsManager.readStr(key: KNUMBER)]
                //设置代理
                controller.messageComposeDelegate = self
                self.present(controller, animated: true, completion: nil)
            } else {
                print("本设备不能发短信")
            }
        }
        alertController.addAction(cancleAction)
        alertController.addAction(sendAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func back(sender:UIButton){
        self.navigationController?.popToRootViewController(animated: false)
    }
    func showBannerView(){
        let banner = NotificationBanner(title: "网络出现问题", subtitle: "双击界面重新请求数据", style: .warning)
        banner.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension HerViewController:MFMessageComposeViewControllerDelegate{
    //实现MFMessageComposeViewControllerDelegate的代理方法
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        //判断短信的状态
        switch result{
        case .sent:
            print("短信已发送")
        case .cancelled:
            print("短信取消发送")
        case .failed:
            print("短信发送失败")
        default:
            break
        }
    }
}
