//
//  ViewController.swift
//  MyDataMachine
//
//  Created by Joshua on 27/05/24.
//

import UIKit

class ViewController: UIViewController {
    private var viewModel = UserDetailsViewModel()
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        viewModel.loadMoreData()
        bindViewModel()
        setupIndicator()
        showActivityIndicator()
    }
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: AppDetails().userListCell)
    }
    func setupIndicator(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        
        activityIndicator?.center = view.center
        activityIndicator?.hidesWhenStopped = true
        if let activityIndicator = activityIndicator {
            view.addSubview(activityIndicator)
        }
    }
    func showActivityIndicator() {
        self.activityIndicator?.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.activityIndicator?.stopAnimating()
    }
    func bindViewModel() {
        viewModel.updateHandler = { [weak self] status in
            if status {
                self?.hideActivityIndicator()
                self?.tableView.reloadData()
            } else {
                self?.hideActivityIndicator()
            }
        }
    }
    // MARK: - Navigation
    func navigateToDetailScreen(index:Int){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let switchObject = storyBoard.instantiateViewController(withIdentifier: "DetailsViewControllerID") as? DetailsViewController{
            switchObject.post = viewModel.getPost(at: index)
            self.navigationController?.pushViewController(switchObject, animated: true)
        }
    }
    
}

// MARK: - TableView Delegates And DataSource
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(index: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AppDetails().userListCell, for: indexPath) as? UserListTableViewCell {
            let post = viewModel.getPost(at: indexPath.row)
            cell.setData(post: post)
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = (viewModel.user.count) - 3 // Load data before 3 rows before for reduce loading time
        if indexPath.row == lastIndex && !viewModel.isLoading {
            viewModel.currentPage += 1
            showActivityIndicator()
            viewModel.loadMoreData()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigateToDetailScreen(index: indexPath.row)
    }
}
