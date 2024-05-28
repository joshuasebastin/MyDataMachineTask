//
//  DetailsViewController.swift
//  MyDataMachine
//
//  Created by Joshua on 27/05/24.
//

import UIKit

class DetailsViewController: UIViewController {
    var post: UserElement? {
        didSet {
            if isViewLoaded { // Check if view is loaded to prevent re-rendering
                updateDetails()
            }
        }
    }
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppDetails().detailScreenTitle
        updateDetails()
        // Do any additional setup after loading the view.
    }
    func updateDetails(){
        titleText.text = post?.title
        bodyTextLabel.text = post?.body
    }
}
