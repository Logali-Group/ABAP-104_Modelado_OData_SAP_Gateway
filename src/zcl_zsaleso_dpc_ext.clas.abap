CLASS zcl_zsaleso_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zsaleso_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: /iwbep/if_mgw_appl_srv_runtime~execute_action         REDEFINITION,
      /iwbep/if_mgw_appl_srv_runtime~get_expanded_entityset REDEFINITION,
      /iwbep/if_mgw_appl_srv_runtime~create_deep_entity     REDEFINITION,

      /iwbep/if_mgw_appl_srv_runtime~changeset_begin        REDEFINITION,
      /iwbep/if_mgw_appl_srv_runtime~changeset_process      REDEFINITION,
      /iwbep/if_mgw_appl_srv_runtime~changeset_end          REDEFINITION,

      /iwbep/if_mgw_appl_srv_runtime~create_stream          REDEFINITION,
      /iwbep/if_mgw_appl_srv_runtime~get_stream             REDEFINITION,
      /iwbep/if_mgw_appl_srv_runtime~update_stream          REDEFINITION,
      /iwbep/if_mgw_appl_srv_runtime~delete_stream          REDEFINITION.

  PROTECTED SECTION.

    METHODS: customersset_create_entity REDEFINITION,
      customersset_get_entity           REDEFINITION,
      customersset_get_entityset        REDEFINITION,
      customersset_update_entity        REDEFINITION,
      customersset_delete_entity        REDEFINITION,

      ordersset_create_entity    REDEFINITION,
      ordersset_get_entity       REDEFINITION,
      ordersset_get_entityset    REDEFINITION,
      ordersset_update_entity    REDEFINITION,
      ordersset_delete_entity    REDEFINITION,

      paymentsset_create_entity  REDEFINITION,
      paymentsset_get_entity     REDEFINITION,
      paymentsset_get_entityset  REDEFINITION,
      paymentsset_update_entity  REDEFINITION,
      paymentsset_delete_entity  REDEFINITION,

      filesset_get_entityset     REDEFINITION.

  PRIVATE SECTION.

    METHODS: order_data IMPORTING iv_entity_name TYPE string
                                  it_order       TYPE /iwbep/t_mgw_sorting_order
                        EXPORTING et_entityset   TYPE table
                        RAISING   /iwbep/cx_mgw_busi_exception.

ENDCLASS.



CLASS zcl_zsaleso_dpc_ext IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_begin.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_end.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~changeset_process.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_deep_entity.

    DATA: ls_deep_entity TYPE          zcl_zsaleso_mpc_ext=>ts_customer_to_orders,
          ls_customers   TYPE          zcustomers,
          lt_orders      TYPE TABLE OF zorders.


    CASE iv_entity_set_name.

      WHEN 'CustomersSet'.


        io_data_provider->read_entry_data( IMPORTING es_data = ls_deep_entity ).

        ls_customers = CORRESPONDING #( ls_deep_entity ).

        lt_orders = VALUE #(  FOR <ls_orders> IN ls_deep_entity-customerstoordersnav (
                                     orderid        = <ls_orders>-orderid
                                     customerid     = <ls_orders>-customerid
                                     paymentid      = <ls_orders>-paymentid
                                     orderdate      = <ls_orders>-orderdate
                                     shipdate       = <ls_orders>-shipdate
                                     shipvia        = <ls_orders>-shipvia
                                     city           = <ls_orders>-shipaddress-city
                                     street         = <ls_orders>-shipaddress-street
                                     postalcode     = <ls_orders>-shipaddress-postalcode
                                     buildnumber    = <ls_orders>-shipaddress-buildnumber
                                     country        = <ls_orders>-shipaddress-country
                                     documentorder  = <ls_orders>-documentorder
                                  ) ).


        INSERT zcustomers FROM ls_customers.

        IF sy-subrc EQ 0.

          INSERT zorders FROM TABLE lt_orders.

          IF sy-subrc EQ 0.
            copy_data_to_ref( EXPORTING is_data = ls_deep_entity
                              CHANGING cr_data  = er_deep_entity ).
          ELSE.
            DATA(lv_exception) = abap_true.
          ENDIF.
        ELSE.
          lv_exception = abap_true.
        ENDIF.

    ENDCASE.

    CHECK lv_exception EQ abap_true.

    DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                          msgno = '002'
                                          attr1 = 'CREATE DEEP ENTITY error' ).

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid = ls_message.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~create_stream.

    CASE iv_entity_name.

      WHEN 'Files'.

*        DATA(lo_facade) = me->/iwbep/if_mgw_conv_srv_runtime~get_dp_facade(  ).
*        DATA(lt_client_header) = lo_facade->get_request_header(  ).

        DATA(ls_files) = VALUE zfile( filename = iv_slug
                                      value    = is_media_resource-value
                                      mimetype = is_media_resource-mime_type
                                      sydate   = sy-datum
                                      sytime   = sy-uzeit ).

        INSERT INTO zfile VALUES ls_files.

        IF sy-subrc EQ 0.

          me->copy_data_to_ref( EXPORTING is_data = ls_files
                                CHANGING  cr_data = er_entity ).

        ENDIF.

    ENDCASE.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~execute_action.

    CASE iv_action_name.

      WHEN 'PaymentStatus'.

        DATA(lv_paymentid) = it_parameter[ name = 'Paymentid' ]-value.
        DATA(lv_status) = it_parameter[ name = 'Status' ]-value.

        IF NOT lv_paymentid IS INITIAL.

          UPDATE zpayments SET status = @lv_status,
                               dateor = @sy-datum
                 WHERE paymentid EQ @lv_paymentid.

          IF sy-subrc EQ 0.

            DATA(ls_entity) = VALUE zcl_zsaleso_mpc=>ts_payments( status = lv_status
                                                                  paymentid = lv_paymentid
                                                                  dateor = sy-datum ).

            me->copy_data_to_ref( EXPORTING is_data = ls_entity
                                  CHANGING cr_data = er_data ).

          ELSE.

          ENDIF.

        ENDIF.

    ENDCASE.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_expanded_entityset.

    CASE iv_entity_set_name.

      WHEN 'CustomersSet'.

        SELECT FROM zcustomers FIELDS *
            INTO TABLE @DATA(lt_customers).

        IF sy-subrc EQ 0.
          copy_data_to_ref( EXPORTING is_data = lt_customers
                            CHANGING  cr_data = er_entityset ).
        ENDIF.

      WHEN 'OrdersSet'.

        DATA(lv_customerid) = it_key_tab[ name = 'Customerid' ]-value.

        SELECT FROM zorders FIELDS *
             WHERE customerid EQ @lv_customerid
             INTO TABLE @DATA(lt_orders).

        IF sy-subrc EQ 0.
          copy_data_to_ref( EXPORTING is_data = lt_orders
                            CHANGING  cr_data = er_entityset ).
        ENDIF.

    ENDCASE.

  ENDMETHOD.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_stream.

    DATA(lv_filename) = it_key_tab[ name = 'Filename' ]-value.

    SELECT SINGLE FROM zfile
           FIELDS value, mimetype
           WHERE filename EQ @lv_filename
           INTO @DATA(ls_file).

    IF sy-subrc EQ 0.

      DATA(ls_stream) = VALUE ty_s_media_resource( value = ls_file-value
                                                   mime_type = ls_file-mimetype ).

      me->copy_data_to_ref( EXPORTING is_data = ls_stream
                            CHANGING  cr_data = er_stream ).

    ENDIF.


  ENDMETHOD.

  METHOD /iwbep/if_mgw_appl_srv_runtime~update_stream.

    DATA(lv_filename) = it_key_tab[ name = 'Filename' ]-value.

    UPDATE zfile
           SET value    = @is_media_resource-value,
               mimetype = @is_media_resource-mime_type
           WHERE filename EQ @lv_filename.

    IF sy-subrc NE 0.

      DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                                  msgno = '002'
                                                  attr1 = 'Stream not updated' ).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid = ls_message.

    ENDIF.

  ENDMETHOD.

  METHOD /iwbep/if_mgw_appl_srv_runtime~delete_stream.

    DATA(lv_filename) = it_key_tab[ name = 'Filename' ]-value.

    DELETE FROM zfile WHERE filename EQ @lv_filename.

    IF sy-subrc NE 0.

      DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                            msgno = '002'
                                            attr1 = 'Stream not deleted' ).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid = ls_message.

    ENDIF.

  ENDMETHOD.
  METHOD customersset_create_entity.

    DATA ls_customers TYPE zcustomers.

    io_data_provider->read_entry_data( IMPORTING es_data = ls_customers ).

    INSERT zcustomers FROM ls_customers.

    IF sy-subrc EQ 0.
      er_entity = ls_customers.
    ELSE.

      DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                            msgno = '002'
                                            attr1 = 'INSERT error' ).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid = ls_message.

    ENDIF.

  ENDMETHOD.


  METHOD customersset_delete_entity.

    DATA(lv_customerid) = it_key_tab[ name = 'Customerid' ]-value.

*    DATA(lt_keys) = io_tech_request_context->get_keys(  ).
*    DATA(lv_custmerid_temp) = lt_keys[ name = 'CUSTOMERID' ]-value.

    DELETE FROM zcustomers WHERE customerid EQ @lv_customerid.

    CHECK sy-subrc NE 0.

    DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                          msgno = '002'
                                          attr1 = 'DELETE error' ).

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid = ls_message.

  ENDMETHOD.


  METHOD customersset_get_entity.

    DATA(lv_customerid) = it_key_tab[ name = 'Customerid' ]-value.

    SELECT SINGLE FROM zcustomers
        FIELDS *
        WHERE customerid EQ @lv_customerid
        INTO @er_entity.

  ENDMETHOD.


  METHOD customersset_get_entityset.

    SELECT FROM zcustomers
        FIELDS *
        INTO TABLE @et_entityset.

    IF NOT it_order IS INITIAL.

      me->order_data(
        EXPORTING
          iv_entity_name = iv_entity_name
          it_order       = it_order
        IMPORTING
          et_entityset   = et_entityset
      ).
*     CATCH /iwbep/cx_mgw_busi_exception.

    ENDIF.

  ENDMETHOD.


  METHOD customersset_update_entity.

    DATA ls_customers_odata   TYPE zcustomers.
    DATA(lv_customerid) = it_key_tab[ name = 'Customerid' ]-value.

    SELECT SINGLE * FROM zcustomers
           WHERE customerid EQ @lv_customerid
           INTO @DATA(ls_customers_ddbb).

    IF sy-subrc EQ 0.

      io_data_provider->read_entry_data( IMPORTING es_data = ls_customers_odata ).

      DATA(ls_customers_update) = VALUE zcustomers( customerid = lv_customerid
                                                    orderid    = COND #( WHEN ls_customers_odata-orderid IS NOT INITIAL
                                                                              THEN ls_customers_odata-orderid
                                                                              ELSE ls_customers_ddbb-orderid )
                                                    name       = COND #( WHEN ls_customers_odata-name IS NOT INITIAL
                                                                              THEN ls_customers_odata-name
                                                                              ELSE ls_customers_ddbb-name )
                                                    address    = COND #( WHEN ls_customers_odata-address IS NOT INITIAL
                                                                              THEN ls_customers_odata-address
                                                                              ELSE ls_customers_ddbb-address )
                                                    city       = COND #( WHEN ls_customers_odata-city IS NOT INITIAL
                                                                              THEN ls_customers_odata-city
                                                                              ELSE ls_customers_ddbb-city )
                                                    country    = COND #( WHEN ls_customers_odata-country IS NOT INITIAL
                                                                              THEN ls_customers_odata-country
                                                                              ELSE ls_customers_ddbb-country )
                                                    postalcode = COND #( WHEN ls_customers_odata-postalcode IS NOT INITIAL
                                                                              THEN ls_customers_odata-postalcode
                                                                              ELSE ls_customers_ddbb-postalcode )
                                                    phone      = COND #( WHEN ls_customers_odata-phone IS NOT INITIAL
                                                                              THEN ls_customers_odata-phone
                                                                              ELSE ls_customers_ddbb-phone ) ).

      UPDATE zcustomers FROM ls_customers_update.

      IF sy-subrc EQ 0.
        er_entity = ls_customers_odata.
      ELSE.
        DATA(lv_exception) = abap_true.
      ENDIF.
    ELSE.
      lv_exception = abap_true.
    ENDIF.

    IF lv_exception EQ abap_true.

      DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                                msgno = '002'
                                                attr1 = 'UPDATE error' ).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid = ls_message.
    ENDIF.

  ENDMETHOD.


  METHOD filesset_get_entityset.

    SELECT FROM zfile
        FIELDS *
        INTO TABLE @et_entityset.

  ENDMETHOD.


  METHOD ordersset_create_entity.

    DATA: ls_orders     TYPE zst_orders_ct,
          ls_orders_ins TYPE zorders.

    io_data_provider->read_entry_data( IMPORTING es_data = ls_orders ).

    ls_orders_ins = VALUE #(  orderid     = ls_orders-orderid
                              customerid  = ls_orders-customerid
                              paymentid   = ls_orders-paymentid
                              orderdate   = ls_orders-orderdate
                              shipdate    = ls_orders-shipdate
                              shipvia     = ls_orders-shipvia
                              city        = ls_orders-shipaddress-city
                              street      = ls_orders-shipaddress-street
                              postalcode  = ls_orders-shipaddress-postalcode
                              buildnumber = ls_orders-shipaddress-buildnumber
                              country     = ls_orders-shipaddress-country  ).

    INSERT zorders FROM ls_orders_ins.

    IF sy-subrc EQ 0.
      er_entity = ls_orders.
    ELSE.

      DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                            msgno = '002'
                                            attr1 = 'INSERT error' ).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid = ls_message.

    ENDIF.

  ENDMETHOD.


  METHOD ordersset_delete_entity.

    DATA(lv_orderid) = it_key_tab[ name = 'Orderid' ]-value.

    DELETE FROM zorders WHERE orderid EQ @lv_orderid.

    CHECK sy-subrc NE 0.

    DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                          msgno = '002'
                                          attr1 = 'DELETE error' ).

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid = ls_message.

  ENDMETHOD.


  METHOD ordersset_get_entity.

    DATA(lv_orderid) = it_key_tab[ name = 'Orderid' ]-value.

    SELECT SINGLE FROM zorders
          FIELDS *
          WHERE orderid EQ @lv_orderid
          INTO @DATA(ls_orders).

    IF sy-subrc EQ 0.

      DATA(ls_shipaddress) = VALUE zcl_zsaleso_mpc=>ts_orders-shipaddress( city        = ls_orders-city
                                                                           street      = ls_orders-street
                                                                           postalcode  = ls_orders-postalcode
                                                                           buildnumber = ls_orders-buildnumber
                                                                           country     = ls_orders-country ).

      er_entity = VALUE #(  orderid       = ls_orders-orderid
                            customerid    = ls_orders-customerid
                            paymentid     = ls_orders-paymentid
                            orderdate     = ls_orders-orderdate
                            shipdate      = ls_orders-shipdate
                            shipvia       = ls_orders-shipvia
                            shipaddress   = ls_shipaddress
                            documentorder = ls_orders-documentorder ).
    ENDIF.

  ENDMETHOD.


  METHOD ordersset_get_entityset.

    DATA(lv_osql_where_clause) = io_tech_request_context->get_osql_where_clause(  ).

    IF NOT lv_osql_where_clause IS INITIAL.

*      REPLACE ALL OCCURRENCES OF SUBSTRING 'SHIPADDRESS-' IN lv_osql_where_clause WITH ''.

      lv_osql_where_clause = replace( val  = lv_osql_where_clause
                                      sub  = 'SHIPADDRESS-'
                                      with = '' ).

      SELECT FROM zorders
         FIELDS *
         WHERE (lv_osql_where_clause)
         INTO TABLE @DATA(lt_orders).

    ELSE.

      SELECT FROM zorders
        FIELDS *
        INTO TABLE @lt_orders.

    ENDIF.

    CHECK sy-subrc EQ 0.

    et_entityset = VALUE #( FOR ls_orders IN lt_orders (
                                orderid                 = ls_orders-orderid
                                customerid              = ls_orders-customerid
                                paymentid               = ls_orders-paymentid
                                orderdate               = ls_orders-orderdate
                                shipdate                = ls_orders-shipdate
                                shipvia                 = ls_orders-shipvia
                                shipaddress-country     = ls_orders-country
                                shipaddress-city        = ls_orders-city
                                shipaddress-street      = ls_orders-street
                                shipaddress-buildnumber = ls_orders-buildnumber
                                shipaddress-postalcode  = ls_orders-postalcode
                                documentorder           = ls_orders-documentorder   ) ).

  ENDMETHOD.


  METHOD ordersset_update_entity.

    DATA: ls_orders TYPE zst_orders_ct.

    io_data_provider->read_entry_data( IMPORTING es_data = ls_orders ).

    DATA(ls_orders_upd) = VALUE zorders(  orderid     = ls_orders-orderid
                                          customerid  = ls_orders-customerid
                                          paymentid   = ls_orders-paymentid
                                          orderdate   = ls_orders-orderdate
                                          shipdate    = ls_orders-shipdate
                                          shipvia     = ls_orders-shipvia
                                          city        = ls_orders-shipaddress-city
                                          street      = ls_orders-shipaddress-street
                                          postalcode  = ls_orders-shipaddress-postalcode
                                          buildnumber = ls_orders-shipaddress-buildnumber
                                          country     = ls_orders-shipaddress-country  ).

    UPDATE zorders FROM ls_orders_upd.

    IF sy-subrc EQ 0.
      er_entity = ls_orders.
    ELSE.

      DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                            msgno = '002'
                                            attr1 = 'UPDATE error' ).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid = ls_message.

    ENDIF.

  ENDMETHOD.


  METHOD order_data.

*    data(lo_dp_facade) = cast /iwbep/cl_mgw_dp_facade( me->/iwbep/if_mgw_conv_srv_runtime~get_dp_facade( ) ).
*
*    data(lo_model) = lo_dp_facade->/iwbep/if_mgw_dp_int_facade~get_model(  ).
*
*    data(lt_entity_props) = lo_model->get_entity_type( conv #( iv_entity_name ) )->get_properties(  ).

    TRY.

        DATA(lt_entity_props) = CAST /iwbep/cl_mgw_dp_facade( me->/iwbep/if_mgw_conv_srv_runtime~get_dp_facade( )
                                     )->/iwbep/if_mgw_dp_int_facade~get_model(
                                     )->get_entity_type( CONV #( iv_entity_name ) )->get_properties(  ).

        DATA(lt_sortorder) = VALUE abap_sortorder_tab( FOR <ls_order> IN it_order (
                                      name       = VALUE #( lt_entity_props[ name = <ls_order>-property ]-technical_name )
                                      descending = COND #( WHEN to_upper( <ls_order>-order ) = 'DESC'
                                                           THEN abap_true
                                                           ELSE abap_false ) ) ).

        CHECK lines( lt_sortorder ) GT 0.

        SORT et_entityset BY (lt_sortorder).

      CATCH cx_root INTO DATA(lx_root).

        DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
             msgno = '002'
             attr1 = lx_root->get_text(  ) ).

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            textid = ls_message.
    ENDTRY.

  ENDMETHOD.


  METHOD paymentsset_create_entity.

    DATA ls_payments TYPE zpayments.

    io_data_provider->read_entry_data( IMPORTING es_data = ls_payments ).

    INSERT zpayments FROM ls_payments.

    IF sy-subrc EQ 0.
      er_entity = ls_payments.
    ELSE.

      DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                            msgno = '002'
                                            attr1 = 'INSERT error' ).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid = ls_message.

    ENDIF.

  ENDMETHOD.


  METHOD paymentsset_delete_entity.

    DATA(lv_paymentid) = it_key_tab[ name = 'Paymentid' ]-value.

    DELETE FROM zpayments WHERE paymentid EQ @lv_paymentid.

    CHECK sy-subrc NE 0.

    DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                          msgno = '002'
                                          attr1 = 'DELETE error' ).

    RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
      EXPORTING
        textid = ls_message.
  ENDMETHOD.


  METHOD paymentsset_get_entity.

*   data(lo_facade) = me->/iwbep/if_mgw_conv_srv_runtime~get_dp_facade(  ).
*   data(lt_client_header) = lo_facade->get_request_header(  ).

    IF NOT it_navigation_path IS INITIAL.

      TRY.

          DATA(lv_nav_prop) = it_navigation_path[ nav_prop = 'OrdersToPaymentsNav' target_type = 'Payments' ]-nav_prop.

          CASE lv_nav_prop.

            WHEN 'OrdersToPaymentsNav'.

              DATA(lv_order_id) = it_key_tab[ name = 'Orderid' ]-value.

              SELECT SINGLE FROM zpayments
                     FIELDS *
                     WHERE orderid EQ @lv_order_id
                     INTO @er_entity.

          ENDCASE.

        CATCH cx_sy_itab_line_not_found INTO DATA(lx_itab_line_not_found).

          DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                               msgno = '002'
                                               attr1 = lx_itab_line_not_found->get_text( ) ).

          RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
            EXPORTING
              textid = ls_message.

      ENDTRY.

    ELSE.

      TRY.
          DATA(lv_paymentid) = it_key_tab[ name = 'Paymentid' ]-value.

        CATCH cx_sy_itab_line_not_found INTO lx_itab_line_not_found.

          ls_message = VALUE scx_t100key( msgid = 'SY'
                                               msgno = '002'
                                               attr1 = lx_itab_line_not_found->get_text( ) ).

          RAISE EXCEPTION TYPE /iwbep/cx_mgw_tech_exception
            EXPORTING
              textid = ls_message.

      ENDTRY.

      SELECT SINGLE FROM zpayments
          FIELDS *
          WHERE paymentid EQ @lv_paymentid
          INTO @er_entity.

    ENDIF.

  ENDMETHOD.


  METHOD paymentsset_get_entityset.

    IF NOT is_paging IS INITIAL.

*      /iwbep/cl_mgw_data_util=>paging(
*        EXPORTING
*          is_paging = is_paging
*        CHANGING
*          ct_data   = et_entityset ).

      SELECT FROM zpayments
       FIELDS *
       ORDER BY paymentid
       INTO TABLE @et_entityset
       OFFSET @is_paging-skip
       UP TO  @is_paging-top ROWS.

    ELSE.

      SELECT FROM zpayments
       FIELDS *
       INTO TABLE @et_entityset.

    ENDIF.

    IF NOT it_order IS INITIAL.

      me->order_data(
              EXPORTING
                iv_entity_name = iv_entity_name
                it_order       = it_order
              IMPORTING
                et_entityset   = et_entityset
            ).

    ENDIF.



  ENDMETHOD.


  METHOD paymentsset_update_entity.

    DATA ls_payments TYPE zpayments.

    io_data_provider->read_entry_data( IMPORTING es_data = ls_payments ).

    UPDATE zpayments FROM ls_payments.

    IF sy-subrc EQ 0.
      er_entity = ls_payments.
    ELSE.

      DATA(ls_message) = VALUE scx_t100key( msgid = 'SY'
                                            msgno = '002'
                                            attr1 = 'UPDATE error' ).

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid = ls_message.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
