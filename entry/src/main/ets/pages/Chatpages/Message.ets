@Component
struct Message {
  build() {
    Row() {
      Image('https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2Ff1d11ab1-35ff-4f2c-b9e9-3e0c996d34a2%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069489&t=e3234db982e8a36639d170fc5cec7848')
        .width(40)
        .height(40)
        .borderRadius(3)

      Row() {
        Column() {
          Text("你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀")
            .backgroundColor($r('app.color.white'))
            .fontColor($r('app.color.text_primary'))
            .padding(10)
            .margin({ left: 10, right: 10 })
            .borderRadius(5)
        }
      }
      .layoutWeight(6)
      .justifyContent(FlexAlign.End)

      Text()
        .layoutWeight(1)
    }
    .direction(Direction.Rtl)
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .padding({
      left: 20,
      right: 20
    })
  }
}

export default Message