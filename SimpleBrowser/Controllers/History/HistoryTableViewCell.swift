//
//  HistoryTableViewCell.swift
//  SimpleBrowser
//
//  Created by Sanatzhan Aimukambetov on 23.12.2020.
//

import UIKit
import SnapKit

class HistoryTableViewCell: UITableViewCell {

    static let reuseId = "HistoryTableViewCell"
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = titleLabel.font.withSize(20)
        return titleLabel
    }()
    
    let urlLabel: UILabel = {
       let urlLabel = UILabel()
        urlLabel.textColor = .gray
        return urlLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        selectionStyle = .none
        backgroundColor = Constants.bgColor
        addSubview(titleLabel)
        addSubview(urlLabel)
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(10)
        }
        
        urlLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }

}
