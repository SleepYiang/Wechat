import { preferences } from '@kit.ArkData';
import { messageInfoModel } from '../Model/massege';
import { defaultUserList, UserList } from '../Model/users';

export class StoreClass {
  static context: Context
  static Wechat_key: string = 'wechat_key'

  static init(context: Context) {
    StoreClass.context = context
  }

  //创建仓库
  static getUserStore(userid: string) {
    return preferences.getPreferencesSync(StoreClass.context, {
      //仓库名称
      name: `${StoreClass.Wechat_key}_${userid}`
    })
  }

  //给莫个人的仓库添加数据
  static async addChatMessage(userid: string, message: messageInfoModel) {
    const store = StoreClass.getUserStore(userid)
    //添加仓库数据
    store.putSync(message.id, JSON.stringify(message))
    //写入到磁盘
    await store.flush()
  }

  //获取某个人的全部数据
  static getChatMessage(userId: string) {
    const store = StoreClass.getUserStore(userId)
    //获取仓库中的所有数据
    const all = store.getAllSync() as object
    //根据发送时间排序
    if (all) {
      const list = Object.values(all).map((item: string) => JSON.parse(item) as messageInfoModel)
      list.sort((a, b) => a.SendTime - b.SendTime)
      return list
    }
    return []
  }

  //删除某个人的数据
  //移除所有数据
  //获取最后一条消息
  static getAllChatLastMessage() {
    const lastList: messageInfoModel[] = []
    defaultUserList.forEach((user: UserList) => {
      const chatList = StoreClass.getChatMessage(user.user_id)
      if (chatList.length) {
        lastList.push(chatList[chatList.length-1])
      }
    })
    lastList.sort((a, b) => a.SendTime - b.SendTime)
    return lastList
  }
}