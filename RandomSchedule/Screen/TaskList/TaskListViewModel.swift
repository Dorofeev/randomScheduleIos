//
//  TaskListViewModel.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 09.09.2022.
//
import Coordinators
import RxSwift

class TaskListViewModel: ListViewModel {
        
    struct TaskSection: Coordinators.Section {
        var title: String
        var items: [Task]
    }
    
    typealias Section = TaskSection
    
    typealias Item = Task
    
    var sections: [TaskSection] {
        didSet {
            onSectionsUpdate?()
        }
    }
    
    var onSectionsUpdate: (() -> Void)?
    
    private var disposeBag = DisposeBag()
    
    weak var routesDelegate: TaskRoutesDelegate?
    
    required init(sections: [TaskSection]) {
        self.sections = sections
    }
    
    required init() {
        self.sections = []
        TaskService.shared.getTasks().subscribe(onNext: { [weak self] tasks in
            self?.sections = [Section(title: "", items: tasks)]
        }).disposed(by: disposeBag)
    }
    
    func didSelect(index: Int) {
        routesDelegate?.routeToDetails(task: sections[0].items[index])
    }
}
