if(location.pathname.match(/\/items\/new/)){

  window.addEventListener('load', () => {
    const priceInput = document.getElementById("item-price");
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      var commission = Math.floor(inputValue/10)
      addTaxDom.innerHTML = commission
      const addProfitDom = document.getElementById("profit");
      var profit = Math.floor(inputValue - commission)
      addProfitDom.innerHTML = profit
    })
  })
  
}