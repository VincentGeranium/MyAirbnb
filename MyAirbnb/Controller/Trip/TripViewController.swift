//
//  TripViewController.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class TripViewController: UIViewController {

    let tableView = UITableView()
    
    let searchBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.opacity = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchBarView: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.searchImageBtn.setImage(UIImage(named: "back33"), for: .normal)
        searchBarView.backgroundColor = .clear
        return searchBarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setAutolayout()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
        searchBarView.useCase = .inTripVC
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    var isStatusBarWhite = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if isStatusBarWhite {
            return .lightContent
        } else {
            return .default
        }
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.separatorStyle = .none
        tableView.register(TripIntroTableViewCell.self, forCellReuseIdentifier: TripIntroTableViewCell.identifier)
        tableView.register(SpecialTripTableViewCell.self, forCellReuseIdentifier: SpecialTripTableViewCell.identifier)
        tableView.register(SeoulRecommenedTripTableViewCell.self, forCellReuseIdentifier: SeoulRecommenedTripTableViewCell.identifier)
        tableView.register(TodaySeoulExperienceTableViewCell.self, forCellReuseIdentifier: TodaySeoulExperienceTableViewCell.identifier)
        view.addSubview(tableView)
        
        view.addSubview(searchBarView)
        searchBarView.filterStackView.isHidden = true
        searchBarView.searchTF.text = "트립"
        
        view.addSubview(searchBarBackgroundView)
        view.bringSubviewToFront(searchBarView)
    }
    
    private func setAutolayout() {
        
        let safeGuide = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        searchBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
       
        searchBarBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBarBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBarBackgroundView.bottomAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10).isActive = true
    }
}


// MARK: - UITableViewDataSource

extension TripViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            tableView.rowHeight = 545

            let introCell = tableView.dequeueReusableCell(withIdentifier: TripIntroTableViewCell.identifier, for: indexPath) as! TripIntroTableViewCell
            
            introCell.delegate = self
            introCell.backgroundColor = .black
            introCell.selectionStyle = .none
            
            return introCell
            
        } else if indexPath.row == 1 {
            tableView.rowHeight = 530
            
            let specialTripCell = tableView.dequeueReusableCell(withIdentifier: SpecialTripTableViewCell.identifier, for: indexPath) as! SpecialTripTableViewCell
            
            specialTripCell.selectionStyle = .none
            
            return specialTripCell
            
        } else if indexPath.row == 2 {
            tableView.rowHeight = 545
            
            let seoulRecommendedTripCell = tableView.dequeueReusableCell(withIdentifier: SeoulRecommenedTripTableViewCell.identifier, for: indexPath) as! SeoulRecommenedTripTableViewCell
            
            seoulRecommendedTripCell.selectionStyle = .none
            seoulRecommendedTripCell.delegate = self
            
            return seoulRecommendedTripCell
            
        } else if indexPath.row == 3 {
            tableView.rowHeight = 900
            
            let todaySeoulExperienceCell = tableView.dequeueReusableCell(withIdentifier: TodaySeoulExperienceTableViewCell.identifier, for: indexPath) as! TodaySeoulExperienceTableViewCell
            
            todaySeoulExperienceCell.selectionStyle = .none
            
            return todaySeoulExperienceCell
            
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension TripViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        // scrollView offset이 (cell.height - backgroundview.height) 일때 opacity가 1이되야함
        // scrollView offset이 대략 200전부터 opacity가 변하기 시작하도록 함
        
        let becomeWhiteEndPoint = 545 - searchBarBackgroundView.frame.height
        let becomeWhiteStartPoint = becomeWhiteEndPoint - 100
        
        if scrollView.contentOffset.y > becomeWhiteStartPoint {
            let opacity = ( scrollView.contentOffset.y - becomeWhiteStartPoint ) / (becomeWhiteEndPoint - becomeWhiteStartPoint)
            searchBarBackgroundView.layer.opacity = Float(opacity)
            isStatusBarWhite = false
        } else {
            searchBarBackgroundView.layer.opacity = 0
            isStatusBarWhite = true
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}

// MARK: - TripIntroTableViewCellDelegate

extension TripViewController: TripIntroTableViewCellDelegate {
    func presentView(index: IndexPath) {
        let avFoundationVC = AVFoundationViewController()
        avFoundationVC.beginPageCount = index.row
        let navi = UINavigationController(rootViewController: avFoundationVC)
        present(navi, animated: true)
    }
}


// MARK: - SeoulRecommenedTripTableViewCellDelegate

extension TripViewController: SeoulRecommenedTripTableViewCellDelegate {
    func pushVC() {
        let detailVC = SeoulRecommendedDetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func pushVCForBtn() {
        let tripAllVC = TripAllViewController()
        navigationController?.pushViewController(tripAllVC, animated: false)
    }
}

