//
//  TaskListView.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 09.09.2022.
//

import Coordinators
import UIKit

class TaskListView: UIView, TableViewHolder {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Task", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(tableView)
        self.addSubview(addButton)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor),
            
            addButton.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -8
            ),
            addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableDelegate(_ delegate: UITableViewDelegate) {
        tableView.delegate = delegate
        tableView.allowsSelection = true
    }
    
    func setup(addAction: UIAction) {
        addButton.addAction(addAction, for: .touchUpInside)
    }
}
