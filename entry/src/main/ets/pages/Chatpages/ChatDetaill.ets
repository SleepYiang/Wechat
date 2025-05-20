import router from '@ohos.router'
import { getMessageInfo } from '../../API'
import { messageInfo, messageInfoModel, MessageTypeEnum } from '../../Model/massege'
import { CurrentUser, UserList } from '../../Model/users'
import { StoreClass } from '../../utils/StoreClass'
import { BottomInput } from './BottomInput'
import Message from './Message'
import { emitter } from '@kit.BasicServicesKit'


@Entry
@Component
struct ChatDetaill {
  @State
  talker: UserList = {} as UserList
  //创建聊天列表
  @State MessageList: messageInfoModel[] = []
  //滚动控键盘
  scroller: Scroller = new Scroller()
  //是否是输入状态
  @State talkerInputIng: boolean = false

  //发送数据
  sendTextMessage(content: string) {
    let message = new messageInfoModel({
      MessageContent: content,
      SendUser: CurrentUser,
      ConnectUser: this.talker
    } as messageInfo)
    this.MessageList.push(message)
    this.getResponseMessage(content)
    //创建仓库
    StoreClass.addChatMessage(this.talker.user_id, message)
  }

  //发送图片信息
  sendImageMessage(filePath: string) {
    let message = new messageInfoModel({
      MessageContent: '[图片]',
      SendUser: CurrentUser,
      ConnectUser: this.talker,
      MessageType: MessageTypeEnum.Image,
      SourceFilePath: filePath,
    } as messageInfo)
    this.MessageList.push(message)
    //创建仓库
    StoreClass.addChatMessage(this.talker.user_id, message)
    this.scroller.scrollEdge(Edge.Bottom)
  }

  // 机器人回复
  async getResponseMessage(content: string) {
    try {
      this.talkerInputIng = true
      const result = await getMessageInfo(content)
      let message = new messageInfoModel({
        MessageContent: result?.info.text,
        SendUser: this.talker,
        ConnectUser: this.talker
      } as messageInfo)
      this.MessageList.push(message)
      this.scroller.scrollEdge(Edge.Bottom)
      this.talkerInputIng = false
      //添加仓库数据
      StoreClass.addChatMessage(this.talker.user_id, message)
    } catch (e) {
      console.log(e)
    }
  }

  //起始获取Params的数据
  aboutToAppear():
    void {
    //接收其他页面发送的参数
    this.talker = router.getParams() as UserList
    //获取首选项的数据
    this.MessageList = StoreClass.getChatMessage(this.talker.user_id)
  }

  delMessage(id: string) {
    const index = this.MessageList.findIndex((item: messageInfoModel) => item.id === id)
    this.MessageList.slice(index, 1)
    emitter.emit(StoreClass.Wechat_key)
  }

  build() {
    Column() {
      //顶部布局
      Row() {
        Stack({ alignContent: Alignment.Start }) {
          Text(this.talkerInputIng ? "对方正在输入" : this.talker.username)
            .width("100%")
            .textAlign(TextAlign.Center)
            .fontSize(16)
            .fontColor($r("app.color.text_primary"))

          Image($r("app.media.ic_public_arrow_left"))
            .width(30)
            .height(30)
            .onClick(() => {
              router.back()
            })
        }
      }
      .height(50)

      //内容布局
      List({ space: 10 }) {
        ForEach(this.MessageList, (item: messageInfoModel) => {
          ListItem() {
            Message({
              CurrentMessage: item,
              delMessage: (id: string) => {
                this.delMessage(id)
              }
            })
          }
        })
      }
      .layoutWeight(1)
      .backgroundColor($r('app.color.back_color'))
      .padding({ top: 20, bottom: 10 })
      .scrollBar(BarState.Off)


      //底部布局
      BottomInput({
        sendTextMessage: (content: string) => {
          this.sendTextMessage(content)
        },
        sendImageMessage:(filePath:string)=>{
          this.sendImageMessage(filePath)
        }
      })

    }
    .width("100%")
    .height("100%")
  }
}
