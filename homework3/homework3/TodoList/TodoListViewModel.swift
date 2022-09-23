//
//  TodoListViewModel.swift
//  homework3


import Foundation

//View is notified with the delegate structure.
protocol ToDoViewModelProtocol:AnyObject{
    //Notifies View
    func didToDoFetch(_ itemsToDo:[ToDoData])
    func showEmptyToDoView()
    func hideEmptyToDoView()
}
class ToDoViewModel{
    //ViewModel has to hold the Model, for this we created a model list
    private let model = ToDoModel()
    
    weak var viewDelegate:ToDoViewModelProtocol?
  
    
    init(){
        //We have delegated the model in Model to receive news from Model
        model.delegateToDo = self
    }
    
    //Informs us that the ViewController is loaded and we can now pull data from the API and perform operations.
    func didViewLoad(){
        model.fetchData()
    }
    
}

private extension ToDoViewModel{
    //we wanted to say that in some cases I will not use it
    @discardableResult
    func makeViewBaseModel(_ commentsImage:[ToDoData]) -> [ToDoData]{
        //we use it to translate the data from the model into the desired structure of the cell
        return commentsImage
    }
}

//MARK:-ToDoModelProtocol
extension ToDoViewModel:ToDoModelProtocol{
    func didToDoFetchProcessFinish(_ isSuccess: Bool) {
    
    
        if isSuccess{
            let commentsImage = model.toDoList
            let cellImageModels = makeViewBaseModel(commentsImage)
            viewDelegate?.didToDoFetch(cellImageModels)
            viewDelegate?.hideEmptyToDoView()
        }
        else{
            viewDelegate?.hideEmptyToDoView()
        }

      
        
    }
}
