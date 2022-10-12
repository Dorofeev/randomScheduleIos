//
//  TaskEditViewModel.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 09.09.2022.
//

import RxSwift
import RealmSwift
import Coordinators

class TaskEditViewModel: ViewModel {
    typealias Item = Task
    
    private var objectId: ObjectId?
    var title: BehaviorSubject<String>
    var priority: BehaviorSubject<Int>
    var minTime: BehaviorSubject<Int>
    var maxTime: BehaviorSubject<Int>
    
    private(set) var isShowDeleteButton: Bool = false
    
    weak var routesDelegate: TaskEditRoutesDelegate?
    
    required init() {
        title = BehaviorSubject(value: "")
        priority = BehaviorSubject(value: 0)
        minTime = BehaviorSubject(value: 15)
        maxTime = BehaviorSubject(value: 120)
    }
    
    init(task: Task) {
        isShowDeleteButton = task.id != nil
        objectId = task.id
        title = BehaviorSubject(value: task.title)
        priority = BehaviorSubject(value: task.priority)
        minTime = BehaviorSubject(value: task.minTime)
        maxTime = BehaviorSubject(value: task.maxTime)
    }
    
    func saveTask() {
        TaskService.shared.saveTask(
            task: Task(
                id: objectId,
                title: (try? title.value()) ?? "",
                priority: (try? priority.value()) ?? 0,
                minTime: (try? minTime.value()) ?? 0,
                maxTime: (try? maxTime.value()) ?? 0
            )
        )
        
        routesDelegate?.routeBack()
    }
    
    func deleteTask() {
        guard let id = objectId else {
            return
        }
        TaskService.shared.deleteTask(id: id)
        routesDelegate?.routeBack()
    }
}
