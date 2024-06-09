//
//  DiscoverViewController.swift
//  Pollexa
//
//  Created by Emirhan Erdogan on 13/05/2024.
//

import UIKit

class DiscoverViewController: UIViewController {

    // MARK: - Properties
    
    let viewModel: ViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aCoder: NSCoder) {
        self.viewModel = ViewModel()
        super.init(coder: aCoder)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setTableView()
        viewModel.delegate = self
        viewModel.retrievePosts()
    }
    
    func setNavigationBar() {
        
        let profileButton = UIButton(type: .custom)
        profileButton.frame = CGRect(origin: .zero, size: CGSize(width: 34, height: 34)) // Adjust size as needed
        profileButton.layer.cornerRadius = profileButton.frame.height / 2// Half of the button's height for a circular shape
        profileButton.clipsToBounds = true
        
        let imageView = UIImageView(image: .avatar)
        imageView.frame = profileButton.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = profileButton.layer.cornerRadius
        imageView.clipsToBounds = true
        
        profileButton.addSubview(imageView)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.title = "Pollexa"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: PostTableViewCell.nameOfClass, bundle: nil),
            forCellReuseIdentifier: PostTableViewCell.nameOfClass
        )
    }
    
    func setTableViewHeader() {
        let headerView = DiscoverHeader(postCount: viewModel.getPostCount())
        headerView.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 128))
        tableView.tableHeaderView = headerView
    }
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getPostCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.nameOfClass,
            for: indexPath
        ) as? PostTableViewCell
        else {
            return  UITableViewCell()
        }
        
        if let post = viewModel.postConents?[indexPath.item] {
            cell.set(post)
            cell.delegate = self
        }
        
        return cell
    }
}

extension DiscoverViewController: ViewModelDelegate {
    func updateList() {
        tableView.reloadData()
        setTableViewHeader()
    }
}

extension DiscoverViewController: PostTableViewCellDelegate {
    func optionSelected(optionId: String, postId: String) {
        viewModel.updatePoll(postId: postId, optionId: optionId)
    }
}
