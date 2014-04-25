public void testAddToBasket() {
	given(user).isViewing().store();
	when(user).addsToBasket(A_SPOON);
	then(user).sees().aBasketWith(A_SPOON);
}
