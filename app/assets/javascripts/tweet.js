// $(document).on('turbolinks:load', function() {
//   // 以降はturbolinksを無効化したい処理について

// /*global $*/
// const CLASSNAME = "-visible";
// const $target = $(".title");

// setInterval(() => {
//   $target.addClass(CLASSNAME);
// });


// //星を作る関数。n は星の個数。多いほど星が多く振ります。
// function starMaker(n) {
//     var star = document.createElement("div");
//     star.className = "star";
//     star.textContent = "★";
//     for(var i = 0; i < n; i++) {
//       console.log(i)
//         starSet(star);
//     }
// }

// //星のセッティングをする関数。
// function starSet(clone) {
//     var starClone = clone.cloneNode(true);
//     var starStyle = starClone.style;

//     //星の位置（left）、アニメーションの遅延時間（animation-delay）、サイズ（font-size）をランダムで指定
//     starStyle.left = 100 * Math.random() + "%";
//     starStyle.animationDelay = 8 * Math.random() + "s";
//     starStyle.fontSize = ~~(50 * Math.random() + 20) + "px";
//     document.body.appendChild(starClone);

//     //星一つのアニメーションが終わったら新しい星を生成
//     starClone.addEventListener("animationend", function() {
//         this.parentNode.removeChild(this);
//         var star = document.createElement("div");
//         star.className = "star";
//         star.textContent = "★";
//         starSet(star);
//     }, false)
// }

// //使用例。星を30個ふらせます。
// starMaker(30)


// });