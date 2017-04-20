//
//  ViewController.swift
//  SmileyTray
//
//  Created by Sabareesh Kappagantu on 4/19/17.
//  Copyright © 2017 Sabareesh Kappagantu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayCenterWhenClosed = trayView.center
        trayCenterWhenOpen = CGPoint(x: trayView.center.x, y: 554)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    @IBAction func onTrayTapGesture(_ sender: UITapGestureRecognizer) {
        
        if(sender.state == .ended){
            print("Clicked the Arrow!!")
            if(trayView.center == trayCenterWhenClosed) {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {
                    self.trayView.center = self.trayCenterWhenOpen
                }, completion: nil)
            } else if(trayView.center == trayCenterWhenOpen){
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {
                    self.trayView.center = self.trayCenterWhenClosed
                }, completion: nil)
            }
        }
        
        
    }
    
    

    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        
        let panGestureRecognizer = sender
        let point = panGestureRecognizer.location(in: trayView.superview)
        let translation = panGestureRecognizer.translation(in: trayView.superview)
        let velocity = panGestureRecognizer.velocity(in: trayView.superview)
        
        if (panGestureRecognizer.state == .began){
            print("Gesture began at : \(point)")
            trayOriginalCenter = trayView.center
        } else if (panGestureRecognizer.state == .changed){
            print("Gesture changed at: \(point)")
            if (translation.y < -130  && trayView.center.y < trayCenterWhenOpen.y){
                panGestureRecognizer.setTranslation(CGPoint(x:0 , y: -130), in: trayView.superview)
            }
            trayView.center = CGPoint(x:trayOriginalCenter.x, y:trayOriginalCenter.y + translation.y)
        } else if (panGestureRecognizer.state == .ended){
            print("Gesture ended at: \(point)")
            if( velocity.y <= 0 ){
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {
                    self.trayView.center = self.trayCenterWhenOpen
                }, completion: nil)
                
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {
                    self.trayView.center = self.trayCenterWhenClosed
                }, completion: nil)
                
            }
            
        }
    }
    
    
    @IBAction func onSmileyPanGesture(_ sender: UIPanGestureRecognizer) {
        let imageView = sender.view as! UIImageView

        let point = sender.location(in: view)
        let translation = sender.translation(in: view)
        
        if( sender.state == .began ){
            newlyCreatedFace = UIImageView(image: imageView.image)
            trayView.superview?.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFaceOriginalCenter = point
            newlyCreatedFace.center.y += trayView.frame.origin.y
        } else if( sender.state == .changed ){
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if (sender.state == .ended) {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: {
                self.newlyCreatedFace.center = point
            }, completion: nil)
            
        }
        
    }
    
  

}

