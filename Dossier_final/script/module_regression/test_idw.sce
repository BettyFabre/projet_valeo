clear ;          // Clear all variables
clc;             // Clear console
xdel(winsid());  // Close all figures
//lines(50,120);   // Plot console using x lines and y columns
stacksize max;   // Max possible stacksize (2 GB)

// charge les fonctions .sci du module
getd(get_absolute_file_path('test_idw.sce'));


// Création d'une grille:
nx = 50; ny = 50;
x = linspace(-1,1,nx);
y = linspace(-1,1,ny);
[X,Y] = ndgrid(x,y);
// Calcul d'une fonction sur la grille 
deff("z=f(x,y)","z=3*x.^2 + 5*y.^2+x*y -6 -2*x")
Z = f(X,Y);
Z=Z(:);

// Affichage de la surface
//clf()
//subplot(1,2,1)
//plot3d(x,y,Z);
//title("Surface initiales");

N = size(Z,1);

indnan = unique(ceil(rand(floor(N),1)*N)); // May remove randomly ~ 50 % of points
// TODO : points à supprimer à voir..
Z1 = Z ;
Z1(indnan) = %nan;
X=X(:);
Y=Y(:);
indvalues = find(~isnan(Z1));
indinterp = find(isnan(Z1));
Z1remain = Z1(indvalues);
Z2=IDW(X(indinterp),Y(indinterp),X(indvalues),Y(indvalues),Z1remain);
clf()
subplot(1,2,1)
plot3d(x,y,Z);
title("Surface initiales");