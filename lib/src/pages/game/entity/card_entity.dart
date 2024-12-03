class CardImage {
  late bool isDisable;
  late bool isVisible;
  late bool isDisabledOnTap;
  final String imgPath;

  CardImage(
      {this.isDisable = false,
      this.isDisabledOnTap = false,
      this.isVisible = false,
      this.imgPath = ''});
}
