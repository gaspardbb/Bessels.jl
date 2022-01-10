function besselj1(x::Float32)
    x = abs(x)
    if iszero(x)
        return one(x)
    elseif isinf(x)
        return zero(x)
    end

    if x <= 2.0f0
        z = x * x
        Z1 = 1.46819706421238932572f1
        p = (z - Z1) * x * evalpoly(z, JP32)
        return p
    else
        q = inv(x)
        w = sqrt(q)
        p = w * evalpoly(q, MO132)
        w = q * q
        xn = q * evalpoly(w, PH132) - THPIO4(Float32)
        p = p * cos(xn + x)
        return p
    end
end

function besselj1(x::Float64)
    x = abs(x)
    if iszero(x)
        return one(x)
    elseif isinf(x)
        return zero(x)
    end

    if x <= 5.0
        z = x * x
        w = evalpoly(z, RP) / evalpoly(z, RQ)
        w = w * x * (z - 1.46819706421238932572e1) * (z - 4.92184563216946036703e1)
        return w
    else
        w = 5.0 / x
        z = w * w
        p = evalpoly(z, PP) / evalpoly(z, PQ)
        q = evalpoly(z, QP) / evalpoly(z, QQ)
        xn = x - THPIO4(Float64)
        p = p * cos(xn) - w * q * sin(xn)
        return p * SQ2OPI(Float64) / sqrt(x)
    end
end

function bessely1(x::Float32)
    if x <= zero(x)
        if iszero(x)
            return -Inf32
        else
            return throw(DomainError(x, "NaN result for non-NaN input."))
        end
    elseif isinf(x)
        return zero(x)
    end

    if x <= 2.0f0
        z = x * x
        YO1 =  4.66539330185668857532f0
        w = (z - YO1) * x * evalpoly(z, YP32)
        w += TWOOPI(Float32) * (besselj1(x) * log(x) - inv(x))
        return w
    else
        q = inv(x)
        w = sqrt(q)
        p = w * evalpoly(q, MO132)
        w = q * q
        xn = q * evalpoly(w, PH132) - THPIO4(Float32)
        p = p * sin(xn + x)
        return p
    end
end

function bessely1(x::Float64)
    if x <= zero(x)
        if iszero(x)
            return -Inf64
        else
            return throw(DomainError(x, "NaN result for non-NaN input."))
        end
    elseif isinf(x)
        return zero(x)
    end

    if x <= 5.0
        z = x * x
        w = x * (evalpoly(z, YP) / evalpoly(z, YQ))
        w += TWOOPI(Float64) * (besselj1(x) * log(x) - inv(x))
        return w
    else
        w = 5.0 / x
        z = w * w
        p = evalpoly(z, PP) / evalpoly(z, PQ)
        q = evalpoly(z, QP) / evalpoly(z, QQ)
        xn = x - THPIO4(Float64)
        p = p * sin(xn) + w * q * cos(xn)
        return p * SQ2OPI(Float64) / sqrt(x)
    end
end


const JP32 = (
    -3.405537384615824f-2, 1.937383947804541f-3,
    -4.541343896997497f-5, 6.009061827883699f-7,
    -4.878788132172128f-9
)


const YP32 = (
    4.202369946500099f-2, -2.641785726447862f-3,
    6.719543806674249f-5, -9.496460629917016f-7,
    8.061978323326852f-9
)


const MO132 = (
    7.978845453073848f-1, 4.976029650847191f-6,
    1.493389585089498f-1, 5.435364690523026f-3,
    -2.102302420403875f-1, 3.138238455499697f-1,
    -2.284801500053359f-1,6.913942741265801f-2,
)

const PH132 = (
    3.749989509080821f-1, -1.637986776941202f-1,
    3.503787691653334f-1, -1.544842782180211f0,
    7.222973196770240f0, -2.485774108720340f1,
    5.073465654089319f1, -4.497014141919556f1,
)

const RP = (
    3.68295732863852883286E15, -7.27494245221818276015E13,
    4.52228297998194034323E11, -8.99971225705559398224E8
)

const RQ = (
    5.32278620332680085395E18, 8.95222336184627338078E16,
    7.84369607876235854894E14, 4.74914122079991414898E12,
    2.21511595479792499675E10, 8.35146791431949253037E7,
    2.56987256757748830383E5, 6.20836478118054335476E2,
    1.00000000000000000000E0
)
const PP = (
    1.00000000000000000254E0, 5.21451598682361504063E0,
    8.42404590141772420927E0, 5.11207951146807644818E0,
    1.12719608129684925192E0, 7.31397056940917570436E-2,
    7.62125616208173112003E-4
)

const PQ = (
    9.99999999999999997461E-1, 5.20982848682361821619E0,
    8.39985554327604159757E0, 5.07386386128601488557E0,
    1.10514232634061696926E0, 6.88455908754495404082E-2,
    5.71323128072548699714E-4
)

const QP = (
    2.52070205858023719784E1, 2.11688757100572135698E2,
    5.97489612400613639965E2, 7.10856304998926107277E2,
    3.66779609360150777800E2, 7.58238284132545283818E1,
    4.98213872951233449420E0, 5.10862594750176621635E-2
)

const QQ = (
    3.36093607810698293419E2, 2.82619278517639096600E3,
    7.99704160447350683650E3, 9.56231892404756170795E3,
    4.98641058337653607651E3, 1.05644886038262816351E3,
    7.42373277035675149943E1, 1.00000000000000000000E0
)

const YP = (
    -7.78877196265950026825E17, 2.02439475713594898196E17,
    -8.12770255501325109621E15, 1.14509511541823727583E14,
    -6.47355876379160291031E11, 1.26320474790178026440E9
)
const YQ = (
    3.97270608116560655612E18, 6.87141087355300489866E16,
    6.20557727146953693363E14, 3.88231277496238566008E12,
    1.87601316108706159478E10, 7.34811944459721705660E7,
    2.35564092943068577943E5, 5.94301592346128195359E2,
    1.00000000000000000000E0
)