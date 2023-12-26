import Home from "../view/Home"
import Messages from "../view/Messages"
import Profile from "../view/Profile"
import LoginedProfile from "../view/LoginedProfile"
import router from '@ohos.router';
@Entry
@Component
struct MainPage {
  @State src: string = router.getParams()?.['src'];
  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Stack() {
          Home()
        }
      }
      .tabBar('首页')

      TabContent() {
        Messages()
      }
      .tabBar('消息')

      TabContent() {
        if (this.src === 'Logined') {
          LoginedProfile()
        } else {
          Profile()
        }
      }
      .tabBar("我的")
    }
    .scrollable(false)
  }
}