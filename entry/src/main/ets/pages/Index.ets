import Connect from './Connect'
import WeChat from './WeChat'

class TabListModel {
  icon: ResourceStr = ''
  title: string = ''
  SelectIcon: ResourceStr = ''
}

@Entry
@Component
struct Index {
  TabList: TabListModel[] = [
    {
      icon: $r('app.media.ic_public_message'),
      title: '微信',
      SelectIcon: $r('app.media.ic_public_message_filled')
    },
    {
      icon: $r('app.media.ic_public_contacts_group'),
      title: '通讯录',
      SelectIcon: $r('app.media.ic_public_contacts_group_filled')
    },
    {
      icon: $r('app.media.ic_gallery_discover'),
      title: '发现',
      SelectIcon: $r('app.media.ic_gallery_discover_filled')
    },
    {
      icon: $r('app.media.ic_public_contacts'),
      title: '我',
      SelectIcon: $r('app.media.ic_public_contacts_filled')
    }
  ]
  @State currentIndex: number = 0

  @Builder
  tabBuilder(item: TabListModel, index: number) {
    Column() {
      Image(this.currentIndex == index ? item.SelectIcon : item.icon)
        .width(20)
        .height(20)
      Text(item.title)
        .fontSize(12)
        .margin({ top: 5 })
        .fontColor(this.currentIndex == index ? $r('app.color.primary') : $r('app.color.text_primary'))
    }
  }

  build() {
    Column() {
      Tabs() {
        ForEach(this.TabList, (item: TabListModel, index: number) => {
          TabContent() {
            if (index === 0) {
             WeChat()
            } else if (index === 1) {
              Connect()
            } else if (index === 2) {
              Text('发现')
            } else if (index === 3) {
              Text('我的')
            }
          }
          .tabBar(this.tabBuilder(item, index))
        })
      }
      .barPosition(BarPosition.End)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .animationDuration(300)
    }
    .width('100%')
    .height('100%')
  }
}


