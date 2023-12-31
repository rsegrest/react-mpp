import {
  useState,
} from 'react';
import ToDoItem from './ToDoItem';
import '../styles/todolist.css';

const ToDoList = ({
  initialToDoList,
}) => {
  const [idCounter, setIdCounter] = useState(4);
  const [toDoInputText, setToDoInputText] = useState('');
  const [toDoList, setToDoList] = useState(initialToDoList || {});

  const addToDoItem = ({id, text}) => {
    // Copy the current toDoList object and tack on the new item
    const newToDoList = {
      ...toDoList,
      [id]: {
        text,
        done: false,
      }
    };
    setToDoList(newToDoList)
    // *** Save to local storage
    //  On a real application,
    //  you would want to handle local storage in a separate class,
    //  so you could replace it with a database or different type of storage
    // (Cohesion and Separation of Concerns, SOLID principles)
    // Facade pattern
    localStorage.setItem('toDoList', JSON.stringify(newToDoList));
    // increment idCounter for next item
    setIdCounter(idCounter + 1);
  }

  const removeToDoItem = (id) => {
    // IMPORTANT!: Make a copy of the toDoList object
    //    Don't just modify the existing object
    //    Otherwise, the screen will not update with the new state
    let newToDoList = {...toDoList};
    delete newToDoList[id];
    localStorage.setItem('toDoList', JSON.stringify(newToDoList));
    // Overwrite the entire (old) object with the new object
    setToDoList(newToDoList);
  }

  const toggleDoneStatus = (id) => {
    // IMPORTANT!: Make a copy of the toDoList object
    //    Don't just modify the existing object
    //    Otherwise, the screen will not update with the new state
    let newToDoList = {...toDoList};
    newToDoList[id].done = !newToDoList[id].done;
    localStorage.setItem('toDoList', JSON.stringify(newToDoList));
    // Overwrite the entire (old) object with the new object
    setToDoList(newToDoList);
  }

  return (
    <div className="App">
      <div
        className="todo-list-container center"
      >
        <h1
          className="todo-list-title"
        >TO-DO LIST</h1>
        {
          Object.keys(
            toDoList
          ).map((id) => (
            <ToDoItem
              key={id}
              id={id}
              toDoItem={toDoList[id]}
              removeToDoItem={removeToDoItem}
              toggleDoneStatus={toggleDoneStatus}
            />
          ))
        }
        <input
          className="todo-list-new-input"
          onChange={(e) => setToDoInputText(e.target.value)}
        />
        <input
          className="todo-list-new-submit"
          type="button"
          value="ADD ITEM"
          onClick={() => {
            const text = toDoInputText;
            setToDoInputText('');
            addToDoItem({
              id: idCounter,
              text,
            });
          }}
        />
      </div>
    </div>
  );
}

export default ToDoList;
