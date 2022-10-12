//
//  Task.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 09.09.2022.
//
import RealmSwift

struct Task {
    var id: ObjectId?
    var title: String
    var priority: Int
    var minTime: Int
    var maxTime: Int
    
    func toRealm() -> RealmTask {
        let task = RealmTask()
        task.title = title
        task.priority = priority
        task.maxTime = maxTime
        task.minTime = minTime
        return task
    }
}

class RealmTask: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var priority: Int
    @Persisted var minTime: Int
    @Persisted var maxTime: Int
    
    func toTask() -> Task {
        return Task(id: _id, title: title, priority: priority, minTime: minTime, maxTime: maxTime)
    }
}
