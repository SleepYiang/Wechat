import { defaultUserList, UserList } from '../Model/users'
import { router } from '@kit.ArkUI'

@Component
struct Connect {
  @State
  filterList: UserList[] = []
  @State
  @Watch("filterName")
  searchName: string = ''

  aboutToAppear(): void {
    this.filterList = defaultUserList
    //组件加载时将数据赋值给filterList
  }

  //筛选联系人
  filterName() {
    this.filterList = defaultUserList.filter((user: UserList) => {
      //如果来呢西人中的列表数据中存在联系人的名称，则将搜到的来呢西人返回给filterLister
      return user.username.includes(this.searchName)
    })
  }

  build() {
    Column() {
      //搜索栏
      Row() {
        Search({ placeholder: '搜索', value: $$this.searchName })
      }
      .width("100%")
      .padding({ top: 20, left: 10, right: 10 })
      .backgroundColor($r('app.color.white'))


      //联系人列表
      List() {
        ForEach(this.filterList, (item: UserList) => {
          ListItem() {
            Row({ space: 10 }) {
              Image(item.avatar)
                .width(30)
                .height(30)
                .borderRadius(5)
              Row() {
                Text(item.username)
                  .fontSize(14)
                  .fontColor($r('app.color.text_primary'))
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)
              .padding(10)
            }
            .width("100%")
            .height(60)
            .padding({ left: 8, top: 8 })
            .stateStyles({
              pressed: {
                .backgroundColor($r('app.color.back_color'))
              },
              normal: {
                .backgroundColor($r('app.color.white'))
              }
            })
          }
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Chatpages/ChatDetaill',
              params: item
            })
          })
        }, (item: UserList) => item.user_id)
      }
      .width('100%')
      .height('100%')
      .padding({
        top: 10, bottom: 8
      })
      .divider({
        strokeWidth: 1,
        color: $r("app.color.back_color")
      })
      .layoutWeight(1)
      .backgroundColor($r('app.color.white'))
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.back_color'))
  }
}

export default Connect