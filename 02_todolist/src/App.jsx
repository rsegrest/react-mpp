
import React, {
    useState,
} from 'react';
import ToDoList from './components/ToDoList';

const App = () => {
    let [idCounter, setIdCounter] = useState(0);
    // Get from local storage if it exists
    //    parse serialized string into an object
    //    if not (||), set to empty object ({})
    const initialToDoList = (
        JSON.parse(localStorage.getItem('toDoList'))
        || {}
    );

  return (
        <div className="App">
            <ToDoList
                idCounter={idCounter}
                setIdCounter={setIdCounter}
                initialToDoList={initialToDoList}
            />
        </div>
  );
}

export default App;
