//
//  SchoolTableViewCell.swift
//  20180918-ZhaoLiang-NYCSchools
//
//  Created by Zhao Liang on 9/18/18.
//  Copyright © 2018 Leon Liang. All rights reserved.
//

import Foundation
import UIKit

class SchoolTableViewCell: UITableViewCell {
    let title : UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
    }
    
    func setup(){
        contentView.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        title.numberOfLines = 0
        
        let separator = UIView(frame: CGRect.zero)
        separator.translatesAutoresizingMaskIntoConstraints = false;
        contentView.addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separator.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        separator.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = UIColor.gray
    }
}
