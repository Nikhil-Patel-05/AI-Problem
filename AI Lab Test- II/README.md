# Emergency Evacuation Planner

## Problem Statement

During emergencies such as fires, people inside a building need to reach a safe exit. However, some corridors or locations may be blocked or unsafe.

The Emergency Evacuation Planner uses Prolog to represent a building as a connected graph and find a safe route from a given starting location to an available exit while avoiding blocked connections and unsafe locations.

## Objectives

- Represent rooms, corridors, staircases and exits as graph nodes.
- Define connections between locations using Prolog facts.
- Identify blocked connections and unsafe locations.
- Find a valid route from the starting location to an available exit.
- Select a route with the minimum number of steps.
- Display a message when no safe route is available.

## AI Concepts Used

- **Graph Representation:** Represents building locations as nodes and connections as edges.
- **Depth First Search (DFS):** Explores possible paths to find an available exit.
- **Constraint Handling:** Prevents movement through blocked connections and unsafe locations.
- **Backtracking:** Allows Prolog to explore alternative routes when a path is unavailable.
- **Shortest Path Selection:** Compares available routes and selects one with the fewest locations.

## Logic and Conditions

1. Each room, corridor, staircase and exit is represented using Prolog facts.
2. Connections between locations are stored using `connected/2`.
3. Connections can be marked as blocked using `blocked_connection/2`.
4. Unsafe locations are identified using `blocked_location/1`.
5. An exit is considered available if it is not blocked or marked unavailable.
6. The program searches for routes using DFS.
7. A visited list prevents revisiting locations and avoids infinite loops.
8. All valid routes are collected, and the shortest route is selected.
9. If no valid route exists, the program displays an appropriate message.

## Main Prolog Predicates

| Predicate | Purpose |
|---|---|
| `location/2` | Defines building locations and their types. |
| `connected/2` | Defines connections between locations. |
| `safe_connection/2` | Checks whether a connection is safe. |
| `available_exit/1` | Checks exit availability. |
| `dfs/4` | Performs Depth First Search. |
| `safe_path/3` | Finds a valid path. |
| `find_best_route/2` | Selects the shortest route. |
| `evacuate/1` | Executes the evacuation process. |

## Conclusion

The project demonstrates the application of Artificial Intelligence and Prolog in solving an emergency evacuation problem. Using graph representation, DFS, backtracking and constraint handling, the system identifies safe evacuation routes while avoiding blocked connections and unsafe locations.


