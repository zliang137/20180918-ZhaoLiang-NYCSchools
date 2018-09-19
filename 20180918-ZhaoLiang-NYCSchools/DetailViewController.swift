//
//  DetailViewController.swift
//  20180918-ZhaoLiang-NYCSchools
//
//  Created by Zhao Liang on 9/18/18.
//  Copyright © 2018 Leon Liang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var satListUrl: String {
        return "https://data.cityofnewyork.us/resource/734v-jeq5.json"
    }

    var item : SchoolItem?
    let itemTitle : UILabel = UILabel()
    let itemDesc : UILabel = UILabel()
    
    let satTitle : UILabel = UILabel()
    
    let numTester : UILabel = UILabel()
    let mathScore : UILabel = UILabel()
    let readingScore : UILabel = UILabel()
    let WrittingScore : UILabel = UILabel()

    func configureView() {
        // Update the user interface for the detail item.
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        contentView.addSubview(itemTitle)
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        itemTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        itemTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        itemTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        
        contentView.addSubview(itemDesc)
        itemDesc.translatesAutoresizingMaskIntoConstraints = false
        itemDesc.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        itemDesc.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        itemDesc.topAnchor.constraint(equalTo: itemTitle.bottomAnchor, constant: 10).isActive = true
        
        contentView.addSubview(satTitle)
        satTitle.translatesAutoresizingMaskIntoConstraints = false
        satTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        satTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        satTitle.topAnchor.constraint(equalTo: itemDesc.bottomAnchor, constant: 25).isActive = true
        
        contentView.addSubview(numTester)
        numTester.translatesAutoresizingMaskIntoConstraints = false
        numTester.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        numTester.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        numTester.topAnchor.constraint(equalTo: satTitle.bottomAnchor, constant: 0).isActive = true
        
        contentView.addSubview(mathScore)
        mathScore.translatesAutoresizingMaskIntoConstraints = false
        mathScore.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        mathScore.topAnchor.constraint(equalTo: numTester.bottomAnchor, constant: 15).isActive = true
        
        contentView.addSubview(readingScore)
        readingScore.translatesAutoresizingMaskIntoConstraints = false
        readingScore.leftAnchor.constraint(equalTo: mathScore.rightAnchor, constant: 20).isActive = true
        readingScore.topAnchor.constraint(equalTo: numTester.bottomAnchor, constant: 15).isActive = true
        
        contentView.addSubview(WrittingScore)
        WrittingScore.translatesAutoresizingMaskIntoConstraints = false
        WrittingScore.leftAnchor.constraint(equalTo: readingScore.rightAnchor, constant: 20).isActive = true
        WrittingScore.topAnchor.constraint(equalTo: numTester.bottomAnchor, constant: 15).isActive = true
        contentView.bottomAnchor.constraint(equalTo: WrittingScore.bottomAnchor, constant: 15).isActive = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
        self.navigationItem.title = self.item?.title
        
        self.itemTitle.text = self.item?.title
        self.itemTitle.numberOfLines = 0
        self.itemTitle.font = UIFont.boldSystemFont(ofSize: 30)
        
        self.itemDesc.text = self.item?.desc
        self.itemDesc.numberOfLines = 0
        self.itemDesc.textColor = UIColor.gray
        
        self.satTitle.text = "Average SAT test score"
        self.satTitle.font = UIFont.boldSystemFont(ofSize: 20)
        
        //fetch json for sat data
        NetWorkHandler.fetchJson(url: satListUrl) { (satJson, error) in
            if let _ = error{
                return
            }

            //add sat data to model
            if let satList = satJson as? [[String: Any]]{
                for satDic in satList {
                    let satId = satDic["dbn"] as? String
                    if satId == self.item?.dbn{
                        let numTester = satDic["num_of_sat_test_takers"] as? String
                        self.item?.numOfTester = numTester

                        let readingScore = satDic["sat_critical_reading_avg_score"] as? String
                        self.item?.readingAvgScore = readingScore

                        let mathScore = satDic["sat_math_avg_score"] as? String
                        self.item?.mathAvgScore = mathScore

                        let writtingScore = satDic["sat_writing_avg_score"] as? String
                        self.item?.writingAvgScore = writtingScore
                    }
                }
            }

            //update UI in main queue
            DispatchQueue.main.async {
                
                if self.self.item?.numOfTester  == nil || self.item?.numOfTester?.count == 0{
                    self.numTester.text = "No data avaliable"
                }else{
                    self.numTester.text = "Number of test takers: \(self.item!.numOfTester!)"
                }
                
                if self.item?.mathAvgScore == nil || self.item?.mathAvgScore?.count == 0{
                    self.mathScore.text = "Math: N/A"
                }else{
                    self.mathScore.text = "Math: \(self.item!.mathAvgScore!)"
                }
                
                if self.item?.readingAvgScore == nil || self.item?.readingAvgScore?.count == 0{
                    self.readingScore.text = "Reading: N/A"
                }else{
                    self.readingScore.text = "Reading: \(self.item!.readingAvgScore!)"
                }
                
                //        readingScore.text = "123"
                
                if self.item?.writingAvgScore == nil || self.item?.writingAvgScore?.count == 0{
                    self.WrittingScore.text = "Writting: N/A"
                }else{
                    self.WrittingScore.text = "Writting: \(self.item!.writingAvgScore!)"
                }
                
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

