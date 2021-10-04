CLASS zcl_zsaleso_mpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zsaleso_mpc
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS define REDEFINITION.

    TYPES: BEGIN OF ts_customer_to_orders,
             customerid           TYPE /bi0/oiobjectid,
             orderid              TYPE /bi0/oiobjectid,
             name                 TYPE /iwbep/mgw_gen_entity_set_name,
             address              TYPE /iwbep/mgw_gen_entity_set_name,
             city                 TYPE /sapquery/s_city,
             country              TYPE iw_country,
             postalcode           TYPE wdr_test_adr_postalcode,
             phone                TYPE demo_cr_telephone_number,
             CustomersToOrdersNav TYPE TABLE OF ts_orders WITH DEFAULT KEY,
           END OF ts_customer_to_orders.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zsaleso_mpc_ext IMPLEMENTATION.


  METHOD define.

    super->define(  ).

*  data(lo_entity_type) = model->get_entity_type(  iv_entity_name = 'Customers' ).
*
*  lo_entity_type->bind_structure( iv_structure_name = 'ZCL_ZSALESO_MPC_EXT=>TS_CUSTOMER_TO_ORDERS' ).

* Define Vocabulary Annotations

    DATA: lo_ann_target TYPE REF TO /iwbep/if_mgw_vocan_ann_target,
          lo_annotation TYPE REF TO /iwbep/if_mgw_vocan_annotation,
          lo_collection TYPE REF TO /iwbep/if_mgw_vocan_collection,
          lo_property   TYPE REF TO /iwbep/if_mgw_vocan_property,
          lo_record     TYPE REF TO /iwbep/if_mgw_vocan_record,
          lo_simp_value TYPE REF TO /iwbep/if_mgw_vocan_simple_val,
          lo_reference  TYPE REF TO /iwbep/if_mgw_vocan_reference.

* Annotations for entity type Orders
    lo_ann_target = vocab_anno_model->create_annotations_target( 'Orders' ).
    lo_ann_target->set_namespace_qualifier( 'ZSALESO_SRV' ). "SRV namespace

*Head Info
    lo_annotation = lo_ann_target->create_annotation( iv_term = 'UI.HeaderInfo' ).
    lo_record = lo_annotation->create_record(  ).
    lo_record->create_property( 'TypeName' )->create_simple_value(  )->set_string( 'Order' ).
    lo_record->create_property( 'TypeNamePlural' )->create_simple_value(  )->set_string( 'Orders' ).

* Columns to be diplayed by default
    lo_annotation = lo_ann_target->create_annotation( iv_term = 'UI.LineItem' ).
    lo_collection = lo_annotation->create_collection(  ).

    lo_record     =  lo_collection->create_record( iv_record_type = 'UI.DataField' ).
    lo_property   = lo_record->create_property( 'Label' ).
    lo_simp_value = lo_property->create_simple_value(  ).
    lo_simp_value->set_string( 'ID' ).
    lo_property   = lo_record->create_property( 'Value' ).
    lo_simp_value = lo_property->create_simple_value(  ).
    lo_simp_value->set_string( 'Orderid' ).

    lo_record     =  lo_collection->create_record( iv_record_type = 'UI.DataField' ).
    lo_property   = lo_record->create_property( 'Label' ).
    lo_simp_value = lo_property->create_simple_value(  ).
    lo_simp_value->set_string( 'Order Date' ).
    lo_property   = lo_record->create_property( 'Value' ).
    lo_simp_value = lo_property->create_simple_value(  ).
    lo_simp_value->set_string( 'Orderdate' ).

    lo_record     =  lo_collection->create_record( iv_record_type = 'UI.DataField' ).
    lo_property   = lo_record->create_property( 'Label' ).
    lo_simp_value = lo_property->create_simple_value(  ).
    lo_simp_value->set_string( 'Ship Date' ).
    lo_property   = lo_record->create_property( 'Value' ).
    lo_simp_value = lo_property->create_simple_value(  ).
    lo_simp_value->set_string( 'Shipdate' ).

    lo_record     =  lo_collection->create_record( iv_record_type = 'UI.DataField' ).
    lo_property   = lo_record->create_property( 'Label' ).
    lo_simp_value = lo_property->create_simple_value(  ).
    lo_simp_value->set_string( 'Ship Via' ).
    lo_property   = lo_record->create_property( 'Value' ).
    lo_simp_value = lo_property->create_simple_value(  ).
    lo_simp_value->set_string( 'Shipvia' ).

    DATA(lo_entity_files) = model->get_entity_type( iv_entity_name = 'Files' ).

    IF lo_entity_files IS BOUND.

      DATA(lo_property_files) = lo_entity_files->get_property( iv_property_name = 'Filename' ).

      lo_property_files->set_as_content_type(  ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
