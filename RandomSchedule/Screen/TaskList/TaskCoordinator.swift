//
//  TaskCoordinator.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 09.09.2022.
//

import Coordinators

class TaskCoordinator: UICoordinator {
    init() {
        
        let viewModel = TaskListViewModel()
        
        let controller = TaskListViewController(viewModel: viewModel)
        
        viewModel.onSectionsUpdate = { [weak controller] in
            controller?.hostedView.tableView.reloadData()
        }
        
        let nav = UINavigationController(
            rootViewController: controller
        )
        super.init(navigationController: nav)
        controller.routesDelegate = self
    }
}

extension TaskCoordinator: TaskRoutesDelegate {
    
    func routeToDetails(task: Task) {
        let coordinator = TaskEditCoordinator(navigationController: self.navigationController)
        coordinator.setupViewModel(task: task)
        coordinator.start(with: self)
    }
    
    func routeToNewTask() {
        let coordinator = TaskEditCoordinator(navigationController: self.navigationController)
        coordinator.setupViewModel(task: nil)
        coordinator.start(with: self)
    }
}
