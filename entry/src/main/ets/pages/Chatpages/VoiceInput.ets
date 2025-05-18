import { VoiceRecordEnum } from '../../Model/Voice'

@Component
struct VoiceInput {
  @Consume
  voiceState: VoiceRecordEnum

  @Builder
  getDisplayContent() {
    if (this.voiceState === VoiceRecordEnum.Cancel) {
      Row() {
      }
      .width(100)
      .height(80)
      .backgroundColor($r('app.color.danger'))
      .borderRadius(20)
      .margin({ left: 30 })
    }
    if (this.voiceState === VoiceRecordEnum.Recording) {
      Row() {
      }
      .width(100)
      .height(80)
      .backgroundColor($r('app.color.chat_primary'))
      .borderRadius(20)
    }
    if (this.voiceState === VoiceRecordEnum.Transfer) {
      Row() {
      }
      .width(280)
      .height(180)
      .backgroundColor($r('app.color.chat_primary'))
      .borderRadius(20)
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Column() {
          this.getDisplayContent()
        }
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .width("100%")
        .alignItems(this.voiceState === VoiceRecordEnum.Cancel ? HorizontalAlign.Start : HorizontalAlign.Center)

        Row() {
          Row() {
            //当进去录音区颜色改为绿色，
            Image($r('app.media.ic_public_cancel'))
              .width(30)
              .aspectRatio(1)
              .fillColor($r('app.color.voice_round_font_color'))
          }
          .width(70)
          .aspectRatio(1)
          .borderRadius(35)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(this.voiceState === VoiceRecordEnum.Cancel ? $r('app.color.voice_round_color') :
          $r('app.color.bottom_color'))
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
          .backgroundColor(this.voiceState === VoiceRecordEnum.Transfer ? $r('app.color.voice_round_color') :
          $r('app.color.bottom_color'))
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
            .fillColor(this.voiceState === VoiceRecordEnum.Recording ? $r('app.color.bottom_color') :
            $r("app.color.bottom_voice_color"))
            .scale({
              x: 1.2
            })
          Image($r('app.media.ic_public_recorder'))
            .width(30)
            .height(30)
            .fillColor($r('app.color.bottom_voice_color'))
        }
      }
      .width("100%")
      .height("100%")
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r('app.color.voice_back_color'))
  }
}

export default VoiceInput