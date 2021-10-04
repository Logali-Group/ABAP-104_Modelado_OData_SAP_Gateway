@AbapCatalog.sqlViewName: 'ZVCFLIGHTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flights'
define view zc_flights
  as select from zsflight as Sflight
    inner join   zspfli   as Spfli on  Spfli.carrid = Sflight.carrid
                                   and Spfli.connid = Sflight.connid
  association [0..1] to zc_scarr as _Scarr on _Scarr.Carrid = $projection.Carrid
{
  key Sflight.carrid as Carrid,
  key Sflight.connid as Connid,
  key fldate         as Fldate,
      Spfli.airpfrom as Airpfrom,
      Spfli.airpto   as Airpto,
      price          as Price,
      currency       as Currency,
      planetype      as Planetype,
      seatsmax       as Seatsmax,
      seatsocc       as Seatsocc,
      paymentsum     as Paymentsum,
      seatsmax_b     as SeatsmaxB,
      seatsocc_b     as SeatsoccB,
      seatsmax_f     as SeatsmaxF,
      seatsocc_f     as SeatsoccF,
      _Scarr
}
