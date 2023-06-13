import ToDoItem from './components/ToDoItem';
import './styles/App.css';

const App = () => {
  let count = 0;
  return (
    <div className="App">
      <div
        style={{
          border: '1px solid gray',
          width: '50vw',
          margin: 'auto',
          textAlign: 'center',
          backgroundColor: '#454465'
        }}
      >
        <h1
          style={{
            color: 'white',
            marginLeft: 'auto',
            marginRight: 'auto',
            marginTop: 'auto',
            marginBottom: '1rem',
            textAlign: 'center'
          }}
        >TO-DO LIST</h1>
        <ToDoItem id={(count += 1)} />
        <ToDoItem id={(count += 1)} />
        <ToDoItem id={(count += 1)} />
        <ToDoItem id={(count += 1)} />
      </div>
    </div>
  );
}

export default App;
