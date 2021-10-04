@AbapCatalog.sqlViewName: 'ZVPMBOPF_SCARR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Scarr - BOPF'
@ObjectModel: { 
   usageType.dataClass: #TRANSACTIONAL,
   modelCategory: #BUSINESS_OBJECT,
   writeActivePersistence: 'zscarr_pm_bopf',
   semanticKey: ['carrid'],
   transactionalProcessingEnabled: true,
   compositionRoot: true,
   createEnabled: true,
   deleteEnabled: true,
   updateEnabled: true
}
define view zi_scarr_pm_bopf
  as select from zscarr_pm_bopf
{
  @ObjectModel.readOnly: true
  key bopfkey  as Bopfkey,
      carrid   as Carrid,
      carrname as Carrname,
      currcode as Currcode,
      url      as Url
}
