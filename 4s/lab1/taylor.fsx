let f_builtin x = (1.0 - x * x / 2.0) * cos x - x * sin x / 2.0


let rec factorial n =
    if n = 0 then 1 else n * factorial (n - 1)


let rec taylor_naive x eps n =
    let rec loop i term sum =
        if abs term < eps then
            (sum, i)
        else
            let term' = ((-1.0) ** float i) * (pown (2.0 * float i) 2 + 1.0) / float (factorial (2 * i)) * pown x (2 * i)
            loop (i + 1) term' (sum + term')
    loop 0 1.0 0.0


let taylor_smart x eps =
    let mutable sum = 1.0
    let mutable term = 1.0
    let mutable i = 1
    while abs term >= eps do
        term <- term * (-2.0 * x * x) / float (2 * i * (2 * i - 1))
        sum <- sum + term
        i <- i + 1
    (sum, i)


let print_table a b eps n =
    printfn "%-10s %-15s %-15s %-10s %-15s %-10s" "x" "Builtin" "Smart Taylor" "# terms" "Dumb Taylor" "# terms"
    for i = 0 to n do
        let x = a + (float i) / (float n) * (b - a)
        
        let builtin_result = f_builtin x
        
        let (naive_result, naive_terms) = taylor_naive x eps 0
        
        let (smart_result, smart_terms) = taylor_smart x eps
        
        printfn "%-10.2f %-15.6f %-15.6f %-10d %-15.6f %-10d" x builtin_result smart_result smart_terms naive_result naive_terms


let main =
    let a = 0.1
    let b = 0.6
    let eps = 0.0001  
    let n = 10        

    print_table a b eps n


main  
