//
//  ViewController.swift
//  Test1_iOS_C14190016
//
//  Created by IOS on 20/03/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var _audioPlayer : AVAudioPlayer!
    
    var _life : Int!
    var _randTebakan : Int!
    
    @IBOutlet weak var _tvLife: UITextView!
    @IBOutlet weak var _btnReset: UIButton!
    @IBOutlet var _btnTebak: [UIButton]!
    
    @IBAction func btnResetAction(_ sender: UIButton) {
        resetState()
    }
    
    @IBAction func btnTebakAction(_ sender: UIButton) {
        if sender.titleLabel!.text! == String(_randTebakan) {
            
            //play sound
            playSound(title: "correct")
            
            //disable interaction
            setAllBtnInteraction(status: false)
            
            //change background color to green
            sender.backgroundColor = UIColor.green
            
            //delay 5 sec before reset
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                self.resetState()
            }
            
            //text you lose
            _tvLife.text = "You Win!!!"
            
        }
        else {
            
            //play sound
            playSound(title: "wrong")
            
            //update life
            _life -= 1
            _tvLife.text = String(_life)
            
            //change background color to red
            sender.backgroundColor = UIColor.red
            
            //check lose state
            if _life == 0 {
                
                //disable interaction
                setAllBtnInteraction(status: false)
                
                //delay 5 sec before reset
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
                    self.resetState()
                }
                
                //text you lose
                _tvLife.text = "You Lose!!!"
            }
        }
        
        //disable interaction sender
        sender.isUserInteractionEnabled = false
    }
    
    func resetState() {
        
        //reset life
        _life = 5
        _tvLife.text = String(_life)
        
        //reset random
        _randTebakan = Int.random(in: 1...25)
        print(_randTebakan!)
        
        //change background color to white
        for btn in _btnTebak {
            btn.backgroundColor = UIColor.white
        }
        
        //enable interaction
        setAllBtnInteraction(status: true)
    }
    
    func playSound(title : String) {
        let url = Bundle.main.url(forResource: "Sound/" + title, withExtension: "mp3")
        _audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        _audioPlayer.play()
    }
    
    func setAllBtnInteraction(status : Bool) {
        for btn in _btnTebak {
            btn.isUserInteractionEnabled = status
        }
        
        _btnReset.isUserInteractionEnabled = status
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //hidden title label
        for btn in _btnTebak {
            btn.titleLabel!.isHidden = true
        }
        
        _life = 5
        _randTebakan = Int.random(in: 1...25)
        print(_randTebakan!)
                
    }


}

