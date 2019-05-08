//
//  ImageCacheManage.swift
//  svgChangeColor
//
//  Created by zhangzhenwei on 2019/5/8.
//  Copyright © 2019 玮大爷. All rights reserved.
//

import Cache

//使用 Cache缓存
class ImageCacheManage {
    
    static let `default` = ImageCacheManage()
    fileprivate init() {}
    
   fileprivate let storage = try? Storage(
        diskConfig: DiskConfig(name: "AtImage.Cache"),
        memoryConfig: MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10),
        transformer: TransformerFactory.forImage()
    )
    
    func saveAtImage(image: UIImage?, key: String)  {
        guard let image = image else{ return }
        let imageStorage = storage?.transformImage()
        try? imageStorage?.setObject(image, forKey: key)
    }
    
    func getAtCacheImage(key: String) -> UIImage? {
        let imageStorage = storage?.transformImage()
        let image = try? imageStorage?.object(forKey: key)
        return image
    }
}
