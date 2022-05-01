//
//  BulletView.swift
//  TestTaskForBell
//
//  Created by CMDB-127710 on 30.04.2022.
//

import UIKit

class BulletView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var bulletLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("BulletView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    func setup(with bullet: String) {
        self.bulletLabel.text = bullet
    }

}
