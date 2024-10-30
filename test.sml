(* This is a comment. Our first prg starts here. *)
val x = 34;
val y = 17;
val z = x+y;
val abs_of_z = if z<0 then ~z else z;

(* Let expressions *)
fun f(z : int)=
    let
	val x = 1+z
	val y = if z>0 then 2 else 1
    in
	(let val x = 3 in x+1 end) + (let val y=x+1 in y+1 end)
    end;

(* Nested functions *)
fun countUpFromOne(x : int) =
    let
	fun count(from: int, to: int) =
	    if from>to
	    then []
	    else (
		if from=to
		then to::[]
		else from::count(from+1, to)
	    );			      
    in
	count(1,x)
    end
