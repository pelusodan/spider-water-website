class Show {
  const Show({required this.url, required this.title, required this.date});

  final String? url;
  final String title;
  final DateTime date;
}

final ShowList = [
  // also gonna include previous shows
  Show(
      url: null,
      title: "LITTER BOX",
      date: DateTime(2022,12,2,20)
  ),
  Show(
      url: "https://www.maydaypvd.com/",
      title: "MAYDAY",
      date: DateTime(2023,2,23,20)
  ),
  Show(
      url: "https://www.silhouetteallston.com/",
      title: "THE SIL",
      date: DateTime(2023,8,27,20,30)
  ),
  Show(
      url: "https://somervilleartscouncil.org/porchfest",
      title: "SOMERVILLE PORCHFEST",
      date: DateTime(2023,5,13,12)
  ),
  Show(
      url: "https://www.thecantablounge.com/",
      title: "CANTAB LOUNGE",
      date: DateTime(2023,8,29,22)
  ),
  Show(
    url: "https://www.thejunglemusicclub.com/",
    title: "THE JUNGLE",
    date: DateTime(2023,9,12,20)
  ),
  Show(
      url: "https://www.silhouetteallston.com/",
      title: "THE SIL",
      date: DateTime(2023,10,25,20,30)
  ),
  Show(
      url: "https://pawtucketartscollaborative.wildapricot.org/",
      title: "PAWTUCKET ART GALLERY",
      date: DateTime(2023,12,9,19)
  ),
];
