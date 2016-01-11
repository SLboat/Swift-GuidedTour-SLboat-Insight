//: ## Enumerations and Structures
//:
//: Use `enum` to create an enumeration. Like classes and all other named types, enumerations can have methods associated with them.
//:
//枚举和结构,它们也可以有方法,哈!
enum Rank: Int { //枚举的名称,原始值.
    case Ace = 1 //一个值
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten //这些值看起来是默认生成值了
    case Jack, Queen, King //继续按顺序生成,这是编译器做的!因为编译的时候就生就了.Jack.raValue = 10
    func simpleDescription() -> String {
        switch self {
            case .Ace:
                return "ace"
            case .Jack:
                return "jack"
            case .Queen:
                return "queen"
            case .King:
                return "king"
            default:
                return String(self.rawValue)
        }
    }
}

let ace = Rank.Ace //赋予类型
let aceRawValue = ace.rawValue //原始值

//实验:一个比较函数...
func compRank(ran1: Rank, ran2: Rank) -> Bool{
    return ran1.rawValue == ran2.rawValue;
}

compRank(Rank.Ace, ran2: Rank.Jack)

//: > **Experiment**:
//: > Write a function that compares two `Rank` values by comparing their raw values.
//:
//: In the example above, the raw-value type of the enumeration is `Int`, so you only have to specify the first raw value. The rest of the raw values are assigned in order. You can also use strings or floating-point numbers as the raw type of an enumeration. Use the `rawValue` property to access the raw value of an enumeration case.
//:
//: Use the `init?(rawValue:)` initializer to make an instance of an enumeration from a raw value.
//:
enum st:String{
    case me = "me"
    case you, her //猜猜看,字符串的原始值是什么?是自身!这里you="you"
}
st.you.rawValue //得到you
st.her.rawValue //得到her

//从原始值来得到枚举类型
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

//: The case values of an enumeration are actual values, not just another way of writing their raw values. In fact, in cases where there isn’t a meaningful raw value, you don’t have to provide one.
//:
//枚举的值是真实的值,不只是另一种方式来保存它们的原始值.事实上,对于可能找不到任何意义的原始值,你甚至你需要提供给一个
enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String { //这里的魔法就是理解自己..
        switch self {
            case .Spades:
                return "spades"
            case .Hearts:
                return "hearts"
            case .Diamonds:
                return "diamonds"
            case .Clubs:
                return "clubs"
        }
    }
}
let hearts = Suit.Hearts //赋予一个枚举值,这里不知道类型,因此必须跟上名称啥的.
let heartsDescription = hearts.simpleDescription() //得到它的描述

extension Suit{
    func color() -> String{ //总是能够计算和理解自己,哈!就像人理解我是谁.
        switch self{
        case .Spades, .Clubs: //类型已知,不需要指明自己就好了...
            return "black"
        case .Hearts, .Diamonds:
            return "red"
        }
    }
}

Suit.Clubs.color() //得到的是black
//: > **Experiment**:
//: > Add a `color()` method to `Suit` that returns “black” for spades and clubs, and returns “red” for hearts and diamonds.
//:
//: Notice the two ways that the `Hearts` case of the enumeration is referred to above: When assigning a value to the `hearts` constant, the enumeration case `Suit.Hearts` is referred to by its full name because the constant doesn’t have an explicit type specified. Inside the switch, the enumeration case is referred to by the abbreviated form `.Hearts` because the value of `self` is already known to be a suit. You can use the abbreviated form anytime the value’s type is already known.
//:
//: Use `struct` to create a structure. Structures support many of the same behaviors as classes, including methods and initializers. One of the most important differences between structures and classes is that structures are always copied when they are passed around in your code, but classes are passed by reference.
//:
struct Card { //这是结构,它和类是如此的相似,甚至包括到有一样的方法和初始化器机制...
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    //练习-全部的卡
    func all() -> [String]{
        var cards = [String]()
        for su in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "J", "P", "Q", "K"] {
            for rn in ["♠️", "♣️", "♥️", "♦️"]{
                cards.append("\(rn)\(su)")
            }
        }
        return cards;
    }
}
let threeOfSpades = Card(rank: .Three, suit: .Spades) //一个古怪的区别是拷贝自己来传递...
let threeOfSpadesDescription = threeOfSpades.simpleDescription() //取得它的描述,这里是一个函数的值...

//赋值
let i = threeOfSpades //赋予
i.simpleDescription() //打印...

print(threeOfSpades.all())

//: > **Experiment**:
//: > Add a method to `Card` that creates a full deck of cards, with one card of each combination of rank and suit.
//:
//: An instance of an enumeration case can have values associated with the instance. Instances of the same enumeration case can have different values associated with them. You provide the associated values when you create the instance. Associated values and raw values are different: The raw value of an enumeration case is the same for all of its instances, and you provide the raw value when you define the enumeration.
//:
//: For example, consider the case of requesting the sunrise and sunset time from a server. The server either responds with the information or it responds with some error information.
//:
//关联值的枚举
enum ServerResponse {
    case Result(String, String) //一种结果关联,带有两个字符串
    case Error(String) //错误关联,带有一个字符串
    case NoNetWork
}

let success = ServerResponse.Result("6:00 am", "8:09 pm") //注意看匹配的存在
let failure = ServerResponse.Error("Out of cheese.") //即使几个是不同的情况,也很容易辨别
let noNet = ServerResponse.NoNetWork

switch success {
    case let .Result(sunrise, sunset):
        print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
    case let .Error(error):
        print("Failure...  \(error)")
    default:
        print("一种全新的情况-很可能是没有网络,哈!")
}

//: > **Experiment**:
//: > Add a third case to `ServerResponse` and to the switch.
//:
//: Notice how the sunrise and sunset times are extracted from the `ServerResponse` value as part of matching the value against the switch cases.
//:


//: [Previous](@previous) | [Next](@next)
