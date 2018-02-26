//
//  SettingViewController.swift
//  WeatherAPP
//
//  Created by apple on 2017/6/23.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit
import NotificationBannerSwift
class SettingViewController: UIViewController,UITextFieldDelegate {

    lazy var backButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "back"), for: .normal)
        return b
    }()
    
    lazy var titleLabel: UILabel = {
        let s = UILabel()
        s.font = KFontSystemSize24
        s.textAlignment = .center
        s.text = "设置对方信息"
        s.textColor = UIColor.black
        return s
    }()
    lazy var setAddressLabel: UILabel = {
        let s = UILabel()
        s.font = KFontSystemSize20
        s.textAlignment = .center
        s.text = "位置："
        s.textColor = UIColor.black
        return s
    }()
    lazy var setNameLabel: UILabel = {
        let s = UILabel()
        s.font = KFontSystemSize20
        s.textAlignment = .center
        s.text = "昵称："
        s.textColor = UIColor.black
        return s
    }()
    lazy var newsBookLabel: UILabel = {
        let s = UILabel()
        s.font = KFontSystemSize20
        s.textAlignment = .center
        s.text = "电话号："
        s.textColor = UIColor.black
        return s
    }()
    lazy var lineView1: UIView = {
        let l = UIView()
        l.backgroundColor = UIColor.init(rgba: "#DBDBDB")
        return l
    }()
    lazy var lineView2: UIView = {
        let l = UIView()
        l.backgroundColor = UIColor.init(rgba: "#DBDBDB")
        return l
    }()
    lazy var lineView3: UIView = {
        let l = UIView()
        l.backgroundColor = UIColor.init(rgba: "#DBDBDB")
        return l
    }()
    lazy var addressFile: UITextField = {
        let u = UITextField()
        u.leftView = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: KAdaptedHeight(x: 40)))
        u.tag = 100
        u.delegate = self
        u.leftViewMode = .always
        u.contentVerticalAlignment = .center
        u.textColor = UIColor.black
        u.returnKeyType = .done
        u.layer.cornerRadius = KAdaptedHeight(x: 10)
        u.clipsToBounds = true
        u.placeholder = "精确到市（必选）"
        u.setValue(UIColor.init(rgba: "#BABABA"), forKeyPath: "_placeholderLabel.textColor")
        u.setValue(KFontSystemSize18, forKeyPath: "_placeholderLabel.font")
        u.tintColor = UIColor.black
        return u
    }()
    lazy var namefile: UITextField = {
        let p = UITextField()
        p.leftView = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: KAdaptedHeight(x: 40)))
        p.tag = 101
        p.delegate = self
        p.leftViewMode = .always
        p.contentVerticalAlignment = .center
        p.textColor = UIColor.black
        p.layer.cornerRadius = KAdaptedHeight(x: 10)
        p.clipsToBounds = true
        p.returnKeyType = .done
        p.clearButtonMode = .whileEditing
        p.placeholder = "信息里的昵称（必选）"
        p.setValue(UIColor.init(rgba: "#BABABA"), forKeyPath: "_placeholderLabel.textColor")
        p.setValue(KFontSystemSize18, forKeyPath: "_placeholderLabel.font")
        p.tintColor = UIColor.black
        return p
    }()
    lazy var newsbookFile: UITextField = {
        let p = UITextField()
        p.leftView = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: KAdaptedHeight(x: 40)))
        p.tag = 102
        p.delegate = self
        p.leftViewMode = .always
        p.contentVerticalAlignment = .center
        p.textColor = UIColor.black
        p.layer.cornerRadius = KAdaptedHeight(x: 10)
        p.clipsToBounds = true
        p.returnKeyType = .done
        p.clearButtonMode = .whileEditing
        p.placeholder = "点击选择联系人（必选）"
        p.setValue(UIColor.init(rgba: "#BABABA"), forKeyPath: "_placeholderLabel.textColor")
        p.setValue(KFontSystemSize18, forKeyPath: "_placeholderLabel.font")
        p.tintColor = UIColor.black
        return p
    }()
    lazy var sureButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(named: "next"), for: .normal)
        return b
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(rgba: "#F0EBD5")
        self.setupSubView()
    }
    func setupSubView(){
        self.view.addSubview(backButton)
        self.view.addSubview(titleLabel)
        self.view.addSubview(setAddressLabel)
        self.view.addSubview(setNameLabel)
        self.view.addSubview(newsBookLabel)
        self.view.addSubview(lineView1)
        self.view.addSubview(lineView2)
        self.view.addSubview(lineView3)
        self.view.addSubview(addressFile)
        self.view.addSubview(namefile)
        self.view.addSubview(newsbookFile)
        self.view.addSubview(sureButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(KAdaptedHeight(x: 24))
            make.left.equalTo(KAdaptedHeight(x: 20))
            make.width.height.equalTo(30)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(KAdaptedHeight(x: 80))
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(KAdaptedHeight(x: 200))
            make.height.equalTo(KAdaptedHeight(x: 30))
        }
        setAddressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(KAdaptedHeight(x: 200))
            make.left.equalTo(KAdaptedHeight(x: 25))
            make.width.equalTo(KAdaptedHeight(x: 80))
            make.height.equalTo(KAdaptedHeight(x: 30))
        }
        setNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(setAddressLabel.snp.bottom).offset(KAdaptedHeight(x: 50))
            make.left.equalTo(KAdaptedHeight(x: 25))
            make.width.equalTo(KAdaptedHeight(x: 80))
            make.height.equalTo(KAdaptedHeight(x: 30))
        }
        newsBookLabel.snp.makeConstraints { (make) in
            make.top.equalTo(setNameLabel.snp.bottom).offset(KAdaptedHeight(x: 50))
            make.left.equalTo(KAdaptedHeight(x: 15))
            make.width.equalTo(KAdaptedHeight(x: 100))
            make.height.equalTo(KAdaptedHeight(x: 30))
        }
        addressFile.snp.makeConstraints { (make) in
            make.centerY.equalTo(setAddressLabel.snp.centerY)
            make.left.equalTo(setAddressLabel.snp.right).offset(KAdaptedHeight(x: 5))
            make.width.equalTo(KAdaptedHeight(x: 220))
            make.height.equalTo(KAdaptedHeight(x: 30))
        }
        namefile.snp.makeConstraints { (make) in
            make.centerY.equalTo(setNameLabel.snp.centerY)
            make.left.equalTo(setNameLabel.snp.right).offset(KAdaptedHeight(x: 5))
            make.width.equalTo(KAdaptedHeight(x: 220))
            make.height.equalTo(addressFile.snp.height)
        }
        newsbookFile.snp.makeConstraints { (make) in
            make.centerY.equalTo(newsBookLabel.snp.centerY)
            make.left.equalTo(newsBookLabel.snp.right).offset(KAdaptedHeight(x: -5))
            make.width.equalTo(KAdaptedHeight(x: 220))
            make.height.equalTo(addressFile.snp.height)
        }
        lineView1.snp.makeConstraints { (make) in
            make.centerX.equalTo(addressFile.snp.centerX)
            make.width.equalTo(addressFile.snp.width)
            make.top.equalTo(addressFile.snp.bottom)
            make.height.equalTo(1)
        }
        lineView2.snp.makeConstraints { (make) in
            make.centerX.equalTo(namefile.snp.centerX)
            make.width.equalTo(lineView1.snp.width)
            make.top.equalTo(namefile.snp.bottom)
            make.height.equalTo(1)
        }
        lineView3.snp.makeConstraints { (make) in
            make.centerX.equalTo(newsbookFile.snp.centerX)
            make.width.equalTo(lineView2.snp.width)
            make.top.equalTo(newsbookFile.snp.bottom)
            make.height.equalTo(1)
        }
        sureButton.snp.makeConstraints { (make) in
            make.top.equalTo(lineView3.snp.bottom).offset(KAdaptedHeight(x: 80))
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.height.equalTo(KAdaptedHeight(x: 50))
        }
        sureButton.addTarget(self, action: #selector(SettingViewController.next(sender:)), for: .touchUpInside)
        self.backButton.addTarget(self, action: #selector(SettingViewController.back(sender:)), for: .touchUpInside)
    }
    func back(sender:UIButton){
        self.navigationController?.popViewController(animated: false)
    }
    func next(sender:UIButton){
        let textField = self.view.viewWithTag(100) as! UITextField
        let textField1 = self.view.viewWithTag(101) as! UITextField
        let textField2 = self.view.viewWithTag(102) as! UITextField
        if textField.text != "" && textField1.text != "" && textField2.text != ""{
            UserDefultsManager.removeObject(key: KADDRESS)
            UserDefultsManager.saveStr(str: textField.text!, key: KADDRESS)
            UserDefultsManager.removeObject(key: KNAME)
            UserDefultsManager.saveStr(str: textField1.text!, key: KNAME)
            UserDefultsManager.removeObject(key: KNUMBER)
            UserDefultsManager.saveStr(str: textField2.text!, key: KNUMBER)
            let herVC = HerViewController()
            herVC.address = addressFile.text!
            self.navigationController?.pushViewController(herVC, animated: false)
        }else{
            let banner = NotificationBanner(title: "有未输入选项", subtitle: "", style: .warning)
            banner.duration = 1.5
            banner.show()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
