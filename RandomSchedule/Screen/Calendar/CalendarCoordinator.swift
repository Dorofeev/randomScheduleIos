//
//  CalendarCoordinator.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 10.09.2022.
//

import Coordinators

class CalendarCoordinator: UICoordinator {
    
    init() {
        let viewModel = CalendarViewModel()
        
        let controller = CalendarViewController(viewModel: viewModel)
        controller.title = "Calendar"
        
        let nav = UINavigationController(
            rootViewController: controller
        )
        nav.view.backgroundColor = .white
        super.init(navigationController: nav)
        controller.routerDelegate = self
    }
}

extension CalendarCoordinator: CalendarRouterDelegate {
    func showAlert(controller: UIAlertController) {
        self.navigationController.present(controller, animated: true)
    }
}
