entrada(paella).
entrada(gazpacho).
entrada(consom�).

carne(filete_de_cerdo).
carne(pollo_asado).

pescado(trucha).
pescado(bacalao).

postre(flan).
postre(helado).
postre(pastel).


principal(X):-carne(X);pescado(X).
menucompleto(X,Y,Z) :- entrada(X) , principal(Y), postre(Z).
consome(X,Y,Z) :- menucompleto(X,Y,Z) , X==consom�.
filtro(X,Y,Z) :- menucompleto(X,Y,Z) , not(Z==flan).
