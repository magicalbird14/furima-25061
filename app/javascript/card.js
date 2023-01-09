const pay = () => {
  const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber')
  const cvcElement = elements.create('cardCvc')
  const expiryElement = elements.create('cardExpiry')
  numberElement.mount('#number') //id
  cvcElement.mount('#cvc') //id
  expiryElement.mount('#exp-date') //id

  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    payjp.createToken(expiryElement).then((response) => {
      if (response.error) {
        // エラー記述は必要なし。エラーハンドリングはmodelにて実施している。
      } else {
      const token = response.id;
      const renderDom = document.getElementById("charge-form"); 
      const tokenObj = `<input value=${token} name='token' type="hidden"> `;
      renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      document.getElementById("charge-form").submit();
    });
  });
};

// 削除コードは不要。HTMLドキュメントでカード情報を生成していない。

window.addEventListener("load", pay);