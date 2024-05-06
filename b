La maldición de la dimensionalidad se refiere únicamente a la dificultad de extraer una muestra 
representativa de un conjunto de datos a medida que este va creciendo en dimensionalidad. 
Seleccione una: Falso  

La maldición de la dimensionalidad se refiere únicamente a como las dimensiones hacen mas 
difícil el calculo de las distancias entre los datos a medida que estos crecen dimensionalmente.  
Seleccione una: Falso  

La maldición de la dimensionalidad se refiere al conjunto de fenómenos que aparece tras el 
crecimiento exponencial del espacio de los datos.  
Seleccione una: Verdadero  

La variante del R-tree propuesta por Green (Green approach) propone introducir el cálculo del 
perímetro de las regiones para que estas sean cada vez mas rectangulares, y así se evite la 
sobreposición.  
Seleccione una: Falso  

Son estrategias para ordenar los octantes de un octree 
I. Nearest Neighbor  
II. Z-order  
III. Range Query  
IV. Bounding Box  
V. Todas las anteriores Seleccione una: 
La respuesta correcta es: FVFFF 

Cuales de las siguientes Estructuras de datos utilizan la información geométrica (ordenamiento 
geométrico) de sus datos  
I. R-tree  
II. KD-tree  
III. R*-tree  
IV. R (Greene approach) - tree  
V. Bkd-tree  
Respuesta correcta La respuesta correcta es: FFVVF

La función PickSeeds del árbol R (R-tree) tiene como objetivo encontrar cuales son los mejores 
objetos/datos para dividir en dos un nodo con overflow.  
Seleccione una: Verdadero  

El Kd-tree es una estructura de datos que me permite indizar únicamente datos en 2d y 3d 
(d=dimensiones).  
Seleccione una: Falso  

El pr-quadtree tiene como estrategia la partición del espacio, tomando como centro de dicha 
partición la posición del punto que se está insertando.  
Seleccione una: Falso  

El árbol R+ (R+ tree) toma en consideración el área, perímetro y la sobreposición de las nuevas 
regiones a ser creadas durante su función de split (Node splitting)  
Seleccione una: Falso  

La función ReInsert del árbol R* (R* tree), es llamada únicamente una vez por cada nível del árbol 
siempre que el nodo con overflow no sea la raíz.  
Seleccione una: Verdadero 

En el árbol R+ (R+ tree) el parámetro fill-factor me ayuda a limitar la cantidad de nodos que tendrá 
dicho nivel de árbol.  
Seleccione una: Falso 

detalle los pasos necesarios para hacer un range query en un kd-tree:
primero se envian los parametros necesarios respecto a la cantidad de dimensiones que fue construido el arbol
entonces partiendo del nodo raiz, se comprueba si es que los sub arboles pueden contener datos dentro del rango enviado
por ejemplo si se esta buscando en la primera dimension entre x[5-10], si el nodo raiz parte x en 3, solo la parte derecha
puede puede contenerlo, por lo tanto solo busca ahi, pero si partiera x entre ese rango se tendria que hacer la busqueda en
ambos subarboles, asi se continua recursivamente intercalando las dimensiones por cada nivel ya que es un kd tree
de ahi cuando se llega a las hojas, se comprueba que el dato se encuentre dentro del rango de busqueda deseado, si es asi se
retornara como parte del conjunto de datos que pertenecen a ese rango


// Estructura de un nodo en el R-tree
struct Node {
    // Definir aquí la estructura de un nodo
};

// Función para eliminar una entrada
void Delete(Node* root, Entry entryToDelete) {
    if (IsLeafNode(root)) {
        // Caso 1: El nodo es una hoja, eliminar la entrada si existe
        if (entryToDelete está en root) {
            Elimina entryToDelete de root;
        }
    } else {
        // Caso 2: El nodo no es una hoja
        Recorre todos los nodos hijos de root {
            if (entryToDelete está en el nodo hijo) {
                // Caso 2a: La entrada se encuentra en un nodo hijo
                Delete(nodo hijo, entryToDelete);
                if (nodo hijo se quedó por debajo del tamaño mínimo) {
                    Elimina el nodo hijo de root;
                }
            }
        }

        if (root está por debajo del tamaño mínimo) {
            // Caso 2b: El nodo actual está por debajo del tamaño mínimo después de la eliminación
            Elimina root;
        }
    }

    // Realiza la reestructuración del árbol si es necesario (utilizando la función AdjustTree)
    if (El número de entradas en root es menor que el tamaño mínimo) {
        AdjustTree(root);
    }
}

// Función para reestructurar el árbol después de la eliminación
void AdjustTree(Node* node) {
    // Implementa la lógica para reorganizar el árbol después de la eliminación
}

// Función para comprobar si un nodo es una hoja
bool IsLeafNode(Node* node) {
    // Implementa la lógica para determinar si un nodo es una hoja
}

int main() {
    // Código principal para inicializar el árbol, insertar entradas, eliminar entradas, etc.
    return 0;
}





#include <iostream>
#include <vector>

struct Point {
    double x;
    double y;
    Point(double x, double y) : x(x), y(y) {}
};

struct QuadTreeNode {
    double x, y;
    double width, height;
    std::vector<Point> points;
    QuadTreeNode* children[4];  // Cuatro hijos: NW, NE, SW, SE

    QuadTreeNode(double x, double y, double width, double height) : x(x), y(y), width(width), height(height) {
        for (int i = 0; i < 4; i++) {
            children[i] = nullptr;
        }
    }
};

class Quadtree {
public:
    Quadtree(double x, double y, double width, double height);
    ~Quadtree();

    void Insert(const Point& point);
    std::vector<Point> QueryRange(double x, double y, double width, double height);
    void Clear();

private:
    QuadTreeNode* root;

    void Insert(QuadTreeNode* node, const Point& point);
    bool IsPointInNode(const QuadTreeNode* node, const Point& point);
    void QueryRange(QuadTreeNode* node, double x, double y, double width, double height, std::vector<Point>& result);
    void Clear(QuadTreeNode* node);
};


Quadtree::Quadtree(double x, double y, double width, double height) {
    root = new QuadTreeNode(x, y, width, height);
}

Quadtree::~Quadtree() {
    Clear();
}

void Quadtree::Insert(const Point& point) {
    Insert(root, point);
}

void Quadtree::Insert(QuadTreeNode* node, const Point& point) {
    if (!IsPointInNode(node, point)) {
        return;
    }

    node->points.push_back(point);

    if (node->points.size() > 4 && node->width > 1 && node->height > 1) {
        double subWidth = node->width / 2;
        double subHeight = node->height / 2;
        for (int i = 0; i < 4; i++) {
            if (node->children[i] == nullptr) {
                double subX = node->x + (i % 2) * subWidth;
                double subY = node->y + (i / 2) * subHeight;
                node->children[i] = new QuadTreeNode(subX, subY, subWidth, subHeight);
            }
        }

        std::vector<Point> points = node->points;
        node->points.clear();
        for (const Point& p : points) {
            for (int i = 0; i < 4; i++) {
                Insert(node->children[i], p);
            }
        }
    }
}

bool Quadtree::IsPointInNode(const QuadTreeNode* node, const Point& point) {
    return point.x >= node->x && point.x <= node->x + node->width &&
           point.y >= node->y && point.y <= node->y + node->height;
}

std::vector<Point> Quadtree::QueryRange(double x, double y, double width, double height) {
    std::vector<Point> result;
    QueryRange(root, x, y, width, height, result);
    return result;
}

void Quadtree::QueryRange(QuadTreeNode* node, double x, double y, double width, double height, std::vector<Point>& result) {
    if (node == nullptr) {
        return;
    }

    if (x + width < node->x || x > node->x + node->width || y + height < node->y || y > node->y + node->height) {
        return;
    }

    for (const Point& point : node->points) {
        if (point.x >= x && point.x <= x + width && point.y >= y && point.y <= y + height) {
            result.push_back(point);
        }
    }

    for (int i = 0; i < 4; i++) {
        QueryRange(node->children[i], x, y, width, height, result);
    }
}

void Quadtree::Clear() {
    Clear(root);
}

void Quadtree::Clear(QuadTreeNode* node) {
    if (node == nullptr) {
        return;
    }

    for (int i = 0; i < 4; i++) {
        Clear(node->children[i]);
    }

    delete node;
}

int main() {
    Quadtree quadtree(0, 0, 100, 100);

    Point p1(10, 10);
    Point p2(20, 20);
    Point p3(30, 30);
    Point p4(40, 40);

    quadtree.Insert(p1);
    quadtree.Insert(p2);
    quadtree.Insert(p3);
    quadtree.Insert(p4);

    std::vector<Point> pointsInRange = quadtree.QueryRange(0, 0, 50, 50);

    for (const Point& p : pointsInRange) {
        std::cout << "Point (" << p.x << ", " << p.y << ") is in the range." << std::endl;
    }

    quadtree.Clear();

    return 0;
}
