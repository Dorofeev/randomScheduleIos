//
//  Event.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 10.09.2022.
//

import CalendarKit
import RealmSwift

class RealmEvent: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var day: String
    @Persisted var startTimeInterval: TimeInterval
    @Persisted var durationTime: TimeInterval
    
    func toEvent() -> Event {
        let event = Event()
        event.text = title
        event.dateInterval = DateInterval(
            start: Date(timeIntervalSinceReferenceDate: startTimeInterval),
            duration: durationTime
        )
        return event
    }
}

extension Event {
    func toRealm() -> RealmEvent {
        let event = RealmEvent()
        event.title = text
        event.day = dateInterval.start.formattedDate()
        event.startTimeInterval = dateInterval.start.timeIntervalSinceReferenceDate
        event.durationTime = dateInterval.duration
        return event
    }
}
