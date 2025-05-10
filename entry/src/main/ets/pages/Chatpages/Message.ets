import { messageInfoModel } from '../../Model/massege'
import { CurrentUser } from '../../Model/users'

@Component
struct Message {
  @Prop
  CurrentMessage: messageInfoModel

  build() {
    Row() {
      Image(this.CurrentMessage.SendUser.avatar)
        .width(40)
        .height(40)
        .borderRadius(3)

      Row() {
        Column() {
          Text(this.CurrentMessage.MessageContent)
            .backgroundColor(CurrentUser.user_id === this.CurrentMessage.SendUser.user_id ?
            $r('app.color.second_primary') :
            $r('app.color.white'))
            .fontColor($r('app.color.text_primary'))
            .padding(10)
            .margin({ left: 10, right: 10 })
            .borderRadius(5)
        }
      }
      .layoutWeight(6)
      .justifyContent(CurrentUser.user_id === this.CurrentMessage.SendUser.user_id ? FlexAlign.End : FlexAlign.Start)

      Text()
        .layoutWeight(1)
    }
    .direction(CurrentUser.user_id === this.CurrentMessage.SendUser.user_id ? Direction.Rtl : Direction.Ltr)
    .width('100%')
    .alignItems(VerticalAlign.Top)
    .padding({
      left: 20,
      right: 20
    })
  }
}

export default Message