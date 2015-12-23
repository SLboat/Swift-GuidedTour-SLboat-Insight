//: ## Objects and Classes
//:
//: Use `class` followed by the class’s name to create a class. A property declaration in a class is written the same way as a constant or variable declaration, except that it is in the context of a class. Likewise, method and function declarations are written the same way.
//:
//使用class跟着class的名称来创造类,一个属性的定义就像在外面的常量(let)和变量(var)一样,除了它是在类的上下文里
class Shape {
    var numberOfSides = 0 //一个属性,带有默认值
    func simpleDescription() -> String { //一个函数-方法...
        return "A shape with \(numberOfSides) sides." //输出!
    }
    // 实验!常量和另一个方法
    let name = "Random";
    func printWith(who: String){
        print("\(who),I'm \(name).")
    }
}


//: > **Experiment**:
//: > Add a constant property with `let`, and add another method that takes an argument.
//:
//: Create an instance of a class by putting parentheses after the class name. Use dot syntax to access the properties and methods of the instance.
//:
//用括号来创建一个实例!
var shape = Shape()
//用点语法来访问属性或者方法
shape.numberOfSides = 7
//瞧!打印-调用!
var shapeDescription = shape.simpleDescription()

//: This version of the `Shape` class is missing something important: an initializer to set up the class when an instance is created. Use `init` to create one.
//:
class NamedShape {
    var numberOfSides: Int = 0 //赋予了初值
    var name: String //每个属性都需要初始化,要么初值,要么初始化器.

    init(name: String) { //带有名字!
       self.name = name //参数和属性可以是一样的,self在这里做出了区分!
    }

    func simpleDescription() -> String {
       return "A shape with \(numberOfSides) sides."
    }
    
    deinit{ //析构器,大概是这东西,最终的总会释放
        print("\(name)被释放了...")
    }
}

// 试试析构器
let n = NamedShape(name: "hi")
print(n.simpleDescription())

//: Notice how `self` is used to distinguish the `name` property from the `name` argument to the initializer. The arguments to the initializer are passed like a function call when you create an instance of the class. Every property needs a value assigned—either in its declaration (as with `numberOfSides`) or in the initializer (as with `name`).
//:
//: Use `deinit` to create a deinitializer if you need to perform some cleanup before the object is deallocated.
//:
//: Subclasses include their superclass name after their class name, separated by a colon. There is no requirement for classes to subclass any standard root class, so you can include or omit a superclass as needed.
//:
//: Methods on a subclass that override the superclass’s implementation are marked with `override`—overriding a method by accident, without `override`, is detected by the compiler as an error. The compiler also detects methods with `override` that don’t actually override any method in the superclass.
//:
class Square: NamedShape { //这里有了子类!
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength //基础类提供了边长
        super.init(name: name) //调用父类是很自由的,但是必须调用
        numberOfSides = 4
    }

    func area() ->  Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String { //编译器会自动检测是否override放置错误...
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()

//实验: 一个圆和它的周长
import Foundation //导入库只能在外面
class Circle: NamedShape {
    var radius: Double //半径
    init(radius: Double, name: String) { //瞧!名字都一样,没啥事!
        self.radius = radius
        super.init(name: name)
        numberOfSides = 0 //这是父类的属性,哈!
    }
    func area() -> Double {
        return 2 * M_PI * radius;
    }
    override func simpleDescription() -> String {
        return "一个半径为\(radius)的圆,周长是\(area())"
    }
}

//实验
let r = Circle(radius: 2, name: "圆圈")
print(r.simpleDescription())

//: > **Experiment**:
//: > Make another subclass of `NamedShape` called `Circle` that takes a radius and a name as arguments to its initializer. Implement an `area()` and a `simpleDescription()` method on the `Circle` class.
//:
//: In addition to simple properties that are stored, properties can have a getter and a setter.
//:
class EquilateralTriangle: NamedShape { //等边三角形,可不有趣嘛!
    var sideLength: Double = 0.0 //边长默认0

    init(sideLength: Double, name: String) { //初始化器
        self.sideLength = sideLength //设置子类的属性
        super.init(name: name) //惯例名称,调用父类指定初始化器
        numberOfSides = 3 //设置父类的属性,要是有其它的初始化活儿也该这里来干呢.
    }

    var perimeter: Double { //这里看起来是面值了...
        get { //取方法
             return 3.0 * sideLength
        }
        set { //存方法!
            sideLength = newValue / 3.0 //新值的隐藏名称!
        }
    }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle") //建造三角形
print(triangle.perimeter) //输出面积,三倍
triangle.perimeter = 9.9
print(triangle.sideLength)

//: In the setter for `perimeter`, the new value has the implicit name `newValue`. You can provide an explicit name in parentheses after `set`.
//:
//: Notice that the initializer for the `EquilateralTriangle` class has three different steps:
//:
//: 1. Setting the value of properties that the subclass declares.
//:
//: 1. Calling the superclass’s initializer.
//:
//: 1. Changing the value of properties defined by the superclass. Any additional setup work that uses methods, getters, or setters can also be done at this point.
//:
//: If you don’t need to compute the property but still need to provide code that is run before and after setting a new value, use `willSet` and `didSet`. The code you provide is run any time the value changes outside of an initializer. For example, the class below ensures that the side length of its triangle is always the same as the side length of its square.
//:
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet { //将要设置值
            square.sideLength = newValue.sideLength //这是个子类呢...
        }
    }
    var square: Square {
        willSet { //将要设置值,在初始化器里操作不会触发,但是外部设置的时候会触发
            triangle.sideLength = newValue.sideLength //绑定了三角形!
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name) //初始化方块
        triangle = EquilateralTriangle(sideLength: size, name: name) //初始化三角形
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape") //制造形状,大小是10
print(triangleAndSquare.square.sideLength) //打印方块的边长
print(triangleAndSquare.triangle.sideLength) //打印三角形的边长
triangleAndSquare.square = Square(sideLength: 50, name: "larger square") //更大的方块
print(triangleAndSquare.triangle.sideLength) //打印三角形的边长...

//: When working with optional values, you can write `?` before operations like methods, properties, and subscripting. If the value before the `?` is `nil`, everything after the `?` is ignored and the value of the whole expression is `nil`. Otherwise, the optional value is unwrapped, and everything after the `?` acts on the unwrapped value. In both cases, the value of the whole expression is an optional value.
//:
//与可选值一起工作..
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength //解包后的某种真实值

//: [Previous](@previous) | [Next](@next)
