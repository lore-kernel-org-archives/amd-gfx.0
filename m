From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: weird reservation issues
Date: Wed, 28 Feb 2018 11:49:11 +0100
Message-ID: <ccb5c0e4-7dfd-370f-1449-dc49d42f0d61@amd.com>
References: <BLUPR12MB044995B6521FBE9C389BBE7184C70@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1292331997=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB044995B6521FBE9C389BBE7184C70-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1292331997==
Content-Type: multipart/alternative;
 boundary="------------30AFFC016205931E2C59A00B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------30AFFC016205931E2C59A00B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Monk,

yeah thinking about those issue currently as well. It indeed looks like 
we have some kind of race here.

When we call backoff_reservation the next iteration of the look will 
reserve all BOs again, so that can't be the issue.

Regards,
Christian.

Am 28.02.2018 um 11:37 schrieb Liu, Monk:
>
> Hi Christian
>
> In amdgpu_cs_parser_bos(), it calls ttm_eu_backoff_reservation() if 
> @need_pages not empty, is it safe ?
>
> You see that if two threads in parallel running in cs_parser_bos(), if 
> the thread1 did call backoff_reservation and continue, that leaves
>
> All following reservation functions on root BO executed without 
> protection from the lock, Meanwhile if this time thread2 call 
> cs_parser_bos() in parallel, it can
>
> Get the lock of the reservation object on root BO (assume thread 1/2 
> share the same VM) immediately, so both of those threads consider they 
> are
>
> Under protection of lock of reservation on the root bo. Do you think 
> it’s a race issue ?
>
> You know that I recently hit BUG() in reservation.c, and also found 
> some weird bugs can be fixed by removing the kfree(obj->staged)
>
> In reservation_object_reserve_shared(), and I think you right on the 
> “staged” part that it shouldn’t be freed if everything go with rules (
>
> Always held the lock of the bo)
>
> Thanks
>
> /Monk
>


--------------30AFFC016205931E2C59A00B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Monk,<br>
      <br>
      yeah thinking about those issue currently as well. It indeed looks
      like we have some kind of race here.<br>
      <br>
      When we call backoff_reservation the next iteration of the look
      will reserve all BOs again, so that can't be the issue.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 28.02.2018 um 11:37 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB044995B6521FBE9C389BBE7184C70-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:DengXian;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:DengXian;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:DengXian;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span lang="EN-US">Hi Christian <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">In
            amdgpu_cs_parser_bos(), it calls
            ttm_eu_backoff_reservation() if @need_pages not empty, is it
            safe ?<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">You see that if two
            threads in parallel running in cs_parser_bos(), if the
            thread1 did call backoff_reservation and continue, that
            leaves
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">All following
            reservation functions on root BO executed without protection
            from the lock, Meanwhile if this time thread2 call
            cs_parser_bos() in parallel, it can
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Get the lock of the
            reservation object on root BO (assume thread 1/2 share the
            same VM) immediately, so both of those threads consider they
            are
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Under protection of lock
            of reservation on the root bo. Do you think it’s a race
            issue ?<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">You know that I recently
            hit BUG() in reservation.c, and also found some weird bugs
            can be fixed by removing the kfree(obj-&gt;staged)
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">In
            reservation_object_reserve_shared(), and I think you right
            on the “staged” part that it shouldn’t be freed if
            everything go with rules (<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Always held the lock of
            the bo)<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Thanks <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">/Monk<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------30AFFC016205931E2C59A00B--

--===============1292331997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1292331997==--
