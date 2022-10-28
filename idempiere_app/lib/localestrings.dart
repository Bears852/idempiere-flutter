import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //ENGLISH LANGUAGE
        'en_US': {
          'changelang': 'Language',
          'Calendar': 'Calendar',
          'Dashborad': 'Dashboard',
          'CRM': 'CRM',
          'Lead': 'Lead',
          'Opportunity': 'Opportunity',
          'ContactBP': 'Contact',
          'CustomerBP': 'Customer',
          'Task&Appuntamenti': 'Task',
          'SalesOrder': 'Sales Order',
          'ProductList': 'Product',
          'Invoice': 'Customer Invoice',
          'Payment: ': 'Payment: ',
          'Commission': 'Commission',
          'Shipment': 'Shipment Customer',
          'Ticket': 'Ticket',
          'Ticket Client': 'Ticket Client',
          'Ticket Internal': 'Ticket Internal',
          'TicketTicketNew': 'Ticket',
          'TicketCustomerTicket': 'Customer Ticket',
          'TicketTaskToDo': 'Task',
          'TicketResourceAssignment': 'Resource Assignment',
          'Maintenance': 'Maintenance',
          'MaintenanceCalendar': 'Calendar',
          'MaintenanceMptask': 'Task',
          'MaintenanceMpanomaly': 'Anomaly',
          'MaintenanceMpwarehouse': 'Mobile Stock',
          'MaintenanceMppicking': 'Picking',
          'MaintenanceInternaluseinventory': 'Internal Inventory',
          'MaintenanceMpimportitem': 'Item Card',
          'PortalMp': 'Customer Portal',
          'PortalMpInvoicepo': 'Invoice Vendor',
          'PortalMpPortaloffer': 'Offer',
          'Purchase': 'Purchase',
          'PurchaseLead': 'Vendor Lead',
          'PurchaseProductwarehouseprice': 'Product',
          'Supplychain': 'Supply Chain',
          'SupplychainProductwarehouse': 'Product',
          'SupplychainInventory': 'Inventary',
          'Load & Unload': 'Load & Unload',
          'SupplychainMaterialreceipt': 'Material Receipt',
          'VehicleEquipment': 'Vehicle & Equipment',
          'VehicleEquipmentVehicle': 'Vehicle',
          'VehicleEquipmentEquipment': 'Equipment',
          'DashboardAssetresource': 'Corporate Resource',
          'HumanResource': 'Human Resource',
          'Employee': 'Employee',
          'SalesRep': 'Sales Rappresentative',
          'AddressIP': 'Address IP',
          'NS': 'Not Started',
          'IP': 'In Progress',
          'ST': 'Stopped',
          'WP': 'Work in Progress',
          'CO': 'Completed',
          'NY': 'Not Yet Started',
          'Location Code': 'Location Code',
          'Location': 'Location',
          'Locator': 'Locator',
          'Type': 'Type',
          'Search by code': 'Search by code',
          'Search by product': 'Search by product',
          'Product Value': 'Product Value',
          'Produt Name': 'Product Name',
          'Description': 'Description',
          'Activity (Barcode)': 'Activity (Barcode)',
          'Add Load/Unload': 'Add Load/Unload',
          'Delete': 'Delete',
          'Are you sure you want to delete the record?':
              'Are you sure you want to delete the record?',
          'Add Line': 'Add Line',
          'Quantity': 'Quantity',
          'Attribute Instance': 'Attribute Instance',
          'Create Instance Attribute': 'Create Instance Attribute',
          'Series Number': 'Series Number',
          'Price': 'Price',
          'Warehouse': 'Warehouse',
          'Create Entry': 'Create Entry',
          'Sign Entry': 'Sign Entry',
          'SET IDEMPIERE URL': 'SET IDEMPIERE URL',
          'Syncing data with iDempiere...': 'Syncing data with iDempiere...',
          'Error!': 'Error!',
          'Account without authentication code':
              'Account without authentication code',
          'Done!': 'Done!',
          'Records saved locally have been synchronized!':
              'Records saved locally have been synchronized!',
          'LOGIN': 'LOGIN',
          'You are offline due to no internet connection, there will be limitations.':
              'You are offline due to no internet connection, there will be limitations.',
          'You are offline due to no internet connection and not your last login is not recent enough.':
              'You are offline due to no internet connection and not your last login is not recent enough.',
          'Protocol': 'Protocol',
          'Select roles': 'Select roles',
          'Select Client': 'Select Client',
          'Select Roles': 'Select Roles',
          'Select Organization': 'Select Organization',
          'Select Warehouse': 'Select Warehouse',
          'VEHICLE': 'VEHICLE',
          'EQUIPMENT': 'EQUIPMENT',
          'Failed to load lead statuses': 'Failed to load lead statuses',
          'Failed to load sales reps': 'Failed to load sales reps',
          'Add Lead': 'Add Lead',
          'The record has been updated': 'The record has been updated',
          'Record not updated': 'Record not updated',
          'The record has been erased': 'The record has been erased',
          'Edit Lead': 'Edit Lead',
          'Record deletion': 'Record deletion',
          'Are you sure to delete the record?':
              'Are you sure to delete the record?',
          'Cancel': 'Cancel',
          'Take the Quiz': 'Take the Quiz',
          'Description: ': 'Description: ',
          'COURSES: ': 'COURSES: ',
          'The record has been created': 'The record has been created',
          'Record not created': 'Record not created',
          'NEW': 'NEW',
          'HOURS': 'HOURS',
          'Attachment': 'Attachment',
          'Status': 'Status',
          'Summary': 'Summary',
          'Priority': 'Priority',
          'Session slots currently free': 'Session slots currently free',
          'PRODUCT WAREHOUSE': 'PRODUCT WAREHOUSE',
          'info button pressed': 'info button pressed',
          'Expected amount': 'Expected amount',
          'Agent: ': 'SalesRep: ',
          'SUPLLY CHAIN': 'SUPLLY CHAIN',
          'Stock Area: ': 'Stock Area: ',
          'Quantity: ': 'Quantity: ',
          'Quantity Count: ': 'Quantity Counted: ',
          'Quantity Booked: ': 'Quantity Booked: ',
          'Activity: ': 'Activity: ',
          'Warehouse: ': 'Warehouse: ',
          'Complete': 'Complete',
          'Complete Action': 'Complete Action',
          'Are you sure you want to complete the record?':
              'Are you sure you want to complete the record?',
          'Contact: ': 'Contact: ',
          'Product: ': 'Product: ',
          'Expected Amount: ': 'Expected Amount: ',
          'Production': 'Production',
          'Training and Course': 'Training and Course',
          'Work Hours': 'Work Hours',
          'Record not cancelled (is it your?)':
              'Record not cancelled (is it your?)',
          'The record has been modified': 'The record has been modified',
          'Name': 'Name',
          'Date': 'Date',
          'Start Time': 'Start Time',
          'End Time': 'End Time',
          'You\'ve completed the Quiz': 'You\'ve completed the Quiz',
          'Internet connection unavailable': 'Internet connection unavailable',
          'No internet connection!': 'No internet connection!',
          'Failed to update records': 'FaileCustomer d to update records',
          'See All': 'See All',
          'Task Overview': 'Task Overview',
          'All': 'All',
          'To do': 'To do',
          'In progress': 'In progress',
          'Done': 'Done',
          'notification': 'notification',
          'more': 'more',
          'Recent Messages': 'Recent Messages',
          'Team Member ': 'Team Member ',
          'add member': 'add member',
          'Add WorkOrder': 'Add WorkOrder',
          'Resource': 'Resource',
          'True': 'True',
          'False': 'False',
          'My Active Project': 'My Active Project',
          'Production Order': 'Production Order',
          'You Have': 'You Have',
          'Undone Tasks': 'Undone Tasks',
          'Tasks are in progress': 'Tasks are in progress',
          'Project': 'Project',
          'Product': 'Product',
          'SalesStage': 'Sales Stage',
          'OpportunityAmt': 'Opportunity Amount',
          'Phone': 'Phone',
          'LeadStatus': 'Lead Status',
          'Edit Sales Order': 'Edit Sales Order',
          'DocumentNo': 'DocumentNo',
          'Document Type': 'Document Type',
          'Business Partner Location': 'Business Partner Location',
          'Value': 'Value',
          'Receipt: ': 'Receipt: ',
          'Edit Receipt': 'Edit Receipt',
          'Edit Payment': 'Edit Payment',
          'Invoice: ': 'Invoice: ',
          'RECEIPTS: ': 'RECEIPTS: ',
          'Today': 'Today',
          'language': 'en',
          'languageCalendar': 'en_EN',
          'Add Event': 'Add Event',
          'Edit Event': 'Edit Event',
          'Accept': 'Accept',
          'Create To Do': 'Create To Do',
          'Edit To Do': 'Edit To Do',
          'Notifications': 'Notifications',
          'COMMISSIONS: ': 'COMMISSIONS: ',
          'Edit Commission': 'Edit Commission',
          'Currency: ': 'Currency: ',
          'CONTACTS: ': 'CONTACTS: ',
          'Contact Name': 'Contact Name',
          'CLIENTS: ': 'CLIENTS: ',
          'Search': 'Search',
          'Edit Customer': 'Edit Customer',
          'BP Group: ': 'BP Group: ',
          'INVOICES: ': 'INVOICES: ',
          'Edit Invoice': 'Edit Invoice',
          'Amount: ': 'Amount: ',
          'Create Opportunity': 'Create Opportunity',
          'OPPORTUNITY: ': 'OPPORTUNITY: ',
          'Bank': 'Bank',
          'Product Detail': 'Product Detail',
          'Available': 'Available',
          'Not Available': 'Not Available',
          'Product List: ': 'Product List: ',
          'Record has been completed': 'Record has been completed',
          'Record not completed': 'Record not completed',
          'SALES ORDERS: ': 'SALES ORDERS: ',
          'Add Sales Order Line': 'Add Sales Order Line',
          'Promised Date': 'Promised Date',
          'The record has been deleted': 'The record has been deleted',
          'Record not deleted': 'Record not deleted',
          'Edit Sales Order Line': 'Edit Sales Order Line',
          'Total Rows: ': 'Total Rows: ',
          'Listed Price: ': 'Listed Price: ',
          'Entered Price: ': 'Entered Price: ',
          'Instance Attribute: ': 'Instance Attribute: ',
          'Edit Shipment': 'Edit Shipment',
          'Note': 'Note',
          'Shipment: ': 'Shipment: ',
          'Note: ': 'Note: ',
          'Edit ShipmentLine': 'Edit ShipmentLine',
          'Quantity Planned': 'Quantity Planned',
          'Selected': 'Selected',
          'Shipment Lines: ': 'Shipment Lines: ',
          '- Qty Confirmed: ': '- Qty Confirmed: ',
          '- Qty Planned: ': '- Qty Planned: ',
          'TASK: ': 'TASK: ',
          'Edit Task': 'Edit Task',
          'You Started at ': 'You Started at ',
          'Assigned To': 'Assigned To',
          'In Progress: ': 'In Progress: ',
          'From': 'From',
          'Edit Ticket': 'Edit Ticket',
          'TICKET HR: ': 'TICKET HR: ',
          'LEAD LIST': 'LEAD LIST',
          'Saved!': 'Saved!',
          'The record has been saved locally waiting for internet connection':
              'The record has been saved locally waiting for internet connection',
          'Add Resource': 'Add Resource',
          'Product Model': 'Product Model',
          'Barcode': 'Barcode',
          'Cartel': 'Cartel',
          'Lot': 'Lot',
          'LocationCode': 'LocationCode',
          'Manufacturer': 'Manufacturer',
          'Manufactured Year': 'Manufactured Year',
          'Due Year': 'Due Year',
          'Date Ordered': 'Date Ordered',
          'First Use Date': 'First Use Date',
          'Check Date': 'Check Date',
          'Revision Date': 'Revision Date',
          'Testing Date': 'Testing Date',
          'User Name': 'User Name',
          'Sync Data': 'Sync Data',
          'Re-Sync All': 'Re-Sync All',
          'User Preferences': 'User Preferences',
          'Business Partners': 'Business Partners',
          'Event Calendar': 'Event Calendar',
          'Work Orders': 'Work Orders',
          'Language': 'Language',
          'Italian': 'Italian',
          'User': 'User',
          'Ticket Title': 'Ticket Title',
          'Summary of the issue': 'Summary of the issue',
          'Subject of the Scheduled Session':
              'Subject of the Scheduled Session',
          'Open Chat': 'Open Chat',
          'Edit Contact': 'Edit Contact',
          'INVENTORY: ': 'INVENTORY: ',
          'Add Anomaly': 'Add Anomaly',
          'Anomaly Type': 'Anomaly Type',
          'Is Charged': 'Is Charged',
          'Is being Replaced Now': 'Is being Replaced Now',
          'Replacement': 'Replacement',
          'CONTRACTS: ': 'CONTRACTS: ',
          'Contract': 'Contract',
          'ANOMALIES: ': 'ANOMALIES: ',
          'Anomaly': 'Anomaly',
          'Edit Anomaly': 'Edit Anomaly',
          'Bill Business Partner': 'Bill Business Partner',
          'Organization': 'Organization',
          'Date Next Run': 'Date Next Run ',
          'Date Last Run': 'Date Last Run',
          'ContractNo': 'ContractNo',
          'RESOURCES': 'RESOURCES',
          'MAINTENANCES': 'MAINTENANCES',
          'No Maintenance Selected': 'No Maintenance Selected',
          'Maintenance Resource': 'Maintenance Resource',
          'Work Order': 'Work Order',
          'Fault Type': 'Fault Type',
          'Document Date': 'Document Date',
          'User/Contact': 'User/Contact',
          'No Resource Selected': 'No Resource Selected',
          'Maintenance Task': 'Maintenance Task',
          'Billing Partner': 'Billing Partner',
          'Code/Position': 'Code/Position',
          'LineNo': 'LineNo',
          'Next Check': 'Next Check',
          'Next Revision': 'Next Revision',
          'Next Testing': 'Next Testing',
          'Contract Date': 'Contract Date',
          'Valid from Date': 'Valid from Date',
          'Valid to Date': 'Valid to Date',
          'Frequency Next Date': 'Frequency Next Date',
          'Frequency Type': 'Frequency Type',
          'Payment Rule': 'Payment Rule',
          'Payment Term': 'Payment Term',
          'STUDENTS: ': 'STUDENTS: ',
          'Birthday': 'Birthday',
          'Birthplace': 'Birthplace',
          'TaxCode': 'TaxCoxe',
          'Position': 'Position',
          'No Course Selected': 'No Course Selected',
          'No Student Selected': 'No Student Selected',
          'Amount': 'Amount',
          'LINES: ': 'LINES: ',
          'No Contract Selected': 'No Contract Selected',
          'Date Invoiced': 'Date Invoiced',
          'Charge Amount': 'Charge Amount',
          'Lines Amount': 'Lines Amount',
          'List Price': 'List Price',
          'Line Amount': 'Line Amount',
          'Tax': 'Tax',
          'No Invoice Selected': 'No Invoice Selected',
          'Select a course': 'Select a course',
          'Please select the course the student will be assigned to':
              'Please select the course the student will be assigned to',
          'Select a student to delete': 'Select a student to delete',
          'Sales Order Request': 'Sales Order Request',
          'Please, fill the Name field to sign':
              'Please, fill the Name field to sign',
          "order-line": "order-line",
          'Approve': 'Approve',
          'Approve Sales Order': 'Approve Sales Order',
          'Are you sure you want to approve this Sales Order?':
              'Are you sure you want to approve this Sales Order?',
          'Sales Order approved': 'Sales Order approved',
          'Sales Order not approved': 'Sales Order not approved',
          'Approved': 'Approved',
          'Sign missing': 'Sign missing',
          'Please, sign this Sales Order to approve it':
              'Please, sign this Sales Order to approve it',
          'No Sales Order selected': 'No Sales Order selected',
          'Sign': 'Sign',
          'Select a request or create a new one':
              'Select a request or create a new one',
          'New Sales Order Request': 'New Sales Order Request',
          'Request': 'Request',
          'Not Listed': 'Not Listed',
          'Request Date': 'Request Date',
          'Expected Close Date': 'Expected Close Date',
          'Subject': 'Subject',
          'Request Details': 'Request Details',
          'Sales Order Requests': 'Sales Order Requests',
          'Document Type: ': 'Document Type: ',
          'Document: ': 'Document: ',
          'Cust.': 'Cust.',
          'U.o.M': 'U.o.M',
          'Qty': 'Qty',
          'Thank you!': 'Thank you!',
          'Total': 'Total',
          'VAT': 'VAT',
          'of which VAT': 'VAT',
          'Business Partner': 'Business Partner',
          'Document N°': 'Document N°',
          'The record was deleted': 'The record was deleted',
          'The record was not deleted': 'The record was not deleted',
          'The record has not been changed': 'The record has not been changed',
          'Failed to load bp location': 'Failed to load bp location',
          'Record deletion ': 'Record deletion ',
          'Erase': 'Erase',
          'Send Quiz': 'Send Quiz',
          'Wrong Username or Password': 'Wrong Username or Password',
          'physical-inventory': 'physical-inventory',
          'inventory-count': 'inventory-count',
          'inventory-count-line': 'inventory-count-line',
          'Check Date: ': 'Check Date: ',
          'Revision Date: ': 'Revision Date: ',
          'Testing Date: ': 'Testing Date: ',
          'Manufactured Year: ': 'Manufactured Year: ',
          'Manufacturer: ': 'Manufacturer: ',
          'Managed by the Customer': 'Managed by the Customer',
          'Representative': 'Representative',
          'Team': 'Team',
          'Note Plant': 'Note Plant',
          'Time': 'Time',
          'WORK ORDER': 'WORK ORDER',
          'Year': 'Year',
          'Check': 'Check',
          'Revision': 'Revision',
          'Testing': 'Testing',
          'Observations': 'Observations',
          'Identification': 'Identification',
          'Activities': 'Activities',
          'maintenance': 'maintenance',
          'Completed': 'Completed',
          'Not Yet Started': 'Not Yet Started',
          'Work In Progress': 'Work In Progress',
          'Create Task': 'Crea Attività',
          'Anomalies Review': 'Anomalies Review',
          'Sales Order Zoom': 'Sales Order'
        },
        //ITALIAN LANGUAGE
        'it_IT': {
          'changelang': 'Lingua   ',
          'Calendar': 'Calendario',
          'Dashboard': 'Cruscotto',
          'CRM': 'CRM',
          'Lead': 'Lead',
          'Opportunity': 'Opportunità',
          'ContactBP': 'Contatto',
          'CustomerBP': 'Cliente',
          'Task&Appuntamenti': 'Task',
          'SalesOrder': 'Offerta',
          'ProductList': 'Listino Prodotto',
          'Invoice': 'Fattura',
          'Payment: ': 'Pagamento: ',
          'Commission': 'Provvigione',
          'Shipment': 'Documento di Trasporto',
          'Ticket': 'Ticket',
          'Ticket Client': 'Portale Cliente',
          'Ticket Internal': 'Portale Interno',
          'TicketTicketNew': 'Ticket',
          'TicketTaskToDo': 'Task',
          'TicketResourceAssignment': 'Ore',
          'Maintenance': 'Intervento',
          'MaintenanceCalendar': 'Calendario',
          'MaintenanceMptask': 'Ordini di Lavoro',
          'MaintenanceMpanomaly': 'Anomalia',
          'MaintenanceMpwarehouse': 'Mag. Furgone',
          'MaintenanceMppicking': 'Prelievo Magazzino',
          'MaintenanceInternaluseinventory': 'Movimento Magazzino',
          'MaintenanceMpimportitem': 'Carico scheda Tecnica',
          'PortalMp': 'Portale Cliente',
          'PortalMpInvoicepo': 'Fatture di Acquisto',
          'PortalMpPortaloffer': 'Offerte di Vendita',
          'Purchase': 'Acquisti',
          'PurchaseLead': 'Lead Fornitore',
          'PurchaseProductwarehouseprice': 'Prodotto',
          'Supplychain': 'Logistica',
          'SupplychainProductwarehouse': 'Prodotto',
          'SupplychainInventory': 'Inventario',
          'Load & Unload': 'Carico/Scarico',
          'SupplychainMaterialreceipt': 'Entrata Merce',
          'VehicleEquipment': 'Mezzi e Attrezzature',
          'VehicleEquipmentVehicle': 'Mezzi',
          'VehicleEquipmentEquipment': 'Attrezzatura',
          'DashboardAssetresource': 'Risorse Aziendali',
          'HumanResource': 'Risorse Umane',
          'Employee': 'Dipendente',
          'SalesRep': 'Agente ',
          'AddressIP': 'Indirizzo IP',
          'NS': 'Non Iniziato',
          'IP': 'In Corso',
          'WP': 'In Corso',
          'ST': 'Fermato',
          'CO': 'Completato',
          'NY': 'Non Iniziato',
          'Location Code': 'Codice Ubicazione',
          'Location': 'Ubicazione',
          'Locator': 'Area Stoccaggio',
          'Type': 'Tipo',
          'Search by code': 'Cerca per codice',
          'Search by product': 'Cerca per prodotto',
          'Product Value': 'Codice Prodotto',
          'Product Name': 'Nome Prodotto',
          'Description': 'Descrizione',
          'Activity (Barcode)': 'Attività (Barcode)',
          'Add Load/Unload': 'Aggiungi Carico/Scarico',
          'Delete': 'Elimina',
          'Are you sure you want to delete the record?':
              'Sicuro di voler eliminare il record?',
          'Add Line': 'Aggiungi Linea',
          'Quantity': 'Quantità',
          'Quantity Count: ': 'Quantità Contata: ',
          'Quantity Booked: ': 'Quantità Registrata: ',
          'Attribute Instance': 'Attributo di Istanza',
          'Create Instance Attribute': 'Crea Attributo di Istanza',
          'Series Number': 'Numero di Serie',
          'Price': 'Prezzo',
          'Warehouse': 'Magazzino',
          'Create Entry': 'Timbra Entrata',
          'Sign Entry': 'Timbra Uscita',
          'SET IDEMPIERE URL': 'IMPOSTA IDEMPIERE URL',
          'Syncing data with iDempiere...':
              'Sincronizzazione dati con iDempiere...',
          'Error!': 'Errore!',
          'Account without authentication code':
              'Account senza Codice di Autenticazione valido',
          'Done!': 'Fatto!',
          'Records saved locally have been synchronized!':
              'I record salvati localmente sono stati sincronizzati!',
          'LOGIN': 'ACCEDI',
          'You are offline due to no internet connection, there will be limitations.':
              'Sei in offline a causa di mancata connessione Internet, saranno presenti delle limitazioni.',
          'You are offline due to no internet connection and not your last login is not recent enough.':
              'Sei in offline a causa di mancata connessione Internet e non il tuo ultimo login non è abbastanza recente.',
          'Protocol ': 'Protocollo ',
          'Select roles': 'Seleziona ruoli',
          'Select Client': 'Seleziona Cliente',
          'Select Roles': 'Seleziona Ruoli',
          'Select Organization': 'Seleziona Organizzazione',
          'Select Warehouse': 'Seleziona magazzino',
          'VEHICLE': 'VEICOLO',
          'EQUIPMENT': 'EQUIPAGGIAMENTO',
          'Failed to load lead statuses':
              'Fallito lo stato del caricamento dei lead',
          'Failed to load sales reps':
              'Impossibile caricare i rappresentanti di vendita',
          'Add Lead': 'Aggiungi Lead',
          'The record has been updated': 'Il record è stato aggiornato',
          'Record not updated': 'Record non aggiornato',
          'The record has been erased': 'Il record è stato cancellato',
          'Edit Lead': 'Modifica Lead',
          'Record deletion': 'Eliminazione record',
          'Are you sure to delete the record?':
              'Sicuro di voler eliminare il record?',
          'Cancel': 'Annulla',
          'Take the Quiz': 'Avvia il quiz',
          'Description: ': 'Descrizione: ',
          'COURSES: ': 'CORSI: ',
          'The record has been created': 'Il record è stato creato',
          'Record not created': 'Record non creato',
          'NEW': 'NUOVO',
          'HOURS': 'ORE',
          'Attachment': 'Allegato',
          'Status': 'Stati',
          'Summary': 'Sommario',
          'Priority': 'Priorita',
          'Session slots currently free': 'Slot di sessione attualmente liberi',
          'PRODUCT WAREHOUSE': 'PRODOTTO DEL MAGAZZINO',
          'info button pressed': 'informazioni del bottone premuto',
          'Expected amount': 'Importo Atteso: ',
          'Agent: ': 'Agente: ',
          'SUPPLY CHAIN': 'CATENA DI MONTAGGIO',
          'Stock Area: ': 'Area di Stoccaggio: ',
          'Quantity: ': 'Quantita: ',
          'Activity: ': 'Attivita: ',
          'Warehouse: ': 'Magazzino',
          'Complete': 'Completa',
          'Complete Action': 'Azione completata',
          'Are you sure you want to complete the record?':
              'Sei sicuro di voler completare il record?',
          'Contact: ': 'Contatto: ',
          'Product: ': 'Prodotto: ',
          'Expected Amount: ': 'Importo Atteso: ',
          'Production': 'Produzione',
          'Training and Course': 'Formazione e corso',
          'Setting': 'Impostazioni',
          'Work Hours': 'Ore di lavoro',
          'Record not cancelled (is it your?)':
              'Record non cancellato (è tuo?)',
          'The record has been modified': 'Il record è stato modificato',
          'Name': 'Nome',
          'Date': 'Data',
          'Start Time': 'Ora Inizio',
          'End Time': 'Ora Fine',
          'You\'ve completed the Quiz': 'Hai completato il quiz',
          'Internet connection unavailable':
              'Collegamento internet non disponibbile',
          'No internet connection!': 'Connessione Internet assente!',
          'Failed to update records': 'Impossibile aggiornare i record',
          'See All': 'Vedi tutto',
          'Task Overview': 'Panoramica delle attività',
          'All': 'Tutti',
          'To do': 'Da fare',
          'In progress': 'In esecuzione',
          'Done': 'Fatto',
          'notification': 'Notifica',
          'more': 'Di più',
          'Recent Messages': 'Messaggi recenti',
          'Team Member ': 'Membro del team',
          'add member': 'Aggiungi membro',
          'Add WorkOrder': 'Aggiungi ordine di lavoro',
          'Resource': 'Risorsa',
          'True': 'Vero',
          'False': 'Falso',
          'My Active Project': 'I miei progetti attivi',
          'Production Order': 'Ordine di produzione',
          'You Have': 'Hai',
          'Undone Tasks': 'Task non finiti',
          'Tasks are in progress': 'Task in corso',
          'Project': 'Progetto',
          'Product': 'Prodotto',
          'SalesStage': 'Stato di Vendita',
          'OpportunityAmt': 'Importo Atteso',
          'Phone': 'Telefono',
          'LeadStatus': 'Stato Lead',
          'Edit Sales Order': 'Modifica Offerta',
          'DocumentNo': 'N. Documento',
          'Document Type': 'Tipo Doc',
          'Business Partner Location': 'Indirizzo del Business Partner',
          'Value': 'Chiave di Ricerca',
          'Receipt: ': 'Incasso: ',
          'Edit Receipt': 'Modifica Incasso',
          'Edit Payment': 'Modifica Pagamento',
          'Invoice: ': 'Fattura: ',
          'RECEIPTS: ': 'INCASSI: ',
          'Today': 'Oggi',
          'language': 'it',
          'languageCalendar': 'it_IT',
          'Add Event': 'Aggiungi Evento',
          'Edit Event': 'Modifica Evento',
          'Accept': 'Continua',
          'Create To Do': 'Crea To Do',
          'Edit To Do': 'Modifica To Do',
          'Notifications': 'Notifiche',
          'COMMISSIONS: ': 'PROVVIGIONI: ',
          'Edit Commission': 'Modifica Provvigione',
          'Currency: ': 'Valuta: ',
          'CONTACTS: ': 'CONTATTI: ',
          'Contact Name': 'Nome Contatto',
          'CLIENTS: ': 'CLIENTI: ',
          'Search': 'Cerca',
          'Edit Customer': 'Modifica Cliente',
          'BP Group: ': 'Gruppo BP: ',
          'INVOICES: ': 'FATTURE: ',
          'Edit Invoice': 'Modifica Fattura',
          'Amount: ': 'Importo: ',
          'Edit Opportunity': 'Modifica Opportunità',
          'Create Opportunity': 'Crea Opportunità',
          'OPPORTUNITY: ': 'OPPORTUNITA: ',
          'Bank': 'Banca',
          'Product Detail': 'Dettaglio Prodotto',
          'Available': 'Disponibile',
          'Not Available': 'Non Disponibile',
          'Product List: ': 'Lista Prodotti',
          'Record has been completed': 'Il record è stato completato',
          'Record not completed': 'Il record non è stato completato',
          'SALES ORDERS: ': 'OFFERTE: ',
          'Add Sales Order Line': 'Aggiungi Linea Offerta',
          'Promised Date': 'Data Promessa',
          'The record has been deleted': 'Il record è stato eliminato',
          'Record not deleted': 'Il record non è stato eliminato',
          'Edit Sales Order Line': 'Modifica Linea Offerta',
          'Total Rows: ': 'Righe Totali: ',
          'Listed Price: ': 'Prezzo Listato: ',
          'Entered Price: ': 'Prezzo Inserito: ',
          'Instance Attribute: ': 'Attributo Istanza: ',
          'Edit Shipment': 'Modifica DDT',
          'Note': 'Note',
          'Shipment: ': 'DDT: ',
          'Note: ': 'Note: ',
          'Edit ShipmentLine': 'Modifica Linea DDT',
          'Quantity Planned': 'Quantità Programmata',
          'Selected': 'Selezionato',
          'Shipment Lines: ': 'Linee DDT: ',
          '- Qty Confirmed: ': '- Qtà Confermata: ',
          '- Qty Planned: ': '- Qtà Programmata: ',
          'TASK: ': 'TASK: ',
          'Edit Task': 'Modifica Task',
          'You Started at ': 'Hai Iniziato alle ',
          'Assigned To': 'Assegnato A',
          'In Progress: ': 'In Corso: ',
          'From': 'Da',
          'Edit Ticket': 'Modifica Ticket',
          'TICKET HR: ': 'TICKET HR: ',
          'LEAD LIST': 'LISTA LEAD',
          'Saved!': 'Salvato!',
          'The record has been saved locally waiting for internet connection':
              'Il record è stato salvato localmente in attesa di connessione internet.',
          'Add Resource': 'Aggiungi Risorsa',
          'Product Model': 'Modello Prodotto',
          'Barcode': 'Barcode',
          'Cartel': 'Cartello',
          'Lot': 'Lotto',
          'LocationCode': 'Codice Posizione',
          'Manufacturer': 'Produttore',
          'Manufactured Year': 'Anno di Produzione',
          'Due Year': 'Anno di Scadenza',
          'Date Ordered': 'Data Ordine',
          'First Use Date': 'Data Primo Utilizzo',
          'Check Date': 'Data Controllo',
          'Revision Date': 'Data di Revisione',
          'Testing Date': 'Data di Collaudo',
          'Next Check Date': 'Prossima Data Controllo',
          'Next Revision Date': 'Prossima Data di Revisione',
          'Next Testing Date': 'Prossima Data di Collaudo',
          'User Name': 'Nome Utente',
          'Sync Data': 'Sincronizza Dati',
          'Re-Sync All': 'Resincronizza Tutti i Dati',
          'User Preferences': 'Preferenze Utente',
          'Business Partners': 'Business Partners',
          'Event Calendar': 'Calendario Eventi',
          'Work Orders': 'Ordini di Lavoro',
          'Language': 'Lingua',
          'Italian': 'Italiano',
          'User': 'Utente',
          'Ticket Title': 'Titolo Ticket',
          'Summary of the issue': 'Riassunto del problema',
          'Subject of the Scheduled Session': 'Soggetto della Sessione',
          'Open Chat': 'Apri Chat',
          'Edit Contact': 'Modifica Contatto',
          'INVENTORY: ': 'INVENTARIO: ',
          'Add Anomaly': 'Crea Anomalia',
          'Anomaly Type': 'Tipo Anomalia',
          'Is Charged': ' Non Compreso',
          'Is being Replaced Now': 'Sostituito adesso',
          'Replacement': 'Sostituzione',
          'CONTRACTS: ': 'CONTRATTI: ',
          'Contract': 'Contratto',
          'ANOMALIES: ': 'ANOMALIE: ',
          'Anomaly': 'Anomalia',
          'Edit Anomaly': 'Modifica Anomalia',
          'Bill Business Partner': 'Partner di fatturazione',
          'Organization': 'Organizzazione',
          'Date Next Run': 'Data Prossima Elaborazione',
          'Date Last Run': 'Data Ultima Elaborazione',
          'ContractNo': 'N. Contratto',
          'RESOURCES': 'DISPOSITIVI',
          'MAINTENANCES': 'INTERVENTI',
          'No Maintenance Selected': 'Nessun Intervento Selezionato',
          'Maintenance Resource': 'Risorsa Intervento',
          'Work Order': 'Ordine di Lavoro',
          'Fault Type': 'Tipo di errore NC',
          'Document Date': 'Data del Documento',
          'User/Contact': 'Utente/Contatto',
          'No Resource Selected': 'Nesuna Risorsa Selezionata',
          'Maintenance Task': 'Task Intervento',
          'Billing Partner': 'Partner di Fatturazione',
          'Code/Position': 'Codice/Posizione',
          'LineNo': 'N. Linea',
          'Next Check': 'Prossimo Controllo',
          'Next Revision': 'Prossima Revisione',
          'Next Testing': 'Prossimo Collaudo',
          'Contract Date': 'Data Contratto',
          'Valid from Date': 'Data Validità Da',
          'Valid to Date': 'Data Validità A',
          'Frequency Date': 'Data Rinnovo',
          'Frequency Type': 'Tipo Frequenza',
          'Payment Rule': 'Metodo di Pagamento',
          'Payment Term': 'Termine di Pagamento',
          'STUDENTS: ': 'STUDENTI: ',
          'Birthday': 'Data di Nascita',
          'Birthplace': 'Nato a',
          'TaxCode': 'Codice Fiscale',
          'Position': 'Posizione',
          'No Course Selected': 'Nessun Corso Selezionato',
          'No Student Selected': 'Nessuno Studente Selezionato',
          'Amount': 'Importo',
          'LINES: ': 'LINEE: ',
          'No Contract Selected': 'Nessun Contratto Selezionato',
          'Date Invoiced': 'Data Fattura',
          'Charge Amount': 'Imponibile',
          'Lines Amount': 'Totale delle Righe',
          'List Price': 'Prezzo di listino',
          'Line Amount': 'Ammontare della riga',
          'Tax': 'Imposta',
          'No Invoice Selected': 'Nessun Fattura Selezionata',
          'Select a course': 'Seleziona un corso',
          'Please select the course the student will be assigned to':
              'Seleziona un corso a cui assegnare lo studente',
          'Select a student to delete': 'Seleziona uno studente da eliminare',
          'Sales Order Request': 'Richiesta di Offerta',
          'Please, fill the Name field to sign':
              'Compilare il campo Nome prima di firmare',
          "order-line": "linee-ordine",
          'Approve': 'Approva',
          'Approve Sales Order': 'Approva Offerta',
          'Are you sure you want to approve this Sales Order?':
              'Sei sicuro di voler approvare questa Offerta?',
          'Sales Order approved': 'Offerta approvata',
          'Sales Order not approved': 'Offerta non approvata',
          'Approved': 'Approvato',
          'Sign missing': 'Firma mancante',
          'Please, sign this Sales Order to approve it':
              'Firma questa Offerta per approvarla',
          'No Sales Order selected': 'Nessuna Offerta selezionata',
          'Sign': 'Firma',
          'Select a request or create a new one':
              'Seleziona una richiesta o creane una nuova',
          'New Sales Order Request': 'Nuova Richiesta di Offerta',
          'Request': 'Richiesta',
          'Not Listed': 'Non in elenco',
          'Request Date': 'Data Richiesta',
          'Expected Close Date': 'Data di Chiusura Attesa',
          'Subject': 'Oggetto',
          'Request Details': 'Dettagli Richiesta',
          'Sales Order Requests': 'Richieste di Offerta',
          'Document Type: ': 'Tipo Doc: ',
          'Document: ': 'Documento: ',
          'Cust.': 'Spett.',
          'U.o.M': 'U.d.M',
          'Qty': 'Qta',
          'Thank you!': 'Grazie!',
          'Total': 'Totale',
          'VAT': 'IVA',
          'of which VAT': 'di cui IVA',
          'Business Partner': 'Business Partner',
          'Document N°': ' N° Doc',
          'The record was deleted': 'Il record è stato cancellato',
          'The record was not deleted': 'Il record non è stato cancellato',
          'The record has not been changed': 'Il record non è stato modificato',
          'Failed to load bp location': 'Impossibile caricare la bp location',
          'Record deletion ': 'Cancellazione record',
          'Erase': 'Cancella',
          'Send Quiz': 'Invia Quiz',
          'Wrong Username or Password': 'Nome Utente e/o Password errati',
          'inventory-count-line': 'dettaglio-inventario-fisico',
          'mp-resources': 'resources',
          'maintenance': 'impianto-manutenzione-dispositivi',
          'Check Date: ': 'Controllo: ',
          'Revision Date: ': 'Revisione: ',
          'Testing Date: ': 'Collaudo: ',
          'Manufactured Year: ': 'Anno di Produzione: ',
          'Manufacturer: ': 'Produttore: ',
          'Managed by the Customer': 'Gestito dal Cliente',
          'Representative': 'Contatto',
          'Team': 'Squadra',
          'Note Plant': 'Note Impianto',
          'Time': 'Ora',
          'WORK ORDER': 'ORDINE DI LAVORO',
          'Year': 'Anno',
          'Check': 'Controllo',
          'Revision': 'Revisione',
          'Testing': 'Collaudo',
          'Observations': 'Osservazioni',
          'Identification': 'Identificazione',
          'Activities': 'Attività',
          'Completed': 'Completato',
          'Not Yet Started': 'Da iniziare',
          'Work In Progress': 'In corso',
          'Create Task': 'Crea Attività',
          'A02': 'Estintori/Idranti',
          'MaintenanceMpContracts': 'Contratti di Manutenzione',
          'Note Work Order': 'Note ODL',
          'Anomalies Review': 'Elenco Anomalie',
          'Sales Order Zoom': 'Ordine/Offerta'
        },
      };
}
