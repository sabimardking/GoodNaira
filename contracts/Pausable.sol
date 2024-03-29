pragma solidity ^0.6.0;


import "./Ownable.sol";

/**
 * @title Pausable
 * @dev Base contract which allows children to implement an emergency stop mechanism.
 * Based on openzeppelin tag v1.10.0 commit: feb665136c0dae9912e08397c1a21c4af3651ef3
 * Modifications:
 * 1) Added pauser role, switched pause/unpause to be onlyPauser (6/14/2018)
 * 2) Removed whenNotPause/whenPaused from pause/unpause (6/14/2018)
 * 3) Removed whenPaused (6/14/2018)
 * 4) Switches ownable library to use zeppelinos (7/12/18)
 * 5) Remove constructor (7/13/18)
 *
 * From https://github.com/centrehq/centre-tokens
 * branch: master commit: 3ba876b5e96eec6955733e7e008d85f419ec44a5
 */

contract Pausable is Ownable{
    event Pause();
    event Unpause();
    event PauserChanged(address indexed newAddress);


    address internal pauser;
    bool internal paused;

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     */
    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    /**
     * @dev throws if called by any account other than the pauser
     */
    modifier onlyPauser() {
        require(msg.sender == pauser);
        _;
    }

    /**
     * @dev called by the owner to pause, triggers stopped state
     */
    function pause() onlyPauser public {
        paused = true;
        emit Pause();
    }

    /**
     * @dev called by the owner to unpause, returns to normal state
     */
    function unpause() onlyPauser public {
        paused = false;
        emit Unpause();
    }

    /**
     * @dev update the pauser role
     */
    function updatePauser(address _newPauser) onlyOwner public {
        require(_newPauser != address(0));
        pauser = _newPauser;
        emit PauserChanged(pauser);
    }

}
