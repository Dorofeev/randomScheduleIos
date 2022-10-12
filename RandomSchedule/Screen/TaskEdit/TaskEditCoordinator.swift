//
//  TaskEditCoordinator.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 09.09.2022.
//

import Coordinators

class TaskEditCoordinator: UICoordinator {
    private lazy var controller: TaskEditViewController = {
        let vc = TaskEditViewController()
        vc.routesDelegate = self
        return vc
    }()
    override var rootViewController: UIViewController { get { controller } set {  } }
    
    func setupViewModel(task: Task?) {
        if let task = task {
            controller.bind(viewModel: TaskEditViewModel(task: task))
        } else {
            controller.bind(viewModel: TaskEditViewModel())
        }
    }
}

extension TaskEditCoordinator: TaskEditRoutesDelegate {
    func routeBack() {
        self.finish(true)
    }
}
