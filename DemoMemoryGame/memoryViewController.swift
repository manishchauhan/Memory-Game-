//
//  memoryViewController.swift
//  DemoMemoryGame
//
//  Created by Manish on 31/01/17.
//  Copyright © 2017 Manish. All rights reserved.
//
extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.5
        animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
        layer.addAnimation(animation, forKey: "shake")
    }
}
import UIKit

class memoryViewController: BaseViewController,memoryGameDelegate  {
    var scoreBoardView:UIAlertController!
    var score:NSInteger=0;
    var highscoreTable:highscoreTableViewController?
    var verticalConstraint:NSLayoutConstraint! = nil
    @IBOutlet weak var newGameBtn: UIButton!
    //get high score list
    @IBOutlet weak var memoryGameView: MainView!
    //show high score table
    @IBOutlet weak var layoutConstraint: NSLayoutConstraint!
    @IBAction func showHighScore(sender: AnyObject?) {
        
        if(verticalConstraint.constant>110)
        {
            verticalConstraint.constant=110;
        }
        else
        {
            verticalConstraint.constant=self.view.frame.height;
        }
        UIView.animateWithDuration(0.5) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBOutlet weak var totalScore: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGameBtn.hidden=true;
        // Do any additional setup after loading the view.
        // Intial setup include background color
        initSetup();
        newGame();
    }
    func newGame() -> Void {
        memoryGameView.alpha=0;
        UIView.animateWithDuration(1.0) {
            self.memoryGameView.alpha=1;
        }
        UIView.animateWithDuration(1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .CurveEaseInOut, animations: {
            self.memoryGameView.alpha = 1
        }) { _ in
            
        }
    }
    func updateScore(value: Int)->Void {
        score += value;
        totalScore.text="Score:-"+String(score);
    }
    
    private func addHighScoreTable()->Void
    {
        highscoreTable=highscoreTableViewController(nibName: "highscoreTableViewController", bundle: nil);
        highscoreTable?.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(highscoreTable!.view);
        self.addChildViewController(highscoreTable!);
        let horizontalConstraint = NSLayoutConstraint(item: highscoreTable!.view, attribute:.CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)
        verticalConstraint = NSLayoutConstraint(item: highscoreTable!.view, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: self.view.frame.height)
        let widthConstraint = NSLayoutConstraint(item: highscoreTable!.view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: self.view.frame.width)
        let heightConstraint = NSLayoutConstraint(item: highscoreTable!.view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: self.view.frame.height)
        
        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    private func initSetup()->Void
    {
        
        memoryGameView.delegate=self;
        //i want high score table added just once
        addHighScoreTable();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //don't submit score--------------------------------------------------------------
    func cancelScore() -> Void {
        
        print("cancel score");
    }
    //submit score--------------------------------------------------------------
    func submitScore() -> Void {
        let username:String=scoreBoardView.textFields!.last!.text!;
        let currentScore:NSInteger=score;
        let rank:Int=1;
        MemoryDataModel.updateNoteList(username, score: currentScore, rank: rank) {[weak this=self] (status) in
            print("record added");
            this!.highscoreTable?.refreshData();
            this!.showHighScore(nil);
        }
        
    }
    func userValidation() -> Void {
        addSubmitScoreView("user name can't be empty",statusFlag: true);
    }
    func addSubmitScoreView(msg:String,statusFlag:Bool) -> Void {
        scoreBoardView = UIAlertController(title: "Score Board", message:"Your score is:->"+String(score), preferredStyle: .Alert);
        
        //add submit button
        let submitButton = UIAlertAction(title: "Save Score", style: UIAlertActionStyle.Default, handler: {
            [weak this=self] alert -> Void in
            //check left blank test filed
            guard let text = this?.scoreBoardView.textFields!.last!.text! where !text.isEmpty else {
                this?.userValidation();
                return
            }
            this?.submitScore();
            
            })
        scoreBoardView.addTextFieldWithConfigurationHandler { (usernameTextField : UITextField! ) in
            usernameTextField.placeholder=msg;
        }
        
        //add cancel button
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {[weak this=self]
            (action : UIAlertAction!) -> Void in
            this?.cancelScore();
            })
        scoreBoardView.addAction(submitButton)
        scoreBoardView.addAction(cancelButton)
        scoreBoardView.view.setNeedsLayout();
        
        presentViewController(scoreBoardView, animated: true)  {
            if(statusFlag==true)
            {
                self.scoreBoardView.view.shake();
            }
        }
    }
    func gameOver() {
        addSubmitScoreView("Enter user name",statusFlag: false);
        newGameBtn.hidden=false;
    }
    @IBAction func replayGame(sender: AnyObject) {
        score=0;
        totalScore.text="Score:-"+String(score);
        memoryGameView.initGame();
        newGame();
        newGameBtn.hidden=true;
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
