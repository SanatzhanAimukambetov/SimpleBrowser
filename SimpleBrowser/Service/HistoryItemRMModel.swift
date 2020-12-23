//
//  HistoryItemRMModel.swift
//  SimpleBrowser
//
//  Created by Sanatzhan Aimukambetov on 23.12.2020.
//

import Foundation
import RealmSwift

class HistoryItemRM: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var url = ""
    
    convenience init(title: String, url: String) {
        self.init()
        self.title = title
        self.url = url
    }
}

extension HistoryItemRM {
    convenience init(item: HistoryItem) {
        self.init(title: item.title,
                  url: item.url)
    }
}
