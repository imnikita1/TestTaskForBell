//
//  MainViewController.swift
//  TestTaskForBell
//
//  Created by CMDB-127710 on 29.04.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var presenter: MainViewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    private func setupNavigationBar() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "GUIDOMIA"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.backgroundColor = .clear
        label.textColor = .white
        label.textAlignment = .left
        navigationItem.titleView = label
        if let navigationBar = navigationController?.navigationBar {
            label.widthAnchor.constraint(equalTo: navigationBar.widthAnchor, constant: -100).isActive = true
            label.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 15).isActive = true
        }

        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                             style: .plain,
                                             target: self,
                                             action: nil)
        rightBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButton
    }

    private func setupTableView() {
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: Constants.promoCellNibName, bundle: nil),
                           forCellReuseIdentifier: Constants.promoCellReuseID)
        tableView.register(UINib(nibName: Constants.carInfoCellNibName, bundle: nil), forCellReuseIdentifier: Constants.carInfoCellReuseID)
    }

    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return presenter?.getNumberOfRows() ?? 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.height * 0.25
        } else {
            return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return UIScreen.main.bounds.height * 0.2
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = FilterView()
            return view
        }
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return getPromoCell()
        } else {
            return getCarInfoCell(for: indexPath)
        }
    }

    private func getPromoCell() -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.promoCellReuseID) as? PromotionCell else {
            return UITableViewCell()
        }
        let promoCellModel = PromotionCellModel(image: UIImage(named: "Tacoma")!,
                                                titleText: "Tacoma 2021",
                                                promoText: "Get your's now")
        cell.configureCell(with: promoCellModel)
        return cell
    }

    private func getCarInfoCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.carInfoCellReuseID) as? CarInfoCell else {
            return UITableViewCell()
        }
        let carModel = presenter?.getCar(with: indexPath)
        cell.configureCell(with: carModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath)
    }
}

