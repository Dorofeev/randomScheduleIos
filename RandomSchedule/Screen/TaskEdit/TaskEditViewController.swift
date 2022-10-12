//
//  TaskEditViewController.swift
//  RandomSchedule
//
//  Created by Andrey Dorofeev on 09.09.2022.
//

import DatePickerDialog
import RxCocoa
import RxSwift
import Coordinators

protocol TaskEditRoutesDelegate: AnyObject {
    func routeBack()
}

class TaskEditViewController: CViewController {
    
    private var viewModel: TaskEditViewModel!
    private var disposeBag = DisposeBag()
    
    weak var routesDelegate: TaskEditRoutesDelegate?
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        
        textField.placeholder = "Task Title"
        return textField
    }()
    
    private lazy var priorityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "priority"
        return label
    }()
    
    private lazy var priorityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        return label
    }()
    
    private lazy var prioritySlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private lazy var minLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "min time: 15"
        return label
    }()
    
    private lazy var minButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitle("Change", for: .normal)
        return button
    }()
    
    private lazy var maxLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "max time: 150"
        return label
    }()
    
    private lazy var maxButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitle("Change", for: .normal)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    override func setup() {
        super.setup()
        
        minButton.addAction(UIAction(handler: { [weak self] _ in
            self?.chooseMinTime()
        }), for: .touchUpInside)
        
        maxButton.addAction(UIAction(handler: { [weak self] _ in
            self?.chooseMaxTime()
        }), for: .touchUpInside)
        
        saveButton.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.saveTask()
        }), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(titleTextField)
        view.addSubview(priorityLabel)
        view.addSubview(priorityValueLabel)
        view.addSubview(prioritySlider)
        view.addSubview(minLabel)
        view.addSubview(minButton)
        view.addSubview(maxLabel)
        view.addSubview(maxButton)
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 16
            ),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            priorityLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 16),
            priorityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            priorityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            priorityValueLabel.topAnchor.constraint(
                equalTo: titleTextField.bottomAnchor,
                constant: 16
            ),
            priorityValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            priorityValueLabel.widthAnchor.constraint(equalToConstant: 50),
            
            prioritySlider.topAnchor.constraint(equalTo: priorityLabel.bottomAnchor, constant: 8),
            prioritySlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            prioritySlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            minLabel.topAnchor.constraint(equalTo: prioritySlider.bottomAnchor, constant: 16),
            minLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            minButton.centerYAnchor.constraint(equalTo: minLabel.centerYAnchor),
            minButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            maxLabel.topAnchor.constraint(equalTo: minLabel.bottomAnchor, constant: 16),
            maxLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            maxButton.centerYAnchor.constraint(equalTo: maxLabel.centerYAnchor),
            maxButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            saveButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
        ])
    }
    
    func bind(viewModel: TaskEditViewModel) {
        self.viewModel = viewModel
        titleTextField.text = try? viewModel.title.value()
        if let priority = try? viewModel.priority.value() {
            prioritySlider.value = Float(priority) / 100
        }
        viewModel.priority.subscribe(onNext: { [weak self] value in
            self?.priorityValueLabel.text = "\(value)"
        }).disposed(by: disposeBag)
        
        viewModel.minTime.subscribe(onNext: { [weak self] value in
            self?.minLabel.text = "Min time: \(value) minutes"
        }).disposed(by: disposeBag)
        
        viewModel.maxTime.subscribe(onNext: { [weak self] value in
            self?.maxLabel.text = "Max time: \(value) minutes"
        }).disposed(by: disposeBag)
        
        titleTextField.rx.text.subscribe(onNext: { [weak viewModel] value in
            viewModel?.title.onNext(value ?? "")
        }).disposed(by: disposeBag)
        
        prioritySlider.rx.value.subscribe(onNext: { [weak viewModel] value in
            viewModel?.priority.onNext(Int(value * 100))
        }).disposed(by: disposeBag)
        
        viewModel.routesDelegate = routesDelegate
        
        if viewModel.isShowDeleteButton {
            let item = UIBarButtonItem(systemItem: .trash)
            item.primaryAction = UIAction(handler: { [weak self] _ in
                self?.deleteAction()
            })
            self.navigationItem.rightBarButtonItem = item
        }
    }
    
    private func chooseMinTime() {
        let dialog = DatePickerDialog()
        dialog.show("Min date", datePickerMode: .countDownTimer) { [weak viewModel] date in
            if let date = date {
                viewModel?.minTime.onNext(Int(date.timeIntervalSinceReferenceDate / 60))
            }
        }
        dialog.datePicker.countDownDuration = Double((try? viewModel.minTime.value()) ?? 0) * 60
    }
    
    private func chooseMaxTime() {
        let dialog = DatePickerDialog()
        dialog.show("Max date", datePickerMode: .countDownTimer) { [weak viewModel] date in
            if let date = date {
                viewModel?.maxTime.onNext(Int(date.timeIntervalSinceReferenceDate / 60))
            }
        }
        dialog.datePicker.countDownDuration = Double((try? viewModel.maxTime.value()) ?? 0) * 60
    }
    
    @objc private func deleteAction() {
        viewModel.deleteTask()
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
