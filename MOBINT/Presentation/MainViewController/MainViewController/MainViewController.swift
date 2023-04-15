//
//  ViewController.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let presenter: MainViewOutput

    internal var footerHeight = 100
    internal var isLoading = false
    internal var isMorePage = true

    internal var companysArray = [CompanyViewStruct]() {
        didSet {
            DispatchQueue.main.async {
                self.mainTable.reloadData()
            }
        }
    }

    private lazy var topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Design.Color.backgroundColor
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.Color.mainColor
        label.font = Design.Font.h1
        label.text = "Управление картами"
        return label
    }()

    private lazy var mainTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.backgroundColor = Design.Color.backgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none

        tableView.register(MainTableCell.self, forCellReuseIdentifier: MainTableCell.reuseIdentifier)
        tableView.register(PreloaderFooterView.self, forHeaderFooterViewReuseIdentifier: PreloaderFooterView.reuseIdentifier)
        return tableView
    }()

    //   MARK: - Init

    init(presenter: MainViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Design.Color.white
        configureConstraits()
        presenter.makeCompanyListRequest(currentCount: companysArray.count)
    }
}

extension MainViewController {

    private func configureConstraits() {
        view.addSubview(topLineView)
        topLineView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.right.left.equalToSuperview()
            make.height.equalTo(1)
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLineView.snp.bottom).offset(Design.Indent.redIndent)
            make.centerX.equalToSuperview()
        }

        view.addSubview(mainTable)
        mainTable.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Design.Indent.redIndent)
            make.right.left.bottom.equalToSuperview()
        }
    }
}

//   MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companysArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableCell.reuseIdentifier, for: indexPath) as? MainTableCell else { return UITableViewCell() }
        cell.configureCell(companysArray[indexPath.row])
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tap cell \(indexPath.row)")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        if position > (mainTable.contentSize.height - 100 - scrollView.frame.size.height) && isMorePage {
            if !isLoading {
                isLoading = true
                if footerHeight == 0 {
                    DispatchQueue.main.async {
                        self.footerHeight = 100
                        self.mainTable.reloadData()
                    }
                }
                presenter.makeCompanyListRequest(currentCount: companysArray.count)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(footerHeight)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: PreloaderFooterView.reuseIdentifier) as? PreloaderFooterView else { return UIView() }
        view.startAnimate()
        if !isMorePage {
            view.stopAnimate()
        }
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = view as? UITableViewHeaderFooterView else { return UIView()}
        header.clipsToBounds = true
        return header
    }
}

//   MARK: - MainTableCellDelegate
extension MainViewController: MainTableCellDelegate {

    func tapEyeButton(withTag tag: Int) {
        self.setAlert(title: "Вы нажали кнопку глаза", message: "ID компании - \(companysArray[tag].id)")
    }

    func deleteCompany(withTag tag: Int) {
        self.setAlert(title: "Вы нажали кнопку мусорки", message: "ID компании - \(companysArray[tag].id)")
    }

    func showMoreCompany(withTag tag: Int) {
        self.setAlert(title: "Вы нажали кнопку \"Подробнее\"", message: "ID компании - \(companysArray[tag].id)")
    }
}

//   MARK: - MainViewInput
extension MainViewController: MainViewInput {

    func reloadTable() {
        DispatchQueue.main.async {
            self.mainTable.reloadData()
        }
    }

    func showError(errorMessage: String) {
        footerHeight = 0
        self.mainTable.reloadData()
        self.setErrorAlert(message: errorMessage)
    }
}

