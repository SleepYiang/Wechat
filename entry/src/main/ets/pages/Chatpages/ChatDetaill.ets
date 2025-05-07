import router from '@ohos.router'
import { UserList } from '../../Model/users'
import { BottomInput } from './BottomInput'


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
      Blank()

      //底部布局
      BottomInput()
    }
    .width("100%")
    .height("100%")
  }
}