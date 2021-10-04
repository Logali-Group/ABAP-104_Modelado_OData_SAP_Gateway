class ZCL_ZV4_BILLING_DPC_EXT definition
  public
  inheriting from ZCL_ZV4_BILLING_DPC
  create public .

public section.
protected section.

  methods INVOICEHEADERSET_READ_LIST
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZV4_BILLING_DPC_EXT IMPLEMENTATION.


  METHOD invoiceheaderset_read_list.
**TRY.
*CALL METHOD SUPER->INVOICEHEADERSET_READ_LIST
*  EXPORTING
*    IO_REQUEST  =
*    IO_RESPONSE =
*    .
**  CATCH /iwbep/cx_gateway.
**ENDTRY.
*    DATA ls_todo_list           TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_list.

*    SELECT * FROM zinvoice_header INTO TABLE @DATA(lt_header).
*
*    IF sy-subrc EQ 0.
*      io_response->set_busi_data( it_busi_data = lt_header ).
*
*
*
*      data(ls_todo_list) = VALUE /iwbep/if_v4_requ_basic_create=>ty_s_todo_process_list( busi_data = abap_true ).
**      ls_todo_list-return = VALUE /iwbep/if_v4_requ_basic_create=>ty_s_todo_return_list( busi_data = abap_true ).
*
*      io_response->set_is_done( is_todo_list = value #(  ) ).
**      CATCH /iwbep/cx_gateway. " SAP Gateway Exception
**       CATCH /iwbep/cx_gateway. " SAP Gateway Exception
***       CATCH /iwbep/cx_gateway. " SAP Gateway Exception
*    ENDIF.

  ENDMETHOD.
ENDCLASS.
