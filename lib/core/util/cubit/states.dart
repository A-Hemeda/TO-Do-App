abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppDataBaseInitialized extends AppStates {}

class AppDataBaseTableCreated extends AppStates {}

class AppDataBaseOpened extends AppStates {}

class AppDataBaseTaskCreated extends AppStates {}

class AppDataBaseTasks extends AppStates {}

class AppDataBaseLoading extends AppStates {}

class AppSelectTask extends AppStates {}

class TaskUpdateDone extends AppStates{}

class CheckedBoxState extends AppStates{}
