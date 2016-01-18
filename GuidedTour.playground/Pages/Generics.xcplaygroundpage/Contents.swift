//: ## Generics
//:
//: Write a name inside angle brackets to make a generic function or type.
//:
//在尖括号里写上一个名字,得到一个通用方法或者类型.
func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item] { //这里Item是一个代替名字
    var result = [Item]() //结果的最初部分
    for _ in 0..<numberOfTimes { //遍历次数
         result.append(item) //翻滚自己...自己的数组总是能够容纳自己
    }
    return result
}
repeatItem("knock", numberOfTimes:4) //演示它,这是个字符串

repeatItem(12, numberOfTimes: 2) //数字也没有问题

//妙处: 嗯...这些东西对啥子类都管用
//: You can make generic forms of functions and methods, as well as classes, enumerations, and structures.
//:
// 重新实现基本库的可选选项...
enum OptionalValue<Wrapped> { //这里Wrapped是个代名词,看起来通常都喜欢大写首字母
    case None
    case Some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)

//: Use `where` after the type name to specify a list of requirements—for example, to require the type to implement a protocol, to require two types to be the same, or to require a class to have a particular superclass.
//:
func anyCommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, _ rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
   return false
}
anyCommonElements([1, 2, 3], [3])

//: > **Experiment**:
//: > Modify the `anyCommonElements(_:_:)` function to make a function that returns an array of the elements that any two sequences have in common.
//:
//: Writing `<T: Equatable>` is the same as writing `<T where T: Equatable>`.
//:


//: [Previous](@previous)
