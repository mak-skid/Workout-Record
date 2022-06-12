//
//  UpcomingViewController.swift
//  Workout Record
//
//  Created by Ono Makoto on 7/6/2022.
//

import UIKit

let screenSize = UIScreen.main.bounds.size

class RecordsViewController: UIViewController {
    var datePicker : UIDatePicker = UIDatePicker()
    
    private let recordsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(RecordsViewTableViewCell.self, forCellReuseIdentifier: RecordsViewTableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = UILabel()
        text.text = "Select a date"
        text.textColor = .white
        text.frame = CGRect(x: 0, y: 50, width: screenSize.width/2, height: 50)
        
        datePicker.frame = CGRect(x: 100, y: 50, width: screenSize.width/2, height: 50)
        datePicker.backgroundColor = .systemBackground
        datePicker.datePickerMode = .date
        
        view.addSubview(text)
        view.addSubview(datePicker)
        view.addSubview(recordsTable)
        
        view.backgroundColor = .systemBackground
        
        recordsTable.delegate = self
        recordsTable.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recordsTable.frame = CGRect(x: 0, y: screenSize.height*0.1+50, width: screenSize.width, height: screenSize.height)
    }
}

let date = ["Bench Press", "Half Deadlift", "Seated Rowing", "Arnold Press"]
let items = [[10, 8, 9], [10, 10, 9], [5, 5, 5, 5, 5], [10, 8]]

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return date.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordsViewTableViewCell.identifier, for: indexPath) as? RecordsViewTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = String(items[indexPath.section][indexPath.row])
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
        return date[section]
    }
}
