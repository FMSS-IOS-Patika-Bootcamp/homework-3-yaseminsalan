//
//  TodoListModel.swift
//  homework3

import Foundation
import CoreData

//Protocol was used to transfer the data from the API to the viewModel
protocol ToDoModelProtocol:AnyObject{
    func didToDoFetchProcessFinish(_ isSuccess:Bool)
}

class ToDoModel{
    //Notifies ViewModel
    weak var delegateToDo:ToDoModelProtocol?
    var toDoList:[ToDoData] = []
    func fetchData(){
      
                
                
            
        let fetchRequest:NSFetchRequest<ToDoData> = ToDoData.fetchRequest()
        
        //we sort the incoming data by date
        //we have made false to be first in last registration
        let sortByDate = NSSortDescriptor(key: #keyPath(ToDoData.date), ascending: false)
        fetchRequest.sortDescriptors = [sortByDate]
        
        
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try context.fetch(fetchRequest)
            results.map{$0.date}
            print(results)
            self.toDoList = results
            self.delegateToDo?.didToDoFetchProcessFinish(true)
            
        }catch{
            print(error.localizedDescription)
            self.delegateToDo?.didToDoFetchProcessFinish(false)
        }
        
        
        
    

    }
}
