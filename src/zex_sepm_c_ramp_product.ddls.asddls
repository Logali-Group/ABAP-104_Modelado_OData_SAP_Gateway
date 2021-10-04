@AbapCatalog.sqlViewAppendName: 'ZZ_SEPM_C_RAMP'
@EndUserText.label: 'Extesion for SEPM_C_RAMP_Product'
extend view SEPM_C_RAMP_Product with ZEX_SEPM_C_RAMP_Product 
{
    Supplier._PrimaryContactPerson.FullName
}
