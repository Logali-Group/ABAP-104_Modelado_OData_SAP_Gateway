CLASS zcl_zsaleso_list_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zsaleso_list_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS salesordersset_get_entityset REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zsaleso_list_dpc_ext IMPLEMENTATION.

  METHOD salesordersset_get_entityset.

************************************
*     INSIDE-OUT
************************************
*    DATA: ls_maxrows     TYPE          bapi_epm_max_rows,
*          lt_header_data TYPE TABLE OF bapi_epm_so_header.
*
*    ls_maxrows-bapimaxrow = 100.
*
*    CALL FUNCTION 'BAPI_EPM_SO_GET_LIST'
*      EXPORTING
*        max_rows     = ls_maxrows
*      TABLES
*        soheaderdata = lt_header_data.
*
*    et_entityset[] = lt_header_data[].

************************************
*     OUTSIDE-IN
************************************
    DATA:
      lv_max_rows             TYPE if_epm_bo=>ty_query_max_rows VALUE 100,
      lt_epm_so_id_range      TYPE if_epm_so_header=>tt_sel_par_header_ids,
      lt_epm_buyer_name_range TYPE if_epm_so_header=>tt_sel_par_company_names,
      lt_epm_product_id_range TYPE if_epm_so_header=>tt_sel_par_product_ids,
      lt_epm_so_header_data   TYPE if_epm_so_header=>tt_node_data.

    TRY.
        " EPM SO header and item node
        DATA(li_epm_so_header) = CAST if_epm_so_header( cl_epm_service_facade=>get_bo( if_epm_so_header=>gc_bo_name ) ).
        DATA(li_message_buffer) = CAST if_epm_message_buffer( cl_epm_service_facade=>get_message_buffer( ) ).

        " EPM SO header data according to given selection criteria
        li_epm_so_header->query_by_header(
          EXPORTING
            it_sel_par_header_ids    = lt_epm_so_id_range[]
            it_sel_par_company_names = lt_epm_buyer_name_range[]
            it_sel_par_product_ids   = lt_epm_product_id_range[]
            iv_max_rows              = lv_max_rows
          IMPORTING
             et_data                 = lt_epm_so_header_data[] ).

        et_entityset = CORRESPONDING #( lt_epm_so_header_data ).

      CATCH cx_epm_exception INTO DATA(lo_epm_exception).

    ENDTRY.


  ENDMETHOD.

ENDCLASS.
