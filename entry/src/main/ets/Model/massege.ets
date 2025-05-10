import { UserList } from './users'
import { util } from '@kit.ArkTS'

export enum MessageTypeEnum {
  Text,
  Voice,
  Image,
  Video,
  Local,
  Link,
}

export interface messageInfo {
  id: string,
  SendUser: UserList
  SendTime: number
  SourceFilePath: string
  sourceDuration: number,
  MessageType: MessageTypeEnum
  MessageContent: string
  ConnectUser: UserList
}

export class messageInfoModel implements messageInfo {
  //发送者的编号
  id: string = ''
  //消息的发送者
  SendUser: UserList = {} as UserList
  //消息的发送时间
  SendTime: number = 0
  //音频地址时间地址
  SourceFilePath: string = ''
  //语音或者视频的长度
  sourceDuration: number = 0
  //消息的类型
  MessageType: MessageTypeEnum
  //消息的内容
  MessageContent: string = ''
  //这条消息的归属者
  ConnectUser: UserList = {} as UserList

  constructor(model: messageInfo) {
    this.id = model.id || util.generateRandomUUID() //一个随机的Id
    this.SendUser = model.SendUser
    this.SendTime = model.SendTime || Date.now() //当前时间戳
    this.SourceFilePath = model.SourceFilePath
    this.sourceDuration = model.sourceDuration
    this.MessageType = model.MessageType || MessageTypeEnum.Text
    this.MessageContent = model.MessageContent
    this.ConnectUser = model.ConnectUser
  }
}