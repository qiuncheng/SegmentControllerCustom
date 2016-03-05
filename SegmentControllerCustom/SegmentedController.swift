//
//  SegmentedController.swift
//  SegmentControllerCustom
//
//  Created by 程庆春 on 15/12/1.
//  Copyright © 2015年 Qiun cheng. All rights reserved.
//

import UIKit

@IBDesignable class SegmentedControll: UIControl {
  
    private var labels = [UILabel]()
    
    var thumbView = UIView()
    @IBInspectable
    var items: [String] = ["item1", "item2", "item3"] {
        didSet {
            setupLabels()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor(white: 1.0, alpha: 0.5).CGColor
        layer.borderWidth = 2.0
        
        backgroundColor = UIColor.clearColor()
        
        setupLabels()
        
        insertSubview(thumbView, atIndex: 0)
        
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectIndex()
        }
    }
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepCapacity: true)
        
        for index in 1 ... items.count {
            let label = UILabel(frame: CGRectZero)
            label.text = items[index - 1]
            label.textAlignment = .Center
            label.textColor = UIColor(white: 0.5, alpha: 1.0)
            
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectFrame = self.bounds
        
        let newWidth = CGRectGetWidth(selectFrame) / CGFloat(items.count)
        selectFrame.size.width = newWidth
        
        thumbView.frame = selectFrame
        thumbView.backgroundColor = UIColor.whiteColor()
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        let labelHeight = self.bounds.height
        let labelWidht = self.bounds.width / CGFloat(items.count)
        
        for index in 0 ... labels.count-1 {
            let label = labels[index]
            
            let xPosition = CGFloat(index) * labelWidht
            label.frame = CGRectMake(xPosition, 0, labelWidht, labelHeight)
        }
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        
        var calculatedIndex: Int?
        for (index, item) in labels.enumerate() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
            
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActionsForControlEvents(.ValueChanged)
        }
        
        return false
    }
    
    func displayNewSelectIndex() {
        let label = labels[selectedIndex]
        self.thumbView.frame = label.frame
    }
}
