//
//  FoodContentView.swift
//  FoodyCookBook
//
//  Created by Neeraja Mohandas on 08/02/22.
//

import UIKit

class FoodContentView: UIView {


    var view_content: UIView!
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required public init?(coder aDecoder : NSCoder ) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        view_content = loadViewFromNib_()
        view_content.frame = bounds
        view_content.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view_content.translatesAutoresizingMaskIntoConstraints = true
        view_content.layer.shadowColor = UIColor(named: "secondary_dark")?.cgColor
        view_content.layer.shadowRadius = 4
        view_content.layer.shadowOffset = CGSize(width: 0, height: 0)
        view_content.layer.shadowOpacity = 0.5
        view_content.layer.masksToBounds = false
        view_content.layer.cornerRadius = 10
        addSubview(view_content)
    }
    
    private func loadViewFromNib_() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }

}
