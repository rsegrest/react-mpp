import "../styles/todoitem.css";

export const ToDoItem = ({
    id,
    toDoItem,
    toggleDoneStatus,
    removeToDoItem,
}) => {
    let fontWeight = 'bold';
    let textDecoration = 'none';

    if (toDoItem['done'] === true) {
        textDecoration = 'line-through';
    }

    return (
        <div
            className="todo-item"
            key={id}
        >
            <input
                className="todo-item-checkbox"
                checked={toDoItem['done']}
                type="checkbox"
                onChange={() => toggleDoneStatus(id)}
            />
            <div
                style={{
                    fontWeight,
                    textDecoration,
                }}
                className="todo-item-text"
            >
                {toDoItem.text}
            </div>
            <input
                className="todo-item-delete"
                type="button"
                value="X"
                onClick={() => removeToDoItem(id)}
            />
        </div>
    );
}
export default ToDoItem;