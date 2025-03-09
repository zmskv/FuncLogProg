open System

let rec dichotomy_internal (f: float -> float) (a: float) (b: float) (accuracy: float) (iternum : int) : float = 
    let mid = (a + b) / 2. 
    if (b - a >= accuracy) then
        if ((f a) * (f mid) > 0) then
            dichotomy_internal f mid b accuracy (iternum + 1)
        else
            dichotomy_internal f a mid accuracy (iternum + 1)
    else
        mid

let dichotomy f a b = dichotomy_internal f a b 0.00001 0

let rec iterations_internal (phi: float -> float) (x0: float) (prev: float) (accuracy: float) (iternum: int) =
    if (Math.Abs(x0 - prev) < accuracy) then
        x0
    else
        iterations_internal phi (phi x0) x0 accuracy (iternum + 1)

let iterations phi x0 = iterations_internal phi x0 (x0 - 1.) 0.00001 0

let newton f f' x0 = 
    iterations (fun x -> x - (f x) / (f' x)) x0


let f1 (x: float) : float = Math.Exp(x) + Math.Sqrt(1.0 + Math.Exp(2.0 * x)) - 2.0
let f2 x : float = Math.Log(x) - x + 1.8
let f3 x : float = x * Math.Tan(x) - 1.0 / 3.0


let f1' x = Math.Exp(x) + (Math.Exp(2.0 * x) / Math.Sqrt(1.0 + Math.Exp(2.0 * x)))
let f2' x = 1. / x - 1.
let f3' x = Math.Tan(x) + x / (Math.Pow(Math.Cos(x), 2.0))


let phi1 (x: float) = Math.Log(2.0 - Math.Sqrt(1.0 + Math.Exp(2.0 * x)))
let phi2 (x: float) = Math.Log(x) + 1.8
let phi3 (x: float) = 1.0 / (3.0 * Math.Tan(x))


let main = 
    printfn "Equation 1: e^x + sqrt(1 + e^(2x)) - 2 = 0"
    printfn "Dichotomy: %10.5f" (dichotomy f1 -1.0 0.0)
    printfn "Iterations: %10.5f" (iterations phi1 -0.5)
    printfn "Newton: %10.5f" (newton f1 f1' -0.5)
    printfn ""

    printfn "Equation 2: ln x - x + 1.8 = 0"
    printfn "Dichotomy: %10.5f" (dichotomy f2 2.0 3.0)
    printfn "Iterations: %10.5f" (iterations phi2 2.5)
    printfn "Newton: %10.5f" (newton f2 f2' 2.5)
    printfn ""

    printfn "Equation 3: x * tan x - 1/3 = 0"
    printfn "Dichotomy: %10.5f" (dichotomy f3 0.2 1.0)
    printfn "Iterations: %10.5f" (iterations phi3 0.5)
    printfn "Newton: %10.5f" (newton f3 f3' 0.5)

main
