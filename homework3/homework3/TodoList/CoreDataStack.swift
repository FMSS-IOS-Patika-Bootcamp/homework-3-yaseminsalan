//
//  CoreDataStack.swift
//  homework3

import Foundation
import CoreData

class CoreDataStack{
    
    private let modelName:String
    init(modelName: String) {
        self.modelName = modelName
    }
    //We have defined layz to be created once, we do not need to create it continuously.
    //we created a container
    private lazy var storeContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores{_, error in
            if let error = error{
                print("unsuccesfull container loading...\(error.localizedDescription)")
            }
    }
        return container
    }()
    //data will be accessed through the container. We need a managedObjectContext to access them
    lazy var managedContext:NSManagedObjectContext = self.storeContainer.viewContext
    
    func saveContext(){
        //if there is a change we save, if there is no change we do not save
        guard managedContext.hasChanges else{
            return
        }
        
        do{
          
            try managedContext.save()
            print("kayıt başarılı")
        }catch let error as NSError{
            print("unresolved error\(error)")
        }
        
    }
    func updateContext(date:Date,status:Bool,description:String)  {
      var success = false
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ToDoData")
        fetchRequest.predicate = NSPredicate(format: "date = %@", date as CVarArg)

      do {
        let test = try managedContext.fetch(fetchRequest)
        if test.count == 1 {
          let objectUpdate = test[0] as! NSManagedObject
          objectUpdate.setValue(description, forKey: #keyPath(ToDoData.toDoDescription))
            objectUpdate.setValue(status, forKey: #keyPath(ToDoData.toDoStatus))
            objectUpdate.setValue(date, forKey: #keyPath(ToDoData.date))
            
            managedContext.updatedObjects
       
            try managedContext.save()
    
  
        }
      } catch {
        print(error)
      }
     
    }
    
}
