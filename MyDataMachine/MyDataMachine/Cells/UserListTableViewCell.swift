//
//  UserListTableViewCell.swift
//  MyDataMachine
//
//  Created by Joshua on 27/05/24.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(post: UserElement?){
        if let post = post {
            self.titleLabel?.text = "ID:\(post.id) Title: \(post.title)"
        }
    }
}
