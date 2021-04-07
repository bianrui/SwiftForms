//
//  String.swift
//  fho
//
//  Created by bianruifeng on 2021/3/24.
//

import Foundation

extension String{
    /// 根据下标获取某个下标字符
    subscript(of index: Int) -> String {
        if index < 0 || index >= self.count{
            return ""
        }
        for (i,item) in self.enumerated(){
            if index == i {
                return "\(item)"
            }
        }
        return ""
    }
    /// 根据range获取字符串 a[1...3]
    subscript(r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: min(r.upperBound, count - 1))
        return String(self[start...end])
    }
    /// 根据range获取字符串 a[0..<2]
    subscript(r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: min(r.upperBound, count))
        return String(self[start..<end])
    }
    /// 根据range获取字符串 a[...2]
    subscript(r: PartialRangeThrough<Int>) -> String {
        let end = index(startIndex, offsetBy: min(r.upperBound, count - 1))
        return String(self[startIndex...end])
    }
    /// 根据range获取字符串 a[0...]
    subscript(r: PartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(r.lowerBound, 0))
        let end = index(startIndex, offsetBy: count - 1)
        return String(self[start...end])
    }
    /// 根据range获取字符串 a[..<3]
    subscript(r: PartialRangeUpTo<Int>) -> String {
        let end = index(startIndex, offsetBy: min(r.upperBound, count))
        return String(self[startIndex..<end])
    }
    
    /// 截取字符串: 从索引 index 开始到结尾
    /// - Parameter index: 截取开始的索引
    /// - Returns: string
    func substring(_ index: Int) -> String {
        guard index < count else {
            return ""
        }
        let start = self.index(endIndex, offsetBy: index - count)
        return String(self[start..<endIndex])
    }
    
    /// 截取字符串 从索引 start 开始，长度为count
    /// - Parameters:
    ///   - begin: 开始截取的索引
    ///   - count: 需要截取的个数
    /// - Returns: 字符串
    func substring(start: Int, length count: Int) -> String {
        let begin = index(startIndex, offsetBy: max(0, start))
        let end = index(startIndex, offsetBy: min(count, start + count))
        return String(self[begin..<end])
    }
    
    // MARK: - 重新实现 substring 方法
    
    /// 返回索引from 到索引to 之间的字符串  包含索引from和to
    /// - Parameters:
    ///   - from: 开始索引
    ///   - to: 结束索引
    /// - Returns: String
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    /// 返回 索引from 之后的所有字符串
    /// - Parameter from: 开始索引
    /// - Returns: String
    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }
    
    /// 返回索引为3 之前的字符串 含索引3
    /// - Parameter to: 结束索引
    /// - Returns: String
    func substring(to: Int) -> String {
        guard to<self.count else {
            return self
        }
        let end = self.index(self.startIndex, offsetBy: to)
        return String(self[self.startIndex...end])
    }
    
    /// 返回索引为 to 之前，长度为length的字符串
    /// - Parameters:
    ///   - length: 截取字符串长度
    ///   - to: 结束索引
    /// - Returns: String
    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        
        return self.substring(from: start, to: to)
    }
    
    /// 去除空格和换行
    /// - Returns: 返回去除空格后的字符串
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    
}


/**
 * 使用
 let str = "0123456789"
 print("**********************************")
 print( str.substring(3)) //3456789 //从3到结尾
 print( str.substring(to: 3)) //0123 //从开始到3结束
 print( str.substring(from: 3)) //3456789 //从3到结尾
 print( str.substring(start: 3,length: 4)) //从3开始截取到索引4 [3..<4]
 print( str.substring(from: 3, to: 4)) //从3开始截取到索引4 [3...4]
 print( str.substring(length: 2, to: 3)) //0123 从3开始向前截取,长度为2
 print("**********************************")
 print(str[of: 9])
 print(str[0...9])
 print(str[0..<9])
 print(str[0...])
 print(str[1...])
 print(str[...9])
 print(str[..<10])
 */
