//
//  TodoListViewController.swift
//  homework3

import UIKit

class TodoListViewController: UIViewController {
    // Create Date
    let date = Date()

    // Create Date Formatter
    let dateFormatter = DateFormatter()


    let toDoAddButton = UIButton(type: .custom)
    @IBOutlet weak var tableView: UITableView!
    private let viewToDoModel = ToDoViewModel()
    private var itemsToDo:[ToDoData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewToDoModel.viewDelegate = self
        viewToDoModel.didViewLoad()
    }
  
 

}
private extension TodoListViewController{
    func setupUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        floatingButton()
        navigationController?.navigationBar.topItem!.title = "TODO"
     
    }
  
    func floatingButton(){
        let image = UIImage(systemName: "plus") as UIImage?
        
        toDoAddButton.isAccessibilityElement = true
        toDoAddButton.accessibilityTraits = UIAccessibilityTraits.button
        toDoAddButton.frame = CGRect(x: (view.frame.width/2)+(view.frame.width/4), y: (((view.frame.height/2)+(view.frame.height/4))-5), width: 60, height: 60)
        // btn.setTitle("Feed", for: .normal)
        toDoAddButton.setImage(image, for: .normal)
        toDoAddButton.clipsToBounds = true
        toDoAddButton.backgroundColor = .lightGray
        toDoAddButton.layer.cornerRadius = 30
        toDoAddButton.addTarget(self,action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(toDoAddButton)
    }
    @objc func buttonTapped()
    {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "toDoListDetailStoryboard") as? ToDoListDetailAndAddViewController
        {
            vc.addControl = true
            self.navigationController?.pushViewController(vc, animated: true)
           // present(vc, animated: true)
         
        }
    }
   /**/
}
extension TodoListViewController:ToDoViewModelProtocol{
    func didToDoFetch(_ itemsToDo: [ToDoData]) {
        //TODO
        self.itemsToDo = itemsToDo
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showEmptyToDoView() {
        //
    }
    
    func hideEmptyToDoView() {
        //
    }
  
    
    
}
extension TodoListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "toDoListDetailStoryboard") as? ToDoListDetailAndAddViewController
        {
            vc.toDoListItem = itemsToDo[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
         
        }
    }
}

extension TodoListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsToDo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath) as! TodoListTableViewCell
        // Set Date Format
        dateFormatter.dateFormat = "YY, MMM d, hh:mm"
        cell.toDoDescriptionLabel.text = itemsToDo[indexPath.row].toDoDescription
        cell.toDoDateLabel.text =  dateFormatter.string(from: itemsToDo[indexPath.row].date!)
        if itemsToDo[indexPath.row].toDoStatus{
            
            cell.toDoStatusButton.setImage(UIImage(named: "toDoClosed"), for: .normal)
        }else{
            cell.toDoStatusButton.setImage(UIImage(named: "todoOpen"), for: .normal)
        }
        return cell
    }
}
