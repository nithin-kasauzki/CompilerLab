#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

struct Instruction {
    string output;
    string op;
    string input1;
    string input2;

    // Print instruction in a readable format
    void print() const {
        if (input2.empty()) {
            cout << output << " = " << input1 << endl;
        } else {
            cout << output << " = " << input1 << " " << op << " " << input2 << endl;
        }
    }
};

class Optimizer {
public:
    Optimizer(vector<Instruction>& codeBlock) : instructions(codeBlock) {}

    // Perform optimizations
    void optimize() {
        constantFolding();
        algebraicSimplification();
        deadCodeElimination();
    }

    // Print the optimized code
    void printOptimizedCode() {
        for (auto& inst : instructions) {
            inst.print();
        }
    }

private:
    vector<Instruction>& instructions;
    unordered_map<string, string> computedValues;

    // Evaluate constant expressions
    void constantFolding() {
        for (auto& inst : instructions) {
            if (isNumber(inst.input1) && (inst.input2.empty() || isNumber(inst.input2))) {
                int result = evaluate(inst.op, inst.input1, inst.input2);
                inst.input1 = std::to_string(result);
                inst.op = "";
                inst.input2 = "";
                computedValues[inst.output] = inst.input1;
            }
        }
    }

    // Simplify algebraic expressions
    void algebraicSimplification() {
        for (auto& inst : instructions) {
            if (inst.op == "-" && inst.input1 == inst.input2) {
                inst.op = "";
                inst.input1 = "0"; // x - x = 0
                inst.input2 = "";
            }
        }
    }

    // Eliminate unused code
    void deadCodeElimination() {
        unordered_map<string, bool> usageMap;

        // Mark all outputs as unused initially
        for (auto& inst : instructions) {
            usageMap[inst.output] = false;
        }

        // Identify used variables
        for (auto& inst : instructions) {
            if (!inst.input1.empty() && usageMap.find(inst.input1) != usageMap.end()) {
                usageMap[inst.input1] = true;
            }
            if (!inst.input2.empty() && usageMap.find(inst.input2) != usageMap.end()) {
                usageMap[inst.input2] = true;
            }
        }

        // Remove instructions that produce unused outputs
        instructions.erase(
            std::remove_if(instructions.begin(), instructions.end(),
                [&usageMap](const Instruction& inst) {
                    return !usageMap[inst.output];
                }),
            instructions.end());
    }

    // Helper to check if a string is a number
    bool isNumber(const std::string& s) {
        return !s.empty() && std::all_of(s.begin(), s.end(), ::isdigit);
    }

    // Evaluate a simple expression
    int evaluate(const std::string& op, const std::string& input1, const std::string& input2) {
        int num1 = std::stoi(input1);
        int num2 = input2.empty() ? 0 : std::stoi(input2);
        if (op == "+") return num1 + num2;
        if (op == "-") return num1 - num2;
        if (op == "*") return num1 * num2;
        if (op == "/") return num2 != 0 ? num1 / num2 : 0; // handle division by zero gracefully
        return 0; // default case
    }
};

int main() {
    std::vector<Instruction> codeBlock = {
    {"t1", "+", "4", "5"},            
    {"t2", "-", "t1", "3"},           
    {"t3", "*", "t2", "0"},           
    {"t4", "+", "t3", "7"},           
    {"t5", "-", "t4", "t4"},         
    {"x", "*", "2", "t5"},            
    {"y", "+", "x", "1"},            
    {"z", "+", "a", "b"},            
};


    Optimizer optimizer(codeBlock);
    cout << "Original code:\n";
    for (auto& inst : codeBlock) {
        inst.print();
    }

    optimizer.optimize();
    cout << "\nOptimized code:\n";
    optimizer.printOptimizedCode();

    return 0;
}
