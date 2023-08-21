import zns_registry.leo;

program zns_registrar.aleo {
    mapping authorized : address => bool;
    mapping operators : u128 => address;
    mapping num_operators : bool => u128;

    transition constructor(){
        return then finalize(self.caller);
    }
    finalize constructor(caller : address){
        authorized.set(caller, true);
        operators.set(0, caller);
        num_operators.set(true,1);
    }

    transition request_operator(public new_operator : address) -> ans_registry.leo/operatorCert{
        //Only the owner can call this function!
        let tld : u128 = 1u128;
        let name : u128 = 1u128;
        let subname : u128 = 0u128;
        return ans_registry.leo/request_operator_cert(new_operator,tld,subname) then finalize(new_operator);
    }
    finalize request_operator(public new_operator : address){
        authorized_users.set(new_operator, true);
        let current : u128 = num_operators.get(true);
        let new : u128 = current + 1u128;
        num_operators.set(true, new);
        operators.set(new, new_operators);
    }
}
