import { preferences } from '@kit.ArkData';
import { messageInfoModel } from '../Model/massege';

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
  //删除某个人的数据
  //移除所有数据
  //获取最后一条消息
}