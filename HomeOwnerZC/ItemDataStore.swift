//
//  ItemDataStore.swift
//  HomeOwnerZC
//
//  Created by Zhiyi Chen on 3/23/22.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
//    init() {
//        if let data = try? Data(contentsOf: itemArchiveURL) {
//            do {
//                if let loadedItems = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Item] {
//                    allItems = loadedItems
//                }
//            } catch {
//                print("Couldn't read items")
//            }
//        }
//    }
    
    let itemArchiveURL: URL = {
        let documentsDrectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDrectory = documentsDrectories.first!
        return documentsDrectory.appendingPathComponent("items.archive")
    }()
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: false)
            try data.write(to: itemArchiveURL)
            return true
        } catch {
            fatalError("Can't encode data: \(error)")
        }
        //return false
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
}
