//
//  MainView.swift
//  DemoMemoryGame
//
//  Created by Manish on 31/01/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit


class MainView: UIView {
    
    //assign collide behaviour
    
    var totalPairToMatched:Int=0;
    var numberofPairFound:Int=0;
    var eachRoundScore:Int=2;
    var trunAllowed:Int=2;
    var matchPairValue:Array<String>=[];
    var matchPairCards:Array<Card>=[];
    weak var delegate:memoryGameDelegate?=nil;
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initGame();
    }
    
    func initGame()->Void
    {
        
        drawGird()
    }
    
    private func drawGird()->Void
    {
        let xdeviceMultiplier:CGFloat=UIScreen.mainScreen().bounds.width/320.0;
        
        //all card url
        var allCards:Array<Array<String>>=[];
        let ontypeCardArray=["color1","color2","color3","color4","color5","color6","color7","color8"]
        for _ in 0..<trunAllowed
        {
            allCards.append(ontypeCardArray)
        }
        var cardsurl = allCards.flatMap { $0 }
        totalPairToMatched=ontypeCardArray.count;
        cardsurl=cardsurl.shuffle()
        //y margin with device Multiplier
        var marginY:CGFloat=2*xdeviceMultiplier;
        var marginX:CGFloat=0;
        //number of rows and number of colums
        let rows:Int=4; let cols:Int=4;
        //image index which would start with -1 and increment by +1 to access next image
        var imgIndex:Int = -1;
        //each image width and height
        var width:CGFloat=0.0,height:CGFloat=0.0
        //horizontal space between cards
        var horizontalMargin:CGFloat=0;
        //vertical space between cards
        var verticalMargin:CGFloat=0;
        //get device type and based on deive i changed horizontal and vertical space between cards
        switch UIDevice().screenType {
        case .iPhone5:
            horizontalMargin=4;
            verticalMargin=4;
            marginX=2;
        case .iPhone6:
            horizontalMargin=16;
            verticalMargin=16;
            marginX=12;
        case .iPhone6Plus:
            horizontalMargin=22;
            verticalMargin=22;
            marginX=22;
        case .unknown:
            horizontalMargin=4;
            verticalMargin = 2;
            marginX=2;
            marginY = -20;
        default:
            break;
        }
        
        for i in 0..<rows {
            for j in 0..<cols {
                let card:Card=Card()
                card.backgroundColor=UIColor.greenColor();
                //adding tab gesture
                card.UITapGesture();
                imgIndex += 1;
                if(imgIndex>cardsurl.count-1)
                {
                    imgIndex=0;
                }
                let pullPath:String="MemoryGame/"+cardsurl[imgIndex];
                //by default show front face
                
                card.tagValue=cardsurl[imgIndex];
                card.cardIndex=imgIndex;
                card.setCardFrontFace(pullPath);
                width=(card.front.image?.size.width)!;
                height=(card.front.image?.size.height)!;
                print(width);
                card.frame=CGRectMake( marginX+CGFloat(j)*(width+horizontalMargin),marginY+CGFloat(i)*(height+verticalMargin),width,height)
                self.addSubview(card);
                card.TabbedBlock={ [weak this=self](card:Card) -> Void in
                    this!.checkForMatch(card);
                }
            }
        }
        
        
        
    }
    //card not matched you will get negative marks
    private func cardNotMatched()->Void
    {
        for card in self.matchPairCards
        {
            card.cardTapped();
        }
        matchPairCards.removeAll();
        matchPairValue.removeAll();
        freezeSubViews(true);
        delegate!.updateScore(-(eachRoundScore/2));
    }
    //car matched
    private func removeCard(card:Card)->Void
    {
        card.removeFromSuperview();
    }
    
    private func cardMatched()->Void
    {
        for card in self.matchPairCards
        {
            card.removeWithEffect();
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.25 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.removeCard(card);
            }
            
        }
     
        freezeSubViews(true);
        delegate!.updateScore(eachRoundScore);
        numberofPairFound += 1;
        if(numberofPairFound==totalPairToMatched)
        {
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.25 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                self.gameOver();
            }
        }
    }
    
    private func gameOver()->Void
    {
        clearAndResetGameView();
        delegate?.gameOver();
    }
    
    
    private func cardMatchedorNot(flag:Bool)->Void
    {
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.25 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            if(flag)
            {
                self.cardMatched();
            }
            else
            {
                self.cardNotMatched();
            }
        }
    }
    private func freezeSubViews(flag:Bool)->Void
    {
        self.subviews.forEach {
            $0.userInteractionEnabled=flag
        }
        
    }
    func clearAndResetGameView() -> Void {
        self.subviews.forEach {
            $0.removeFromSuperview();
        }
        numberofPairFound=0;
    }
    private func checkForMatch(card:Card)->Void
    {
        
        //clear all cards from the stack
        if(matchPairCards.count==eachRoundScore)
        {
            matchPairCards.removeAll();
            matchPairValue.removeAll();
        }
        //if card alerady in stack
        var cardAreadyinStack:Bool=false;
        matchPairCards.forEach {
            if( $0.cardIndex == card.cardIndex)
            {
                cardAreadyinStack=true
            }
        }
        //if card in stack return
        guard (cardAreadyinStack != true) else {  return;};
        //add to stack
        matchPairCards.append(card);
        matchPairValue.append(card.tagValue);
        if(trunAllowed==matchPairValue.count)
        {
            if(matchPairValue.first==matchPairValue.last)
            {
                freezeSubViews(false);
                cardMatchedorNot(true);
            }
            else
            {
                freezeSubViews(false);
                cardMatchedorNot(false);
            }
        }
    }
}
