//
//  RootViewController.swift
//  svgChangeColor
//
//  Created by zhangzhenwei on 2019/5/8.
//  Copyright © 2019 玮大爷. All rights reserved.
//

import UIKit
import SVGKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(clickButton)
    }
    
    //svg资源库 https://www.iconfont.cn
    
    fileprivate let clickButton: UIButton = {
        let clickButton = UIButton(type: .custom)
        if let image = UIImage.svgImageNamed(name: "diaozhui_zhengfangxing", size: CGSize.init(width: 100, height: 100), changeColor1: .black, changeColor2: .green, changeColor3: .yellow) {
            clickButton.setBackgroundImage(image, for: .normal)
        }
        clickButton.frame = CGRect.init(x: 100, y: 400, width: 100, height: 100)
        return clickButton
    }()
    
}



extension UIImage {
    
    static func svgImageNamed(name: String, size: CGSize, changeColor1: UIColor? = nil, changeColor2: UIColor? = nil, changeColor3: UIColor? = nil ) -> UIImage? {
        
        //check cache
        var cacheColorKey:String?
        if let changeColorReslut1 = changeColor1?.cgColor.components ,
            let changeColorReslut2 = changeColor2?.cgColor.components ,
            let changeColorReslut3 = changeColor3?.cgColor.components {
            let color1 = changeColorReslut1.compactMap{
                "\(lroundf(Float($0*255)))"
                }.joined(separator: "")
            let color2 = changeColorReslut2.compactMap{
                "\(lroundf(Float($0*255)))"
                }.joined(separator: "")
            let color3 = changeColorReslut3.compactMap{
                "\(lroundf(Float($0*255)))"
                }.joined(separator: "")
            cacheColorKey = "ColorResult_\(color1)_\(color2)_\(color3)"
        }
        if let key = cacheColorKey, let image = ImageCacheManage.default.getAtCacheImage(key: key){
            return image
        }
        
        let svgImage = SVGKImage.init(named: name)
        svgImage?.size = size
        
        //change svg image
        if(changeColor1 != nil && changeColor2 != nil && changeColor3 != nil) {
            for subLayer: CALayer in svgImage?.caLayerTree.sublayers ?? [] {
                if subLayer.isKind(of: CAShapeLayer.self) {
                    let shapeLayer = subLayer as! CAShapeLayer
                    if let fillCGColor = shapeLayer.fillColor {
                        let color = UIColor.init(cgColor: fillCGColor)
                        if (color.hexString ?? "") == "#471A1A" {
                            shapeLayer.fillColor = UIColor.green.cgColor
                        }
                        if (color.hexString ?? "") == "#F2BC36" {
                            shapeLayer.fillColor = UIColor.blue.cgColor
                        }
                        if (color.hexString ?? "") == "#FF2929" {
                            shapeLayer.fillColor = UIColor.yellow.cgColor
                        }
                    }
                }
            }
            
            if let key = cacheColorKey{
                ImageCacheManage.default.saveAtImage(image: svgImage?.uiImage, key: key)
            }
        }
        return svgImage?.uiImage
    }
}

extension UIColor {
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}
