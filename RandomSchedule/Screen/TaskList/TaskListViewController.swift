//
//  TaskListViewController.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 09.09.2022.
//

import Coordinators
import UIKit

protocol TaskRoutesDelegate: AnyObject {
    func routeToDetails(task: Task)
    func routeToNewTask()
}

class TaskListViewController: CTableViewController<
TaskListView,
TaskListViewModel,
TaskTableViewCell
> {
    
    weak var routesDelegate: TaskRoutesDelegate? {
        didSet {
            viewModel.routesDelegate = routesDelegate
        }
    }
    
    override func loadView() {
        let taskView = TaskListView()
        view = taskView
        taskView.setupTableDelegate(self)
        taskView.setup(addAction: UIAction(handler: { [weak self] _ in
            self?.routesDelegate?.routeToNewTask()
        }))
        

    }
    
    override init(viewModel:TaskListViewModel = TaskListViewModel()) {
        super.init(viewModel: viewModel)
    }
    
    override func setup() {
        super.setup()
        title = "Task List"
    }
    

}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(index: indexPath.row)
    }
}
