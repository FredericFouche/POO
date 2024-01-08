# La POO

## Sommaire

- [1. Qu'est-ce que la POO ?](#1-quest-ce-que-la-poo)
  - [Qu'est-ce qu'un objet ?](#12-quest-ce-quun-objet)
  - [Le desing pattern de la Factory](#13-le-desing-pattern-de-la-factory)
  - [La syntaxe ES6](#14-la-syntaxe-es6)
  - [Les getters et les setters](#15-les-getters-et-les-setters)
- [2. L'héritage](#2-lhéritage)
  - [Qu'est-ce que l'héritage ?](#21-quest-ce-que-lhéritage)

## 1. Qu'est-ce que la POO ?

En Javascript, la `POO` est un sucre syntaxique, certains langages n'ont pas d'objet de base, mais en Javascript, si, on a : {}.

En JS, la `POO` au sens "design pattern", c'est facultatif, c'est une surcouche, on peut faire du JS sans `POO`, mais on le retrouve parfois dans des codes de librairies.

Par exemple : L'orm `Sequelize` est basé sur de la POO.

### 1.2. Qu'est-ce qu'un objet ?

Un `objet` est une représentation de quelque chose dans le monde réel. Par exemple, un `objet` peut être une voiture, une personne, un animal, etc. Il peut être représenté par des `attributs` et des `méthodes`.

Derrière la POO, il y a la notion de **factory** (usine), c'est une fonction de fabrique à `objet`.

### 1.3. Le desing pattern de la Factory

Un design pattern est une solution à un problème récurrent.
La factory est une fonction qui va servir à créer un objet.
La factory est un moule pour créer des instances d'objets qui ont les mêmes propertys et les mêmes méthodes.

```js
const harry = {
  name: 'Harry',
  age: 17,
  school: 'Poudlard',
  house: 'Gryffondor',
  friends: ['Ron', 'Hermione'],
  sayHello: function () {
    console.log(`Hello, my name is ${this.name}`);
  },
  castSpell: function () {
    console.log(`
    ${this.name} : Expelliarmus !
    `);
  },
};

const hermione = {
  name: 'Hermione',
  age: 17,
  school: 'Poudlard',
  house: 'Gryffondor',
  friends: ['Ron', 'Harry'],
  sayHello: function () {
    console.log(`Hello, my name is ${this.name}`);
  },
  castSpell: function () {
    console.log(`
    ${this.name} : Expelliarmus !
    `);
  },
};

hermione.sayHello();
harry.sayHello();

// au lieu de répéter le code, on peut créer une factory qui va créer des objets
function createPerson(name, age, school, house, friends) {
  return {
    name: name,
    age: age,
    school: school,
    house: house,
    friends: friends,
    sayHello: function () {
      console.log(`Hello, my name is ${this.name}`);
    },
    castSpell: function () {
      console.log(`
    ${this.name} : Expelliarmus !
    `);
    },
  };
}

// on peut créer des objets avec la factory
const harry = createPerson('Harry', 17, 'Poudlard', 'Gryffondor', [
  'Ron',
  'Hermione',
]); // Ceci est une instance de la factory createPerson
const hermione = createPerson('Hermione', 17, 'Poudlard', 'Gryffondor', [
  'Ron',
  'Harry',
]); // Ceci est une autre instance de la factory createPerson

// on peut appeler la méthode sayHello sur les objets
hermione.sayHello();
harry.sayHello();

// On peut aussi utiliser cette syntaxe
const PersonFactory = {
  makePerson(name, age, school, house, friends) {
    return {
      name: name,
      age: age,
      school: school,
      house: house,
      friends: friends,
      sayHello: function () {
        console.log(`Hello, my name is ${this.name}`);
      },
      castSpell: function () {
        console.log(`
            ${this.name} : Expelliarmus !
            `);
      },
    };
  },
};

// on peut créer ron comme ça
const ron = PersonFactory.makePerson('Ron', 17, 'Poudlard', 'Gryffondor', [
  'Harry',
  'Hermione',
]);

ron.sayHello();
```

### 1.4. La syntaxe ES6

ES6 est une version de Javascript qui est sortie en 2015, elle a apporté de nouvelles fonctionnalités, la syntaxe des classes, les fonctions fléchées, les littéraux de gabarits, let et const, le new, etc.

On va refaire la factory avec la syntaxe POO de ES6.

```js
// on peut créer une classe

class Wizard {
  // les attributs, il est facultatif de les lister mais c'est une bonne pratique
  // on accède aux attributs avec le mot clé this
  firstname;
  lastname;
  age;

  // Il faut un constructeur, c'est une méthode qui est appelée lorsqu'on crée une instance de la classe
  // Le constructeur est la méthode qui construit l'objet
  constructor(firstname, lastname, age, isProfessor) {
    // on peut initialiser les attributs
    this.firstname = firstname;
    this.lastname = lastname;
    this.age = age;
    // on peut aussi initialiser des attributs qui ne sont pas tout le temps passés en paramètre
    this.isProfessor = isProfessor || false; // on peut mettre une valeur par défaut

    // ici on peut mettre de la validation aussi
  }

  // l'avantage de cette syntaxe est qu'on peut ajouter les méthodes que l'on veut, mais il faut utiliser le mot clé this pour accéder aux attributs
  sayHello() {
    console.log(`Hello, my name is ${this.firstname} ${this.lastname} !`);
  }

  castSpell() {
    console.log(`
        ${this.firstname} : Expelliarmus !
        `);
  }
}

// on peut créer une instance de la classe Wizard via le mot clé new
// le mot clé new va appeler le constructeur de la classe
const harry = new Wizard('Harry', 'Potter', 10);
harry.sayHello();
harry.castSpell();

// on peut créer une seconde classe facilement
const hermione = new Wizard('Hermione', 'Granger', 11);
hermione.sayHello();
hermione.castSpell();

const dumbledore = new Wizard('Albus', 'Dumbledore', 150, true);
dumbledore.sayHello();
dumbledore.castSpell();
```

Le mot clé `this` permet d'accéder aux attributs et aux méthodes de l'instance courante de la classe. Il permet de faire référence à l'objet courant.
Il est de bonne pratique de mettre la fabrique dans un fichier à part et de l'exporter. Pour pouvoir l'utiliser ailleurs, mais c'est plus lisible.

On peut utiliser # devant une property pour la rendre privée, on ne peut plus y accéder de l'extérieur de la classe.

```js
class vehicule {
  wheels;
  color;
  #isStarted = false; // on ne peut pas y accéder de l'extérieur de la classe

  constructor(wheels, color) {
    this.wheels = wheels;
    this.color = color;
  }

  start() {
    this.#isStarted = true;
  }

  stop() {
    this.#isStarted = false;
  }
}

const clio = new vehicule(4, 'red');
clio.start();
clio.stop();
```

### 1.5. Les getters et les setters

Les getters et les setters sont des méthodes qui permettent de récupérer et de modifier des attributs privés.
En reprenant l'exemple précédent, on peut créer des getters et des setters pour l'attribut privé #isStarted. C'est une interface pour accéder à l'attribut privé.

```js
class vehicule {
  wheels;
  color;
  #enginePower;

  constructor(wheels, color, enginePower) {
    this.wheels = wheels;
    this.color = color;
    this.#enginePower = enginePower;
  }

  // Setter pour l'attribut privé #enginePower
  set enginePower(enginePower) {
    if (typeof enginePower !== 'number') {
      throw new Error('enginePower must be a number');
    } else {
      this.#enginePower = enginePower;
    }
  }

  // Getter pour l'attribut privé #enginePower
  get enginePower() {
    return this.#enginePower;
  }
}

const clio = new vehicule(4, 'red', 100);
clio.enginePower = 120; // Mise à jour de la puissance du moteur
console.log(clio.enginePower); // Affiche la puissance du moteur
```

Le getter est une méthode qui permet de récupérer la valeur d'un attribut privé, c'est une interface de lecture. Alors que le setter est une méthode qui permet de modifier la valeur d'un attribut privé, c'est une interface d'écriture qui nous permet de faire de la validation.

### 1.6. Le this

Le mot-clé `this` en JavaScript est utilisé pour identifier l'objet qui est en train d'exécuter une méthode donnée. Sa valeur change selon l'objet qui invoque la méthode. En d'autres termes, `this` pointe vers l'instance actuelle de la classe où il est utilisé, permettant ainsi d'accéder aux attributs et méthodes spécifiques de cette instance.

Pour les fonctions fléchées, la situation est un peu différente. Contrairement aux fonctions normales, elles n'ont pas leur propre contexte `this`. À la place, elles "empruntent" le `this` du contexte où elles sont créées. Cela signifie que le `this` à l'intérieur d'une fonction fléchée fait référence au même objet que le `this` dans son contexte extérieur.

Par exemple :

```js
const person = {
  name: 'John',
  age: 30,
  // cette méthode est une méthode normale et le this fait référence à l'objet person
  sayHello: function () {
    console.log(`Hello, my name is ${this.name}`);
  },
  // cette méthode est une méthode fléchée et le this fait référence à l'objet global c'est à dire window
  sayHelloArrow: () => {
    console.log(`Hello, my name is ${this.name}`);
  },
};

person.sayHello(); // Hello, my name is John
person.sayHelloArrow(); // Hello, my name is undefined
```

Cependant, l'utilisation de `this` peut parfois créer de la confusion, surtout lorsqu'on travaille avec des callbacks. Dans ces cas, `this` ne réfère pas toujours à l'objet attendu. Par exemple, si une méthode de classe est passée en tant que callback, le `this` à l'intérieur de cette méthode pourrait ne pas pointer vers l'instance de la classe, mais plutôt vers l'objet qui appelle le callback, ce qui peut mener à des erreurs inattendues.

### 2. L'héritage

#### 2.1. Qu'est-ce que l'héritage ?

L'héritage est un principe de la `POO` qui permet de créer une classe à partir d'une autre classe. La classe mère est appelée la classe parent et la classe fille est appelée la classe enfant.

```js
// on peut créer une classe parent qui s'appelle vehicule
class vehicule {
  wheels;
  color;
  enginePower;

  constructor(wheels, color, enginePower) {
    this.wheels = wheels;
    this.color = color;
    this.enginePower = enginePower;
  }

  start() {
    console.log('Vehicule started');
  }

  stop() {
    console.log('Vehicule stopped');
  }
}

// on peut créer une classe enfant qui s'appelle car qui va hériter de vehicule
class car extends vehicule {
  trunkSize; // on peut ajouter des attributs spécifiques à la classe enfant

  constructor(color, enginePower, trunkSize) {
    // on peut appeler le constructeur de la classe parent avec le mot clé super et passer les paramètres du constructeur de la classe parent
    super(4, color, enginePower);
    this.trunkSize = trunkSize;
  }

  // on peut surcharger des méthodes de la classe parent
  start() {
    console.log('Car started');
  }

  // ou ajouter des méthodes spécifiques à la classe enfant

  openTrunk() {
    console.log('Trunk opened');
    console.log(`Trunk size : ${this.trunkSize}`);
    console.log('Trunk closed');
  }
}

// on peut créer une instance de la classe car
const clio = new car('red', 100, 1000);
clio.start(); // on peut appeler les méthodes de la classe parent car elles sont héritées
clio.openTrunk(); // on peut appeler les méthodes de la classe enfant

// on peut créer une classe enfant qui s'appelle bike qui va hériter de vehicule
class bike extends vehicule {
  constructor(color, enginePower) {
    super(2, color, enginePower);
  }
}

// on peut créer une instance de la classe bike
const bmx = new bike('blue', 0);
bmx.start(); // on peut appeler les méthodes de la classe parent car elles sont héritées
```

L'intérêt de l'héritage est de pouvoir réutiliser du code, on peut créer une classe parent qui contient du code commun et créer des classes enfants qui vont hériter de la classe, on peut aussi surcharger des méthodes de la classe parent dans les classes enfants.

Surcharger une méthode, c'est redéfinir une méthode dans une classe enfant. On peut aussi appeler une méthode de la classe parent dans une classe enfant avec le mot clé `super` comme le constructeur ou autre.

Il faut toujours réécrire le constructeur dans une classe enfant, car toute classe doit avoir un `constructeur`.

### Bonnes pratiques

Pour éviter d'avoir des 50 paramètres dans le constructeur, on peut utiliser le `littéral d'objet` pour passer des paramètres à la classe.

```js
// pour éviter ça
class vehicule {
  property1;
  property2;
  property3;
  property4;
  property5;
  property6;

  constructor(
    property1,
    property2,
    property3,
    property4,
    property5,
    property6
  ) {
    this.property1 = property1;
    this.property2 = property2;
    this.property3 = property3;
    this.property4 = property4;
    this.property5 = property5;
    this.property6 = property6;
  }
}

// on peut faire ça et utiliser un littéral d'objet
class vehicule {
  property = {
    property1: '',
    property2: '',
    property3: '',
    property4: '',
    property5: '',
    property6: '',
  };

  // obj est michelisable
  constructor(obj) {
    this.property1 = obj.property1;
    this.property2 = obj.property2;
    this.property3 = obj.property3;
    this.property4 = obj.property4;
    this.property5 = obj.property5;
    this.property6 = obj.property6;
  }
}
```

C'est plus lisible, plus facile à maintenir et plus facile à utiliser.

### 2.2. Instanceof

L'opérateur `instanceof` permet de vérifier si un objet est une instance d'une classe.

```js
class vehicule {
  wheels;
  color;
  enginePower;

  constructor(wheels, color, enginePower) {
    this.wheels = wheels;
    this.color = color;
    this.enginePower = enginePower;
  }
}

class toyota extends vehicule {
  constructor(color, enginePower) {
    super(4, color, enginePower);
  }
}

const clio = new toyota('red', 100);

console.log(clio instanceof toyota); // true car clio est une instance de la classe toyota qui hérite de la classe vehicule
console.log(clio instanceof vehicule); // true car clio est une instance qui hérite de la classe vehicule
```

### 2.3. Les proxy

Un Proxy en JavaScript est un objet spécial qui agit comme un intermédiaire entre un objet cible et les interactions avec cet objet. Il permet de personnaliser les comportements fondamentaux des objets, tels que la lecture et l'écriture des propriétés, l'invocation de fonctions, l'énumération des propriétés, et plus encore. En utilisant un Proxy, vous pouvez intercepter et redéfinir ces opérations fondamentales.

Pour créer un Proxy, vous utilisez le constructeur `new Proxy(target, handler)`. Ici, `target` est l'objet original que vous voulez "proxifier", et `handler` est un objet qui contient des fonctions, appelées "traps" (pièges), qui définissent le comportement personnalisé pour différentes opérations. Par exemple, un trap `get` peut être défini pour intercepter les lectures de propriétés, ou un trap `set` pour intercepter les écritures de propriétés.

Les Proxy sont puissants et flexibles, permettant de nombreux cas d'utilisation avancés tels que la validation des données, la journalisation des opérations, la création d'objets observables (pour la réactivité), et l'implémentation de modèles de programmation sophistiqués. Cependant, cette puissance s'accompagne d'une certaine complexité et, dans certains cas, d'un impact sur les performances. Il est donc recommandé de les utiliser judicieusement et dans des scénarios où leurs avantages l'emportent sur leurs inconvénients potentiels.

exemple :

```js
class vehicule {
  wheels;
  color;
  enginePower;

  constructor(wheels, color, enginePower) {
    this.wheels = wheels;
    this.color = color;
    this.enginePower = enginePower;
  }
}

class toyota extends vehicule {
  constructor(color, enginePower) {
    super(4, color, enginePower);
  }
}

const clio = new toyota('red', 100);

// on peut créer un proxy pour intercepter les accès aux propriétés de l'objet clio

const clioProxy = new Proxy(clio, {
  // trap get pour intercepter les accès aux propriétés
  get(target, property) {
    console.log(`Reading property ${property}`);
    return target[property];
  },
  // trap set pour intercepter les écritures aux propriétés
  set(target, property, value) {
    console.log(`Writing property ${property}`);
    target[property] = value;
  },
});

clioProxy.color = 'blue'; // Writing property color

console.log(clioProxy.color); // Reading property color
```

### 2.4. Les REGEX

Les expressions régulières (ou `REGEX`) sont des motifs utilisés pour faire des recherches et des remplacements dans les chaînes de caractères, ou pour valider des chaînes de caractères. Elles sont écrites dans une syntaxe concise et flexible, et permettent de rechercher des chaînes de caractères avec un niveau de contrôle très précis.

| Symbole  | Description                                      |
| -------- | ------------------------------------------------ |
| \w       | Caractère alphanumérique ou \_                   |
| \d       | Chiffre                                          |
| \s       | Espace                                           |
| \.       | Point                                            |
| \w+      | Un ou plusieurs caractères alphanumériques ou \_ |
| \d+      | Un ou plusieurs chiffres                         |
| /        | Début de l'expression régulière                  |
| $        | Fin de l'expression régulière                    |
| [a-zA-Z] | Un caractère entre a et z ou entre A et Z        |
| {2,3}    | Entre 2 et 3 caractères                          |
| ^        | Début de la chaîne de caractère                  |

exemple :

```js
// une regex pour valider un email
const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

// on peut tester si une chaine de caractère est valide avec la méthode test
console.log(emailRegex.test('azopeopaze')); // false
console.log(emailRegex.test('azopeopaze@')); // false
console.log(emailRegex.test('azopeopaze@gmail')); // false
console.log(emailRegex.test('azeiopaze@gmail.com')); // true
```

Explication de cette regex :

    ^[a-zA-Z0-9._%+-]+ : La partie locale de l'adresse e-mail. Elle autorise les lettres majuscules et minuscules, les chiffres, les points, les soulignés, les pourcentages, les plus et les tirets. Elle commence par ^, indiquant le début de la chaîne.

    @ : Caractère at-symbol obligatoire dans les adresses e-mail.

    [a-zA-Z0-9.-]+ : Nom de domaine, qui peut inclure des lettres, des chiffres, des points et des tirets.

    \. : Un point littéral séparant le nom de domaine de l'extension.

    [a-zA-Z]{2,}$ : Extension du domaine. Elle doit avoir au moins deux caractères, sans limite supérieure. Le $ indique la fin de la chaîne.
