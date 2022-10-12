//
//  CalendarViewController.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 10.09.2022.
//

import Coordinators
import CalendarKit

protocol CalendarRouterDelegate: AnyObject {
    func showAlert(controller: UIAlertController)
}

class CalendarViewController: DayViewController {
    private var viewModel: CalendarViewModel!
    
    weak var routerDelegate: CalendarRouterDelegate? {
        didSet {
            viewModel.routerDelegate = routerDelegate
        }
    }
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.updateView = { [weak self] in
            self?.dayView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = viewModel
        self.dataSource = viewModel
        self.dayView.reloadData()
    }
}
