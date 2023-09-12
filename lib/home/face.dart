enum Face {
  dan('assets/img/dan.png','please god dont press me please man'),
  emma('assets/img/emma.png', 'where the heck can I find a bass amp'),
  stin('assets/img/stin.png', 'big buck hunter leaderboard boston'),
  chuck('assets/img/chuck.png', 'how to get synth sounds off broken board');

const Face(this.imgPath, this.tooltip);
  
  final String imgPath;
  final String tooltip;
}