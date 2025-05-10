import router from '@ohos.router'
import { messageInfoModel } from '../../Model/massege'
import { CurrentUser, UserList } from '../../Model/users'
import { BottomInput } from './BottomInput'
import Message from './Message'


@Entry
@Component
struct ChatDetaill {
  @State
  talker: UserList = {} as UserList
  //创建聊天列表
  @State MessageList: messageInfoModel[] = [
    new messageInfoModel({
      id: '1',
      SendUser: {
        username: 'liuhao',
        avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F373c6d24-1f8b-4000-8dd9-8d8410c35e71%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069618&t=51805a82420593c2a3cda47b9f65a80e',
        user_id: 'liu'
      },
      SendTime: 123456434,
      SourceFilePath: '',
      sourceDuration: 0,
      MessageType: 0,
      MessageContent: '连眀旸是个坏蛋',
      ConnectUser: CurrentUser,
    }),
    new messageInfoModel({
      id: '2',
      SendUser: CurrentUser,
      SendTime: 123456434,
      SourceFilePath: '',
      sourceDuration: 0,
      MessageType: 0,
      MessageContent: '她是乖宝宝',
      ConnectUser: CurrentUser,
    }),
    new messageInfoModel({
      id: '3',
      SendUser: {
        username: 'liuhao',
        avatar: 'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fsafe-img.xhscdn.com%2Fbw1%2F373c6d24-1f8b-4000-8dd9-8d8410c35e71%3FimageView2%2F2%2Fw%2F1080%2Fformat%2Fjpg&refer=http%3A%2F%2Fsafe-img.xhscdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1708069618&t=51805a82420593c2a3cda47b9f65a80e',
        user_id: 'liu'
      },
      SendTime: 123456434,
      SourceFilePath: '',
      sourceDuration: 0,
      MessageType: 0,
      MessageContent: '她是嘛？',
      ConnectUser: CurrentUser,
    }),
    new messageInfoModel({
      id: '4',
      SendUser: CurrentUser,
      SendTime: 123456434,
      SourceFilePath: '',
      sourceDuration: 0,
      MessageType: 0,
      MessageContent: '铁铁包是的',
      ConnectUser: CurrentUser,
    }),
  ]

  //起始获取Params的数据
  aboutToAppear(): void {
    this.talker = router.getParams() as UserList
  }

  build() {
    Column() {
      //顶部布局
      Row() {
        Stack({ alignContent: Alignment.Start }) {
          Text(this.talker.username)
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
              CurrentMessage: item
            })
          }
        })
      }
      .layoutWeight(1)
      .backgroundColor($r('app.color.back_color'))
      .padding({ top: 20, bottom: 10 })
      .scrollBar(BarState.Off)


      //底部布局
      BottomInput()
    }
    .width("100%")
    .height("100%")
  }
}