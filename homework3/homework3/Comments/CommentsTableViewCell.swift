//
//  CommentsTableViewCell.swift
//  homework3


import UIKit

class CommentsTableViewCell: UITableViewCell {
//private(set) because this "namelabel" value cannot be set from outside
    @IBOutlet private(set) weak var titleLabel: UILabel!
    
    @IBOutlet private(set) weak var bodyLabel: UILabel!
    
    @IBOutlet weak var commentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commentView.layer.cornerRadius = 8
        commentView.backgroundColor = .lightGray.withAlphaComponent(0.2)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
