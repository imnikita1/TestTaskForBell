//
//  FilterView.swift
//  TestTaskForBell
//
//  Created by CMDB-127710 on 30.04.2022.
//

import UIKit

protocol FilterViewDelegate: AnyObject {
    func didFilterBy(_ text: String?)
}

class FilterView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var modelFIlterTextField: UITextField!
    @IBOutlet weak var makeFilterTextField: UITextField!

    weak var delegate: FilterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        [modelFIlterTextField, makeFilterTextField].forEach {
            $0?.delegate = self
        }
    }
    @IBAction func didEndEditing(_ sender: UITextField) {
//        debugPrint(sender.text)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.delegate?.didFilterBy(sender.text)
            sender.resignFirstResponder()
        }
    }
}

extension FilterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.didFilterBy(textField.text)
        return true
    }



}
