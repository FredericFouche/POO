class vehicule {
  nbOfWheels;
  enginePower;
  isStarted;

  constructor(nbOfWheels, enginePower) {
    this.nbOfWheels = nbOfWheels;
    this.enginePower = enginePower;
    this.isStarted = false;
  }

  start() {
    this.isStarted = true;
    console.log('Engine started');
  }

  stop() {
    this.isStarted = false;
    console.log('Engine stopped');
  }

  makeNoise() {
    if (this.isStarted) {
      console.log('Vrooom');
    } else {
      console.log('...');
    }
  }

  toString() {
    //opérateur ternaire
    const started = this.isStarted
      ? 'The engine is started'
      : 'The engine is stopped';
    console.log(
      `Nb of wheels: ${this.nbOfWheels}, Engine power: ${this.enginePower}, ${started}`
    );
  }

  boostEngine(power) {
    // boost avec 2000 max
    this.enginePower += power;
    if (this.enginePower > 2000) {
      this.enginePower = 2000;
      console.log('Engine power max');
    } else if (this.enginePower < 0) {
      this.enginePower = 0;
      console.log('Engine power min');
    } else {
      this.enginePower += power;
      console.log('Engine power: ' + this.enginePower);
    }
  }
}

const ferrarri = new vehicule(4, 1000);
ferrarri.start();
ferrarri.stop();
ferrarri.makeNoise();
ferrarri.toString();
ferrarri.boostEngine(500);
