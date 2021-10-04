@AbapCatalog.sqlViewName: 'ZCPMBOPF_SCARR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Scarr - BOPF'
@ObjectModel: {
  transactionalProcessingDelegated: true,
  compositionRoot: true,
  createEnabled: true,
  deleteEnabled: true,
  updateEnabled: true,
  semanticKey: 'carrid'
}
@OData.publish: true
define view zc_scarr_pm_bopf
  as select from zi_scarr_pm_bopf
{
  key Bopfkey,
      Carrid,
      Carrname,
      Currcode,
      Url
}
