//
//  MainTableCell.swift
//  MOBINT
//
//  Created by Денис Ледовский on 14.04.2023.
//

import UIKit
import Kingfisher

protocol MainTableCellDelegate: AnyObject {
    func tapEyeButton(withTag tag: Int)
    func deleteCompany(withTag tag: Int)
    func showMoreCompany(withTag tag: Int)
}

class MainTableCell: UITableViewCell {

    weak var delegate: MainTableCellDelegate?

    private lazy var backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = Design.Color.cardBackgroundColor
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.Color.highlightTextColor
        label.font = Design.Font.h1
        return label
    }()

    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Design.Color.white
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Design.Color.backgroundColor
        return view
    }()

    private lazy var scoreCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.Color.highlightTextColor
        label.font = Design.Font.h1
        return label
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.Color.textColor
        label.font = Design.Font.h2
        return label
    }()

    private lazy var cashBackLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.Color.textColor
        label.font = Design.Font.h3
        label.text = "Кешбэк"
        return label
    }()

    private lazy var cashBackCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.Color.highlightTextColor
        label.font = Design.Font.h2
        return label
    }()

    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.Color.textColor
        label.font = Design.Font.h3
        label.text = "Уровень"
        return label
    }()

    private lazy var levelDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Design.Color.highlightTextColor
        label.font = Design.Font.h2
        return label
    }()

    private lazy var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Design.Color.backgroundColor
        return view
    }()

    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(Design.Image.eye, for: .normal)
        button.tintColor = Design.Color.mainColor
        button.addTarget(self, action: #selector(tapEye), for: .touchUpInside)
        return button
    }()

    private lazy var trashButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(Design.Image.trash, for: .normal)
        button.tintColor = Design.Color.accentColor
        button.addTarget(self, action: #selector(tapTrash), for: .touchUpInside)
        return button
    }()

    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Design.Color.backgroundColor
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Design.Font.h2,
            .foregroundColor: Design.Color.mainColor
        ]
        let attributedString = NSAttributedString(string: "Подробнее", attributes: attributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tapMore), for: .touchUpInside)
        return button
    }()

// MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = .clear
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

// MARK: - configureCell
    func configureCell(_ company: CompanyViewStruct) {
        titleLabel.text = company.titleCompany
        if let imgUrl = URL(string: company.urlLogo) {
            logoImage.kf.setImage(with: imgUrl, options: [
                .cacheOriginalImage
            ])
        } else {
            logoImage.image = Design.Image.logo
        }
        scoreCountLabel.text = company.score.description
        cashBackCountLabel.text = company.cashback + " %"
        levelDescriptionLabel.text = company.level
        scoreLabel.text = checkLastNumber(company.score)
    }
}

// MARK: - Constraits
extension MainTableCell {
    private func configureConstraints() {

        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Design.Indent.redIndent)
            make.left.right.equalToSuperview().inset(Design.Indent.redIndent)
            make.bottom.equalToSuperview()
        }

        backView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Design.Indent.redIndent)
            make.right.equalToSuperview().inset(Design.Indent.redIndent)
            make.size.equalTo(40)
        }

        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImage.snp.centerY)
            make.left.equalToSuperview().inset(Design.Indent.redIndent)
        }

        backView.addSubview(topLineView)
        topLineView.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(Design.Indent.yellowIndent)
            make.left.right.equalToSuperview().inset(Design.Indent.redIndent)
            make.height.equalTo(1)
        }

        backView.addSubview(scoreCountLabel)
        scoreCountLabel.snp.makeConstraints { make in
            make.top.equalTo(topLineView.snp.bottom).offset(Design.Indent.redIndent)
            make.left.equalToSuperview().inset(Design.Indent.redIndent)
        }

        backView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { make in
            make.bottom.equalTo(scoreCountLabel.snp.bottom)
            make.left.equalTo(scoreCountLabel.snp.right).offset(Design.Indent.yellowIndent)
        }

        backView.addSubview(cashBackLabel)
        cashBackLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreCountLabel.snp.bottom).offset(Design.Indent.redIndent)
            make.left.equalToSuperview().inset(Design.Indent.redIndent)
        }

        backView.addSubview(cashBackCountLabel)
        cashBackCountLabel.snp.makeConstraints { make in
            make.top.equalTo(cashBackLabel.snp.bottom).offset(Design.Indent.yellowIndent)
            make.left.equalToSuperview().inset(Design.Indent.redIndent)
        }

        backView.addSubview(levelLabel)
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(cashBackLabel.snp.top)
            make.left.equalTo(cashBackLabel.snp.right).offset(Design.Indent.blueIndent)
        }

        backView.addSubview(levelDescriptionLabel)
        levelDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).offset(Design.Indent.yellowIndent)
            make.left.equalTo(levelLabel.snp.left)
        }

        backView.addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints { make in
            make.top.equalTo(levelDescriptionLabel.snp.bottom).offset(Design.Indent.yellowIndent)
            make.left.right.equalToSuperview().inset(Design.Indent.redIndent)
            make.height.equalTo(1)
        }

        backView.addSubview(eyeButton)
        eyeButton.snp.makeConstraints { make in
            make.left.equalTo(bottomLineView.snp.left).inset(Design.Indent.redIndent)
            make.top.equalTo(bottomLineView.snp.bottom).offset(Design.Indent.redIndent)
            make.size.equalTo(20)
        }

        backView.addSubview(trashButton)
        trashButton.snp.makeConstraints { make in
            make.centerY.equalTo(eyeButton.snp.centerY)
            make.left.equalTo(eyeButton.snp.right).offset(Design.Indent.blueIndent)
            make.size.equalTo(20)
        }

        backView.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(bottomLineView.snp.bottom).offset(Design.Indent.yellowIndent)
            make.right.equalToSuperview().inset(Design.Indent.redIndent)
            make.bottom.equalToSuperview().inset(Design.Indent.redIndent)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }

        if let lastSubview = self.contentView.subviews.last {
            self.contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 0).isActive = true
        }
    }
}

// MARK: - Actions
extension MainTableCell {

    @objc
    private func tapEye() {
        delegate?.tapEyeButton(withTag: self.tag)
    }

    @objc
    private func tapTrash() {
        delegate?.deleteCompany(withTag: self.tag)
    }

    @objc
    private func tapMore() {
        delegate?.showMoreCompany(withTag: self.tag)
    }
}

extension MainTableCell {

    private func checkLastNumber(_ score: Int) -> String {
        if score < 100 {
            let lastNumber = score.description.last
            switch lastNumber {
            case "1":
                if score.description.count != 2 {
                    return "балл"
                } else {
                    return "баллов"
                }
            case "2","3","4":
                if score.description.count != 2 {
                    return "балла"
                } else {
                    return "баллов"
                }
            default:
                return "баллов"
            }
        } else {
            let lastNumber = score.description.last
            var newScore = score.description
            newScore.removeLast()
            let secondLastNumber = newScore.last
            if secondLastNumber == "1" {
                return "баллов"
            } else {
                switch lastNumber {
                case "1":
                    return "балл"
                case "2","3","4":
                    return "балла"
                default:
                    return "баллов"
                }
            }
        }
    }
}


