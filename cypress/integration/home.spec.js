describe('Jungle Rails Homepage', () => {
  beforeEach(() => {
    cy.visit('/');
  });
  it('Displays jungle homepage', () => {
    cy.get('.navbar-brand').should('have.text', 'Jungle');
    cy.contains('Looking for a way to add some life to your home?').should('be.visible');
  });

  it("Has 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

});
