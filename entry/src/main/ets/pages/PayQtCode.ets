import { router } from '@kit.ArkUI'

@Entry
@Component
struct PayQtCode {
  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Start }) {
          Image($r('app.media.ic_public_arrow_left'))
            .width(30)
            .height(30)
            .fillColor($r('app.color.white'))
            .onClick(() => {
              router.back()
            })
            .zIndex(2)
          Text('收付款')
            .fontSize(16)
            .fontColor($r('app.color.white'))
            .textAlign(TextAlign.Center)
            .width("100%")
        }
      }
      .width("100%")
      .height(50)

      Column() {
        Row() {
          Image($r("app.media.ic_public_scan"))
            .width(20)
            .height(20)
            .fillColor($r('app.color.pay_back'))

          Text("付款码")
            .fontColor($r('app.color.pay_back'))
            .fontSize(16)
            .padding({
              left: 10,
              right: 10
            })
        }

        Column() {
          Text("优先使用XX储蓄卡支付")
            .fontColor($r('app.color.text_second'))
            .fontSize(12)
        }
        .margin({ top: 10, bottom: 10 })
      }
      .backgroundColor($r('app.color.white'))
      .padding(10)
      .layoutWeight(1)
      .width("100%")
      .borderRadius(5)
    }
    .width("100%")
    .height("100%")
    .backgroundColor($r('app.color.pay_back'))
  }
}