//
//  TaskService.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 09.09.2022.
//
import RxSwift
import RealmSwift

class TaskService {
    static let shared = TaskService()
    
    private var tasks: BehaviorSubject<[Task]> = BehaviorSubject(value: [])
    
    private var notificationToken: NotificationToken?
    
    func saveTask(task: Task) {
        let localRealm = try! Realm()
        if let id = task.id {
            let object = localRealm.object(ofType: RealmTask.self, forPrimaryKey: id)
            try! localRealm.write {
                object?.title = task.title
                object?.priority = task.priority
                object?.minTime = task.minTime
                object?.maxTime = task.maxTime
            }
        } else {
            let realmTask = task.toRealm()
            try! localRealm.write {
                localRealm.add(realmTask)
            }
        }
    }
    
    func getTasksValue() -> [Task] {
        return (try? tasks.value()) ?? []
    }
    
    func getTasks() -> Observable<[Task]> {
        let localRealm = try! Realm()
        let result = localRealm.objects(RealmTask.self)
        
        notificationToken =  result.observe { [weak self] result in
            switch result {
            case .initial(let value), .update(let value, _, _, _):
                self?.tasks.onNext(value.map { $0.toTask() })
            case .error(_):
                break
            }
        }
        
        return tasks.asObservable()
    }
    
    func deleteTask(id: ObjectId) {
        let localRealm = try! Realm()
        
        try! localRealm.write {
            guard let item = localRealm.object(ofType: RealmTask.self, forPrimaryKey: id) else {
                return
            }
            localRealm.delete(item)
        }
    }
}
