// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "controllers"
import "bootstrap"
import "chartkick/chart.js"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Internal imports, e.g:
document.addEventListener('turbolinks:load', () => {
  if (document.querySelector("#banner-contact") || document.querySelector(".contact-index-conseils") || document.querySelector(".notation-button") || document.querySelector("#notification-help") || document.getElementById("rencontre-page")) {
    new Modal();
  }

})

'use strict';

class Modal {

  constructor() {
    this.triggers = document.querySelectorAll( '.js-modal' );
    this.close = document.querySelectorAll( '.js-close-modal' );
    this.modals = document.querySelectorAll( '.modal' );
    this.modalInners = document.querySelectorAll( '.modal-inner' );

    this.listeners();
  }

  listeners() {
    window.addEventListener( 'keydown', this.keyDown );

    this.triggers.forEach( el => {
      el.addEventListener( 'click', this.openModal, false );
    } );

    this.modals.forEach( el => {
      el.addEventListener( 'transitionend', this.revealModal, false );
      el.addEventListener( 'click', this.backdropClose, false );
    } );

    this.close.forEach( el => {
      el.addEventListener( 'click', Modal.hideModal, false );
    } );

    this.modalInners.forEach( el => {
      el.addEventListener( 'transitionend', this.closeModal, false );
    } );
  }

  keyDown( e ) {
    if ( 27 === e.keyCode && document.body.classList.contains( 'modal-body' ) ) {
      Modal.hideModal();
    }
  }

  backdropClose( el ) {
    if ( ! el.target.classList.contains( 'modal-visible' ) ) {
      return;
    }

    let backdrop =  el.currentTarget.dataset.backdrop !== undefined ? el.currentTarget.dataset.backdrop : true ;

    if ( backdrop === true ) {
      Modal.hideModal();
    }
  }

  static hideModal() {
    let modalOpen = document.querySelector( '.modal.modal-visible' );

    modalOpen.querySelector( '.modal-inner' ).classList.remove( 'modal-reveal' );
    document.querySelector( '.modal-body' ).addEventListener( 'transitionend', Modal.modalBody, false );
    document.body.classList.add( 'modal-fadeOut' );
  }

  closeModal( el ) {
    if ( 'opacity' === el.propertyName && ! el.target.classList.contains( 'modal-reveal' ) ) {
      document.querySelector( '.modal.modal-visible' ).classList.remove( 'modal-visible' );
    }
  }

  openModal( el ) {
    if ( ! el.currentTarget.dataset.modal ) {
      console.error( 'No data-modal attribute defined!' );
      return;
    }

    let modalID = el.currentTarget.dataset.modal;
    let modal = document.getElementById( modalID );

    document.body.classList.add( 'modal-body' );
    modal.classList.add( 'modal-visible' );
  }

  revealModal( el ) {
    if ( 'opacity' === el.propertyName && el.target.classList.contains( 'modal-visible' ) ) {
      el.target.querySelector( '.modal-inner' ).classList.add( 'modal-reveal' );
    }
  }

  static modalBody( el ) {
    if ( 'opacity' === el.propertyName && el.target.classList.contains( 'modal' ) && ! el.target.classList.contains( 'modal-visible' ) ) {
      document.body.classList.remove( 'modal-body', 'modal-fadeOut' );
    }
  }

}

