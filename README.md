# Swift Checked Continuations Demo

A complete callback-to-async bridge. Input validation happens before the continuation is created, and the one-shot legacy callback resumes exactly once.

## Run

```bash
git clone https://github.com/2252408699/swift-checked-continuations-demo.git
cd swift-checked-continuations-demo
swift run
```

The executable loads user 42 and then demonstrates the validation error path without leaving a continuation suspended.
