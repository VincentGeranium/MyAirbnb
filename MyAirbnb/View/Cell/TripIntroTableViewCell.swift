//
//  TripIntroTableViewCell.swift
//  MyAirbnb
//
//  Created by Solji Kim on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class TripIntroTableViewCell: UITableViewCell {
    
    private enum UI {
        static let itemsInLine: CGFloat = 1
        static let linesOnScreen: CGFloat = 2
        static let lineSpacing: CGFloat = 20.0
        static let itemSpacing: CGFloat = 0.0
        static let edgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 30, right: 20)
        
        static let nextOffset: CGFloat = 10
    }
    
    static let identifier = "tripIntroTableViewCell"
    
    let redTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Medium", size: 14)
        label.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        label.text = "에어비앤비 트립"
        return label
    }()
    
    let introTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp-Bold", size: 38)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "현지인이 호스팅하는\n하나뿐인 특별한 체험"
        return label
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let images = ["adventure", "kayak", "boxer", "concert", "lp"]
    let categories = ["어드벤처", "어드벤처", "복싱", "콘서트", "역사 투어"]
    let titles = ["갈라파고스 슬로푸드 사파리", "카약을 타고 만나는 스웨덴의 다양한 섬", "세계 챔피언 '파이어'와 함께 권투하기", "워털루의 숨겨진 재즈 클럽", "LP판의 마스터"]
    let hostNames = ["Jill & Javier", "Helena", "Keisher", "Theo And Jannine", "DJ Jigüe"]
    
//    let gradientLayer = CAGradientLayer()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func layoutSublayers(of layer: CALayer) {
//        super.layoutSublayers(of: self.layer)
//        gradientLayer.frame = yourView.bounds
//    }
    
    private func configure() {
        
        contentView.addSubview(redTitleLabel)
        contentView.addSubview(introTitleLabel)
        
//        self.layer.insertSublayer(gradient(frame: self.bounds), at: 0)
//        self.layer.addSublayer(gradient(frame: self.bounds))
//        (gradient(frame: self.bounds), at: 0)
        
        collectionView.dataSource = self
        collectionView.register(TripIntroCollectionViewCell.self, forCellWithReuseIdentifier: TripIntroCollectionViewCell.identifier)
        collectionView.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UI.lineSpacing
        layout.minimumInteritemSpacing = UI.itemSpacing
        
        collectionView.contentInset = UI.edgeInsets
        contentView.addSubview(collectionView)
    }
    
    private func setAutolayout() {
        redTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        redTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120).isActive = true
        redTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        introTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        introTitleLabel.topAnchor.constraint(equalTo: redTitleLabel.bottomAnchor, constant: 15).isActive = true
        introTitleLabel.centerXAnchor.constraint(equalTo: redTitleLabel.centerXAnchor).isActive = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: introTitleLabel.bottomAnchor, constant: 30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
//    func gradient(frame: CGRect) -> CAGradientLayer {
//        let layer = CAGradientLayer()
//        layer.frame = frame
//        layer.startPoint = CGPoint(x: 0, y: 0)
//        layer.endPoint = CGPoint(x: 0, y: 1)
//        layer.colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]
//        return layer
//    }
}


// MARK: - UICollectionViewDataSource

extension TripIntroTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TripIntroCollectionViewCell.identifier, for: indexPath) as! TripIntroCollectionViewCell
        
        cell.imageView.image = UIImage(named: images[indexPath.row])
        cell.categoryLabel.text = categories[indexPath.row]
        cell.titleLabel.text = titles[indexPath.row]
        cell.hostNameLabel.text = hostNames[indexPath.row]
        
        return cell
    }
    
}

extension TripIntroTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let lineSpacing = UI.lineSpacing * (UI.linesOnScreen - 1)
        let horizontalInset = UI.edgeInsets.left + UI.edgeInsets.right
        
        let horizontalSpacing = lineSpacing + horizontalInset + UI.nextOffset
        let cellWidth: CGFloat = ((collectionView.frame.width - horizontalSpacing) / UI.linesOnScreen)
        let cellHeight = collectionView.frame.height * 0.9
        
        let roundedWidth = cellWidth.rounded(.down)
        let roundedHeight = cellHeight.rounded(.down)
        
        return CGSize(width: roundedWidth, height: roundedHeight)
    }
}

