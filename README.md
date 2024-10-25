<h2 id="تعريف">تعريف</h2>
<p>دوكر (Docker) هو برنامج بيسهل إنشاء تطبيقات داخل صورة (image)، اللي بتحتوى على البرامج والمكتبات اللازمة لتشغيل التطبيق بشكل سليم، بعد كده بيتم تشغيل الصورة دي في حاوية (container)، الحاويات بتخلى التطبيق يشتغل في بيئة معزولة عن نظام التشغيل بتاعك، يعنى باختصار Docker بيسهل نقل التطبيقات وتشغيلها على أي جهاز من غير مشاكل توافق. هنا فى مادة TM351 تم استخدامه لإنشاء صورة تضم جميع البرامج والمكتبات اللازمة لتشغيل ملفات الـ notebooks.</p>
<p>لو حابب تعرف أكتر عن Docker ممكن تشوف <a href="https://www.youtube.com/watch?v=8Zi_8-9f7xk">الفيديو</a> ده. </p>
<p>تقدر تشغل الحاوية الخاصة بالمادة على جهازك (Linux, Windows, Mac) من خلال تحميل برنامح Docker لكن تسهيلاً على الناس يمكن استخدام موقع play-with-docker اللى بيقدم سيرفر مجانى متسطب عليه Docker بالتالى مش هتحتاج تحمل أى برامج أو ملفات.</p>

<br>

<h2 id="خطوات-تشغيل-ملفات-الـ-notebooks-على-play-with-docker">خطوات تشغيل ملفات الـ notebooks على play-with-docker</h2>
<h3 id="التسجيل-على-play-with-docker">
  <strong>التسجيل على play-with-docker</strong>
</h3>
<ol>
  <li>اعمل أكونت على موقع Docker من <a href="https://app.docker.com/signup">https://app.docker.com/signup</a>. بتسجل زى أى موقع بشكل عادى. </li>
  <li>افتح <a href="https://labs.play-with-docker.com">https://labs.play-with-docker.com</a> ودوس على <strong>Login</strong> واختار <strong>docker</strong> بعدين دوس على <strong>Accept</strong> وهتلاقى الصفحة عملت ريفرش. </li>
  <li>دوس على <strong>Start</strong> هيفتح معاك صفحة جديدة. </li>
</ol>
<h3 id="تشغيل-الحاوية">
  <strong>تشغيل الحاوية</strong>
</h3>
<ol dir="rtl">
  <li>
    <p>من على الشمال دوس على <strong>ADD NEW INSTANCE</strong>
      <img src="https://github.com/user-attachments/assets/c90ff256-ef73-4021-b586-2bb11eb05540" alt=""> وهيفتح command line تقدر تكتب فيه بالشكل ده <img src="https://github.com/user-attachments/assets/157b5f04-f6db-4314-8cf0-77c20746ef0b" alt="">
    </p>
  </li>
  <li>
    <p>فى الـ command line اكتب:</p>
    <pre><code>docker run -it --network host --rm ghcr.io/amkige/aou-tm351</code></pre>
    <blockquote>
      <p>ملحوظة: تقدر تعمل paste فى الـ command line بأنك تدوس على <code>CTRL+SHIFT+V</code>
      </p>
    </blockquote>
    <p>ودوس أنتر واستنى لحد ما يخلص تحميل. أول ما تلاقى مكتوب <code>The Jupyter Notebook is running</code> يبقى كل حاجة اشتغلت تمام <img src="https://github.com/user-attachments/assets/0d051e23-e84f-44fc-b218-f82cddb323ce" alt="">
    </p>
  </li>
  <li>
    <p>دوس على <strong>OPEN PORT</strong> واكتب (<code>8888</code> لفتح Jupyter Notebook أو <code>3333</code> لفتح OpenRefine) ودوس <strong>OK</strong>
      <img src="https://github.com/user-attachments/assets/c57ff57f-c29e-4116-9f62-203a31b3b495" alt=""> وبكدا هيفتح معاك صفحة الـ notebooks <img src="https://github.com/user-attachments/assets/248e5feb-2fd0-4b87-a023-fc4fdf095986" alt="">
    </p>
  </li>
</ol>
