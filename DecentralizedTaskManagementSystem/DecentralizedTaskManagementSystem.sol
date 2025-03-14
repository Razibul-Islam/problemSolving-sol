// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITaskManager {
    struct Task {
        uint256 taskId;
        string description;
        address assignTo;
        uint256 deadLine;
        bool isComplete;
    }

    function createTask(
        string memory _disc,
        address _assignTo,
        uint256 _deadline
    ) external;

    function updateTask(string memory _disc, uint256 _taskId) external;

    function markTaskCompleted(uint256 _taskId) external;

    function getAllTasks() external view returns (Task[] memory);

    function deleteTask(uint256 _taskId) external;
}

contract TaskManager is ITaskManager {
    address private owner;

    constructor(){
        owner = msg.sender;
    }

    mapping(uint256 => Task) private tasks;

    uint256[] private taskIds;

    event taskCreated(
        uint256 taskId,
        string description,
        address assignTo,
        uint256 deadLine
    );
    event taskUpdate(uint256 taskId, string _disc);

    modifier checkTask(uint256 taskId) {
        bool exits = false;
        for (uint256 i = 0; i < taskIds.length; i++) {
            if (taskIds[i] == taskId) {
                exits = true;
                break;
            }
        }
        require(exits, "There is no task With This ID");
        _;
    }

    uint256 nextTaskId = 1;

    function createTask(
        string memory _disc,
        address _assignTo,
        uint256 _deadline
    ) external override {
        require(_assignTo != address(0), "This is not valid Address");
        require(
            _deadline > block.timestamp,
            "Dead Line must be an future number"
        );

        uint256 taskId = nextTaskId++;
        tasks[taskId] = Task(taskId, _disc, _assignTo, _deadline, false);
        taskIds.push(taskId);

        emit taskCreated(taskId, _disc, _assignTo, _deadline);
    }

    function updateTask(string memory _disc, uint256 _taskId)
        external
        override
        checkTask(_taskId)
    {
        require(!tasks[_taskId].isComplete,"Task is already completed");
        require(bytes(_disc).length >= 50,"Must be 50 words");
        tasks[_taskId].description = _disc;
    }

    function markTaskCompleted(uint256 _taskId)
        external
        override
        checkTask(_taskId)
    {
        require(!tasks[_taskId].isComplete,"Task is already completed");
        require(msg.sender == owner,"You are not the owner");
        tasks[_taskId].isComplete = true;
    }

    function getAllTasks() external view override returns (Task[] memory) {
        Task[] memory allTasks = new Task[](taskIds.length);

        for (uint256 i = 0; i < allTasks.length; i++) {
            allTasks[i] = tasks[taskIds[i]];
        }

        return allTasks;
    }

    function deleteTask(uint256 _taskId) external override checkTask(_taskId) {
        require(owner == msg.sender,"You are not the owner");

        delete tasks[_taskId];

        uint index;

        bool found = false;

        for(uint i = 0; i< taskIds.length; i++){
            if(taskIds[i]== _taskId){
                index = i;
                found = true;
                break ;
            }
        }

        require(found,"There is no Task by this id");

        taskIds[index] = taskIds[taskIds.length - 1];
        taskIds.pop();
        
    }
}
