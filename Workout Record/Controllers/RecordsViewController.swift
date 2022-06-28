//
//  UpcomingViewController.swift
//  Workout Record
//
//  Created by Ono Makoto on 7/6/2022.
//

import UIKit

let screenSize = UIScreen.main.bounds.size

class RecordsViewController: UIViewController {
    var database = Database()
    var selectedDate: String = ""
    var items = [[Data]]()

    private let recordsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(RecordsViewTableViewCell.self, forCellReuseIdentifier: RecordsViewTableViewCell.identifier)
        return tableView
    }()
    
    private let label: UILabel = {
        let text = UILabel()
        text.text = "Select a date:"
        text.textColor = .white
        text.frame.size = CGSize(width: screenSize.width/2, height: 50)
        return text
    }()
    
    private let datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.frame.size = CGSize(width: screenSize.width/2, height: 50)
        picker.backgroundColor = .systemBackground
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        return picker
    }()
    
    private let pickerStack = UIStackView()
    
    private func config() {
        pickerStack.distribution = .fillEqually
        pickerStack.axis = .horizontal
        pickerStack.frame.size = CGSize(width: screenSize.width, height: 50)
        
        [label, datePicker].forEach {
            pickerStack.addArrangedSubview($0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
        selectedDate = database.formatDate()
        items = database.findByDate(selectedDate: selectedDate)
    
        view.addSubview(recordsTable)
        
        view.backgroundColor = .systemBackground
        
        recordsTable.delegate = self
        recordsTable.dataSource = self
        recordsTable.tableHeaderView = pickerStack
        
        configureNavBar()
    }

    private func configureNavBar() {
        navigationItem.title = "Records"
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        recordsTable.isEditing = editing
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recordsTable.frame = view.bounds
    }
    
    @objc func dateChange(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        selectedDate = formatter.string(from: datePicker.date)
        items = database.findByDate(selectedDate: selectedDate)
        recordsTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items = database.findByDate(selectedDate: selectedDate)
        recordsTable.reloadData()
    }

}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordsViewTableViewCell.identifier, for: indexPath) as? RecordsViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.weightLabel.text = "\(items[indexPath.section][indexPath.row].weight)"
        cell.countLabel.text = "\(items[indexPath.section][indexPath.row].rep_count)"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return items[section][0].type_name
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            database.delete(idToDelete: items[indexPath.section][indexPath.row].id)
            items[indexPath.section].remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if items[indexPath.section].isEmpty {
                tableView.deleteSections([indexPath.section], with: .automatic)
                items.remove(at: indexPath.section)
            }
            tableView.endUpdates()
        }
    }
}
