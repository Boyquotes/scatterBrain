extends Node

const categories = [

  "A BOY'S NAME",
  "CITIES",
  "THINGS THAT ARE COLD",
  "THINGS YOU DON'T WANT IN THE HOUSE",
  "SPORTS TEAMS",
  "INSECTS",
  "IN A COFFEE BAR",
  "TV SHOWS",
  "IN THE OCEAN",
  "EVERYTHING WEATHER",
  "FOODS THAT KIDS HATE",

  "FAMOUS FEMALES",
  "MEDICINES AND SUPPLEMENTS",
  "MACHINES",
  "HOBBIES",
  "THINGS YOU DO IN THE MORNING",
  "THINGS YOU PLUG IN",
  "ANIMALS",
  "LANGUAGES",
  "THINGS YOU GRAB ON YOUR WAY OUT THE DOOR",
  "JUNK FOOD",
  "IN AN ARCADE",

  "ARTICLES OF CLOTHING",
  "DESSERTS",
  "CAR PARTS",
  "SHOES",
  "ATHLETES",
  "4-LETTER WORDS",
  "THINGS YOU FOLD",
  "THINGS IN A BEDROOM",
  "THINGS YOU DO ONLINE",
  "AT THE BEACH",
  "TOOLS",

  "HEROES AND VILLAINS",
  "GIFTS AND PRESENTS",
  "TYPES OF DANCES",
  "THINGS THAT ARE BLACK",
  "VEHICLES",
  "IN AN ARENA",
  "TOPICS OF GOSSIP",
  "WEEKEND ACTIVITIES",
  "THINGS IN A SOUVENIR SHOP",
  "ITEMS IN A PURSE OR WALLET",

  "SANDWICHES",
  "THINGS YOU CAN DO WITH YOUR FEET",
  "WORLD LEADERS AND POLITICIANS",
  "COLLEGE COURSES",
  "EXCUSES FOR BEING LATE",
  "FLAVORS OF ICE CREAM",
  "ICE CREAM TOPPINGS",
  "SPORTS",
  "TELEVISION STARS",
  "IN A PARK",
  "COUNTRIES",
  "STONES AND GEMS",
  "MUSICAL INSTRUMENTS",

  "NICKNAMES",
  "IN THE SKY",
  "THINGS WITH WINDOWS",
  "UNIVERSITIES",
  "FISH",
  "SOMETHING YOU ADD WATER TO",
  "SOMETHING THAT HAS SPOTS",
  "SOMETHING THAT SMELLS BAD",
  "SOMETHING YOU'RE AFRAID OF",
  "UNITS OF MEASUREMENT",
  "TERMS OF MEASUREMENT",
  "ITEMS IN THIS ROOM",
  "BOOK TITLES",

  "FICTIONAL CHARACTERS",
  "PLACES TO GO ON A DATE",
  "MAGAZINES",
  "FAMOUS LANDMARKS",
  "TOURIST ATTRACTIONS",
  "THINGS THAT TASTE SWEET",
  "THINGS YOU SAVE UP TO BUY",
  "SOMETHING YOU KEEP HIDDEN",
  "ITEMS IN A SUITCASE",
  "STUFF WITH TAILS",
  "SPORTS EQUIPMENT",
  "CRIMES",

  "THINGS THAT ARE STICKY",
  "AWARDS/CEREMONIES",
  "CARS",
  "SPICES AND HERBS",
  "BAD HABITS",
  "COSMETICS AND TOILETRIES",
  "CELEBRITIES",
  "REPTILES AND AMPHIBIANS",
  "FADS",
  "COMMON ALLERGENS",

  "SONG TITLES",
  "PARTS OF THE BODY",
  "THINGS YOU SHOUT",
  "BIRDS",
  "A GIRL'S NAME",
  "METHODS OF TRAVEL",
  "RECIPIE INGREDIENTS",
  "MONSTERS",
  "FLOWERS",
  "THINGS THAT WEIGH LESS THAN ONE POUND",

  "SOMETHING THAT NEED TO BE CLEANED",
  "FAMOUS DUOS AND TRIOS",
  "ITEMS IN A DESK",
  "ISLANDS",
  "IN A HOSPITAL",
  "WORDS ASSOCIATED WITH MONEY",
  "ITEMS IN A VENDING MACHINE",
  "MOVIE TITLES",
  "VIDEO GAMES",
  "THINGS THAT YOU WEAR",
  "AT A CIRCUS",

  "VEGETABLES",
  "THINGS YOU THROW AWAY",
  "THINGS YOU CELEBRATE",
  "ANIMATED CHARACTERS",
  "TYPES OF DRINKS",
  "MUSICAL GROUPS",
  "SCIENCES",
  "TREE SPECIES",
  "PERSONALITY TRAITS",

  "THINGS YOU CAN TIE IN A KNOT",
  "THINGS THAT ARE SOFT",
  "THINGS IN A SCI-FI MOVIE",
  "WORDS WITH FOUR DIFFERENT VOWELS",
  "THINGS THAT KIDS PLAY WITH",
  "AT A WEDDING",
  "HOT PLACES",
  "IN OUTER SPACE",
  "ONOMATOPOEIA",
  "SOMETHING CUTE",
  "FAMOUS SINGERS",
  "AT AN AMUSEMENT PARK",

  "THINGS WORN ABOVE THE WAIST",
  "THINGS THAT HAVE NUMBERS",
  "IN A GYM",
  "CHAIN STORES",
  "WAYS TO SAY HI AND BYE",
  "IN A GARDEN",
  "THINGS PEOPLE USE TO DECORATE",
  "ITEMS IN AN OFFICE",
  "THINGS IN PAIRS OR SETS",
  "ARTISTS",
  "CRUISE SHIP DESTINATIONS",

  "AT A ZOO",
  "SOMETHING SMALLER THAN YOUR FIST",
  "SOMETHING THAT FLY",
  "THINGS YOU EAT ON A DIET",
  "IN A HOTEL",
  "SOMETHING WITH CLAWS",
  "PARTY THINGS",
  "REASONS TO SKIP SCHOOL OR WORK",
  "TITLES PEOPLE HAVE",

  "THINGS THAT GO WELL WITH CHOCOLATE",
  "IN A MYSTERY NOVEL",
  "WEBSITES",
  "LOUD THINGS",
  "THINGS YOU EAT WITH A SPOON",
  "FAMOUS SAYINGS",
  "SOMETHING UNDERGROUND",
  "SOMETHING THAT IS WET",
  "IN AN AIRPORT",
  "WORDS WITH DOUBLE LETTERS",
  "THINGS A BABY USES",
  "IN A FAIRY TALE",

  "IN THE JUNGLE",
  "COLORS",
  "BREAKFAST FOODS",
  "THINGS ON A MAP",
  "IN A CHURCH",
  "FRUITS",
  "IN A FANTASY NOVEL",
  "HOUSEHOLD APPLIANCES",
  "ARTIFICIAL FLAVORS",
  "METALS, ROCKS, AND ELEMENTS",
  "THINGS THAT USE ELECTRICITY",
  "LUNCH HOT SPOTS",
  "SUMMER ACTIVITIES",
  "WEAPONS",
  "HALLOWEEN COSTUMES",
  "THINGS ON A CONSTRUCTION SITE",
  "ENTREES",
  "BEVERAGES",
  "ICE CREAM FLAVORS",
  "EXTINCT ANIMALS",
  "CANDLE SCENTS",
  "TEXTURES",
  "THINGS WITH ENTRANCES AND EXITS",
  "AT A PICNIC",
  "FROZEN FOOD",
  "OCCUPATIONS",
  "NAME BRANDS",
  "RESTAURANTS",
  "SCHOOL SUPPLIES",
  "CHRISTMAS",
  "ITEMS IN A BACKPACK",
  "CHIP FLAVORS",
  "ACTORS AND ACTRESSES",
  "PLACES IN EUROPE",
  "CANNED FOODS",
  "BIBLE NAMES",
  "STATES AND CAPITALS",
  "CANDY",
  "CHILDREN'S BOOKS",
  "AT A BAR",
  "FOODS YOU EAT RAW",
  "OLYMPIC EVENTS",
  "MATH TERMS",
  "BIOLOGY TERMS",
  "ANIMALS IN BOOKS OR MOVIES",
  "BOARD GAMES",
  "CARD GAMES",
  "THINGS THAT USE A REMOTE",
  "INTERNET LINGO",
  "WIRELESS THINGS",
  "COMPUTER PARTS",
  "SOFTWARE",
  "GAMING TERMS",
  "PETS",
  "IN THE HARRY POTTER UNIVERSE",
  "THINGS WITH BATTERIES",

  "THINGS THAT EMIT LIGHT",
  "THINGS YOU BUY COVERS OR CASES FOR",
  "DOLLAR STORE ITEMS",
  "MUSIC GENRES",
  "THINGS WITH WIRES",
  "IPHONE APPS",
  "THINGS TO DO IN THE SNOW",
  "BUILDING MATERIALS",
  "SOMEHTING SMALLER THAN A THUMBNAIL",
  "POLITICAL TERMS",
  "THINGS MADE OF PLASTIC",
  "THINGS YOU COULD USE TO BREAK A WINDOW",
  "THINGS YOU COULD FIT IN A WATER BOTTLE",
  "SAFETY EQUIPMENT",
  "HEALTH FOOD",
  "THINGS IN IKEA",
  "SOMETHING THAT IS GREEN",
  "PLANTS",
  "IN THE STAR WARS UNIVERSE",
  "THINGS MADE OF GLASS",
  "THINGS YOU CAN SEE YOUR REFLECTION IN",
  "THINGS THAT ABSORB WATER",
  "THINGS THAT HAVE WHEELS",
  "COLD BLOODED ANIMALS",
  "HERBIVORES",
  "BOOKS TURNED INTO MOVIES",
  "THINGS YOU SHOULDN'T TOUCH",
  "COMPANIES",
  "HISTORIC EVENTS",
  "REASONS TO MAKE A CALL",
  "THINGS YOU GET TICKETS FOR",

  "CLEANING SUPPLIES",
  "SOMETHING THAT IS BLUE",
  "SOMETHING UNKNOWN TO THOSE IN THE 80'S",
  "ON A PIRATE SHIP",
  "PRE-2000'S TECHNOLOGY",
  "ON A MOVIE SET",
  "THINGS THAT CAN CATCH FIRE",
  "AT CHUCK-A-RAMA",
  "THINGS THAT WEIGH MORE THAN 500 LBS",

  "THINGS THAT ARE RECTANGULAR",
  "WORDS THAT BEGIN AND END WITH THE SAME LETTER",
  "AUTHORS AND POETS",
  "DOG AND CAT BREEDS",
  "CROPS",
  "DISEASES AND ILLNESSES",
  "SYMPTOMS",
  "THINGS THAT ARE ROUND",
  "ALL THINGS HAIR",
  "SAUCES",
  "NATURAL DISASTERS",
  "LAND FORMATIONS",
  "WORDS THAT END WITH THE LETTER",
  "WORDS THAT HAVE THREE OF THE LETTER",
  "WORDS IN AN INSTRUCTION MANUAL",
  "TWO WORDS THAT RHYME",
  "SOMETHING MONEY CAN'T BUY",
  "WORDS WITH A DOUBLE MEANING",

  # APRIL 16, 2023

  "MUSICAL TERMS",
  "CONTAINERS",
  "AT THE GROCERY STORE",
  "AT HOME DEPOT",
  "GROCERY STORE AISLES",
  "WATER ACTIVITIES",
  "ON A COLLEGE CAMPUS",
  "ON A FARM",
  "IN AN ELEMENTARY SCHOOL",
  "PLACES YOU'D FIND A LOBBY",
  "IN THE HOUSE",
  "EMOTIONS",
  "THINGS THAT STINK",
  "THINGS THAT ARE GROSS",
  "IN A CHRISTMAS STOCKING",
  "WAYS TO EXERCISE",
  "THINGS YOU CAN SEE THROUGH",
  "THINGS THAT MAKE YOU LAUGH",
  "THINGS THAT MAKE YOU CRY",
  "AT THE CRAFT STORE",
  "BONES",
  "THINGS THAT BEND",
  "APPETIZERS",
  "MEDICAL SUPPLIES",
  "FOREIGN CUSINE",
  "SIX LETTER WORDS",
  "SYMMETRICAL THINGS",
  "FICTIONAL PLACES",
  "THINGS THAT MAKE YOU MAD",
  "PALINDROMES",
  "SOMETHING THAT COMES IN DIFFERENT COLORS",
  "OPPOSITES",
  "PLACES GERMS THRIVE",
  "WAR TACTICS",
  "MEDIUMS OF ART",
  "SPORTS PLAYED WITHOUT A BALL",
  "CAMPING GEAR",
  "EMBARASSING EVENTS",
  "FISHING GEAR",
  "COMPOUND WORDS",
  "SUPERPOWERS",
  "CEREALS",
  "PIZZA TOPPINGS",
  "WORDS ASSOCIATED WITH A WORD PROCESSOR",
]

func _ready():
	
	pass
#	var category_data_collection = Firebase.Firestore.collection('category_data')
#
#	var data = {
#		"cats" : categories
#	}
#
#	var add_task = category_data_collection.add("main", data)
#	var doc = yield(add_task, "add_document")



