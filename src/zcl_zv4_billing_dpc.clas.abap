class ZCL_ZV4_BILLING_DPC definition
  public
  inheriting from /IWBEP/CL_V4_ABS_DATA_PROVIDER
  create public .

public section.

  methods /IWBEP/IF_V4_DP_BASIC~READ_ENTITY_LIST
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~CREATE_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~READ_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~UPDATE_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~DELETE_ENTITY
    redefinition .
  methods /IWBEP/IF_V4_DP_BASIC~READ_REF_TARGET_KEY_DATA_LIST
    redefinition .
protected section.

  methods INVOICEHEADERSET_CREATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_CREATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_CREATE
    raising
      /IWBEP/CX_GATEWAY .
  methods INVOICEHEADERSET_DELETE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_DELETE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_DELETE
    raising
      /IWBEP/CX_GATEWAY .
  methods INVOICEHEADERSET_READ
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_READ
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_READ
    raising
      /IWBEP/CX_GATEWAY .
  methods INVOICEHEADERSET_READ_LIST
    importing
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_LIST
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_LIST
    raising
      /IWBEP/CX_GATEWAY .
  methods INVOICEHEADERSET_UPDATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_UPDATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_UPDATE
    raising
      /IWBEP/CX_GATEWAY .
  methods INVOICEHEADE_READ_REF_KEY_LIST
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_REF_L
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_REF_L
    raising
      /IWBEP/CX_GATEWAY .
  methods INVOICEITEMSSET_CREATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_CREATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_CREATE
    raising
      /IWBEP/CX_GATEWAY .
  methods INVOICEITEMSSET_DELETE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_DELETE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_DELETE
    raising
      /IWBEP/CX_GATEWAY .
  methods INVOICEITEMSSET_READ
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_READ
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_READ
    raising
      /IWBEP/CX_GATEWAY .
  methods INVOICEITEMSSET_READ_LIST
    importing
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_LIST
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_LIST
    raising
      /IWBEP/CX_GATEWAY .
  methods INVOICEITEMSSET_UPDATE
    importing
      !IO_RESPONSE type ref to /IWBEP/IF_V4_RESP_BASIC_UPDATE
      !IO_REQUEST type ref to /IWBEP/IF_V4_REQU_BASIC_UPDATE
    raising
      /IWBEP/CX_GATEWAY .
private section.
ENDCLASS.



CLASS ZCL_ZV4_BILLING_DPC IMPLEMENTATION.


  method /IWBEP/IF_V4_DP_BASIC~CREATE_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&* This class has been generated  on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

  CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceHeaderSet
*-------------------------------------------------------------------------*
    WHEN 'INVOICEHEADERSET'.
*     Call the entity set generated method
      invoiceheaderset_create(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceItemsSet
*-------------------------------------------------------------------------*
    WHEN 'INVOICEITEMSSET'.
*     Call the entity set generated method
      invoiceitemsset_create(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~create_entity( io_request  = io_request
                                                  io_Response = io_response ).
  ENDCASE.
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~DELETE_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&* This class has been generated  on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside the DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

  CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceHeaderSet
*-------------------------------------------------------------------------*
    WHEN 'INVOICEHEADERSET'.
*     Call the entity set generated method
      invoiceheaderset_delete(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceItemsSet
*-------------------------------------------------------------------------*
    WHEN 'INVOICEITEMSSET'.
*     Call the entity set generated method
      invoiceitemsset_delete(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~delete_entity( io_request  = io_request
                                                  io_response = io_response ).
  ENDCASE.
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~READ_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&* This class has been generated  on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

  CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceHeaderSet
*-------------------------------------------------------------------------*
    WHEN 'INVOICEHEADERSET'.
*     Call the entity set generated method
      invoiceheaderset_read(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceItemsSet
*-------------------------------------------------------------------------*
    WHEN 'INVOICEITEMSSET'.
*     Call the entity set generated method
      invoiceitemsset_read(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~read_entity( io_request  = io_request
                                                io_response = io_response ).


  ENDCASE.
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~READ_ENTITY_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

  CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceHeaderSet
*-------------------------------------------------------------------------*
    WHEN 'INVOICEHEADERSET'.
*     Call the entity set generated method
      invoiceheaderset_read_list(
        EXPORTING
          io_request  = io_request
          io_response = io_response
       ).
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceItemsSet
*-------------------------------------------------------------------------*
    WHEN 'INVOICEITEMSSET'.
*     Call the entity set generated method
      invoiceitemsset_read_list(
        EXPORTING
          io_request  = io_request
          io_response = io_response
       ).
    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~read_entity_list( io_Request  = io_request
                                                     io_response = io_response ).
  ENDCASE.
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~READ_REF_TARGET_KEY_DATA_LIST.
*&-----------------------------------------------------------------------------------------------*
*&* This class has been generated  on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC provider subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_source_entity_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_source_entity_type( IMPORTING ev_source_entity_type_name = lv_source_entity_name ).

  CASE lv_source_entity_name.
*-------------------------------------------------------------------------*
*             Entity -  InvoiceHeader
*-------------------------------------------------------------------------*
    WHEN 'INVOICEHEADER'.
*     Call the entity type generated method
      invoiceheade_read_ref_key_list(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~read_ref_target_key_data_list( io_request  = io_request
                                                                  io_response = io_response ).
  ENDCASE.
  endmethod.


  method /IWBEP/IF_V4_DP_BASIC~UPDATE_ENTITY.
*&-----------------------------------------------------------------------------------------------*
*&* This class has been generated  on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA lv_entityset_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

  io_request->get_entity_set( IMPORTING ev_entity_set_name = lv_entityset_name ).

  CASE lv_entityset_name.
*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceHeaderSet
*-------------------------------------------------------------------------*
    WHEN 'INVOICEHEADERSET'.
*     Call the entity set generated method
      invoiceheaderset_update(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

*-------------------------------------------------------------------------*
*             EntitySet -  InvoiceItemsSet
*-------------------------------------------------------------------------*
    WHEN 'INVOICEITEMSSET'.
*     Call the entity set generated method
      invoiceitemsset_update(
           EXPORTING io_request  = io_request
                     io_response = io_response
                       ).

    WHEN OTHERS.
      super->/iwbep/if_v4_dp_basic~update_entity( io_request  = io_request
                                                  io_response = io_Response ).
  ENDCASE.
  endmethod.


  method INVOICEHEADERSET_CREATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_invoiceheader  TYPE zcl_zv4_billing_mpc=>ts_invoiceheader.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method INVOICEHEADERSET_DELETE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_invoiceheader TYPE zcl_zv4_billing_mpc=>ts_invoiceheader.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method INVOICEHEADERSET_READ.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_invoiceheader TYPE zcl_zv4_billing_mpc=>ts_invoiceheader.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method INVOICEHEADERSET_READ_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA lt_invoiceheader TYPE zcl_zv4_billing_mpc=>tt_invoiceheader.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method INVOICEHEADERSET_UPDATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_invoiceheader TYPE zcl_zv4_billing_mpc=>ts_invoiceheader.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method INVOICEHEADE_READ_REF_KEY_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_ref_l=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_ref_l=>ty_s_todo_process_list.
  DATA lv_nav_property_name TYPE /iwbep/if_v4_med_element=>ty_e_med_internal_name.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

  io_request->get_navigation_prop( IMPORTING ev_navigation_prop_name = lv_nav_property_name ).

  CASE lv_nav_property_name.
    WHEN 'HEADERTOITEMS'.
    WHEN OTHERS.
  ENDCASE.

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method INVOICEITEMSSET_CREATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_invoiceitems  TYPE zcl_zv4_billing_mpc=>ts_invoiceitems.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_create=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method INVOICEITEMSSET_DELETE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_invoiceitems TYPE zcl_zv4_billing_mpc=>ts_invoiceitems.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_delete=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method INVOICEITEMSSET_READ.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_invoiceitems TYPE zcl_zv4_billing_mpc=>ts_invoiceitems.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_read=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method INVOICEITEMSSET_READ_LIST.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA lt_invoiceitems TYPE zcl_zv4_billing_mpc=>tt_invoiceitems.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.


  method INVOICEITEMSSET_UPDATE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the DPC implementation, use the
*&*   generated methods inside DPC subclass - ZCL_ZV4_BILLING_DPC_EXT
*&-----------------------------------------------------------------------------------------------*

*Used for setting business data
*  DATA ls_invoiceitems TYPE zcl_zv4_billing_mpc=>ts_invoiceitems.

  DATA ls_todo_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_list. "#EC NEEDED
  DATA ls_done_list TYPE /iwbep/if_v4_requ_basic_update=>ty_s_todo_process_list.

* Get the request options the application should/must handle
  io_request->get_todos( IMPORTING es_todo_list = ls_todo_list ).

* Report list of request options handled by application
  io_response->set_is_done( ls_done_list ).
  endmethod.
ENDCLASS.
