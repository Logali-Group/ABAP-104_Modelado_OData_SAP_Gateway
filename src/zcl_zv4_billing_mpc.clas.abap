class ZCL_ZV4_BILLING_MPC definition
  public
  inheriting from /IWBEP/CL_V4_ABS_MODEL_PROV
  create public .

public section.

  types:
     TS_INVOICEHEADER type ZINVOICE_HEADER .
  types:
     TT_INVOICEHEADER type standard table of TS_INVOICEHEADER .
  types:
     TS_INVOICEITEMS type ZINVOICE_ITEMS .
  types:
     TT_INVOICEITEMS type standard table of TS_INVOICEITEMS .

  methods /IWBEP/IF_V4_MP_BASIC~DEFINE
    redefinition .
protected section.
private section.

  methods DEFINE_INVOICEHEADER
    importing
      !IO_MODEL type ref to /IWBEP/IF_V4_MED_MODEL
    raising
      /IWBEP/CX_GATEWAY .
  methods DEFINE_INVOICEITEMS
    importing
      !IO_MODEL type ref to /IWBEP/IF_V4_MED_MODEL
    raising
      /IWBEP/CX_GATEWAY .
ENDCLASS.



CLASS ZCL_ZV4_BILLING_MPC IMPLEMENTATION.


  method /IWBEP/IF_V4_MP_BASIC~DEFINE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZV4_BILLING_MPC_EXT
*&-----------------------------------------------------------------------------------------------*
  define_invoiceheader( io_model ).
  define_invoiceitems( io_model ).
  endmethod.


  method DEFINE_INVOICEHEADER.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZV4_BILLING_MPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lo_entity_type    TYPE REF TO /iwbep/if_v4_med_entity_type.
 DATA lo_property       TYPE REF TO /iwbep/if_v4_med_prim_prop.
 DATA lo_entity_set     TYPE REF TO /iwbep/if_v4_med_entity_set.
 DATA lo_nav_prop       TYPE REF TO /iwbep/if_v4_med_nav_prop.
 DATA lv_INVOICEHEADER  TYPE zinvoice_header.
***********************************************************************************************************************************
*   ENTITY - InvoiceHeader
***********************************************************************************************************************************
 lo_entity_type = io_model->create_entity_type_by_struct( iv_entity_type_name = 'INVOICEHEADER' is_structure = lv_INVOICEHEADER
                                                          iv_add_conv_to_prim_props = abap_true ). "#EC NOTEXT

 lo_entity_type->set_edm_name( 'InvoiceHeader' ).           "#EC NOTEXT

***********************************************************************************************************************************
*   Properties
***********************************************************************************************************************************
 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'INVOICE_ID' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'InvoiceId' ).                  "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_is_key( ).
 lo_property->set_max_length( iv_max_length = '10' ).       "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'CREATION_DATE' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'CreationDate' ).               "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Date' ).         "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'AMOUNT' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'Amount' ).                     "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Decimal' ).      "#EC NOTEXT
 lo_property->set_precision( iv_precision = '23' ).         "#EC NOTEXT
 lo_property->set_scale( iv_scale = '4' ).                  "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'DESCRIPTION' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'Description' ).                "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '40' ).       "#EC NOTEXT


***********************************************************************************************************************************
*   Navigation Properties
***********************************************************************************************************************************
 lo_nav_prop = lo_entity_type->create_navigation_property( iv_property_name = 'HEADERTOITEMS' ). "#EC NOTEXT
 lo_nav_prop->set_edm_name( 'Items' ).                      "#EC NOTEXT
 lo_nav_prop->set_target_entity_type_name( 'INVOICEITEMS' ).
 lo_nav_prop->set_target_multiplicity( 'N' ).
 lo_nav_prop->set_on_delete_action( 'None' ).               "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
 lo_entity_set = lo_entity_type->create_entity_set( 'INVOICEHEADERSET' ). "#EC NOTEXT
 lo_entity_set->set_edm_name( 'InvoiceHeaderSet' ).         "#EC NOTEXT

 lo_entity_set->add_navigation_prop_binding( iv_navigation_property_path = 'HEADERTOITEMS'
                                                              iv_target_entity_set = 'INVOICEITEMSSET' ). "#EC NOTEXT
  endmethod.


  method DEFINE_INVOICEITEMS.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 07.08.2021 08:12:53 in client 001
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZV4_BILLING_MPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA lo_entity_type    TYPE REF TO /iwbep/if_v4_med_entity_type.
 DATA lo_property       TYPE REF TO /iwbep/if_v4_med_prim_prop.
 DATA lo_entity_set     TYPE REF TO /iwbep/if_v4_med_entity_set.
 DATA lv_INVOICEITEMS  TYPE zinvoice_items.
***********************************************************************************************************************************
*   ENTITY - InvoiceItems
***********************************************************************************************************************************
 lo_entity_type = io_model->create_entity_type_by_struct( iv_entity_type_name = 'INVOICEITEMS' is_structure = lv_INVOICEITEMS
                                                          iv_add_conv_to_prim_props = abap_true ). "#EC NOTEXT

 lo_entity_type->set_edm_name( 'InvoiceItems' ).            "#EC NOTEXT

***********************************************************************************************************************************
*   Properties
***********************************************************************************************************************************
 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'ITEM_ID' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'ItemId' ).                     "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_is_key( ).
 lo_property->set_max_length( iv_max_length = '10' ).       "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'INVOICE_ID' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'InvoiceId' ).                  "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '10' ).       "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'QUANTITY' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'Quantity' ).                   "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Decimal' ).      "#EC NOTEXT
 lo_property->set_precision( iv_precision = '18' ).         "#EC NOTEXT
 lo_property->set_scale( iv_scale = '5' ).                  "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'PRICE' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'Price' ).                      "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'Decimal' ).      "#EC NOTEXT
 lo_property->set_precision( iv_precision = '23' ).         "#EC NOTEXT
 lo_property->set_scale( iv_scale = '10' ).                 "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'DESCRIPTION' ). "#EC NOTEXT
 lo_property->set_add_annotations( abap_true ).
 lo_property->set_edm_name( 'Description' ).                "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '40' ).       "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
 lo_entity_set = lo_entity_type->create_entity_set( 'INVOICEITEMSSET' ). "#EC NOTEXT
 lo_entity_set->set_edm_name( 'InvoiceItemsSet' ).          "#EC NOTEXT
  endmethod.
ENDCLASS.
