import { promptAction } from '@kit.ArkUI'

@Component
export struct BottomInput {
  //保存输入框输入内容
  @State content: string = ''
  @State
  ShowVice: boolean = false
  @State showVoiceCom: boolean = false
  sendTextMessage: (content: string) => void = () => {
  }

  @Builder
  getVoiceCom() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Row() {
            Image($r('app.media.ic_public_cancel'))
              .width(30)
              .aspectRatio(1)
              .fillColor($r('app.color.voice_round_font_color'))
          }
          .width(70)
          .aspectRatio(1)
          .borderRadius(35)
          .justifyContent(FlexAlign.Center)
          .backgroundColor($r('app.color.voice_round_color'))
          .rotate({
            angle: -10
          })


          Row() {
            Text("文")
              .fontSize(24)
              .fontColor($r('app.color.voice_round_font_color'))
              .textAlign(TextAlign.Center)
          }
          .width(70)
          .aspectRatio(1)
          .borderRadius(35)
          .justifyContent(FlexAlign.Center)
          .backgroundColor($r('app.color.voice_round_color'))
          .rotate({
            angle: 10
          })
        }
        .padding({ left: 40, right: 40 })
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ bottom: 15 })

        Stack() {
          Image($r('app.media.ic_public_output'))
            .width("100%")
            .height(120)
            .fillColor($r("app.color.bottom_color"))
            .scale({
              x: 1.2
            })
          Image($r('app.media.ic_public_recorder'))
            .width(30)
            .height(30)
            .fillColor($r('app.color.bottom_voice_color'))
        }
      }
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r('app.color.voice_back_color'))
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
            .borderRadius(2)
            .height(35)
            .fontColor($r('app.color.text_primary'))
            .gesture(LongPressGesture()
              .onAction(() => {
                //手势开始触发
                this.showVoiceCom = true
              })
              .onActionEnd(() => {
                //手势结束触发
                this.showVoiceCom = false
              })
            )
            .bindContentCover(this.showVoiceCom, this.getVoiceCom, {
              modalTransition: ModalTransition.NONE
            })
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