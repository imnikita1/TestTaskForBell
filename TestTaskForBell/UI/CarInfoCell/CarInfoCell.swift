//
//  CarInfoCell.swift
//  TestTaskForBell
//
//  Created by CMDB-127710 on 30.04.2022.
//

import UIKit

class CarInfoCell: UITableViewCell {

    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet var starsArray: [UIImageView]!

    @IBOutlet weak var detailsStackView: UIStackView!
    @IBOutlet weak var prosStackView: UIStackView!
    @IBOutlet weak var consStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        starsArray.forEach {
            $0.isHidden = true
        }
        detailsStackView.isHidden = false
    }

    override func prepareForReuse() {
        carImageView.image = nil
        carPriceLabel.text = nil
        carModelLabel.text = nil
        starsArray.forEach {
            $0.isHidden = true
        }
        prosStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        consStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }

    func configureCell(with car: Car?) {
        guard let car = car else { return }
        carImageView.image = UIImage(named: car.imageName ?? "")
        carModelLabel.text = car.make + " " + car.model
        carPriceLabel.text = "Price : \(car.marketPrice)"
        for star in 0..<car.rating {
            starsArray[star].isHidden = false
        }

        car.prosList.forEach {
            if !$0.isEmpty {
                let bulletView = BulletView()
                bulletView.setup(with: $0)
                bulletView.translatesAutoresizingMaskIntoConstraints = false
                bulletView.heightAnchor.constraint(equalToConstant: 15).isActive = true
                prosStackView.addArrangedSubview(bulletView)
            }
        }

        car.consList.forEach {
            if !$0.isEmpty {
                let bulletView = BulletView()
                bulletView.setup(with: $0)
                bulletView.translatesAutoresizingMaskIntoConstraints = false
                bulletView.heightAnchor.constraint(equalToConstant: 15).isActive = true
                consStackView.addArrangedSubview(bulletView)
            }
        }
        detailsStackView.isHidden = car.infoIsHidden ?? true
    }
}
