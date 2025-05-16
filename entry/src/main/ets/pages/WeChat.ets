import { messageInfoModel } from '../Model/massege'
import { StoreClass } from '../utils/StoreClass'
import { emitter } from '@kit.BasicServicesKit'
import { router } from '@kit.ArkUI'

@Component
struct WeChat {
  @State List: messageInfoModel[] = []

  aboutToAppear(): void {
    this.List = StoreClass.getAllChatLastMessage()
    //订阅消息
    emitter.on(StoreClass.Wechat_key, () => {
      //刷新消息列表
      this.List = StoreClass.getAllChatLastMessage()
    })
  }

  @Builder
  itemEnd() {
    Row() {
      Text('删除')
        .fontColor($r('app.color.white'))
        .textAlign(TextAlign.Center)
        .width(80)
    }
    .backgroundColor($r('app.color.danger'))
    .height(70)
    .padding({ right: 10, left: 10 })
  }

  //格式化时间
  //不是今年
  //今年：11-11
  //这个月：12天前
  //一周星期五
  //当天;20:52
  //这一小时之内
  //这一分钟之内：刚刚
  transTime(time: number) {
    //把时间戳准换为UTC时间
    const dateObj = new Date(time)
    //获取年
    const year = dateObj.getFullYear()
    //获取月
    const month = dateObj.getMonth() //0-11
    //获取时
    const hour = dateObj.getHours()
    //获取分
    const minutes = dateObj.getMinutes()
    //获取日
    const day = dateObj.getDay()
    //不是今年
    if (year === new Date().getFullYear()) {
      //不是这个月
      if (month === new Date().getMonth()) {
        //是不是今天
        if (day === new Date().getDay()) {
          return hour.toString().padStart(2, "0") + ':' + minutes.toString().padStart(2, "0")
        } else {
          return `${new Date().getDay() - day}天前`
        }
      } else {
        return `${month}月${day}日`
      }

    } else {
      return `${year}年${month}月${day}日`
    }

  }

  build() {
    Column() {
      List() {
        ForEach(this.List, (item: messageInfoModel) => {
          ListItem() {
            Row({ space: 5 }) {
              Image(item.ConnectUser.avatar)
                .width(40)
                .height(40)
                .borderRadius(5)
              Column() {
                Row() {
                  Text(item.ConnectUser.username)
                    .fontSize(16)
                    .fontColor($r('app.color.text_primary'))

                  Text(this.transTime(item.SendTime))
                    .fontSize(12)
                    .fontColor($r('app.color.text_primary'))
                    .margin({ top: 10, })
                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width('100%')

                Text(item.MessageContent)
                  .maxLines(1)
                  .fontSize(14)
                  .fontColor($r('app.color.text_second'))
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .layoutWeight(1)
              .height(50)
              .alignItems(HorizontalAlign.Start)
              .justifyContent(FlexAlign.SpaceBetween)
              .padding({ top: 3, bottom: 3 })
            }
            .onClick(() => {
              router.pushUrl({
                url: 'pages/Chatpages/ChatDetaill',
                params: item.ConnectUser
              })
            })
          }
          .swipeAction({
            end: {
              builder: () => {
                this.itemEnd()
              }
            }
          })
          .padding({ top: 10, bottom: 10 })
          .stateStyles({
            pressed: {
              .backgroundColor($r('app.color.back_color'))
            },
            normal: {
              .backgroundColor($r('app.color.white'))
            }
          })
        })
      }
      .divider({
        strokeWidth: 1,
        color: $r('app.color.border_color')
      })
      .padding({
        left: 10, right: 10
      })
      .width('100%')
      .height('100%')
      .layoutWeight(1)
    }
    .width("100%")
    .height("100%")
    .backgroundColor('#fff')
  }
}

export default WeChat