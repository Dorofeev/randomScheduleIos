//
//  TaskTableViewCell.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 09.09.2022.
//

import Coordinators

private let yOffset: CGFloat = 4.0
private let xOffset: CGFloat = 16.0

class TaskTableViewCell: CTableViewCell<Task> {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priorityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var item: Task? {
        didSet {
            titleLabel.text = item?.title
            priorityLabel.text = "\(item?.priority ?? 0)"
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        self.selectionStyle = .none
    }
    
    override func setupLayout() {
        super.setupLayout()
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        
        addSubview(titleLabel)
        addSubview(priorityLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: yOffset),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -yOffset),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: xOffset),
            titleLabel.heightAnchor.constraint(equalToConstant: 44.0),
            
            priorityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: yOffset),
            priorityLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: yOffset
            ),
            priorityLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -xOffset
            ),
            priorityLabel.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
}
