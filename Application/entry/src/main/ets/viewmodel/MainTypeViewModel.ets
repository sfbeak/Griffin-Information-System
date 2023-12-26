import MainTypeModel from './MainTypeModel'

const DEFAULT_Main_TYPES: MainTypeModel[] = [
  new MainTypeModel(0, '全部'),
  new MainTypeModel(1, '推荐'),
  new MainTypeModel(2, '收藏'),
];

class MainTypeViewModel {
  getDefaultTypeList(): MainTypeModel[] {
    return DEFAULT_Main_TYPES;
  }
}

let mainTypeViewModel = new MainTypeViewModel();

export default mainTypeViewModel as MainTypeViewModel;