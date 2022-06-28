//
//  RecordsViewTableViewCell.swift
//  Workout Record
//
//  Created by Ono Makoto on 11/6/2022.
//

import UIKit

enum Edge {
    case top
    case bottom
    case left
    case right
}


class RecordsViewTableViewCell : UITableViewCell {
    
    static let identifier = "RecordsViewTableViewCell"
    
    let countLabel = UILabel()
    let weightLabel = UILabel()
    
    private let horizontalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = .label
        
        setUpViews()
        setUpHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpViews() {
        [countLabel, weightLabel, horizontalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
         
        [weightLabel, countLabel].forEach {
            $0.font = .systemFont(ofSize: 20, weight: .medium)
            $0.textColor = .white
        }
        
        countLabel.textAlignment = .right
        
        horizontalStackView.axis = .horizontal
    }
    
    private func setUpHierarchy() {
        contentView.addSubview(horizontalStackView)
        
        [weightLabel, countLabel].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupLayout() {
        horizontalStackView.pinToSuperview([.left, .bottom, .top, .right], constant: 10)
        horizontalStackView.distribution = .fillEqually
    }
    
    func update(with database: Database) {
        //weightLabel.text = "\(database.findByDate()[indexPath.section][indexPath.row].rep_count)"
    }
}

extension UIView {
    func pinToSuperview(_ edges: [Edge], constant: CGFloat) {
        guard let superview = superview else {return }
        edges.forEach {
            switch $0 {
            case .left:
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            }
        }
    }
}
