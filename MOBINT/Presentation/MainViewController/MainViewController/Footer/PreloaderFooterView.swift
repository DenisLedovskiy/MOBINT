//
//  PreloaderFooterView.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import UIKit

class PreloaderFooterView: UITableViewHeaderFooterView {

    private lazy var spinnerView: SpinnerView = {
        let spinner = SpinnerView()
        return spinner
    }()

    private lazy var loadLabel: UILabel = {
        let label = UILabel()
        label.font = Design.Font.h2
        label.textColor = Design.Color.highlightTextColor
        label.text = "Подгрузка компаний"
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Design.Color.backgroundColor
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func startAnimate() {
        spinnerView.animate()
    }

    func stopAnimate() {
        spinnerView.stopAnimating()
    }
}

extension PreloaderFooterView {
    private func configureConstraints() {

        contentView.addSubview(spinnerView)
        spinnerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Design.Indent.yellowIndent)
            make.centerX.equalToSuperview()
            make.size.equalTo(40)
        }
        
        contentView.addSubview(loadLabel)
        loadLabel.snp.makeConstraints { make in
            make.top.equalTo(spinnerView.snp.bottom).offset(Design.Indent.yellowIndent)
            make.centerX.equalToSuperview()
        }

        if let lastSubview = self.contentView.subviews.last {
            self.contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 0).isActive = true
        }
    }
}

