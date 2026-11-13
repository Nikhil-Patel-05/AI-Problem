
from collections import deque

def is_valid(m, c):
    # Check both banks
    if m < 0 or c < 0 or m > 3 or c > 3:
        return False

    # Missionaries should not be outnumbered
    if m > 0 and c > m:
        return False

    if (3 - m) > 0 and (3 - c) > (3 - m):
        return False

    return True


def missionaries_cannibals():
    # State: (missionaries_left, cannibals_left, boat_position)
    # Boat position: 0 = Left, 1 = Right

    start = (3, 3, 0)
    goal = (0, 0, 1)

    queue = deque([start])
    visited = {start}
    parent = {start: None}

    # Possible boat movements
    moves = [
        (1, 0),  # 1 missionary
        (2, 0),  # 2 missionaries
        (0, 1),  # 1 cannibal
        (0, 2),  # 2 cannibals
        (1, 1)   # 1 missionary and 1 cannibal
    ]

    while queue:
        state = queue.popleft()
        m, c, boat = state

        if state == goal:
            break

        for dm, dc in moves:

            if boat == 0:
                new_state = (m - dm, c - dc, 1)
            else:
                new_state = (m + dm, c + dc, 0)

            nm, nc, nb = new_state

            if is_valid(nm, nc) and new_state not in visited:
                visited.add(new_state)
                parent[new_state] = state
                queue.append(new_state)

    # Print solution path
    if goal not in parent:
        print("No solution found!")
        return

    path = []
    state = goal

    while state is not None:
        path.append(state)
        state = parent[state]

    path.reverse()

    print("Solution Path:")
    for step in path:
        print(step)


missionaries_cannibals()
