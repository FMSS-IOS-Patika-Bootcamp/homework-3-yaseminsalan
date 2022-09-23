//
//  ViewController.swift
//  homework3


import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = CommentsViewModel()
    private var items:[CommentCellViewModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.viewDelegate = self
        
        viewModel.didViewLoad()
        // Do any additional setup after loading the view.
    }
  

}
private extension CommentsViewController{
    func setupUI(){
        tableView.delegate = self
        tableView.dataSource = self
      
    }
    
    
}

//The structure that ViewModel will notify view. It does this with delegate structure.
extension CommentsViewController:CommentsViewModelViewProtocol{
    func showEmptyView() {
        //TODO
    }
    
    func hideEmptyView() {
        //TODO
    }
    
    func didCellItemFetch(_ items: [CommentCellViewModel]) {
        //TODO
        self.items = items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
    }
    
   
}
extension CommentsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didClickItem(at:indexPath.row)
    }
}

extension CommentsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsTableViewCell
   
        cell.titleLabel.text = items[indexPath.row].title
        cell.bodyLabel.text = items[indexPath.row].body
      
        return cell
    }
}
