# La POO

## Sommaire

- 1. [Qu'est-ce que la POO ?](#1-qu-est-ce-que-la-poo)
  - 1.1. [Qu'est-ce qu'un objet ?](#11-qu-est-ce-qu-un-objet)
  - 1.2. [Le desing pattern de la Factory](#12-le-desing-pattern-de-la-factory)
  - 1.3. [La syntaxe ES6](#13-la-syntaxe-es6)
  - 1.4. [Les getters et les setters](#14-les-getters-et-les-setters)
  - 1.5. [Le this](#15-le-this)
- 2. [L'héritage](#2-l-héritage)
  - 2.1. [Qu'est-ce que l'héritage ?](#21-qu-est-ce-que-l-héritage)
  - 2.2. [Instanceof](#22-instanceof)
  - 2.3. [Les proxy](#23-les-proxy)
- 3. [Les design patterns](#3-les-design-patterns)
  - 3.1. [Le Data Mapper](#31-le-data-mapper)
  - 3.2. [L'active record](#32-l-active-record)
- 4. [Les REGEX](#4-les-regex)

## 1. Qu'est-ce que la POO ?

En Javascript, la `POO` est un sucre syntaxique, certains langages n'ont pas d'objet de base, mais en Javascript, si, on a : {}.

En JS, la `POO` au sens "design pattern", c'est facultatif, c'est une surcouche, on peut faire du JS sans `POO`, mais on le retrouve parfois dans des codes de librairies.

Par exemple : L'orm `Sequelize` est basé sur de la POO.

### 1.1. Qu'est-ce qu'un objet ?

Un `objet` est une représentation de quelque chose dans le monde réel. Par exemple, un `objet` peut être une voiture, une personne, un animal, etc. Il peut être représenté par des `attributs` et des `méthodes`.

Derrière la POO, il y a la notion de **factory** (usine), c'est une fonction de fabrique à `objet`.

Il existe deux types d'objets :

- Les plain objects : ce sont des objets simples, ils n'ont pas de méthodes, ils sont créés avec la syntaxe littérale.
- Les instances d'objets : ce sont des objets qui ont des méthodes, ils sont créés avec le mot clé `new`.

### 1.2. Le desing pattern de la Factory

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

### 1.3. La syntaxe ES6

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

### 1.4. Les getters et les setters

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

### 1.5. Le this

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

### 1.5. les méthodes statiques

En JavaScript, le mot-clé `static` est utilisé principalement dans le contexte des classes. Il permet de définir des propriétés ou des méthodes statiques sur une classe. Voici quelques points clés sur l'intérêt et l'utilisation de `static` en JavaScript :

1. **Appartenance à la Classe et non à l'Instance :**

   - Les méthodes et propriétés statiques appartiennent à la classe elle-même, pas à des instances de la classe. Cela signifie que vous pouvez les utiliser sans créer un objet de cette classe.

2. **Utilisation dans les Utilitaires et Helpers :**

   - Les méthodes statiques sont souvent utilisées pour créer des fonctions utilitaires et des helpers. Par exemple, si vous avez une classe Mathématique, vous pourriez avoir des méthodes statiques pour des opérations telles que l'addition ou la multiplication.

3. **Encapsulation :**

   - L'utilisation de méthodes statiques peut contribuer à l'encapsulation en regroupant des fonctionnalités liées à une certaine classe, même si elles ne nécessitent pas d'interagir avec des instances de cette classe.

4. **Réduction de la Redondance :**

   - Les méthodes statiques aident à réduire la redondance du code. Plutôt que de répéter la même fonction dans plusieurs instances, une méthode statique permet de l'écrire une seule fois et de l'appeler sur la classe elle-même.

5. **Exemple d'Utilisation :**

   - Supposons que vous ayez une classe `Util` avec une méthode statique `sayHello`. Vous pouvez appeler `Util.sayHello()` sans avoir besoin de créer une instance de `Util`.

   ```javascript
   class Util {
     static sayHello() {
       console.log('Hello');
     }
   }

   Util.sayHello(); // Affiche "Hello"
   ```

6. **Héritage :**
   - Les méthodes statiques peuvent être héritées. Si une classe hérite d'une autre, elle hérite aussi de ses méthodes statiques. Cependant, elles restent liées à la classe originale et ne sont pas accessibles via des instances de la classe dérivée.

En résumé, `static` est utilisé pour définir des propriétés et des méthodes qui sont liées à la classe elle-même plutôt qu'à des instances de cette classe. Cela est utile pour des méthodes qui fournissent des fonctionnalités générales ou des utilitaires qui ne nécessitent pas l'accès aux propriétés d'une instance spécifique.

## 2. L'héritage

### 2.1. Qu'est-ce que l'héritage ?

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

### 2.4 Le polymorphisme

Polymorphisme en Programmation Orientée Objet

Définition :
Le polymorphisme, du grec "poly" (plusieurs) et "morph" (formes), est la capacité d'une entité à prendre plusieurs formes. En programmation orientée objet (POO), cela se réfère à la capacité d'un type (classe) d'être traité comme le type d'une de ses classes parentes ou d'une interface qu'il implémente.

Types de Polymorphisme :
Il existe principalement deux types de polymorphisme en POO :

    Polymorphisme Statique (ou Surcharge) : Cela se produit lorsqu'il y a plusieurs méthodes dans une classe avec le même nom mais des signatures différentes (par exemple, nombre ou types de paramètres différents). C'est ce qu'on appelle la surcharge de méthodes.

    Polymorphisme Dynamique (ou Substitution) : Cela se produit lorsqu'une classe enfant remplace ou étend une méthode d'une classe parente. C'est ce qu'on appelle la redéfinition de méthodes (ou "overriding" en anglais). Ce type de polymorphisme est crucial pour l'héritage, permettant à une instance de la classe enfant d'être traitée comme une instance de la classe parente.

Avantages :

    Flexibilité : Le polymorphisme permet aux programmeurs de réutiliser du code et de créer des programmes plus modulaires.
    Extensibilité : Les programmes deviennent plus extensibles car les nouvelles classes peuvent être ajoutées avec peu ou pas de modification du code existant.
    Maintenabilité : Il facilite la maintenance du code en regroupant des comportements communs, rendant le code plus lisible et plus facile à gérer.

Exemple en Pratique :
Considérons une classe parente Animal avec une méthode faireSon(). Des classes filles comme Chat et Chien héritent de Animal et redéfinissent faireSon() pour produire des sons spécifiques à chaque animal.

```javascript
class Animal {
  faireSon() {
    console.log('Quelque son');
  }
}

class Chat extends Animal {
  faireSon() {
    console.log('Miaou');
  }
}

class Chien extends Animal {
  faireSon() {
    console.log('Wouaf');
  }
}

let monAnimal = new Chat();
monAnimal.faireSon(); // Affiche "Miaou"

monAnimal = new Chien();
monAnimal.faireSon(); // Affiche "Wouaf"
```

Dans cet exemple, monAnimal est une référence de type Animal, mais elle peut se comporter comme un Chat ou un Chien. Le polymorphisme permet à monAnimal de prendre différentes formes, facilitant ainsi la gestion des objets de types différents mais liés par une hiérarchie commune.

### 2.5. Le masquage ou shadowing de propriétés

Le masquage de propriétés est un concept de la POO qui permet de masquer une propriété d'une classe parent dans une classe enfant.

```js
class Animal {
  name;
  static type;

  constructor(obj) {
    this.type = obj.type;
    this.name = obj.name;
  }

  faireSon() {
    console.log('Quelque son');
  }
}

class Chat extends Animal {
  static type = 'Chat'; // on peut masquer la propriété type de la classe parent

  constructor(obj) {
    super(obj);
  }

  faireSon() {
    console.log('Miaou');
  }
}

class Chien extends Animal {
  static type = 'Chien'; // on peut masquer la propriété type de la classe parent

  constructor(obj) {
    super(obj);
  }

  faireSon() {
    console.log('Wouaf');
  }
}
```

L'objectif est de pouvoir accéder à la propriété type de la classe parent et de la classe enfant quand on en a besoin, par exemple pour dynamiser une méthode pour faire une requête sql dans la classe parente.

```js
class Animal {
  name;
  static type;

  constructor(obj) {
    this.type = obj.type;
    this.name = obj.name;
  }

  faireSon() {
    console.log('Quelque son');
  }

  // on peut créer une méthode statique pour faire une requête sql
  static async findAll() {
    const result = await db.query(`SELECT * FROM ${this.type}`);
    return result.rows;
  }
}

class Chat extends Animal {
  static type = 'Chat';

  constructor(obj) {
    super(obj);
  }

  faireSon() {
    console.log('Miaou');
  }
}
```

Ce qui nous permettra de faire ça :

```js
const chats = await Chat.findAll();
```

Car le `this.type` dans la méthode statique `findAll` de la classe parente `Animal` sera remplacé par `Chat` quand on appellera la méthode `findAll` sur la classe `Chat`.
Le cas `this.constructor.type` permet de gérer les situations où vous avez besoin d'accéder à la propriété statique de la classe parente dans une méthode d'instance. Cette approche est utile pour garantir que la méthode d'instance utilise la propriété statique de la classe dans laquelle elle a été définie, et non celle qui a été masquée par la classe enfant.

Poursuivons l'exemple pour illustrer cela :

```js
class Animal {
  name;
  static type = 'Animal';

  constructor(obj) {
    this.type = obj.type; // Utilise le type passé en objet, si disponible
    this.name = obj.name;
  }

  faireSon() {
    console.log('Quelque son');
  }

  static async findAll() {
    const result = await db.query(`SELECT * FROM ${this.type}`);
    return result.rows;
  }

  // Méthode d'instance utilisant la propriété statique de la classe parente
  getType() {
    return this.constructor.type; // Retourne 'Animal' pour une instance d'Animal, 'Chat' pour Chat, etc.
  }
}

class Chat extends Animal {
  static type = 'Chat'; // Masque la propriété 'type' de la classe parente

  constructor(obj) {
    super(obj);
  }

  faireSon() {
    console.log('Miaou');
  }
}

class Chien extends Animal {
  static type = 'Chien'; // De même pour Chien

  constructor(obj) {
    super(obj);
  }

  faireSon() {
    console.log('Wouaf');
  }
}

// Utilisation des méthodes
const animal = new Animal({});
console.log(animal.getType()); // Affiche 'Animal'

const chat = new Chat({});
console.log(chat.getType()); // Affiche 'Chat'

const chien = new Chien({});
console.log(chien.getType()); // Affiche 'Chien'
```

Dans ce scénario :

La méthode getType dans la classe Animal utilise this.constructor.type pour accéder à la propriété statique type de la classe. Cela garantit que même si une classe enfant comme Chat ou Chien masque la propriété type, la méthode getType retournera toujours la valeur correcte associée à l'instance actuelle.

Quand getType est appelée sur une instance de Chat, elle retourne 'Chat', et de même pour Chien, ce qui montre l'utilisation du masquage pour personnaliser le comportement des sous-classes tout en conservant la capacité d'accéder aux propriétés et méthodes de la classe parente.

## 3. Les design patterns

### 3.1. Le Data Mapper

Le Data Mapper est un motif de conception (design pattern) utilisé dans le développement de logiciels pour séparer efficacement la logique métier de la logique de persistance des données. Ce modèle est fondamental dans les architectures où la séparation des préoccupations est une priorité. Il agit comme un intermédiaire entre la base de données et la couche métier de l'application, assurant une interaction propre et organisée entre ces deux composants.

Dans le modèle Data Mapper, les objets de la couche métier ne contiennent aucune logique de persistance des données. Cette responsabilité est déléguée à un objet séparé, le mapper, qui est responsable de transférer les données entre les objets et la base de données. Cette séparation offre plusieurs avantages :

1. **Indépendance de la logique métier :** La logique métier reste pure et non polluée par les détails de la base de données. Cela signifie que les développeurs peuvent se concentrer sur la mise en œuvre des règles métier sans se soucier des aspects techniques de la gestion des données.

2. **Flexibilité et maintenabilité :** Comme la logique de base de données est isolée, il est plus facile de modifier ou de maintenir le système. Les changements dans la structure de la base de données ou dans la logique métier peuvent être effectués indépendamment, réduisant ainsi les risques d'erreurs et simplifiant les mises à jour.

3. **Réutilisabilité :** Les mappers peuvent être réutilisés pour différentes entités métier, ce qui favorise le respect du principe DRY (Don't Repeat Yourself) et conduit à un code plus propre et plus efficace.

4. **Testabilité :** Les composants séparés sont plus faciles à tester. Les tests unitaires pour la logique métier peuvent être effectués sans nécessiter d'accès à la base de données, rendant les tests plus rapides et plus fiables.

En conclusion, le Data Mapper est une approche robuste pour la gestion des données dans les applications complexes. Il favorise un code bien structuré, facile à maintenir et à tester, tout en assurant une séparation claire entre les différentes préoccupations de l'application. Ce modèle est particulièrement utile dans les projets de grande envergure et ceux qui nécessitent une flexibilité élevée pour s'adapter aux changements constants des exigences métier et techniques.

### 3.2. L'active record

L'Active Record est un patron de conception utilisé dans le développement de logiciels pour faciliter la manipulation des données dans les bases de données. Il représente une instance de classe qui est chargée de la persistance de ses propres données. Cette approche se caractérise par l'intégration de fonctions de manipulation de données directement dans l'objet, simplifiant ainsi les interactions avec la base de données.

**Définition des termes clés :**

- Wrap (Englober) : Dans le contexte de l'Active Record, 'wrap' se réfère au processus d'englobement d'un enregistrement de la base de données dans un objet. Cela permet de manipuler les données de cet enregistrement comme s'il s'agissait des propriétés et méthodes de l'objet, rendant ainsi le code plus intuitif et plus proche du paradigme de la programmation orientée objet.

- Encapsuler : L'encapsulation est un principe fondamental de la programmation orientée objet. Dans le cadre de l'Active Record, elle désigne la pratique de cacher les détails de l'accès et de la manipulation des données de la base de données à l'intérieur de l'objet. Ainsi, les modifications des données et les requêtes sont effectuées à travers une interface claire et contrôlée, ce qui renforce la sécurité et la maintenabilité du code.

- Logique métier : La logique métier se réfère aux règles ou algorithmes qui gèrent la communication entre une base de données et les interfaces utilisateurs. Dans un modèle Active Record, on peut intégrer cette logique directement au sein de la classe. Cela permet non seulement de réaliser des opérations de base de données mais aussi d'y ajouter des fonctionnalités spécifiques au contexte de l'application, comme la validation des données ou le traitement de conditions spéciales.

L'Active Record est donc un modèle puissant pour structurer l'accès et la manipulation des données dans les applications, en associant étroitement les données avec les comportements et règles les concernant. Cette méthode offre une approche intuitive et efficace pour gérer les interactions avec les bases de données, tout en gardant une structure claire et maintenable.

exemple de code d'un active record :

```js
// instanciation du client
const db = require('../db');

// création de la classe
class level {
  id;
  name;

  constructort(obj) {
    this.id = obj.id;
    this.name = obj.name;
  }

  // insert() et delete() sont des méthodes d'instance

  // méthode pour insérer un nouveau niveau
  async insert() {
    const result = await db.query(
      `INSERT INTO level ("name")
        VALUES ($1)
        RETURNING id`,
      [this.name]
    );
    const insertedevel = result.rows[0]; // on récupère le niveau inséré dans la base de données
    this.id = insertedevel.id; // on met à jour l'id de l'instance de la classe
  }

  // méthode pour supprimer un niveau
  async delete() {
    const result = await db.query(
      `DELETE FROM level
        WHERE id = $1`,
      // l'id étant défini dans l'instance de la classe, on peut l'utiliser
      [this.id]
    );
    if (result.rowCount > 0) {
      // si rowCount est supérieur à 0, cela veut dire qu'une ligne a été supprimée
      return true;
    } else {
      // sinon, cela veut dire qu'aucune ligne n'a été supprimée
      return false;
    }
  }

  // updateOne()
  async updateOne() {
    const result = await db.query(
      `UPDATE level
        SET name = $1
        WHERE id = $2`,
      [this.name, this.id]
    );
    if (result.rowCount > 0) {
      return true;
    } else {
      return false;
    }
  }

  // findById() sont des méthodes de classe ou méthodes statiques

  // méthode pour lire un niveau de id x
  static async findById(researchedID) {
    const result = await db.query(
      `SELECT * FROM level
        WHERE id = $1`,
      [researchedID]
    );
    if (result.rowCount > 0) {
      // si rowCount est supérieur à 0, cela veut dire qu'une ligne a été trouvée
      const resultLevel = result.rows[0]; // on récupère le niveau trouvé dans la base de données qui est un tableau
      const level = new Level(resultLevel); // on crée une instance de la classe avec les données du tableau
      return level; // on retourne l'instance de la classe
    } else {
      return null;
    }
  }

  // findbyName(x)
  static async findByName(researchedName) {
    const result = await db.query(
      `SELECT * FROM level
        WHERE name = $1`,
      [researchedName]
    );
    if (result.rowCount > 0) {
      const resultLevel = result.rows[0]; // on récupère le niveau trouvé dans la base de données qui est un tableau
      // si resultLevel est null, cela veut dire qu'aucune ligne n'a été trouvée et on retourne null pour éviter une erreur
      const level = resultLevel ? new Level(resultLevel) : null; // on crée une instance de la classe avec les données du tableau si resultLevel n'est pas null
      return level;
    } else {
      return null;
    }
  }

  //findall()
  static async findAll() {
    // la requête
    const result = await db.query(`SELECT * FROM level`);
    // on crée une instance de la classe pour chaque ligne trouvée dans la base de données et on retourne un tableau d'instances de la classe
    if (result.rowCount > 0) {
      const levels = result.rows.map((level) => new Level(level));
      return levels;
    } else {
      return [];
    }
  }
}

// on exporte la classe
module.exports = level;
```

---

> **La différence principale entre le Data Mapper et l'Active Record réside dans la manière dont ils gèrent la séparation entre la logique métier et la persistance des données. le choix entre Data Mapper et Active Record dépend largement de la complexité de l'application et des besoins en matière de flexibilité, de maintenabilité, et d'évolutivité. Le Data Mapper est préférable pour les grandes applications avec des structures de données complexes et en évolution, tandis que l'Active Record convient mieux aux applications plus simples et plus petites. Certains développeurs considèrent que l'active record est un anti-pattern, car il mélange la logique métier et la logique de persistance des données. Pour une petite application, c'est Ok, car on fait du CRUD simple. Mais pour une grosse application, il vaut mieux utiliser le Data Mapper.**

---

### 4. Les REGEX

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

autre exemple plus complexe :

```js
const emailRegex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$;
```

    ^ : Commence l'expression régulière.

    ([\w-]+(?:\.[\w-]+)*) :
        [\w-]+ : Correspond à un ou plusieurs caractères alphanumériques ou tirets.
        (?:\.[\w-]+)* : Un groupe non-capturant pour zéro ou plusieurs séquences de caractères précédées d'un point. Cela permet les parties locales de l'email avec des points (comme dans nom.prenom@example.com).

    @ : Caractère at-symbol séparant la partie locale du nom de domaine.

    ((?:[\w-]+\.)*\w[\w-]{0,66}) :
        (?:[\w-]+\.) : Un groupe non-capturant pour une séquence de caractères alphanumériques ou tirets, suivie d'un point. Cela peut se répéter plusieurs fois pour permettre les sous-domaines.
        \w[\w-]{0,66} : Assure que le nom de domaine est suivi d'au moins un caractère alphanumérique, puis jusqu'à 66 caractères alphanumériques ou tirets, pour respecter la longueur maximale des noms de domaine.

    \.([a-z]{2,6}(?:\.[a-z]{2})?) :
        . : Un point littéral.
        [a-z]{2,6} : Correspond à l'extension de domaine, avec une longueur de 2 à 6 lettres minuscules.
        (?:\.[a-z]{2})? : Un groupe non-capturant optionnel pour une seconde extension de domaine, comme .co.uk.

    $ : Termine l'expression régulière.

### Pour vérifier une date

Il est possible de faire une vérification de date avec l'ojet `Date` de Javascript.

```js
const date = new Date('2021-01-01');

console.log(date instanceof Date); // true
```
