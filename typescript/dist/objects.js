"use strict";
var Role;
(function (Role) {
    Role["ADMIN"] = "admin";
    Role[Role["NON_ADMIN"] = 2] = "NON_ADMIN";
})(Role || (Role = {}));
var person = {
    name: 'test',
    age: 23,
    hobbies: ['a', 'b'],
    role: Role.ADMIN,
    desc: 5,
    gender: 'f'
};
//# sourceMappingURL=objects.js.map