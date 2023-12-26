@Entry
@Component
struct GISwidgetCard {
  /*
   * The max lines.
   */
  readonly MAX_LINES: number = 1;

  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';

  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';

  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'EntryAbility';

  /*
   * The with percentage setting.
   */
  readonly FULL_WIDTH_PERCENT: string = '100%';

  /*
   * The height percentage setting.
   */
  readonly FULL_HEIGHT_PERCENT: string = '100%';

  build() {
    Row() {
      Column() {
        Stack({ alignContent: Alignment.Start }) {
          Text("GIS留言板")
            .width("100%")
            .height("47vp")
            .position({ x: "0px", y: "0px" })
            .fontColor(Color.Black)
            .textAlign(TextAlign.Center)
            .fontSize("19fp")
            .fontStyle(FontStyle.Normal)
            .fontWeight(FontWeight.Bold)
          Image($r('app.media.icon'))
            .width("100%")
            .height("100%")
        }
        .width("150vp")
        .height("150vp")
      }
      .width(this.FULL_WIDTH_PERCENT)
    }
    .height(this.FULL_HEIGHT_PERCENT)
    .onClick(() => {
      postCardAction(this, {
        action: this.ACTION_TYPE,
        abilityName: this.ABILITY_NAME,
        params: {
          message: this.MESSAGE
        }
      });
    })
  }
}