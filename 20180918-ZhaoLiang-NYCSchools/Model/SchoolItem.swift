//
//  SchoolItem.swift
//  20180918-ZhaoLiang-NYCSchools
//
//  Created by Zhao Liang on 9/18/18.
//  Copyright © 2018 Leon Liang. All rights reserved.
//

import Foundation

class SchoolItem {
    var title: String?
    var desc: String?
    var dbn: String?
    
    var numOfTester: String?
    var readingAvgScore: String?
    var mathAvgScore: String?
    var writingAvgScore: String?
    
    init(json: [String: Any]) {
        if let titleText = json["school_name"] as? String{
            title = titleText
        }
        
        if let descText = json["overview_paragraph"] as? String{
            desc = descText
        }
        
        if let dbnText = json["dbn"] as? String{
            dbn = dbnText
        }
    }
    
//    func setNumOfTester(num: String){
//        self.numOfTester = num
//    }
//    
//    func setreadingAvgScore(score: String){
//        self.readingAvgScore = score
//    }
//    func mathAvgScore(score: String){
//        self.mathAvgScore = score
//    }
//    func writingAvgScore(score: String){
//        self.writingAvgScore = score
//    }
}
