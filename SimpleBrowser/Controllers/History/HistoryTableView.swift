//
//  HistoryTableView.swift
//  SimpleBrowser
//
//  Created by Sanatzhan Aimukambetov on 23.12.2020.
//

import UIKit
import RealmSwift

class HistoryTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private var historyItems = [HistoryItem]()

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setup()
        historyItems = StorageManager.getItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        dataSource = self
        delegate = self
        backgroundColor = Constants.bgColor
        
        register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.reuseId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseId, for: indexPath) as! HistoryTableViewCell
        
        let item = historyItems[indexPath.row]
        
        cell.titleLabel.text = item.title
        cell.urlLabel.text = item.url
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
