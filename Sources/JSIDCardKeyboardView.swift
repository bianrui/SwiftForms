//
//  JSIDCardKeyboardView.swift
//  fho
//
//  Created by 郭颢源 on 2021/3/23.
//

import UIKit

class JSIDCardKeyboardView: UIView {
    var currentTextField:UITextField = UITextField()
    
    var titles:Array<String> = ["1","2","3","4","5","6","7","8","9","X","0","deleted"]
    var inputstr:String = ""
     var clearImage:UIImage {
        get{
            return imageWithColor(color: .clear)
        }
    }
    
    typealias changeStr = (_ str:String)->Void
    var block : changeStr?
    
    var maxY = 0
    
    let kMargin = 5
    let kTotalRows = 4
    let kTotalCols = 3

    let kButtonHeight = 50
    var kButtonWidth: CGFloat{
        get{
            return ((UIScreen.main.bounds.width - CGFloat((kTotalCols+1)*kMargin)) / CGFloat(kTotalCols))
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 211.0/255.0, green: 215.0/255.0, blue: 221.0/255.0, alpha: 1.0)
        inputstr = String()
        setUIConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func initWithFrame(frame:CGRect) -> AnyObject {
//
//        backgroundColor = UIColor(red: 211.0/255.0, green: 215.0/255.0, blue: 221.0/255.0, alpha: 1.0)
//        inputstr = String()
//        setUIConfig()
//        return self
//    }
//    -(void)setUIConfig{
//        NSInteger count = self.titles.count;
//        for (int index = 0; index < count; index ++) {
//            UIButton *button = [self createKeyBoardButton];
//
//            NSInteger currentRow = index / kTotalCols;
//            NSInteger currentCol = index % kTotalCols;
//            CGFloat buttonX = kMargin + (kButtonWidth + kMargin) * currentCol;
//            CGFloat buttonY = kMargin + (kButtonHeight + kMargin) * currentRow;
//            button.frame = CGRectMake(buttonX, buttonY, kButtonWidth, kButtonHeight);
//            if (index == self.titles.count -1) {
//                [button setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//                [button setBackgroundImage:self.clearImage forState:UIControlStateNormal];
//                [button setBackgroundImage:self.clearImage forState:UIControlStateHighlighted];
//                self.maxY = CGRectGetMaxY(button.frame);
//            }else{
//                [button setTitle:self.titles[index] forState:UIControlStateNormal];
//            }
//            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:button];
//        }
//    }
    func setUIConfig() {
        let count:NSInteger = self.titles.count;
        for index in 0...count-1 {
            let button:UIButton = createKeyBoardButton()
            let currentRow:NSInteger = index / kTotalCols
            let currentCol:NSInteger = index % kTotalCols
            let buttonX = kMargin + (Int(kButtonWidth) + kMargin) * currentCol
            let buttonY = kMargin + (kButtonHeight + kMargin) * currentRow
            button.frame = CGRect(x: buttonX, y: buttonY, width: Int(kButtonWidth), height: kButtonHeight)
            
            if index == titles.count-1 {
                button.setImage(UIImage(named: "delete"), for: .normal)
                button.setBackgroundImage(clearImage, for: .normal)
                button.setBackgroundImage(clearImage, for: .highlighted)
                
                maxY = Int(button.frame.maxY)
            }else
            {
                button.setTitle(titles[index], for: .normal)
            }
            button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            addSubview(button)
        }
    }

    func createKeyBoardButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(imageWithColor(color: .white), for: .normal)
        button.setBackgroundImage(imageWithColor(color: self.backgroundColor!), for: .highlighted)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        return button
    }


    @objc func buttonClick(button:UIButton) {
        let currentRange:NSRange = selectedRange(textField: currentTextField);
        if button.currentImage != nil {

            if inputstr.count != 0 {
                inputstr.remove(at:inputstr.index(before:inputstr.endIndex))
                currentTextField.deleteBackward()
            }
        }else{

            inputstr.insert(Character(button.currentTitle!),at:inputstr.endIndex)
            currentTextField.text = inputstr
            setCursorLocation(location: currentRange.location + 1, textField: currentTextField)
        }
        self.block!(inputstr)
    }


    func selectedRange(textField:UITextField) -> NSRange {
        let beginning:UITextPosition = textField.beginningOfDocument
        let selectedRange:UITextRange = textField.selectedTextRange!
        let selectionStart:UITextPosition = selectedRange.start
        let selectionEnd:UITextPosition = selectedRange.end
        let location:NSInteger = textField.offset(from: beginning, to: selectionStart)
//         [textField offsetFromPosition:beginning toPosition:selectionStart];
        let length:NSInteger = textField.offset(from: selectionStart, to: selectionEnd)
//            [textField offsetFromPosition:selectionStart toPosition:selectionEnd];
       
        return NSRange(location: location, length: length)
    }

//    - (void) setSelectedRange:(NSRange)range :(UITextField *)textField{
//        UITextPosition* beginning = textField.beginningOfDocument;
//        UITextPosition* startPosition = [textField positionFromPosition:beginning offset:range.location];
//        UITextPosition* endPosition = [textField positionFromPosition:beginning offset:range.location + range.length];
//        UITextRange* selectionRange = [textField textRangeFromPosition:startPosition toPosition:endPosition];
//        [textField setSelectedTextRange:selectionRange];
//    }

    func setSelectedRange(range:NSRange, textField: UITextField) {
        let beginning:UITextPosition = textField.beginningOfDocument;
        let startPosition:UITextPosition = textField.position(from: beginning, offset: range.location)!
//            [textField positionFromPosition:beginning offset:range.location];
        let endPosition:UITextPosition = textField.position(from: beginning, offset: range.location+range.length)!
//            [textField positionFromPosition:beginning offset:range.location + range.length];
        let selectionRange:UITextRange = textField.textRange(from: startPosition, to: endPosition)!
        
//            [textField textRangeFromPosition:startPosition toPosition:endPosition];
//        [textField setSelectedTextRange:selectionRange];
//        textField.setMarkedText(<#T##markedText: String?##String?#>, selectedRange: <#T##NSRange#>)
//        textField.setMarkedText(textField.text, selectedRange: selectionRange)
        textField.selectionRects(for: selectionRange)
//        textField.selectedTextRange(selectionRange)
        
    }



    func setCursorLocation(location:NSInteger,textField:UITextField) {
        
        let range:NSRange = NSRange(location: location,length: 0)
        let beginning:UITextPosition = textField.beginningOfDocument
        let start:UITextPosition = textField.position(from: beginning, offset: range.location)!
        let end:UITextPosition = textField.position(from: start, offset: range.length)!
        textField.selectedTextRange = textField.textRange(from: start, to: end)
//        textField.setMarkedText(textField.text, selectedRange: textField.textRange(from: start, to: end))
    }
    
    func imageWithColor(color:UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
//    - (UIImage *)imageWithColor:(UIColor *)color {
//        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//        UIGraphicsBeginImageContext(rect.size);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetFillColorWithColor(context, [color CGColor]);
//        CGContextFillRect(context, rect);
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return image;
//    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
