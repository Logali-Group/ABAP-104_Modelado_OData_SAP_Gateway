@AbapCatalog.sqlViewName: 'ZCVSCARR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Scarr'
define view zc_scarr
  as select from zscarr
{
  key carrid   as Carrid,
      carrname as Carrname,
      currcode as Currcode,
      url      as Url
}
