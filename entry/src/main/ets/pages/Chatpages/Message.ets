import { messageInfo, messageInfoModel } from '../../Model/massege'
import { PopupItem } from '../../Model/popup'
import { CurrentUser } from '../../Model/users'

@Component
struct Message {
  @Prop
  CurrentMessage: messageInfoModel = new messageInfoModel({} as messageInfo)
  @State
  showPopup: boolean = false
  @State
  popupList: PopupItem[] = [{
    title: '听筒播放',
    icon:
    $r("app.media.ic_public_ears")
  },
    {
      title: '收藏',
      icon: $r("app.media.ic_public_cube")
    },
    {
      title: '转文字',
      icon:
      $r("app.media.ic_public_trans_text")
    },
    {
      title: '删除',
      icon: $r("app.media.ic_public_cancel")
    },
    {
      title: '多选',
      icon:
      $r("app.media.ic_public_multi_select")
    },
    {
      title: '引用',
      icon: $r("app.media.ic_public_link")
    },
    {
      title: '提醒',
      icon: $r("app.media.ic_public_warin")
    }]

  @Builder
  getContent() {
    GridRow({ columns: 5 }) {
      ForEach(this.popupList, (item: PopupItem) => {
        GridCol() {
          Column({ space: 6 }) {
            Image(item.icon)
              .width(18)
              .aspectRatio(1)//设置宽高比
              .fillColor($r('app.color.white'))
            Text(item.title)
              .fontSize(14)
              .fontColor($r('app.color.white'))
          }
          .height(60)
        }
        .onClick(() => {
          item?.itemClick
        })
      })
    }
    .width(300)
    .padding({
      top: 15, left: 10
    })
  }

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
            .bindPopup(this.showPopup, {
              builder: this.getContent,
              popupColor: $r('app.color.popup_back'),
              backgroundBlurStyle: BlurStyle.NONE,
              onStateChange: (Event) => {
                this.showPopup = Event.isVisible
              }
            })
            .gesture(LongPressGesture().onAction(() => {
              this.showPopup = true
            }))
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