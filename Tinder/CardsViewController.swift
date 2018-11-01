//
//  CardsViewController.swift
//  Tinder
//
//  Created by Mac on 8/9/1397 AP.
//  Copyright © 1397 Abraham Asmile. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var cardInitialCenter: CGPoint!
    
    @IBOutlet weak var profileView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapPhoto(_ sender: AnyObject) {
        performSegue(withIdentifier: "profileSegue", sender: sender)
    }
    
    
    @IBAction func didSwipePhoto(_ sender: AnyObject) {
        print("SWIPEPHOTO")
        let translation = sender.translation(in: view)
        
        print("translation \(translation)")
        
        if sender.state == .began {
            cardInitialCenter = profileView.center
            
        } else if sender.state == .changed {
            let rotation = CGAffineTransform(rotationAngle: translation.x / 100)
            profileView.transform = rotation
            profileView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            
            
        } else if sender.state == .ended {
            if translation.x < 50 {
                UIView.animate(withDuration: 1.0, delay: 0.2, options: [.autoreverse], animations: {
                    print("x is less than 50")
                    self.profileView.center = CGPoint(x: -15000, y: self.cardInitialCenter.y)
                }, completion: nil)
            } else if translation.x > 50 {
                print("x is greater than 50")
                UIView.animate(withDuration: 1.0, delay: 0.2, options: [.autoreverse], animations: {
                    self.profileView.center = CGPoint(x: 15000, y: self.cardInitialCenter.y)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 1.0, delay: 0.2, options: [.autoreverse], animations: {
                    sender.view?.center = self.cardInitialCenter
                    sender.view?.transform = .identity
                    //cardView.transform = CGAffineTransformIdentity
                })
                
            }
            
        }
        
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "profileSegue" {
            print("Showing the profile")
            //let mainStoryBoard = UIStoryboard(name: "Main",bundle: nil)
            //let vc = mainStoryBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            let vc = segue.destination as! ProfileViewController
            vc.image = self.profileView.image!
        }
        
    }


    
}
