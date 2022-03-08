This is a disaster-relief robot using the Coppelia Robotics virtual robot software.  The full scene is not included, just the BubbleRob robot tools and commands (LUA).

This robot searches a building that is on fire for anyone still inside.  It will navigate around furniture and debris until it locates a "person" within.  While this robot does not rescue them itself, it does provide an alternate view of the situation without putting the lives of others in danger.  

The robot has three visual sensors (left, right, search), and adjusts itself when the left and right sensors reach an obstacle.  The search sensor scans for a person, and the program ends when one is located.  

Limitations: It does not house any visual map of the layout, and might run into the same loop depending on the debris.  It might not find someone if they are blocked by an obstacle and the robot adjusts away from the person.  It also does not have a heat sensor (fire is an obstacle in this case, but might be a problem if it was used in real-world scenarios).  It also does not have anything beyond a visual sensor, so smoke/other visual obstacles would be an issue.
