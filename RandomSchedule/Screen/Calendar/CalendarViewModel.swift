//
//  CalendarViewModel.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 10.09.2022.
//

import Coordinators
import CalendarKit

class CalendarViewModel: ViewModel {
    typealias Item = Task
    
    var updateView: (() -> Void)?
    
    weak var routerDelegate: CalendarRouterDelegate?
    
    required init() {
    }
    
    func generateScheduleAlert(for date: Date) {
        let alert = UIAlertController(
            title: "Generate Schedule",
            message: "for \(date.formattedFullDate())",
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let agree = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            EventService.shared.generateEvents(since: date)
            self?.updateView?()
        }
        alert.addAction(cancel)
        alert.addAction(agree)
        routerDelegate?.showAlert(controller: alert)
    }
}

extension CalendarViewModel: EventDataSource {
    func eventsForDate(_ date: Date) -> [EventDescriptor] {
        print("ohohoh")
        return EventService.shared.getEvents(for: date)
    }
}

extension CalendarViewModel: DayViewDelegate {
    func dayViewDidSelectEventView(_ eventView: EventView) {
        let date = eventView
            .descriptor!
            .dateInterval
            .start
            .formattedTime()
        let duration = eventView.descriptor!.dateInterval.duration / 60
        let message = "start: \(date), duration \(duration) minutes"
        let alert = UIAlertController(
            title: eventView.descriptor!.text,
            message: message,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        routerDelegate?.showAlert(controller: alert)
    }
    
    func dayViewDidLongPressEventView(_ eventView: EventView) {
        
    }
    
    func dayView(dayView: DayView, didTapTimelineAt date: Date) {
        generateScheduleAlert(for: date)
    }
    
    func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
        generateScheduleAlert(for: date)
    }
    
    func dayViewDidBeginDragging(dayView: DayView) {
        
    }
    
    func dayViewDidTransitionCancel(dayView: DayView) {
        
    }
    
    func dayView(dayView: DayView, willMoveTo date: Date) {
        
    }
    
    func dayView(dayView: DayView, didMoveTo date: Date) {
        
    }
    
    func dayView(dayView: DayView, didUpdate event: EventDescriptor) {
        
    }
}
