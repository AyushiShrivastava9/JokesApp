//
//  JokeListViewController.swift
//  Practice2
//
//  Created by Ayushi on 21/07/23.
//

import UIKit

class JokeListViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 40
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel = JokeListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.dataSource = self
        tableView.delegate = self
        // Fetch joke list
        viewModel.delegate = self
        viewModel.fetchItems()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - UITableViewDataSource
extension JokeListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.noOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let category = viewModel.item(at: indexPath.row) else { return UITableViewCell() }
        let cell = UITableViewCell()
        cell.textLabel?.text = category
        return cell
    }
}

// MARK: - UITableViewDelegate
extension JokeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = viewModel.item(at: indexPath.row) else { return }
        let viewModel = JokeDetailViewModel(category: category)
        let vc = JokeDetailViewController(viewModel: viewModel)
        self.present(vc, animated: false)
    }
}

// MARK: - JokeListViewModelDelegate
extension JokeListViewController: JokeListViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
