@Component
struct VoiceInput {
  build() {
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
}

export default VoiceInput