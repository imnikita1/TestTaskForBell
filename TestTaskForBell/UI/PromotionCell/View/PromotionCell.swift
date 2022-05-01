//
//  PromotionCell.swift
//  TestTaskForBell
//
//  Created by CMDB-127710 on 30.04.2022.
//

import UIKit

class PromotionCell: UITableViewCell {

    @IBOutlet weak var promotionImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var promoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }

    private func initialSetup() {
        promotionImage.image = UIImage(named: "Tacoma")
        titleLabel.text = "Tacoma 2021"
        promoLabel.text = "Get your's now"
    }

    override func prepareForReuse() {
        promotionImage.image = nil
        titleLabel.text = nil
        promoLabel.text = nil
    }

    public func configureCell(with model: PromotionCellModel) {
        promotionImage.image = model.image
        titleLabel.text = model.titleText
        promoLabel.text = model.promoText
    }
}
