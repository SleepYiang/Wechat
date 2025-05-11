@Component
struct WeChat {
  build() {
    Column() {
      List() {
        ListItem() {
          Row({ space: 5 }) {
            Image('https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F373c6d24-1f8b-4000-8dd9-8d8410c35e71%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069618&t=51805a82420593c2a3cda47b9f65a80e')
              .width(40)
              .height(40)
              .borderRadius(5)
            Column() {
              Row() {
                Text('老板')
                  .fontSize(16)
                  .fontColor($r('app.color.text_primary'))

                Text("00:00")
                  .fontSize(12)
                  .fontColor($r('app.color.text_primary'))
                  .margin({ top: 10, })
              }
              .justifyContent(FlexAlign.SpaceBetween)
              .width('100%')

              Text('hello brow')
                .maxLines(1)
                .fontSize(14)
                .fontColor($r('app.color.text_second'))
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .layoutWeight(1)
            .height(50)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({ top: 3, bottom: 3 })
          }
        }
        .padding({ top: 10, bottom: 10 })
        .stateStyles({
          pressed: {
            .backgroundColor($r('app.color.back_color'))
          },
          normal: {
            .backgroundColor($r('app.color.white'))
          }
        })
      }
      .divider({
        strokeWidth: 1,
        color: $r('app.color.border_color')
      })
      .padding({
        left: 10, right: 10
      })
      .width('100%')
      .height('100%')
      .layoutWeight(1)
    }
    .width("100%")
    .height("100%")
    .backgroundColor('#fff')
  }
}

export default WeChat