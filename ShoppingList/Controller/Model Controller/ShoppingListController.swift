//
//  ShoppingListController.swift
//  ShoppingList
//
//  Created by Jason Mandozzi on 6/21/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation
import CoreData
import UserNotifications

protocol ItemAdd: class {
    func addItemAlert(Item: ShoppingList)
}

class ShoppingListController {
    
    //Singleton
    
    static let shared = ShoppingListController()
    
    //Creating the fetched results to essentially act as my source of truth
    
    let fetchedResultsController: NSFetchedResultsController<ShoppingList>
    
    init () {
        
        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: false)]
        
        let resultsController: NSFetchedResultsController<ShoppingList> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch!! \(error.localizedDescription)")
        }
    }
    
    func add(Item: ShoppingList, name: String) {
        ShoppingList(name: name)
        saveToPersistentStore()
        
    }
    
    func remove(Item: ShoppingList) {
        CoreDataStack.context.delete(Item)
    }
    
    func toggleIsComplete(Item: ShoppingList) {
        Item.isComplete = !Item.isComplete
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object Context")
        }
    }
}


