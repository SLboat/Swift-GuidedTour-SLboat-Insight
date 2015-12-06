//: ## Functions and Closures
//:
//: Use `func` to declare a function. Call a function by following its name with a list of arguments in parentheses. Use `->` to separate the parameter names and types from the function’s return type.
//:
func greet(name: String, day: String) -> String {  //一个函数,括号分割了参数(包含类型),横线和箭头指向返回值.
    return "Hello \(name), today is \(day)." //语句快,这个是引用字符串啥子的.
}
greet("Bob", day: "Tuesday") //调用函数,不要名称也可以..

//greet(name: "hi",day: "lo") //第一个参数不可以跟名字,否则出错: error: extraneous argument label 'name:' in call

func tellLanch(name: String, lanuch: String) -> String{
    return "Hi \(name), today's special lunch is \(lanuch)" //会自动补充的,自然的
}

tellLanch("Mikey", lanuch: "White food")

//: > **Experiment**:
//: > Remove the `day` parameter. Add a parameter to include today’s lunch special in the greeting.
//:
//: Use a tuple to make a compound value—for example, to return multiple values from a function. The elements of a tuple can be referred to either by name or by number.
//:
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) { //欢迎来到元祖世界,奇怪的tuple,土坡!它可以不定的组成,不同的类型,可以用名字也可以用序号来取得它.
    var min = scores[0] //最小-第一个
    var max = scores[0] //最大-第一个
    var sum = 0 //总和: 初始化

    for score in scores { //遍历分数
        if score > max { //比最大的大
            max = score //冒泡起来
        } else if score < min { //比最小的小
            min = score //冒泡下去
        }
        sum += score //比和加一加
    }

    return (min, max, sum) //返回三个家伙,也可以跟上标签
}
let statistics = calculateStatistics([5, 3, 100, 3, 9]) //开始统计
print(statistics.sum) //这是和
print(statistics.2) //这是第二个,这是最大值

//: Functions can also take a variable number of arguments, collecting them into an array.
//:
//这里是变长参数
func sumOf(numbers: Int...) -> Int { //三个点,放置一堆的玩意
    var sum = 0 //初步的和
    for number in numbers { //遍历
        sum += number //加和
    }
    return sum //返回和
}
sumOf() //没有人的和,得到0
sumOf(42, 597, 12) //三个的和,得到的是总和651


//带着另一个参数!
func nameWithsumOf(numbers: Int... , name: String) -> String{ //逗号很敏感,要小心
    var sum = 0 //初步的和
    for number in numbers { //遍历
        sum += number //加和
    }
    return "\(name),\(numbers) has sum: \(sum)" //会得到错误error: cannot invoke 'sumOf' with an argument list of type '([Int])'
}

nameWithsumOf(12,12,12,123, name: "mike") //瞧,有趣的是第二个是需要标签的


// 实验: 计算平均数
func average(numbers: Double...) -> Double{
    var sum = 0.0 //必须浮点数对应浮点数
    for number in numbers{
        sum += number
    }
    return sum / Double(numbers.count)
}

print("的平均数是:\(average(12,12,12,14,15.3))")
//: > **Experiment**:
//: > Write a function that calculates the average of its arguments.
//:
//: Functions can be nested. Nested functions have access to variables that were declared in the outer function. You can use nested functions to organize the code in a function that is long or complex.
//:
//函数可以嵌套,好处是简化太长的或者复杂的函数 !
func returnFifteen() -> Int { //一个函数,返回int,不接受参数
    var y = 10 //一个大函数里的变量
    func add() { //一个大函数里的内函数
        y += 5 //内函数可以访问外部的变量!它是可以写的
    }
    add() //呼叫内函数,y变化
    return y //返回自身变量(内函数的外变量)
}
returnFifteen() //调用大函数->连锁的内函数也调用了
//: Functions are a first-class type. This means that a function can return another function as its value.
//:
//函数是一级类型,可以返回另外一个函数...
func makeIncrementer() -> ((Int) -> Int) { //注意看最后的大括号,发返回的东西带有箭头,那是函数家的玩意,返回的是一个int参数的int函数,
    func addOne(number: Int) -> Int { //一个新的函数,而不是闭包,但是可以作为返回..
        return 1 + number //构造了一个函数...
    }
    return addOne
}
var increment = makeIncrementer() //瞧唷,返回了一个函数,类型是[Int -> Int]
increment(7)


//加上一堆别名
typealias 整数=Int;

func 制造递加函数(基数 基数: 整数) -> ((递加数字: 整数) -> 整数){
    //函数可以丢回去
    func 加一(数字: 整数) -> 整数 {
        return 基数 + 1 + 数字
    }
    //闭包也能丢回去
    let 加二:((数字: 整数) -> 整数) = { 数字 in
        return 基数 + 2 + 数字
    }
    return 加二
}

var 增加器 = 制造递加函数(基数: 2)
增加器(递加数字: 3)
//: A function can take another function as one of its arguments.
//:
//函数可以接受另一个函数作为参数,这就有趣了,而且很重要,因为闭包参数的起源就是这里了!
//隐藏:看起来很简单的特性,却蕴含了一切的奇妙...闭包回调的世界
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool { //参数1是一个整数数组,参数2是一个函数,接受整数参数和返回布尔结果,最终的返回是一个布尔值.整个玩意的作用是寻找任何匹配
    for item in list { //对里面的每一项遍历,根据泛型,这里的每一项是整数
        if condition(item) { //现在将参数的2的函数送来做判断...
            return true //如果真的发生了,返回离开...
        }
    }
    return false //啥也没遇到,离开..
}


//困扰:闭包什么时候捕捉变量呢?
func lessThanTen(number: Int) -> Bool { //构造一个直接函数用来比较....也可以一个闭包是的,闭包是私有的函数...
    return number < 10 //拿小于10来做个比较.
}

var numbers = [20, 19, 7, 12] //一个真实的整数数组
hasAnyMatches(numbers, condition: lessThanTen) //送去判断..

//: Functions are actually a special case of closures: blocks of code that can be called later. The code in a closure has access to things like variables and functions that were available in the scope where the closure was created, even if the closure is in a different scope when it is executed—you saw an example of this already with nested functions. You can write a closure without a name by surrounding code with braces (`{}`). Use `in` to separate the arguments and return type from the body.
//:
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})

//: > **Experiment**:
//: > Rewrite the closure to return zero for all odd numbers.
//:
//: You have several options for writing closures more concisely. When a closure’s type is already known, such as the callback for a delegate, you can omit the type of its parameters, its return type, or both. Single statement closures implicitly return the value of their only statement.
//:
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

//: You can refer to parameters by number instead of by name—this approach is especially useful in very short closures. A closure passed as the last argument to a function can appear immediately after the parentheses. When a closure is the only argument to a function, you can omit the parentheses entirely.
//:
let sortedNumbers = numbers.sort { $0 > $1 }
print(sortedNumbers)



//: [Previous](@previous) | [Next](@next)
