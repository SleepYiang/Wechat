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
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.back_color'))
  }
}

export default Connect