Conceived as a modern alternative to [[Gitflow]], it's an approach to [[Git]] repo management wherein developers merge small, frequent updates to a core "trunk" (main) branch as part of a [[Continuous Integration and Continuous Delivery (CI&CD)|CI/CD]] pipeline.

This simplified structure allows for a steady pace of smaller commits, enabling teams to easily utilize automated testing and smoother code review processes.

Nicely complemented by [[Feature Flags]], wrapping changes in an inactive code path to be activated at a later time. 

Best practice is to delete inactive branches after a feature has been merged. Working on a single branch maintains a single source of truth, steady software release cadence, and streamlines CI/CD pipelines. 

---

- https://www.atlassian.com/continuous-delivery/continuous-integration/trunk-based-development