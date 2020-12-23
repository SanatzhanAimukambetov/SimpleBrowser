//
//  HistoryViewController.swift
//  SimpleBrowser
//
//  Created by Sanatzhan Aimukambetov on 23.12.2020.
//

import UIKit
import SnapKit

class HistoryViewController: UIViewController {
    
    let topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = Constants.grayColor
        return topView
    }()
    
    let mainLabel: UILabel = {
       let mainLabel = UILabel()
        mainLabel.text = "История"
        mainLabel.textColor = .white
        mainLabel.font = mainLabel.font.withSize(25)
        return mainLabel
    }()
    
    lazy var backButton: UIButton = {
       let backButton = UIButton()
        backButton.setTitle("Готово", for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return backButton
    }()
    
    let historyTableView = HistoryTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    @objc private func goBack() {
        
        dismiss(animated: true, completion: nil)
    }
    
    private func setupViews() {
        
        //Добавление основных элементов
        view.addSubview(historyTableView)
        view.addSubview(topView)
        
        //Добавление второстепенных элементов
        topView.addSubview(mainLabel)
        topView.addSubview(backButton)
        
    }
    
    private func setupConstraints() {
        
        //Constraints основных элементов
        topView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        historyTableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        //Constraints второстепенных элементов
        mainLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }

}
