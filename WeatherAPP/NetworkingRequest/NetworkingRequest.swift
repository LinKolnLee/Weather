//
//  NetworkingRequest.swift
//  NetworkingTool
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 com.jinhu.caipiaoxo. All rights reserved.
//

import UIKit

//class NetworkingRequest: NSObject {
//
//}
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
private let NetworkRequestShareInstance = NetworkingRequest()

class NetworkingRequest {
    class var sharedInstance : NetworkingRequest {
        return NetworkRequestShareInstance
    }
}
extension NetworkingRequest {
    func getRequest<T: KResponseObjectSerializable>(urlString: String, params : [String : Any],header:HTTPHeaders, success : @escaping (_ response : T)->(), failture : @escaping (_ error : Error)->()) {
        
        Alamofire.request(urlString, method: .get, parameters: nil,encoding: JSONEncoding.default,headers: header).responseString { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let dic = self.getDictionaryFromJSONString(jsonString: value)
                    success(T(anyObject:dic))
                }
            case.failure(let error):
                failture(error)
            }
        }
        
    }
    func postRequest<T: KResponseObjectSerializable>(urlString : String, params : [String : Any]?, header:HTTPHeaders,success : @escaping (_ response :T)->(), failture : @escaping (_ error : Error)->()) {
        
        Alamofire.request(urlString, method: .post, parameters: params,encoding: JSONEncoding.default,headers: header).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value{
                    let dic = self.getDictionaryFromJSONString(jsonString: value as! String)
                    success(T(anyObject:dic))
                }
            case .failure(let error):
                failture(error)
            }
        }
    }
    func upLoadImageRequest(urlString : String, params:[String:String], data: [Data], name: [String],success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                let flag = params["flag"]
                let userId = params["userId"]
                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
                multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                for i in 0..<data.count {
                    multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                        }
                    }
                case .failure(let encodingError):
                    failture(encodingError)
                }
        }
        )
    }
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
        
        
    }
}
