export const ToDoItem = ({
    id,
    done=false
}) => {
    let fontWeight = 'bold';
    let textDecoration = 'none';
    if (done) {
        textDecoration = 'line-through';
    }
    return (
        <div
            style={{
                border: '1px solid black',
                backgroundColor: 'beige',
                width: '90%',
                padding: '0.5rem',
                margin: '0.5rem auto',
                display: 'block',
                textAlign: 'left',
            }}
            className="todo-item"
        >
            <input
                style={{
                    display: 'inline',
                    padding: '0.5rem',
                    marginLeft: '0.5rem',
                    marginTop: '0.5rem',
                    marginBottom: '0.5rem',
                    marginRight: '2.0rem',
                }}
                checked={done}
                type="checkbox"
            />
            <div
                style={{
                    display: 'inline',
                    fontWeight,
                    fontAlign: 'left',
                    textDecoration,
                }}
            >TO-DO ITEM : {id}</div>
        </div>
    );
}
export default ToDoItem;