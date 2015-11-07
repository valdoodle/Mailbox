//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Valerie Chao on 11/3/15.
//  Copyright © 2015 Valerie Chao. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var archiveView: UIImageView!
    
    @IBOutlet weak var laterView: UIImageView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    var initialCenter: CGPoint!
    
    var laterInitialCenter: CGPoint!
    
    var archiveInitialCenter: CGPoint!
    
    @IBOutlet weak var rescheduleView: UIImageView!
    
    @IBOutlet weak var listView: UIImageView!
    
    @IBOutlet weak var feedView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSizeMake(320, 1136)
        
        laterView.alpha = 0
        archiveView.alpha = 0
        listView.alpha = 0
        rescheduleView.alpha = 0
        
        messageView.userInteractionEnabled = true
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        
        
        // location of finger
        let location = sender.locationInView(view)
        // how far you've moved
        let translation = sender.translationInView(view)
        // direction
        let velocity = sender.velocityInView(view)
        
        
        
        
        if sender.state == UIGestureRecognizerState.Began {
            
            initialCenter = messageView.center
            laterInitialCenter = laterView.center
            archiveInitialCenter = archiveView.center
            
            backgroundView.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.86, alpha: 1.0) /* #dbdbdb */
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            messageView.center = location
            
            self.messageView.center = CGPoint(x: translation.x + self.initialCenter.x, y:self.initialCenter.y)
            
            print("translation: \(translation)")
            
            UIView.animateWithDuration(0.3, delay: 0.1, options: [], animations: { () -> Void in
                self.laterView.alpha = 1
                self.archiveView.alpha = 1
                }, completion: { (Bool) -> Void in
            })
            
            if translation.x < -260 {
                print ("brown under -260")
                archiveView.alpha = 0
                backgroundView.backgroundColor = UIColor(hue: 0.0806, saturation: 0.63, brightness: 0.75, alpha: 1.0) /* #bf8046 brown */
                laterView.image = UIImage(named: "list_icon")
                self.laterView.center = CGPoint(x: self.laterInitialCenter.x + translation.x + 50, y: self.laterInitialCenter.y)
            } else if translation.x > -260 && translation.x < -60 {
                print ("yellow under -60")
                archiveView.alpha = 0
                backgroundView.backgroundColor = UIColor(hue: 0.1472, saturation: 1, brightness: 1, alpha: 1.0) /* #ffe100 yellow */
                self.laterView.center = CGPoint(x: self.laterInitialCenter.x + translation.x + 50, y: self.laterInitialCenter.y)
                laterView.image = UIImage(named: "later_icon")
            } else if translation.x > -60 && translation.x < 0 {
                print ("grey under 0")
                laterView.image = UIImage(named: "later_icon")
                
                
            } else if translation.x > 0 && translation.x < 60 {
                print ("grey under 60")
                self.archiveView.image = UIImage(named: "archive_icon")
                
            } else if translation.x > 60 && translation.x < 260 {
                print ("green over 60")
                laterView.alpha = 0
                backgroundView.backgroundColor = UIColor(hue: 0.35, saturation: 1, brightness: 0.8, alpha: 1.0) /* #00cc14 green */
                self.archiveView.center = CGPoint(x: self.archiveInitialCenter.x + translation.x - 50 , y: self.archiveInitialCenter.y)
                self.archiveView.image = UIImage(named: "archive_icon")
                
            } else if translation.x > 260 {
                print("red over 260")
                laterView.alpha = 0
                backgroundView.backgroundColor = UIColor(hue: 0.05, saturation: 1, brightness: 0.94, alpha: 1.0) /* #ef4700 red */
                archiveView.image = UIImage(named: "delete_icon")
                self.archiveView.center = CGPoint(x: self.archiveInitialCenter.x + translation.x - 50 , y: self.archiveInitialCenter.y)
            }
            
            
            
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {

            if translation.x < -260 {
                print ("brown under -260")
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = 0 - self.messageView.frame.size.width / 2
                    self.laterView.alpha = 0
                    self.laterView.center.x = 0 - self.messageView.frame.size.width / 2 + self.laterView.frame.size.width
                    }, completion: { (Bool) -> Void in
                        print("show view")
                        self.laterView.center = self.laterInitialCenter
                        self.listView.alpha = 1
                })
                
                
                
            } else if translation.x > -260 && translation.x < -60 {
                print ("yellow under -60")
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = 0 - self.messageView.frame.size.width / 2
                    self.laterView.alpha = 0
                    self.laterView.center.x = 0 - self.messageView.frame.size.width / 2 + self.laterView.frame.size.width
                    }, completion: { (Bool) -> Void in
                    print("show view")
                    self.laterView.center = self.laterInitialCenter
                    self.rescheduleView.alpha = 1
                })
                
            } else if translation.x > -60 && translation.x < 0 {
                print ("grey under 0")
                messageView.center.x = self.view.frame.size.width - self.messageView.frame.size.width / 2
                
            } else if translation.x > 0 && translation.x < 60 {
                print ("grey under 60")
                messageView.center.x = self.view.frame.size.width - 160
                
            } else if translation.x > 60 && translation.x < 260 {
                print ("green over 60")
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = self.view.frame.size.width + self.messageView.frame.size.width
                    self.archiveView.alpha = 0
                    self.archiveView.center.x = self.messageView.frame.size.width + self.archiveView.frame.size.width
                    }, completion: { (Bool) -> Void in
                        print("show view")
                        self.archiveView.center = self.archiveInitialCenter
                        self.feedView.frame.origin.y -= self.messageView.frame.size.height
                        
                        UIView.animateWithDuration(0.2, delay: 0.5, options: [], animations: { () -> Void in
                            self.feedView.frame.origin.y += self.messageView.frame.size.height
                            self.messageView.center.x = self.initialCenter.x
                            }, completion: { (Bool) -> Void in
                                
                        })
                        
                })
                
            } else if translation.x > 260 {
                print("red over 260")
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.messageView.center.x = self.view.frame.size.width + self.messageView.frame.size.width
                    self.archiveView.alpha = 0
                    self.archiveView.center.x = self.messageView.frame.size.width + self.archiveView.frame.size.width
                    }, completion: { (Bool) -> Void in
                        print("show view")
                        self.archiveView.center = self.archiveInitialCenter
                        self.feedView.frame.origin.y -= self.messageView.frame.size.height
                        
                        UIView.animateWithDuration(0.2, delay: 0.5, options: [], animations: { () -> Void in
                            self.feedView.frame.origin.y += self.messageView.frame.size.height
                            self.messageView.center.x = self.initialCenter.x
                            }, completion: { (Bool) -> Void in
                                
                        })
                        
                })

            }
            

        }
        
    }
    
    
    
    @IBAction func didTapReschedule(sender: UITapGestureRecognizer) {
        
        self.messageView.center.x = self.initialCenter.x
        
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
                self.rescheduleView.alpha = 0
                self.feedView.frame.origin.y -= self.messageView.frame.size.height
            }) { (Bool) -> Void in
                print("animation to hide color")
                
                UIView.animateWithDuration(0.2, delay: 0.5, options: [], animations: { () -> Void in
                    
                    self.feedView.frame.origin.y += self.messageView.frame.size.height
                    
                    }, completion: { (Bool) -> Void in
                        
                })
        }
    }
    
    
    @IBAction func didTapList(sender: UITapGestureRecognizer) {
        
        self.messageView.center.x = self.initialCenter.x
        
        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { () -> Void in
            self.listView.alpha = 0
            self.feedView.frame.origin.y -= self.messageView.frame.size.height
            }) { (Bool) -> Void in
                print("animation to hide color")
                
                UIView.animateWithDuration(0.2, delay: 0.5, options: [], animations: { () -> Void in
                    
                    self.feedView.frame.origin.y += self.messageView.frame.size.height
                    
                    }, completion: { (Bool) -> Void in
                        
                })
            
        }
        
        
        
        
        
    }
    
    
}
