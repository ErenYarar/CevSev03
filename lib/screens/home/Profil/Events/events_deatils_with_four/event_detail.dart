class Event {
  final String imagePath, title, description, location, duration, punchLine1, punchLine2;
  final List categoryIds, galleryImages;

  Event(
      {this.imagePath,
        this.title,
        this.description,
        this.location,
        this.duration,
        this.punchLine1,
        this.punchLine2,
        this.categoryIds,
        this.galleryImages});
}

final firstEvent = Event(
    imagePath: "images/cop1.jpg",
    title: "Katıldığım ilk etkinlik!",
    description: "Katıldığım ilk etkinlik oldu... Çok Eğlenceliydi!",
    location: "Pleasant Park",
    duration: "3h",
    punchLine1: "Marathon!",
    punchLine2: "The latest fad in foodology, get the inside scoup.",
    galleryImages: [],
    categoryIds: [0, 1]);

final secondEvent = Event(
    imagePath: "images/cop2.jpg",
    title: "Katıldığım ikinci etkinlik!",
    description: "Katıldığım ikinci etkinlik oldu... Çok Eğlenceliydi!",
    location: "Food Court Avenue",
    duration: "4h",
    punchLine1: "Granite Cooking",
    punchLine2: "The latest fad in foodology, get the inside scoup.",
    categoryIds: [0, 2],
    galleryImages: ["images/cop1.jpg", "images/cop2.jpg", "images/cop3.jpg"]);

final thirdEvent = Event(
    imagePath: "images/cop3.jpg",
    title: "Katıldığım üçüncü etkinlik!",
    description: "Katıldığım üçüncü etkinlik oldu... Çok Eğlenceliydi!",
    location: "D.Y. Patil Stadium, Mumbai",
    duration: "5h",
    punchLine1: "Music Lovers!",
    punchLine2: "The latest fad in foodology, get the inside scoup.",
    galleryImages: ["images/cop4.jpg", "images/cop3.jpg", "images/cop1.jpg"],
    categoryIds: [0, 1]);

final fourthEvent = Event(
    imagePath: "images/cop4.jpg",
    title: "Katıldığım dördüncü etkinlik!",
    description: "Katıldığım dördüncü etkinlik oldu... Çok Eğlenceliydi!",
    location: "NSIC Ground, Okhla",
    duration: "1d",
    punchLine1: "Golf!",
    punchLine2: "The latest fad in foodology, get the inside scoup.",
    galleryImages: ["images/cop1.jpg", "images/cop5.jpg", "images/cop6.jpg"],
    categoryIds: [0, 3]);

final events = [
  firstEvent,
  secondEvent,
  thirdEvent,
  fourthEvent,
];