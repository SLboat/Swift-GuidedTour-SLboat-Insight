//: # A Swift Tour
//:
//: Tradition suggests that the first program in a new language should print the words “Hello, world!” on the screen. In Swift, this can be done in a single line:
//:

//: 留意: 让他们存档到源码里去!

print("Hello, world!") //问候世界
print("你好!世界!")

//: If you have written code in C or Objective-C, this syntax looks familiar to you—in Swift, this line of code is a complete program. You don’t need to import a separate library for functionality like input/output or string handling. Code written at global scope is used as the entry point for the program, so you don’t need a `main()` function. You also don’t need to write semicolons at the end of every statement.
//:
//: This tour gives you enough information to start writing code in Swift by showing you how to accomplish a variety of programming tasks. Don’t worry if you don’t understand something—everything introduced in this tour is explained in detail in the rest of this book.
//:
//: ## Simple Values
//:
//: Use `let` to make a constant and `var` to make a variable. The value of a constant doesn’t need to be known at compile time, but you must assign it a value exactly once. This means you can use constants to name a value that you determine once but use in many places.
//:
var myVariable = 42 //变量...
myVariable = 50 //瞧赋值进去了
let myConstant = 42 //常量,不可变化,会得到警告噢
//: myConstant = 12 //取消注释?就得完蛋
//: A constant or variable must have the same type as the value you want to assign to it. However, you don’t always have to write the type explicitly. Providing a value when you create a constant or variable lets the compiler infer its type. In the example above, the compiler infers that `myVariable` is an integer because its initial value is an integer.
//:
//: If the initial value doesn’t provide enough information (or if there is no initial value), specify the type by writing it after the variable, separated by a colon.
//:
let implicitInteger = 70 //一个整数类型?
String(implicitInteger.dynamicType) //哈,来一个打印类型...,这里是int
let implicitDouble = 70.0 //一个浮点数类型?
let explicitDouble: Double = 70 //双浮点,显式的...

let explicitFloat: Float = 64 //实验!
//: > **Experiment**:
//: > Create a constant with an explicit type of `Float` and a value of `4`.
//:
//: Values are never implicitly converted to another type. If you need to convert a value to a different type, explicitly make an instance of the desired type.
//:
let label = "The width is "
let width = 94
let widthLabel = label + String(width) //都是光明正大的转换的,不会隐式转换

//let widthLabel = label + width //实验,出意外的..overloads for '+' exist with these partially matching parameter lists: (Int, Int), (String, String),多友好的提醒阿.

//: > **Experiment**:
//: > Try removing the conversion to `String` from the last line. What error do you get?
//:
//: There’s an even simpler way to include values in strings: Write the value in parentheses, and write a backslash (`\`) before the parentheses. For example:
//:
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples." //反斜杠和括号!
let fruitSummary = "I have \(apples + oranges + 3) pieces of fruit." //计算值,哈!

//实验
let someName = "pink"
let greet = "\(someName),hi,let me tell you,1.3+2.4 = \(1.3+2.4)"

//: > **Experiment**:
//: > Use `\()` to include a floating-point calculation in a string and to include someone’s name in a greeting.
//:
//: Create arrays and dictionaries using brackets (`[]`), and access their elements by writing the index or key in brackets. A comma is allowed after the last element.
//:
var shoppingList = ["catfish", "water", "tulips", "blue paint"] //数组,哈!
shoppingList[1] = "bottle of water" //数组的一个,用序号巡查.

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic", //最后有个逗号,没问题!js看起来也这样!
 ]
occupations["Jayne"] = "Public Relations" //等等,这个就成了字典了吧!

//: To create an empty array or dictionary, use the initializer syntax.
//:
let emptyArray = [String]() //空数组,字符串的
let emptyDictionary = [String: Float]() //数组对浮点数的空数组..

//: If type information can be inferred, you can write an empty array as `[]` and an empty dictionary as `[:]`—for example, when you set a new value for a variable or pass an argument to a function.
//:
shoppingList = [] //类型无关
occupations = [:] //类型无关的字典



//: See [License](License) for this sample's licensing information.
//: 
//: [Next](@next)
