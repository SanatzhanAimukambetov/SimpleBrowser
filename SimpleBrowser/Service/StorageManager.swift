//
//  StorageManager.swift
//  SimpleBrowser
//
//  Created by Sanatzhan Aimukambetov on 23.12.2020.
//

import RealmSwift

class StorageManager {
    
    private static let realm = try! Realm()
    
    static func saveObject(_ historyItem: HistoryItem) {
        let historyItemRM = HistoryItemRM(item: historyItem)
        try! realm.write {
            realm.add(historyItemRM)
        }
    }
    
    static func getItems() -> [HistoryItem] {
        let objects = realm.objects(HistoryItemRM.self)
        return objects.map{ HistoryItem(itemRM: $0) }.reversed()
    }
}
