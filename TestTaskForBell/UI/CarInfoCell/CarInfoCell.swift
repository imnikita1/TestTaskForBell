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

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        starsArray.forEach {
            $0.isHidden = true
        }
    }

    override func prepareForReuse() {
        carImageView.image = nil
        carPriceLabel.text = nil
        carModelLabel.text = nil
        starsArray.forEach {
            $0.isHidden = true
        }
    }

    func configureCell(with car: Car?) {
        guard let car = car else { return }
        carImageView.image = UIImage(named: car.imageName ?? "")
        carModelLabel.text = car.make + " " + car.model
        carPriceLabel.text = "Price : \(car.marketPrice)"
        for star in 0..<car.rating {
            starsArray[star].isHidden = false
        }
    }
}
