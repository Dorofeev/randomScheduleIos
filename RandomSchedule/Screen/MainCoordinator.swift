//
//  MainCoordinator.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 10.09.2022.
//

import Coordinators

class MainCoordinator: UICoordinator {
    init(window: UIWindow?) {
        let tabBarController = UITabBarController()
        super.init(navigationController: UINavigationController())
        
        let taskCoordinator = TaskCoordinator()
        
        let calendarCoordinator = CalendarCoordinator()
        
        self.childCoordinators.append(taskCoordinator)
        self.childCoordinators.append(calendarCoordinator)
        
        tabBarController.viewControllers = [calendarCoordinator.navigationController, taskCoordinator.navigationController]
        
        window?.rootViewController = tabBarController
        
//        let viewModel = TaskListViewModel()
//        
//        let controller = TaskListViewController(viewModel: viewModel)
//        
//        viewModel.onSectionsUpdate = { [weak controller] in
//            controller?.hostedView.tableView.reloadData()
//        }
//        
//        let nav = UINavigationController(
//            rootViewController: controller
//        )
//        window?.rootViewController = nav
//        super.init(navigationController: nav)
//        controller.routesDelegate = self
    }
}
