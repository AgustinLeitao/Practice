let userInput: unknown;
let userName: string; // username = userInput Not valid.

if (typeof userInput === 'string') {
  userName = userInput;
}

function thowError(message: string, code: number): never {
  throw { message: message, errorCode: code };
}

thowError('error', 3);
