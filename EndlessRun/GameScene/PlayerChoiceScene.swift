//
//  PlayerChoiceScene.swift
//  EndlessRun
//
//  Created by Valentino Palomba on 04/04/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerChoiceScene : SKScene {
    let Doctor = SKSpriteNode(imageNamed: "doc1")
    
    let pizzaBoy = SKSpriteNode(imageNamed: "Pizzaboy")
    
    let kimJong = SKSpriteNode(imageNamed: "Kim")
    
    let selection = SKSpriteNode(imageNamed: "selection")
    
    let backButton = SKSpriteNode(imageNamed: "BackButton")
    
    var arrayPoint = [CGPoint]()
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        let chooseLabel = SKLabelNode(fontNamed: "Chalkduster")
        chooseLabel.text = "Choose your Player!"
        chooseLabel.fontColor = SKColor.black
        chooseLabel.fontSize = 40
        chooseLabel.position = CGPoint(x: frame.midX, y: frame.midY+130)
        Doctor.position = CGPoint(x: frame.midX-pizzaBoy.size.width-70, y: frame.midY-30)
        pizzaBoy.position = CGPoint(x: frame.midX, y: frame.midY-30)
        kimJong.position = CGPoint(x: frame.midX+pizzaBoy.size.width+70, y: frame.midY-30)
        backButton.position = CGPoint(x: frame.minX+40, y: frame.maxY-30)
        arrayPoint.append(contentsOf: [Doctor.position,pizzaBoy.position,kimJong.position])
        selection.position = arrayPoint[defaults.integer(forKey: "PlayerChoice")]
        selection.position.y = Doctor.size.height + 130
        addChild(pizzaBoy)
        addChild(kimJong)
        addChild(Doctor)
        addChild(chooseLabel)
        addChild(selection)
        addChild(backButton)
        selectionAppearDisappear()
    }
    
    func selectionAppearDisappear(){
        let ActionAppear = SKAction.run {
            self.selection.alpha = 1.0
        }
        let ActionDisappear = SKAction.run {
            self.selection.alpha = 0.0
        }
        let ActionWait = SKAction.wait(forDuration: 0.3)
        let loop = SKAction.repeatForever(SKAction.sequence([ActionDisappear,ActionWait,ActionAppear, ActionWait]))
        selection.run(loop)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        if Doctor.contains(location!) {
            selection.position = arrayPoint[0]
            selection.position.y = Doctor.size.height + 130
            defaults.set(0, forKey: "PlayerChoice")
        }
        if pizzaBoy.contains(location!) {
            selection.position = arrayPoint[1]
            selection.position.y = Doctor.size.height + 130
            defaults.set(1, forKey: "PlayerChoice")
        }
        if kimJong.contains(location!) {
            selection.position = arrayPoint[2]
            selection.position.y = Doctor.size.height + 130
            defaults.set(2, forKey: "PlayerChoice")
        }
        
        if backButton.contains(location!) {
            run(SKAction.sequence([
                
                SKAction.run() { [weak self] in
                    // 5
                    guard let `self` = self else { return }
                    let reveal = SKTransition.push(with: .up, duration: 0.5)
                    let scene = MenuScene(size: self.size)
                    self.view?.presentScene(scene, transition:reveal)
                }
            ]))
        }
        
    }
}
