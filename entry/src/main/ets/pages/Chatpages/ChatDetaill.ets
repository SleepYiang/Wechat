import router from '@ohos.router'
import { UserList } from '../../Model/users'
import { BottomInput } from './BottomInput'
import Message from './Message'


@Entry
@Component
struct ChatDetaill {
  @State
  talker: UserList = {} as UserList

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
        ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 9, 8, 7, 6, 5, 4, 3, 2, 1], () => {
          ListItem() {
            Message()
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