#include <iostream>
#include <unordered_map>
#include <vector>
#include <unordered_set>
#include <stack>

class DAGNode {
public:
    std::string label;
    std::vector<DAGNode*> children;

    DAGNode(std::string label) : label(label) {}
};

class DAG {
    std::unordered_map<std::string, DAGNode*> nodes;

public:
    DAGNode* createNode(const std::string& label) {
        if (nodes.find(label) == nodes.end()) {
            nodes[label] = new DAGNode(label);
        }
        return nodes[label];
    }

    void addEdge(const std::string& parentLabel, const std::string& childLabel) {
        DAGNode* parent = createNode(parentLabel);
        DAGNode* child = createNode(childLabel);
        parent->children.push_back(child);
    }

    // The heuristic ordering algorithm
    std::vector<DAGNode*> generateEvaluationOrder() {
        std::vector<DAGNode*> orderedNodes;
        std::unordered_set<DAGNode*> visited;
        std::stack<DAGNode*> toVisit;

        // Finding all roots to start traversal
        for (auto& pair : nodes) {
            bool isRoot = true;
            for (auto& innerPair : nodes) {
                for (DAGNode* child : innerPair.second->children) {
                    if (child == pair.second) {
                        isRoot = false;
                        break;
                    }
                }
                if (!isRoot) break;
            }
            if (isRoot) toVisit.push(pair.second);
        }

        // Post-order traversal to generate list
        while (!toVisit.empty()) {
            DAGNode* current = toVisit.top();
            toVisit.pop();

            if (visited.find(current) != visited.end()) continue;

            visited.insert(current);
            orderedNodes.push_back(current);

            // Add children to stack if unvisited
            for (DAGNode* child : current->children) {
                if (visited.find(child) == visited.end()) {
                    toVisit.push(child);
                }
            }
        }

        std::reverse(orderedNodes.begin(), orderedNodes.end());
        return orderedNodes;
    }
};

void generateCode(DAG& dag) {
    auto orderedNodes = dag.generateEvaluationOrder();
    std::unordered_map<std::string, std::string> registerMap;

    int regCounter = 0;
    for (DAGNode* node : orderedNodes) {
        std::string reg = "R" + std::to_string(regCounter++);
        std::cout << "MOV " << node->label << ", " << reg << std::endl;
        registerMap[node->label] = reg;
        for (DAGNode* child : node->children) {
            std::cout << "ADD " << child->label << ", " << reg << std::endl;
        }
    }
}

int main() {
    DAG dag;
    // input DAG: t1 = (t2 + t3) * t4
    dag.addEdge("t1", "t2");
    dag.addEdge("t1", "t3");
    dag.addEdge("t1", "t4");

    generateCode(dag);

    return 0;
}
