//
//  EventsService.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 10.09.2022.
//

import CalendarKit
import RealmSwift

class EventService {
    static let shared = EventService()
    
    func getEvents(for date: Date) -> [Event] {
        let localRealm = try! Realm()
        let events = localRealm.objects(RealmEvent.self)
        print(events)
        let filteredEvents = events.where { query in
            query.day == date.formattedDate()
        }
        return filteredEvents.map { $0.toEvent() }
    }
    
    func generateEvents(since date: Date) {
        
        var events: [Event] = []
        var currentDate = date
        
        repeat {
            let newEvent = generateEvent(date: currentDate)
            currentDate = newEvent.dateInterval.end.addingTimeInterval(300)
            events.append(newEvent)
        } while !currentDate.isHalfHourBeforeTomorrow(day: date)
        
        let localRealm = try! Realm()
        
        let realmEvents = events.map { $0.toRealm() }
        
        try! localRealm.write {
            localRealm.add(realmEvents)
        }
    }
    
    func generateEvent(date: Date) -> Event {
        let event = Event()
        let tasks = TaskService.shared.getTasksValue()
        
        let number = Randomizer.randomRandom() - 1
        
        let task = tasks[number % tasks.count]
        
        event.text = task.title
        
        let duration = stride(
            from: task.minTime,
            through: task.maxTime,
            by: 15
        ).shuffled().first!
        event.dateInterval = DateInterval(start: date, duration: TimeInterval(duration * 60))
        return event
    }
}
