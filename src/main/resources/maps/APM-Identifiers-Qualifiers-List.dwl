%dw 2.0
output application/json
---
payload map (id, indexOfId) -> {
    identifier: id.label,
    qualifiers: id.qualifiers map (qual, indexOfQual) -> {
        qualifierCode: id.label ++ ": " ++ qual.code,
        qualifierLabel: qual.label,
        qualifierId: qual.id
    }
}