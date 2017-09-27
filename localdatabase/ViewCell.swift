//
//  ViewCell.swift
//  localdatabase
//
//  Created by kliklabs indo kreasi on 9/27/17.
//  Copyright © 2017 kliklabs. All rights reserved.
//

import UIKit

class ViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    let name : UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont(name:"Verdana", size: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let age : UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.font = UIFont(name:"Verdana", size: 8.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(name)
        addSubview(age)
        
        name.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        name.widthAnchor.constraint(equalTo: widthAnchor, constant: -84).isActive = true
        name.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        age.leftAnchor.constraint(equalTo: name.rightAnchor, constant: 10).isActive = true
        age.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        age.widthAnchor.constraint(equalToConstant: 50).isActive = true
        age.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

}
