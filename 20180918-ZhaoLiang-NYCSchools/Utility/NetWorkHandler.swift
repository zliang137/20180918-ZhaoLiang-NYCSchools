//
//  NetWorkHandler.swift
//  20180918-ZhaoLiang-NYCSchools
//
//  Created by Zhao Liang on 9/18/18.
//  Copyright © 2018 Leon Liang. All rights reserved.
//

import Foundation

class NetWorkHandler {
    class func fetchJson(url: String, completionHandler: @escaping ([Any]?, Error?) -> Void){
        if let url = URL(string: url){
            URLSession.shared.dataTask(with: url) {
                if let error = $2 {
                    completionHandler(nil, error)
                    return
                }
                
                guard let data = $0 else {
                    completionHandler(nil, nil)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [Any]
                    completionHandler(json, nil)
                }
                catch let error as NSError {
                    completionHandler(nil, error)
                }
                
                }.resume()
        }
        // add code here to handle url parsing error if necessary
    }
}
