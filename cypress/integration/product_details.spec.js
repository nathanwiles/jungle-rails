describe('Jungle Rails Product Page', () => {
  beforeEach(() => {
    cy.visit('/');
    cy.contains('Scented Blade').click();
  });
  it("navigates to product's page when product clicked", () => {
    cy.contains("The Scented Blade is an")
  });
});
