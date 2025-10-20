import 'package:intl/intl.dart';

class Show {
  const Show({required this.url, required this.title, required this.date});

  final String? url;
  final String title;
  final DateTime date;

  Map toJson() =>
      {'title': title, 'date': DateFormat('M-dd').format(date), 'url': url};
}

final ShowList = [
  // also gonna include previous shows
  Show(url: null, title: "LITTER BOX", date: DateTime(2022, 12, 2, 20)),
  Show(
      url: "https://www.maydaypvd.com/",
      title: "MAYDAY",
      date: DateTime(2023, 2, 23, 20)),
  Show(
      url: "https://www.silhouetteallston.com/",
      title: "THE SIL",
      date: DateTime(2023, 8, 27, 20, 30)),
  Show(
      url: "https://somervilleartscouncil.org/porchfest",
      title: "SOMERVILLE PORCHFEST",
      date: DateTime(2023, 5, 13, 12)),
  Show(
      url: "https://www.thecantablounge.com/",
      title: "CANTAB LOUNGE",
      date: DateTime(2023, 8, 29, 22)),
  Show(
      url: "https://www.thejunglemusicclub.com/",
      title: "THE JUNGLE",
      date: DateTime(2023, 9, 12, 20)),
  Show(
      url: "https://pawtucketartscollaborative.wildapricot.org/",
      title: "PAWTUCKET ART GALLERY (SOLO)",
      date: DateTime(2023, 9, 24, 19)),
  Show(
      url: "https://www.silhouetteallston.com/",
      title: "THE SIL",
      date: DateTime(2023, 10, 25, 20, 30)),
  Show(
      url: "https://www.lilypadinman.com/",
      title: "THE LILYPAD",
      date: DateTime(2023, 11, 3, 22, 00)),
  Show(
      url: "https://pawtucketartscollaborative.wildapricot.org/",
      title: "PAWTUCKET ART GALLERY",
      date: DateTime(2023, 12, 9, 19)),
  Show(
      url: "https://ci.ovationtix.com/36186/production/1213789?performanceId=11525072",
      title: "ALBUM RELEASE SHOW @ REGENT",
      date: DateTime(2024, 10, 12, 20)),
  Show(
      url: "https://obrienspubboston.com/show/133938/",
      title: "O'BRIEN'S PUB",
      date: DateTime(2025, 1, 13, 20)),
  Show(
      url: "https://obrienspubboston.com/show/spider-water-seph-the-nomads-rose-wood-park-anna-gurl/",
      title: "O'BRIEN'S PUB",
      date: DateTime(2025, 2, 19, 21)),
  Show(
      url: "https://www.thecantablounge.com/",
      title: "CANTAB UNDERGROUND",
      date: DateTime(2025, 3, 8, 18)),
  Show(
      url: "https://uniontavern-somerville.com/",
      title: "UNION TAVERN",
      date: DateTime(2025, 4, 11, 20)),
/* show got rescheduled
  Show(
      url: "https://www.thecantablounge.com/",
      title: "CANTAB LOUNGE",
      date: DateTime(2025, 4, 22, 20)),*/
  Show(
      url: "https://uniontavern-somerville.com/",
      title: "UNION TAVERN",
      date: DateTime(2025, 5, 2, 20)),
  Show(
    url: "https://tunehatch.com/shows/148458303",
    title: "CANTAB UNDERGROUND",
    date: DateTime(2025, 5, 29, 20)),
  Show(
      url: null,
      title: "FORREST FEST",
      date: DateTime(2025, 8, 23, 13, 45)),
  Show(
    url: "https://www.eventbrite.com/e/granite-and-gritspider-waterandey-tickets-1599118740199?aff=oddtdtcreator",
    title: "THE JUNGLE",
    date: DateTime(2025, 9, 28, 17)),
  Show(
    url: "https://tunehatch.com/shows/221203076",
    title: "CANTAB UNDERGROUND",
    date: DateTime(2025,10,3,19,0)
  ),
  Show(
    url: null,
    title: "UNION TAVERN",
    date: DateTime(2025, 11, 7, 20),
  ),
  Show(
      url: "https://www.eventbrite.com/e/spiderwaterlunch-ladieslongnecktba-tickets-1839603877719?aff=oddtdtcreator",
      title: "THE JUNGLE w Special Guest!",
      date: DateTime(2025, 11, 28, 21)),
];