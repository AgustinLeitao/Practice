/* Mixins allow to create complex objects from simple objects */

// Disposable Mixin
class Disposable {
  isDisposed: boolean;
  dispose() {
    this.isDisposed = true;
  }
}

// Activatable Mixin
class Activatable {
  isActive: boolean;
  activate() {
    this.isActive = true;
  }
  deactivate() {
    this.isActive = false;
  }
}

class SmartObject {
  constructor() {
    setInterval(
      () => console.log(this.isActive + ' : ' + this.isDisposed),
      500
    );
  }

  interact() {
    this.activate();
  }
}

interface SmartObject extends Disposable, Activatable {}
applyMixins(SmartObject, [Disposable, Activatable]);

let smartObj = new SmartObject();
setTimeout(() => smartObj.interact(), 1000);

function applyMixins(derivedCtor: any, baseCtors: any[]) {
  baseCtors.forEach(baseCtor => {
    Object.getOwnPropertyNames(baseCtor.prototype).forEach(name => {
      Object.defineProperty(
        derivedCtor.prototype,
        name,
        Object.getOwnPropertyDescriptor(baseCtor.prototype, name) as any
      );
    });
  });
}


import Pepo, { logToConsole as pepe} from "object.js";

pepe();