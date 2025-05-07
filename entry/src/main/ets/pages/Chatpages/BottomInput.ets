@Component
export struct BottomInput {
  @State
  ShowVice: boolean = false

  build() {
    Column() {
      Row({ space: 5 }) {
        //左侧图标
        Image(this.ShowVice ? $r('app.media.ic_public_keyboard') : $r('app.media.ic_public_sound'))
          .onClick(() => {
            this.ShowVice = !this.ShowVice
          })
          .width(25)
          .height(25)
        //中间输入
        if (this.ShowVice) {
          Button('按住说话')
            .type(ButtonType.Normal)
            .backgroundColor(Color.White)
            .layoutWeight(1)
            .fontColor($r('app.color.text_primary'))
            .borderRadius(2)
            .height(35)
        } else {
          TextInput()
            .layoutWeight(1)
            .height(35)
            .borderRadius(2)
            .backgroundColor(Color.White)
        }


        //右侧图标
        Image($r('app.media.ic_public_add_norm'))
          .width(25)
          .height(25)
      }
      .width('100%')
      .height(60)
      .padding({ right: 10, left: 10 })
    }
    .backgroundColor($r('app.color.second_back_color'))
  }
}