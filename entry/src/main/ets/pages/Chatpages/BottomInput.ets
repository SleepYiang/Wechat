import { promptAction } from '@kit.ArkUI'

@Component
export struct BottomInput {
  //保存输入框输入内容
  @State content: string = ''
  @State
  ShowVice: boolean = false
  sendTextMessage: (content: string) => void = () => {
  }

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
          TextInput({ text: $$this.content })
            .layoutWeight(1)
            .id('input')
            .focusable(true)//设置元素聚焦
            .defaultFocus(true)//通过defaultFocus开启默认聚焦
            .height(35)
            .borderRadius(2)
            .backgroundColor(Color.White)
            .onSubmit(() => {
              if (this.content) {
                this.sendTextMessage(this.content)
                this.content = ''
                focusControl.requestFocus('input')
              } else {
                promptAction.showToast({
                  message: '内容不能为空'
                })
              }
            })
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