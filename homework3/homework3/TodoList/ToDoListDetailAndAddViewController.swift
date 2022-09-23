//
//  ToDoListDetailAndAddViewController.swift
//  homework3


import UIKit
import CoreData

class ToDoListDetailAndAddViewController: UIViewController {
    
    var statusControl:Bool=false
    //checking which page you are coming for
    var addControl:Bool=false
    
 
    var toDoListItem = ToDoData()
    @IBOutlet weak var todoView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var toDoDescriptionTextView: UITextView!
    @IBOutlet weak var statusOpenButton: UIButton!
    @IBOutlet weak var statusClosedButton: UIButton!
    
    @IBAction func statusClosedButton(_ sender: Any) {
        statusControl = false
        statusClosedButton.isHidden = true
        statusClosedButton.isUserInteractionEnabled = false
        statusOpenButton.isHidden = false
        statusClosedButton.isUserInteractionEnabled = true
      if addControl == false{
            updateDataWithCoreData()
        }
    }
    
    @IBAction func statusOpenButton(_ sender: Any) {
        
        statusControl = true
        statusClosedButton.isHidden = false
        statusClosedButton.isUserInteractionEnabled = true
        statusOpenButton.isHidden = true
        statusOpenButton.isUserInteractionEnabled = false
        if addControl == false{
              updateDataWithCoreData()
          }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        saveDataWithCoreData()
       
        //self.navigationController!.dismiss(animated: false, completion:nil)
        dismiss(animated: true)
    }
    
    private func saveDataWithCoreData(){
        
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        let data = ToDoData(context: managedContext)
        
        if let description = toDoDescriptionTextView.text{
            data.setValue(description, forKey: #keyPath(ToDoData.toDoDescription))
        }
        data.setValue(statusControl, forKey: #keyPath(ToDoData.toDoStatus))
        data.setValue(Date(), forKey: #keyPath(ToDoData.date))
        //we save our created object
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
    }
    private func updateDataWithCoreData(){
     
        AppDelegate.sharedAppDelegate.coreDataStack.updateContext(date: toDoListItem.date!,status:statusControl,description:toDoListItem.toDoDescription!)
    }
    
    private func statusButtonControl(){
        if addControl{
            
        }
        else{
            toDoDescriptionTextView.isUserInteractionEnabled = false
            toDoDescriptionTextView.text = toDoListItem.toDoDescription
            if toDoListItem.toDoStatus{
                statusClosedButton.isHidden = false
                statusClosedButton.isUserInteractionEnabled = true
                statusOpenButton.isHidden = true
                statusOpenButton.isUserInteractionEnabled = false
            }else{
               
                
                statusClosedButton.isHidden = true
                statusClosedButton.isUserInteractionEnabled = false
                statusOpenButton.isHidden = false
                statusOpenButton.isUserInteractionEnabled = true
            }
            
            saveButton.isHidden = true
            saveButton.isUserInteractionEnabled = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        statusButtonControl()
        setupUI()
        // Do any additional setup after loading the view.
    }
    

}
private extension ToDoListDetailAndAddViewController{
    func setupUI(){
        
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = .blue.withAlphaComponent(0.3)
        
    }}
