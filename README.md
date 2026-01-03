# Flags Example

## ISSUE: Snapshot not being read properly?

_I'm trying to do some weirdish stuff, so I wouldn't be surprised if this is 100% me. :). I could absolutely be doing something stupid. I was trying to whip this up to demonstrate an idea._

You can see the issue in both the `App` where triple tap reveals the config view, and the companion `Config` app.

### UI

- `Modules/Sources/DomainUI/ConfigRoot.swift` describes the UI and has the code that appends/removes snapshots etc. 
- The intention is that there is an overall "enable/disable" feature flags toggle, and a "enable the experiemenal features" toggle. 
- The experimental features toggle is currently modelled to append/remove a snapshot with the desired values.

### Issue

- When I enable the experimental toggle the snapshot appears to be inserted, but the UI is not updated correctly. 
- If I tap into a particular toggle it shows that the snapshot is there, and seems to update _some_ of the UI.
- If I switch to the App the values don't seem to be reflected in the UI and if I open the config UI I see the same issue as outlined above.
