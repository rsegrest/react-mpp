import '../styles/App.css';
import BasicClassComponent from './BasicClassComponent';
import BasicFunctionalComponent from './BasicFunctionalComponent';

function App() {
  // Remove "aNameProp" from either component below, and the prop value will default to "World"
  return (
    <>
      <BasicFunctionalComponent
        aNameProp="Rick"
      />
      <BasicClassComponent
        aNameProp="Mr. Segrest"
      />
    </>
  );
}

export default App;
