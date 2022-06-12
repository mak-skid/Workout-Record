//
//  RecordsViewTableViewCell.swift
//  Workout Record
//
//  Created by Ono Makoto on 11/6/2022.
//

import UIKit


class RecordsViewTableViewCell : UITableViewCell {
    
    static let identifier = "RecordsViewTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
