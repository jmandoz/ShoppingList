//
//  ButtonTableViewCell.swift
//  ShoppingList
//
//  Created by Jason Mandozzi on 6/21/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

@IBDesignable

class ButtonTableViewCell: UITableViewCell {

    var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var copmpleteButton: UIButton!
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        showAlert()
    }
    func showAlert()
    {
        let alert = UIAlertController(title: "add item", message: "add the item you want", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Agree", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.text = "Some default text."
        })
        ShoppingListController.shared.add(Item: ShoppingList, name: UITextField.text)
    }
    
    
    fileprivate func updateButton(_ isComplete: Bool) {
        if isComplete {
            copmpleteButton.setImage(UIImage(named:"complete"), for: .normal)
        } else {
            copmpleteButton.setImage(UIImage(named:"incomplete"), for: .normal)
        }
    }
}

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

extension ButtonTableViewCell {
    func update(Item: ShoppingList) {
        itemLabel.text = Item.name
        updateButton(Item.isComplete)
    }
}
