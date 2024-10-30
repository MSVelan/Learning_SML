fun is_older(d1: int*int*int, d2:int*int*int) =
    if #1 d1 < #1 d2 orelse (#1 d1 = #1 d2 andalso #2 d1 < #2 d2) orelse (#1 d1 = #1 d2 andalso #2 d1 = #2 d2 andalso #3 d1 < #3 d2)
    then true
    else false;

fun number_in_month(dates: (int*int*int) list, month: int) =
    if null dates
    then 0
    else
	let
	    val date = hd dates
	    val rem_count = number_in_month(tl dates, month)
	in
	    if #2 date = month
	    then 1+rem_count
	    else rem_count
	end;
	

fun number_in_months(dates: (int*int*int) list, months: int list) =
    if null months
    then 0
    else
	number_in_month(dates, hd months) + number_in_months(dates, tl months)
							     
fun dates_in_month(dates: (int*int*int) list, month: int) =
    if null dates
    then []
    else	
	let
	    val date = hd dates
	in
	    if #2 date = month
            then date::dates_in_month(tl dates, month)
	    else
		dates_in_month(tl dates, month)
	end;

fun dates_in_months(dates: (int*int*int) list, months: int list) =
    if null months
    then []
    else
	dates_in_month(dates, hd months)@dates_in_months(dates, tl months);

fun get_nth(strs: string list, n: int) =
    if n=1
    then hd strs
    else
	
	get_nth(tl strs, n-1);

fun date_to_string(date: int*int*int) =
    let
	val day = #3 date
	val month = #2 date
	val yr = #1 date
	val months_str = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
	get_nth(months_str, month) ^ " " ^ Int.toString(day) ^ ", " ^ Int.toString(yr)
    end;

(* Please don't put semicolons unnecessarily, it can save hours of debugging ;) *)

(* This works as well..

fun date_to_string(date: int * int * int) =
    let
        val day = #3 date
        val month = #2 date
        val yr = #1 date
        val months_str = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        fun get_nth(strs: string list, n: int) =
            if n = 1
            then hd strs
            else get_nth(tl strs, n - 1)
    in
        get_nth(months_str, month) ^ " " ^ Int.toString(day) ^ ", " ^ Int.toString(yr)
    end;
*)

fun number_before_reaching_sum(sum: int, nums: int list) =
    if null nums orelse sum<=hd nums
    then 0
    else
	1+number_before_reaching_sum(sum-hd nums, tl nums)
	
fun what_month(day_of_yr: int) =
    let
	val months_str = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
	val month_days = [31,28,31,30,31,30,31,31,30,31,30,31]
    in
	get_nth(months_str, 1+number_before_reaching_sum(day_of_yr, month_days))
    end;


fun oldest(dates: (int*int*int) list) =
    if null dates
    then NONE
    else
	let
	    fun non_empty_oldest(dates: (int*int*int) list) =
		if null (tl dates)
		then hd dates
		else
		    let
			val rem_oldest = non_empty_oldest(tl dates)
		    in
			if is_older(hd dates, rem_oldest)
			then hd dates
			else rem_oldest
		    end
	in
	    SOME (non_empty_oldest(dates))
	end;


fun number_in_months_challenge(dates: (int*int*int) list, months: int list) =
    (* remove duplicates in months first and then use number_in_months function *)
    let
	fun remove_dup(months: int list) =
	    let
		fun is_dup(x: int, nums: int list) =
		    if null nums
		    then false
		    else
			x=hd nums orelse is_dup(x, tl nums)
	    in
		if null months
		then []
		else
		    let
			val ans_without_hd = remove_dup(tl months)
		    in
			if is_dup(hd months, ans_without_hd)
			then ans_without_hd
			else
			    hd months::ans_without_hd
		    end
	    end
		
	    
	val no_dup_months = remove_dup(months)
    in
	number_in_months(dates, no_dup_months) 
    end;
