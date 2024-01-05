# La POO

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
La factory est un moule pour créer des instances d'objets qui ont les mêmes propriétés et les mêmes méthodes.

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
