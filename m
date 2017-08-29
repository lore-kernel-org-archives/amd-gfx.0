From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 9/9] drm/amdgpu: WIP add IOCTL interface for per VM BOs
Date: Tue, 29 Aug 2017 15:59:24 +0200
Message-ID: <8e7b93cf-033b-ac3a-4c81-446db00186f5@vodafone.de>
References: <1503653899-1781-1-git-send-email-deathsimple@vodafone.de>
 <1503653899-1781-9-git-send-email-deathsimple@vodafone.de>
 <19c04fac-1fdd-1436-e85c-95dd4ac02b1b@amd.com>
 <9304342a-def2-187e-4e9c-d872c58cdc17@vodafone.de>
 <CAAxE2A5dSR-PY+zZ3VeaT7iiCmj5jfty0hv7XZjz4HgOrApQHw@mail.gmail.com>
 <e7d5f9d9-ed3e-2654-9acd-c7339976006f@vodafone.de>
 <fba30bfa-aa7c-d342-b4b6-85058f5db5bf@vodafone.de>
 <a897738d-ab23-8b43-9b9e-c64f7da5e065@amd.com>
 <0006623b-f042-dda0-b6a2-425dc568ff03@vodafone.de>
 <MWHPR1201MB0206D4E64E86D7AADA159A47B49E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0841725084=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB0206D4E64E86D7AADA159A47B49E0-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2w/6Yaf?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is a multi-part message in MIME format.
--===============0841725084==
Content-Type: multipart/alternative;
 boundary="------------D611DE905B83654816640270"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D611DE905B83654816640270
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Ok, found something that works. Xonotic in lowest resolution, lowest 
effects quality (e.g. totally CPU bound):

Without per process BOs:

Xonotic 0.8:
     pts/xonotic-1.4.0 [Resolution: 800 x 600 - Effects Quality: Low]
     Test 1 of 1
     Estimated Trial Run Count:    3
     Estimated Time To Completion: 3 Minutes
         Started Run 1 @ 21:13:50
         Started Run 2 @ 21:14:57
         Started Run 3 @ 21:16:03  [Std. Dev: 0.94%]

     Test Results:
         187.436577
         189.514724
         190.9605812

     Average: 189.30 Frames Per Second
     Minimum: 131
     Maximum: 355

With per process BOs:

Xonotic 0.8:
     pts/xonotic-1.4.0 [Resolution: 800 x 600 - Effects Quality: Low]
     Test 1 of 1
     Estimated Trial Run Count:    3
     Estimated Time To Completion: 3 Minutes
         Started Run 1 @ 21:20:05
         Started Run 2 @ 21:21:07
         Started Run 3 @ 21:22:10  [Std. Dev: 1.49%]

     Test Results:
         203.0471676
         199.6622532
         197.0954183

     Average: 199.93 Frames Per Second
     Minimum: 132
     Maximum: 349

Well that looks like some improvement.

Regards,
Christian.

Am 28.08.2017 um 14:59 schrieb Zhou, David(ChunMing):
> I will push our vulkan guys to test it, their bo list is very long.
>
> 发自坚果 Pro
>
> Christian K鰊ig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> 于 2017年8月28日 下午7:55写道：
>
> Am 28.08.2017 um 06:21 schrieb zhoucm1:
> >
> >
> > On 2017年08月27日 18:03, Christian König wrote:
> >> Am 25.08.2017 um 21:19 schrieb Christian König:
> >>> Am 25.08.2017 um 18:22 schrieb Marek Olšák:
> >>>> On Fri, Aug 25, 2017 at 3:00 PM, Christian König
> >>>> <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> wrote:
> >>>>> Am 25.08.2017 um 12:32 schrieb zhoucm1:
> >>>>>>
> >>>>>>
> >>>>>> On 2017年08月25日 17:38, Christian König wrote:
> >>>>>>> From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >>>>>>>
> >>>>>>> Add the IOCTL interface so that applications can allocate per VM
> >>>>>>> BOs.
> >>>>>>>
> >>>>>>> Still WIP since not all corner cases are tested yet, but this
> >>>>>>> reduces
> >>>>>>> average
> >>>>>>> CS overhead for 10K BOs from 21ms down to 48us.
> >>>>>> Wow, cheers, eventually you get per vm bo to same reservation
> >>>>>> with PD/pts,
> >>>>>> indeed save a lot of bo list.
> >>>>>
> >>>>> Don't cheer to loud yet, that is a completely constructed test case.
> >>>>>
> >>>>> So far I wasn't able to archive any improvements with any real
> >>>>> game on this
> >>>>> with Mesa.
> > With thinking more, too many BOs share one reservation, which could
> > result in reservation lock often is busy, if eviction or destroy also
> > happens often in the meaning time, then which could effect VM update
> > and CS submission as well.
>
> That's exactly the reason why I've added code to the BO destroy path to
> avoid at least some of the problems. But yeah, that's only the tip of
> the iceberg of problems with that approach.
>
> > Anyway, this is very good start and try that we reduce CS overhead,
> > especially we've seen "reduces average CS overhead for 10K BOs from
> > 21ms down to 48us. ".
>
> Actually, it's not that good. See this is a completely build up test
> case on a kernel with lockdep and KASAN enabled.
>
> In reality we usually don't have so many BOs and so far I wasn't able to
> find much of an improvement in any real world testing.
>
> Regards,
> Christian.
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------D611DE905B83654816640270
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Ok, found something that works. Xonotic
      in lowest resolution, lowest effects quality (e.g. totally CPU
      bound):<br>
      <br>
      Without per process BOs:<br>
      <br>
      Xonotic 0.8:<br>
          pts/xonotic-1.4.0 [Resolution: 800 x 600 - Effects Quality:
      Low]<br>
          Test 1 of 1<br>
          Estimated Trial Run Count:    3<br>
          Estimated Time To Completion: 3 Minutes<br>
              Started Run 1 @ 21:13:50<br>
              Started Run 2 @ 21:14:57<br>
              Started Run 3 @ 21:16:03  [Std. Dev: 0.94%]<br>
      <br>
          Test Results:<br>
              187.436577<br>
              189.514724<br>
              190.9605812<br>
      <br>
          Average: 189.30 Frames Per Second<br>
          Minimum: 131<br>
          Maximum: 355<br>
      <br>
      With per process BOs:<br>
      <br>
      Xonotic 0.8:<br>
          pts/xonotic-1.4.0 [Resolution: 800 x 600 - Effects Quality:
      Low]<br>
          Test 1 of 1<br>
          Estimated Trial Run Count:    3<br>
          Estimated Time To Completion: 3 Minutes<br>
              Started Run 1 @ 21:20:05<br>
              Started Run 2 @ 21:21:07<br>
              Started Run 3 @ 21:22:10  [Std. Dev: 1.49%]<br>
      <br>
          Test Results:<br>
              203.0471676<br>
              199.6622532<br>
              197.0954183<br>
      <br>
          Average: 199.93 Frames Per Second<br>
          Minimum: 132<br>
          Maximum: 349<br>
      <br>
      Well that looks like some improvement.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 28.08.2017 um 14:59 schrieb Zhou, David(ChunMing):<br>
    </div>
    <blockquote type="cite"
cite="mid:MWHPR1201MB0206D4E64E86D7AADA159A47B49E0-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <div>I will push our vulkan guys to test it, their bo list is very long.<br>
        <br>
        <p dir="ltr" style="display:inline"><span style="color:#888888"><span
              style="font-size:0.81em">发自坚果 Pro</span></span></p>
        <style type="text/css">
<!--
* body
	{padding:0 16px 30px!important;
	margin:0!important;
	background-color:#ffffff;
	line-height:1.4;
	word-wrap:break-word;
	word-break:normal}
div
	{word-wrap:break-word;
	word-break:normal}
p
	{word-wrap:break-word;
	word-break:normal;
	text-indent:0pt!important}
span
	{word-wrap:break-word;
	word-break:normal}
a
	{word-wrap:break-word;
	word-break:normal}
td
	{word-wrap:break-word;
	word-break:break-all}
-->
</style>
        <div class="x_quote">
          <div style="margin:0 0px; font-size:105%"><font
              style="line-height:1.4" color="#629140"><span>Christian
                K鰊ig <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a> 于 2017年8月28日
                下午7:55写道：</span></font></div>
          <br type="attribution">
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">Am 28.08.2017 um 06:21 schrieb zhoucm1:<br>
            &gt;<br>
            &gt;<br>
            &gt; On 2017年08月27日 18:03, Christian König wrote:<br>
            &gt;&gt; Am 25.08.2017 um 21:19 schrieb Christian König:<br>
            &gt;&gt;&gt; Am 25.08.2017 um 18:22 schrieb Marek Olšák:<br>
            &gt;&gt;&gt;&gt; On Fri, Aug 25, 2017 at 3:00 PM, Christian
            König<br>
            &gt;&gt;&gt;&gt; <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a> wrote:<br>
            &gt;&gt;&gt;&gt;&gt; Am 25.08.2017 um 12:32 schrieb zhoucm1:<br>
            &gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;&gt; On 2017年08月25日 17:38, Christian
            König wrote:<br>
            &gt;&gt;&gt;&gt;&gt;&gt;&gt; From: Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;&gt; Add the IOCTL interface so that
            applications can allocate per VM <br>
            &gt;&gt;&gt;&gt;&gt;&gt;&gt; BOs.<br>
            &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;&gt;&gt; Still WIP since not all corner
            cases are tested yet, but this <br>
            &gt;&gt;&gt;&gt;&gt;&gt;&gt; reduces<br>
            &gt;&gt;&gt;&gt;&gt;&gt;&gt; average<br>
            &gt;&gt;&gt;&gt;&gt;&gt;&gt; CS overhead for 10K BOs from
            21ms down to 48us.<br>
            &gt;&gt;&gt;&gt;&gt;&gt; Wow, cheers, eventually you get per
            vm bo to same reservation <br>
            &gt;&gt;&gt;&gt;&gt;&gt; with PD/pts,<br>
            &gt;&gt;&gt;&gt;&gt;&gt; indeed save a lot of bo list.<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; Don't cheer to loud yet, that is a
            completely constructed test case.<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; So far I wasn't able to archive any
            improvements with any real <br>
            &gt;&gt;&gt;&gt;&gt; game on this<br>
            &gt;&gt;&gt;&gt;&gt; with Mesa.<br>
            &gt; With thinking more, too many BOs share one reservation,
            which could <br>
            &gt; result in reservation lock often is busy, if eviction
            or destroy also <br>
            &gt; happens often in the meaning time, then which could
            effect VM update <br>
            &gt; and CS submission as well.<br>
            <br>
            That's exactly the reason why I've added code to the BO
            destroy path to <br>
            avoid at least some of the problems. But yeah, that's only
            the tip of <br>
            the iceberg of problems with that approach.<br>
            <br>
            &gt; Anyway, this is very good start and try that we reduce
            CS overhead, <br>
            &gt; especially we've seen "reduces average CS overhead for
            10K BOs from <br>
            &gt; 21ms down to 48us. ".<br>
            <br>
            Actually, it's not that good. See this is a completely build
            up test <br>
            case on a kernel with lockdep and KASAN enabled.<br>
            <br>
            In reality we usually don't have so many BOs and so far I
            wasn't able to <br>
            find much of an improvement in any real world testing.<br>
            <br>
            Regards,<br>
            Christian.<br>
          </div>
        </span></font>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------D611DE905B83654816640270--

--===============0841725084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0841725084==--
