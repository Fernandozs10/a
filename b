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
