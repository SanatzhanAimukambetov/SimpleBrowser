//
//  HistoryItemModel.swift
//  SimpleBrowser
//
//  Created by Sanatzhan Aimukambetov on 23.12.2020.
//

import RealmSwift
import Foundation

struct HistoryItem {
    var title = ""
    var url = ""
}

extension HistoryItem {
    init(itemRM: HistoryItemRM) {
        self.title = itemRM.title
        self.url = itemRM.url
    }
}



