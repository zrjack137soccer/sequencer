# Sequencer

Simple sequential function that allows for building a list of functions that will then be run in a sequence updating an object that represents a state

## Quickstart
Make sure lua is built and installed

Run linear sequence:
```bash
lua main.lua linear {file_name}
```

Example:
```bash
lua main.lua linear simple_sequence
```

# State Machine
State machine function that allows for a non-linear flow of functions representing steps. Each function returns the next step.

Run state machine:
```bash
lua main.lua state {file_name}
```

Example:
```bash
lua main.lua state trap_doors
```

## Structure

```
hello.lua -> "Hello, World!"
main.lua -> root file for execution
/engine -> contains all mechanisms like the sequencer and state machine
/content -> contains lua files that are used with the engine (files for the state machine are in this folder)
|_ /sequences -> contains all linear sequence lua files
```
