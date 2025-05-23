import { messageInfoModel } from '../Model/massege'
import { StoreClass } from '../utils/StoreClass'
import { emitter } from '@kit.BasicServicesKit'
import { router } from '@kit.ArkUI'
import { PopupItem } from '../Model/popup'
import { scanBarcode, scanCore } from '@kit.ScanKit'

@Component
struct WeChat {
  @State List: messageInfoModel[] = []
  @State
  showDropDown: boolean = false
  @State
  popList: PopupItem[] = [
    {
      title: '发起群聊',
      icon:
      $r('app.media.ic_public_message')
    },
    {
      title: '添加朋友',
      icon: $r('app.media.ic_public_add_friend')
    },
    {
      title: '扫一扫',
      icon: $r('app.media.ic_public_scan'),
      itemClick: async () => {
        //扫码参数
        let options: scanBarcode.ScanOptions = {
          scanTypes: [scanCore.ScanType.ALL],
          enableMultiMode: true,
          enableAlbum: true
        }
        //启动扫码程序
        try {
          const result = await scanBarcode.startScanForResult(getContext(this), options)
        } catch (e) {
          console.log(e)
        }
      }
    },
    {
      title: '收付款',
      icon: $r('app.media.ic_public_receive')
    }
  ]

  aboutToAppear(): void {
    this.List = StoreClass.getAllChatLastMessage()
    //订阅消息
    emitter.on(StoreClass.Wechat_key, () => {
      //刷新消息列表
      this.List = StoreClass.getAllChatLastMessage()
    })
  }

  @Builder
  getDropDown() {
    Column() {
      ForEach(this.popList, (item: PopupItem) => {
        Row({ space: 5 }) {
          Image(item.icon)
            .width(20)
            .height(20)
            .fillColor($r("app.color.white"))
          Text(item.title)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .fontColor($r('app.color.white'))
        }
        .width("100%")
        .padding({ left: 10, right: 10 })
        .height(45)
        .justifyContent(FlexAlign.Center)
      })
    }
    .width(120)
  }

  @Builder
  itemEnd(user_id: string) {
    Row() {
      Text('删除')
        .fontColor($r('app.color.white'))
        .textAlign(TextAlign.Center)
        .width(80)
    }
    .onClick(() => {
      //删除首选项的数据
      StoreClass.RemoveChatAllMessage(user_id)
      //删除UI界面的数据
      const index = this.List.findIndex((item: messageInfoModel) => item.ConnectUser.user_id)
      this.List.splice(index, 1)
    })
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
      Row() {
        Stack({ alignContent: Alignment.End }) {
          Text("微信")
            .fontSize(16)
            .fontColor($r('app.color.text_primary'))
            .textAlign(TextAlign.Center)
            .width("100%")
          Image($r('app.media.ic_public_add_norm'))
            .width(20)
            .alignSelf(1)
            .fillColor($r('app.color.text_primary'))
            .margin({ right: 20 })
            .onClick(() => {
              this.showDropDown = true
            })
            .bindPopup($$this.showDropDown, {
              builder: this.getDropDown,
              onStateChange: (event) => {
                this.showDropDown = event.isVisible
              },
              backgroundBlurStyle: BlurStyle.NONE,
              popupColor: $r("app.color.popup_back")
            })
        }

      }
      .width("100%")

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
            .stateStyles({
              pressed: {
                .backgroundColor($r('app.color.back_color'))
              },
              normal: {
                .backgroundColor($r('app.color.white'))
              }
            })
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
                this.itemEnd(item.ConnectUser.user_id)
              }
            }
          })
          .padding({ top: 10, bottom: 10 })
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