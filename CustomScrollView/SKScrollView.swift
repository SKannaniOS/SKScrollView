//
//  SKScrollView.swift
//  CustomScrollView
//
//  Created by SaTHEEsH KaNNaN on 05/05/17.
//  Copyright © 2017 SKannaniOS. All rights reserved.
//

import Foundation
import UIKit

// MARK: - SKScrollView

class SKScrollView : UIScrollView {
    
    /**
     This function retuns all subviews of this scrollview except the scrollview indicators
     */
    
    func getAllSubViews() -> [UIView] {
     
        var subViews = [UIView]()
        
        let verticalScrollIndicatorState = self.showsVerticalScrollIndicator
        let horizondalScrollIndicatorState = self.showsHorizontalScrollIndicator
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        subViews = self.subviews
        
        self.showsVerticalScrollIndicator = verticalScrollIndicatorState
        self.showsHorizontalScrollIndicator = horizondalScrollIndicatorState
        
        return subViews
    }
    
    /**
     This function will add the view to the scrollview at specific index.
     
     - parameter view : The view is going to add.
     - parameter index : The index of the view (Default -1, added at last index).
     - parameter showAddedView : This indicates wether the added view needs to visible or not.
     */
    
    func insertNewSubView(_ view : UIView, atIndex index : Int = -1, scrollToView showAddedView : Bool = false) -> Void {
        
        var allSubViews = self.getAllSubViews()
        
        var viewFrame = view.frame
        
        if index >= 0 && index < allSubViews.count {
            
            if index == 0 {
                viewFrame.origin.y = 0
            }
            else {
               let indexFrame = allSubViews[index-1].frame
                viewFrame.origin.y = indexFrame.origin.y + indexFrame.size.height
            }
            
            view.frame = viewFrame
            
            allSubViews.forEach{ $0.removeFromSuperview() }
            
            allSubViews.insert(view, at: index)
            
            for (idx,sView) in allSubViews.enumerated() {
                
                if idx > index {
                    var vFrame = sView.frame
                    vFrame.origin.y = allSubViews[idx-1].frame.origin.y + allSubViews[idx-1].frame.size.height
                    sView.frame = vFrame
                }
                
                self.addSubview(sView)
            }
        }
        else {
            
            viewFrame.origin.y = 0
            
            if let lastView = allSubViews.last {
                let lastFrame = lastView.frame
                viewFrame.origin.y = lastFrame.origin.y + lastFrame.size.height
            }
            
            view.frame = viewFrame
            self.addSubview(view)
        }
        
        allSubViews = self.getAllSubViews()
        
        if let lastView = allSubViews.last {
            let lastFrame = lastView.frame
            self.contentSize = CGSize(width: self.contentSize.width, height: lastFrame.origin.y + lastFrame.size.height)
            
            if showAddedView == true {
                DispatchQueue.main.async {
                    let offset = CGPoint(x: 0, y: view.frame.origin.y)
                    self.setContentOffset(offset, animated: true)
                }
            }

        }
    }
    
    /**
     This function will delete the view
     
     - parameter index : The index of view, need to delete.
     */
    
    func deleteSubView(atIndex index : Int) -> Void {
        
        var allSubViews = self.getAllSubViews()
        
        guard index < allSubViews.count, index >= 0 else {
            return
        }
        
        allSubViews.forEach{ $0.removeFromSuperview() }
        allSubViews.remove(at: index)
        
        for (idx,sView) in allSubViews.enumerated() {
            
            var vFrame = sView.frame
        
            vFrame.origin.y = idx == 0 ? 0 : allSubViews[idx-1].frame.origin.y + allSubViews[idx-1].frame.size.height
            sView.frame = vFrame
            
            self.addSubview(sView)
        }
        
        allSubViews = self.getAllSubViews()
        
        if let lastView = allSubViews.last {
            let lastFrame = lastView.frame
            self.contentSize = CGSize(width: self.contentSize.width, height: lastFrame.origin.y + lastFrame.size.height)
        }

    }
    
    /**
     This function will delete the view.
     
     - parameter view : The view needs to delete.
     */
    
    func deleteSubView(_ view : UIView) -> Void {
        
        guard view.isDescendant(of: self) else {
            return
        }
        
        let allSubViews = self.getAllSubViews()
        
        if let index = allSubViews.index(of: view) {
            self.deleteSubView(atIndex: index)
        }
    }
}
