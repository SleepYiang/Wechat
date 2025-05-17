import { display, promptAction } from '@kit.ArkUI'
import { VoiceRecordEnum } from '../../Model/Voice'
import VoiceInput from './VoiceInput'

@Component
export struct BottomInput {
  //保存输入框输入内容
  @State content: string = ''
  @State
  ShowVice: boolean = false
  @State showVoiceCom: boolean = false
  //获取屏幕高度，屏幕宽度
  @State screenWidth: number = 0 //屏幕宽度
  @State screenHeight: number = 0 //获取屏幕高度
  //保存状态
  voiceState: VoiceRecordEnum = VoiceRecordEnum.Recording

  //页面加载获取屏幕宽度高度
  aboutToAppear(): void {
    this.screenWidth = px2vp(display.getDefaultDisplaySync().width) //获取屏幕宽度
    this.screenHeight = px2vp(display.getDefaultDisplaySync().height) //获取屏幕高度
  }

  sendTextMessage: (content: string) => void = () => {
  }

  //获取当前手指触摸的位置坐标x,y
  //手势拖动时的判断当前的位置坐标x,y 是否大于屏幕高度-录音高度

  @Builder
  getVoiceCom() {
    Column() {
      VoiceInput()
    }
  }

  build() {
    Column() {
      Row({ space: 5 }) {
        //左侧图标
        Image(this.ShowVice ? $r('app.media.ic_public_keyboard') : $r('app.media.ic_public_sound'))
          .onClick(() => {
            this.ShowVice = !this.ShowVice
          })
          .width(25)
          .height(25)
        //中间输入
        if (this.ShowVice) {
          Button('按住说话')
            .type(ButtonType.Normal)
            .backgroundColor(Color.White)
            .layoutWeight(1)
            .borderRadius(2)
            .height(35)
            .fontColor($r('app.color.text_primary'))//绑定手势
            .gesture(
              //设置手势类型——组合手势
              //设置组合手势执行顺序_并发执行
              GestureGroup(GestureMode.Parallel,
                //长按手势
                LongPressGesture()
                  .onAction(() => {
                    //手势开始触发
                    this.showVoiceCom = true
                  })
                  .onActionEnd(() => {
                    //手势结束触发
                    this.showVoiceCom = false
                  }),
                //移动手势
                PanGesture()
                  .onActionUpdate((event) => {
                    if (event.fingerList[0].globalY > this.screenHeight - 120) {
                      //手势触碰到录音区域
                      this.voiceState = VoiceRecordEnum.Recording
                    } else {
                      if (event.fingerList[0].globalX > this.screenWidth / 2) {
                        //右侧
                        this.voiceState = VoiceRecordEnum.Cancel
                      } else {
                        //左侧
                        this.voiceState = VoiceRecordEnum.Transfer
                      }
                    }
                  })
                  .onActionEnd(() => {
                    this.voiceState = VoiceRecordEnum.Recording
                  })
              )
            )
            .bindContentCover(this.showVoiceCom, this.getVoiceCom, {
              modalTransition: ModalTransition.NONE
            })
        } else {
          TextInput({ text: $$this.content })
            .layoutWeight(1)
            .id('input')
            .focusable(true)//设置元素聚焦
            .defaultFocus(true)//通过defaultFocus开启默认聚焦
            .height(35)
            .borderRadius(2)
            .backgroundColor(Color.White)
            .onSubmit(() => {
              if (this.content) {
                this.sendTextMessage(this.content)
                this.content = ''
                focusControl.requestFocus('input')
              } else {
                promptAction.showToast({
                  message: '内容不能为空'
                })
              }
            })
        }


        //右侧图标
        Image($r('app.media.ic_public_add_norm'))
          .width(25)
          .height(25)
      }
      .width('100%')
      .height(60)
      .padding({ right: 10, left: 10 })
    }
    .backgroundColor($r('app.color.second_back_color'))
  }
}