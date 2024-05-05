#include <iostream>
#include <vector>
#include <unordered_map>

// Node structure for the DAG
struct Node {
    std::string op;
    std::vector<Node*> operands;
    int label = -1; // for register allocation (optional)
};

// Mapping between operators and assembly instructions
std::unordered_map<std::string, std::string> opMap = {
    {"+", "add"},
    {"-", "sub"},
    {"*", "mul"},
    {"/", "div"} // Add more operators as needed
};

// Function to generate a unique register name
std::string getRegisterName(int label) {
    // Implement a scheme to generate unique register names (e.g., "r" + std::to_string(label))
    return "r" + std::to_string(label);
}

// Function to generate code from a DAG node
std::string generateCode(Node* node, int nextRegister = 1) {
    if (node->operands.empty()) {
        return node->op; // Return the constant value as a string
    }

    std::string code;
    int temp1, temp2;

    // Allocate registers for operands (if not already assigned)
    if (node->operands[0]->label == -1) {
        temp1 = nextRegister++;
        node->operands[0]->label = temp1;
    } else {
        temp1 = node->operands[0]->label;
    }

    if (node->operands.size() > 1 && node->operands[1]->label == -1) {
        temp2 = nextRegister++;
        node->operands[1]->label = temp2;
    } else if (node->operands.size() > 1) {
        temp2 = node->operands[1]->label;
    } else {
        temp2 = -1; // Unary operation doesn't need a second register
    }

    // Generate code for operands recursively
    code = generateCode(node->operands[0], nextRegister);
    if (temp2 != -1) {
        code += "\n" + generateCode(node->operands[1], nextRegister);
    }

    std::string instruction = opMap[node->op];
    std::string reg1 = getRegisterName(temp1);
    std::string reg2 = (temp2 != -1) ? getRegisterName(temp2) : "";

    // Generate assembly code with register names
    if (temp2 == -1) {
        code = instruction + " " + reg1; // Unary operation
    } else {
        code = instruction + " " + reg1 + ", " + reg2;
    }

    return code;
}

Node* buildDAG() {
    Node* a = new Node; // Constant node with value "a"
    a->op = "a";

    Node* b = new Node; // Constant node with value "b"
    b->op = "b";

    Node* add = new Node; // Addition operator
    add->op = "+";
    add->operands.push_back(a);
    add->operands.push_back(b);

    Node* mul = new Node; // Multiplication operator
    mul->op = "*";
    mul->operands.push_back(add);

    Node* c = new Node; // Constant node with value "c"
    c->op = "c";

    Node* sub = new Node; // Subtraction operator
    sub->op = "-";
    sub->operands.push_back(mul);
    sub->operands.push_back(c);

    return sub;
}


int main() {
    Node* root = buildDAG();

    int nextRegister = 1;  
    std::string assemblyCode;

    // Generate code for each operand (if they're not constants)
    for (Node* operand : root->operands) {
        if (operand->label == -1) { // Check if operand needs code generation
            assemblyCode += generateCode(operand, nextRegister) + "\n";
            nextRegister++;
        }
    }

    // Generate code for the root node (the main operation)
    assemblyCode += generateCode(root, nextRegister);

    std::cout << "Assembly Code: \n" << assemblyCode << std::endl;

    // Free memory allocated for the DAG nodes
    delete root; // Implement proper deletion recursively for all nodes

    return 0;
}
