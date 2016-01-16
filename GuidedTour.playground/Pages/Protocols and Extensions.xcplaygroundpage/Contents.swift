//: ## Protocols and Extensions
//:
//: Use `protocol` to declare a protocol.
//:
protocol ExampleProtocol { //定义了一个协议
     var simpleDescription: String { get } //标识是一个取得方法,没有写入?或者至少有取得?
     mutating func adjust() //一个会改变自身的方法...
}

//: Classes, enumerations, and structs can all adopt protocols.
//:
class SimpleClass: ExampleProtocol { //类可以装载协议,采用,领养,哈!
     var simpleDescription: String = "A very simple class." //实现了取方法
     var anotherProperty: Int = 69105 //这是自己的属性啦
     func adjust() { //这是协议里的方法
          simpleDescription += "  Now 100% adjusted." //给自己加了东西...
     }
}
var a = SimpleClass() //建造一个类
a.adjust() //调整自己...
let aDescription = a.simpleDescription //现在信息被改变了

struct SimpleStructure: ExampleProtocol { //结构化的同样的它...
     var simpleDescription: String = "A simple structure"
     mutating func adjust() { //增加调整字符
          simpleDescription += " (adjusted)"
     }
}
//同样的演化...
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription


//练习: 枚举...
enum mike: ExampleProtocol{
    case me,you
    var simpleDescription: String { //可以属性,但是只能是计算的,不能是存储的...存储的就是一个值记住的...
        //想法: 计算属性,就像是存取器嘛
        return "A simple structure"
    }
    mutating func adjust() {
        self = .you
    }
}
//: > **Experiment**:
//: > Write an enumeration that conforms to this protocol.
//:
//: Notice the use of the `mutating` keyword in the declaration of `SimpleStructure` to mark a method that modifies the structure. The declaration of `SimpleClass` doesn’t need any of its methods marked as mutating because methods on a class can always modify the class.
//:
//: Use `extension` to add functionality to an existing type, such as new methods and computed properties. You can use an extension to add protocol conformance to a type that is declared elsewhere, or even to a type that you imported from a library or framework.
//:
//扩展,可以扩展计算属性(不能存储属性),可以引入协议(甚至是外部的)
extension Int: ExampleProtocol { //这是遵循了协议
    var simpleDescription: String { //协议里的一个计算方法要求({get})
        return "The number \(self)"
    }
    mutating func adjust() { //变化自身,Int是个结构: struct Int : SignedIntegerType, Comparable, Equatable
        self += 42 //改变自身
    }
 }
print(7.simpleDescription) //所有的数字现在都变化了...

//练习:给double一个礼物...
import Foundation //fabs依赖darwin

extension Double{ //扩展Double
    var absoluteValue: Double { //取得绝对值
        return fabs(self)
    }
}

-12.3.absoluteValue //得到12.3

//: > **Experiment**:
//: > Write an extension for the `Double` type that adds an `absoluteValue` property.
//:
//: You can use a protocol name just like any other named type—for example, to create a collection of objects that have different types but that all conform to a single protocol. When you work with values whose type is a protocol type, methods outside the protocol definition are not available.
//:
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// print(protocolValue.anotherProperty)  // Uncomment to see the error

//: Even though the variable `protocolValue` has a runtime type of `SimpleClass`, the compiler treats it as the given type of `ExampleProtocol`. This means that you can’t accidentally access methods or properties that the class implements in addition to its protocol conformance.
//:


//: [Previous](@previous) | [Next](@next)
