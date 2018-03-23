# Delphi LiveBindings With Objects
## Overview
Delphi LiveBindings With Objects is a short exploration of ways to implement LiveBindings using objects and object lists as a data source. This Github project contains a Delphi Project Group consisting of a single project that illustrates how to display the contents of a singleton object in TLabel components as well as two collections of objects using TOBjectList<T> objects. The lists are displayed using TListView components and together form a master-detail relationship. Managing the TListView displays given the master-detail relationship is explored.

The source code conforms to a very simplified MVVM or MVC (take your pick) pattern that attempts to separate data from presentation, with Livebindings as the isolating technology. The data presented is arbitrarily created at run time in the Create constructors for the various objects used.
## Obtaining the project source code
Download or clone the files from this Github project to obtain the full source for the project. Also included are some documentation artifacts such as the license, this README file, an overview diagram of the structures involved in LiveBindings Using Objects and other forms of prose documentation. (See the DOCS folder.)
## Running the demonstration
After downloading (and unZipping the files if necessary) launch Delphi or RAD Studio. Open the project group `LiveBindings` and make the project `LiveindingObjects.exe` the active project. Run the project.
### User interface
The program displays a screen with a banner at the top and two ListView components immediately beneath their corresonding TBindNavigator components. The left-hand ListView displays the current branch list for the hypothetical company shown in the top banner. The right-hand ListView displays the current employee roster for the currently selected branch.

![Delphi LiveBindings With Objects UI](/docs/delphi livebindings with objects ui.png)

### Using the program
#### Navigation
Navigation can be achieved using the customary methods familiar to most computer users:
*	Clicking directy on an item.
*	Using up/down arrow keys
*	Using First, Previous, Next and Last buttons on the Navigators  

As the currently selected Branch item changes, note that the Employee list changes to reflect the current employees at the branch.
#### Unused or ambiguous buttons
On each BindNavigator, the four right-most buttons respond, but don't seem to do much of anything. Time did not permit exploring the possibilities for these buttons (Edit, Post, Cancel and Refresh) but they were left in the project should anyone else want to explore their possible uses.
#### Add and Delete
The remaining two buttons are Add and Delete. Clicking the Add button (+) causes a new entry to be inserted in the corresponding object list, a new branch or a new employee. The contents of the newly inserted entry is arbitrary and accomplished by the Create function for the object; each new instance will be the same as all other newly inserted instances with the exception that a serial number is added to enable the identification of unique instance insertions.

The Delete button (-) prompts the user to confirm the delete and then deletes the corresponding currently selected entry. If a branch is deleted, all of its employees are deleted as well.
## Additional information
The program was developed using RAD Studio Tokyo 10.2.2. It has not been tried with any other version of Delphi or RAD Studio.

The program is intended to be a Windows desktop application. Hence, it has not been tested on any other devices such as Android or iOS tablets or phones.

The source code of the program contains extensive comments, perhaps to the point of obsession. However, the intention was to convey substantial explanations related to the structure and specific coding used.

For more comprehensive explanations, see the blog entry at {Link to be posted when blog entry is complete.}.
