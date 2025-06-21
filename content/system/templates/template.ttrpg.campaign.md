---
world: 
campaign: <%tp.file.title%>
status: 
role: 
system: 
type: campaign
tags: []
---
## (Note: Delete this line #template ) 
# The Setting Of <%tp.file.title%>

## Player Characters
(Create note link for each character)

```dataview
TABLE WITHOUT ID file.link AS "Player Characters", player AS "Player", description AS "Description"
WHERE contains(type, "PlayerCharacter") AND contains(campaign, "<%tp.file.folder(false)%>") AND !contains(file.tags, "#template")
```

----

## Sessions
Table shows a list of sessions from this specific world.
```button
name New Session
type command
action QuickAdd: New TTRPG Session
```
^button-8s0j
```dataview
TABLE WITHOUT ID file.link AS "Session", summary AS "Summary"
WHERE contains(type, "session") AND contains(campaign, "<%tp.file.folder(false)%>") AND !contains(file.tags, "#template")
```


## Information about the World

----

## Factions 
Table shows a list of factions from this specific world.
```dataview
TABLE WITHOUT ID file.link AS "Faction", description AS "Description"
WHERE contains(type, "faction") AND contains(campaign, "<%tp.file.folder(false)%>")
```

----

## Custom Rules




-----

