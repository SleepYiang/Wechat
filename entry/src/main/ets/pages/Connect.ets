@Component
struct Connect {
  build() {
    Column() {
      //搜索栏
      Row() {
        Search({ placeholder: '搜索' })
      }
      .width("100%")
      .padding({ top: 20, left: 10, right: 10 })
      .backgroundColor($r('app.color.white'))

      //联系人列表
      List() {
        ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9], () => {
          ListItem() {
            Row({ space: 10 }) {
              Image('https://img2.baidu.com/it/u=2778471297,524433918&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500')
                .width(30)
                .height(30)
                .borderRadius(5)
              Row() {
                Text('小趴菜')
                  .fontSize(14)
                  .fontColor($r('app.color.text_primary'))
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)
              .padding(10)
            }
            .width("100%")
            .height(60)
            .padding({ left: 8, top: 8 })
            .stateStyles({
              pressed: {
                .backgroundColor($r('app.color.back_color'))
              },
              normal: {
                .backgroundColor($r('app.color.white'))
              }
            })
          }
        })

      }
      .width('100%')
      .height('100%')
      .padding({
        top: 10, bottom: 8
      })
      .divider({
        strokeWidth: 1,
        color: $r("app.color.back_color")
      })
      .layoutWeight(1)
      .backgroundColor($r('app.color.white'))
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.back_color'))
  }
}

export default Connect