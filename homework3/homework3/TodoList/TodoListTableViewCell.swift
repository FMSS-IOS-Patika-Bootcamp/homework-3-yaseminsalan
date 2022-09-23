//
//  TodoListTableViewCell.swift
//  homework3


import UIKit

class TodoListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var toDoView: UIView!
    @IBOutlet weak var toDoStatusButton: UIButton!
    @IBAction func toDoStatusButton(_ sender: Any) {
    }
    @IBOutlet weak var toDoDescriptionLabel: UILabel!
    @IBOutlet weak var toDoDateLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        toDoStatusButton.isUserInteractionEnabled = false
        toDoView.layer.cornerRadius = 8
        toDoView.backgroundColor = .blue.withAlphaComponent(0.3)
        // Configure the view for the selected state
    }

}
