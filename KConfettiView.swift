//
//
//  Copyright © 2018 Kenan Atmaca. All rights reserved.
//  kenanatmaca.com
//
//

import UIKit

class KConfettiView: UIView {

    private var emitterLayer:CAEmitterLayer!
    
    var coefficient:Float = 0.5
    var cellCount:Int = 5
    var image:UIImage?
    var color:UIColor?
    var defaultConfettiSize:CGFloat = 3.0
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func setup() {
        
        emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: self.frame.size.width / 2.0, y: 0)
        emitterLayer.emitterShape = kCAEmitterLayerLine
        emitterLayer.emitterSize = CGSize(width: self.frame.size.width, height: 1)
        
        var cells = [CAEmitterCell]()
        
        for _ in 0..<cellCount {
            cells.append(confettiSetup(color ?? UIColor.randomColor(),image ?? UIImage.image(color: UIColor.randomColor(), size: CGSize(width: defaultConfettiSize, height: defaultConfettiSize))))
        }
        
        emitterLayer.emitterCells = cells
        self.layer.addSublayer(emitterLayer)
    }
    
    private func confettiSetup(_ color:UIColor,_ cimage:UIImage) -> CAEmitterCell {
        let confetti = CAEmitterCell()
        confetti.birthRate = 8.0 * coefficient
        confetti.lifetime = 14.0 * coefficient
        confetti.lifetimeRange = 0
        confetti.color = color.cgColor
        confetti.velocity = CGFloat(350.0 * coefficient)
        confetti.velocityRange = CGFloat(80.0 * coefficient)
        confetti.emissionLongitude = .pi
        confetti.emissionRange = .pi / 4
        confetti.spin = CGFloat(3.5 * coefficient)
        confetti.spinRange = CGFloat(4.0 * coefficient)
        confetti.scaleRange = CGFloat(coefficient)
        confetti.scaleSpeed = CGFloat(-0.1 * coefficient)
        confetti.contents = cimage.cgImage
        return confetti
    }
}

extension UIColor {
    static func randomColor() -> Self {
        let r = CGFloat(arc4random_uniform(255)) / 255.0
        let g = CGFloat(arc4random_uniform(255)) / 255.0
        let b = CGFloat(arc4random_uniform(255)) / 255.0
        return self.init(red: r, green: g, blue: b ,alpha: 1.0)
    }
}

extension UIImage {
   static func image(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
