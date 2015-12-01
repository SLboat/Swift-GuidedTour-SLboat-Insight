//: ## Control Flow
//:
//: Use `if` and `switch` to make conditionals, and use `for`-`in`, `for`, `while`, and `repeat`-`while` to make loops. Parentheses around the condition or loop variable are optional. Braces around the body are required.
//:
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores { //花括号必选
    if score > 50 { //圆括号可选
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

//: In an `if` statement, the conditional must be a Boolean expression—this means that code such as `if score { ... }` is an error, not an implicit comparison to zero.
//:
//: You can use `if` and `let` together to work with values that might be missing. These values are represented as optionals. An optional value either contains a value or contains `nil` to indicate that a value is missing. Write a question mark (`?`) after the type of a value to mark the value as optional.
//:
var optionalString: String? = "Hello" //可选值!哈!

print(optionalString == nil) //打印它是否是空的

var optionalName: String? = "John Appleseed" //可选的名称
var greeting = "Hello!" //问候
if let name = optionalName { //能够赋予
    greeting = "Hello, \(name)" //打印
}

//空来一次
optionalName = nil
if let name = optionalName { //能够赋予,这是仅仅内部使用的实例变量,有效的时候-解包,赋值,给内部使用.
    greeting = "Hello, \(name)" //打印
}

//如果不能let解包
if optionalName != nil{
    greeting = "\(optionalString),\(optionalName)"
}
//: > **Experiment**:
//: > Change `optionalName` to `nil`. What greeting do you get? Add an `else` clause that sets a different greeting if `optionalName` is `nil`.
//:
//: If the optional value is `nil`, the conditional is `false` and the code in braces is skipped. Otherwise, the optional value is unwrapped and assigned to the constant after `let`, which makes the unwrapped value available inside the block of code.
//:
//: Another way to handle optional values is to provide a default value using the `??` operator. If the optional value is missing, the default value is used instead.
//:
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)" //有个默认值了!哈!

//: Switches support any kind of data and a wide variety of comparison operations—they aren’t limited to integers and tests for equality.
//:
let vegetable = "red pepper" //原始字符串
switch vegetable { //开始切换开关
    case "celery": //这是字符串对比
        print("Add some raisins and make ants on a log.")
        //默认不会往下,不用break
    case "cucumber", "watercress": //这是两种字符串对比
        print("That would make a good tea sandwich.")
    case let x where x.hasSuffix("pepper"): //字符串拆包,并且判断前缀-可选值绑定
        print("Is it a spicy \(x)?")
    default: //默认的玩意,必须有它...
        print("Everything tastes good in soup.")
}

//: > **Experiment**:
//: > Try removing the default case. What error do you get?
//:
//: Notice how `let` can be used in a pattern to assign the value that matched that part of a pattern to a constant.
//:
//: After executing the code inside the switch case that matched, the program exits from the switch statement. Execution doesn’t continue to the next case, so there is no need to explicitly break out of the switch at the end of each case’s code.
//:
//: You use `for`-`in` to iterate over items in a dictionary by providing a pair of names to use for each key-value pair. Dictionaries are an unordered collection, so their keys and values are iterated over in an arbitrary order.
//:
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13], //字典的键值和值
    "Fibonacci": [1, 1, 2, 3, 5, 8],//数组只能是一个类型?
    "Square": [1, 4, 9, 16, 25], //字典的键和值,屁股后面可以跟个逗号
]

var largest = 0 //最大的标记
var largestKind = ""
for (kind, numbers) in interestingNumbers { //遍历所有的数字
    for number in numbers { //遍历内部的
        if number > largest { //对比值..看起来它得自己相信它可以是数字的
            largest = number
            largestKind = kind
        }
    }
}
print("\(largest) in \(largestKind)")


//数组类型推测
//let d = [1,2,"3"] //出错,可怜的人,没有Swift类型指定,也没有Foundation撑腰

//import Foundation;
//let c = [1,2,"3"] //必须导入这个Foundation才能拥有混合类型.

let b:[Any] = [1,2,"3"] //这是特别指定类型,Swift家的
//: > **Experiment**:
//: > Add another variable to keep track of which kind of number was the largest, as well as what that largest number was.
//:
//: Use `while` to repeat a block of code until a condition changes. The condition of a loop can be at the end instead, ensuring that the loop is run at least once.
//:
var n = 2
while n < 100 { //标准while,while和花括号,不确定会否执行一次,但是总会回来...
    n = n * 2
}
print(n)

var m = 2
repeat { //倒置的while,至少总是有一遍会执行
    m = m * 2
} while m < 100
print(m)

//: You can keep an index in a loop—either by using `..<` to make a range of indexes or by writing an explicit initialization, condition, and increment. These two loops do the same thing:
//:
var firstForLoop = 0
for i in 0..<4 { //新型的循环...点点小于
    firstForLoop += i
}
print(firstForLoop)

var secondForLoop = 0
for var i = 0; i < 4; ++i { //旧时代的循环,三段,接括号也可以 for (var i = 0; i < 4; ++i){}
    secondForLoop += i
}
print(secondForLoop)

//: Use `..<` to make a range that omits its upper value, and use `...` to make a range that includes both values.
//:
for _ in 0...0 { //这就是新式的全包含,怎么都会有一次
    print("打印了一次.")
}

//: [Previous](@previous) | [Next](@next)
