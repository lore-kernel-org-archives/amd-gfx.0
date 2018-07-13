From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: GTT memory usage overflow
Date: Fri, 13 Jul 2018 09:00:49 +0200
Message-ID: <9564a854-21ff-1ca3-34d9-cf9baaa18a8c@gmail.com>
References: <EB021AE3BDDC1742A899855D00BABEB001075B42@DGGEMM506-MBX.china.huawei.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1819925969=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <EB021AE3BDDC1742A899855D00BABEB001075B42-0LhPdUyVHB9548jd+VSckwK1hpo4iccwjNknBlVQO8k@public.gmane.org>
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
To: sunnanyong <sunnanyong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Baixin (BX)" <baixin1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

This is a multi-part message in MIME format.
--===============1819925969==
Content-Type: multipart/alternative;
 boundary="------------F47472819D4FC383B1AA30B2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F47472819D4FC383B1AA30B2
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

no that is certainly not normal.

We temporary allow the kernel to allocate more pages than available when 
we bind stuff into the GART, but that shouldn't have this effect.

How do you allocate the GTT space?

Regards,
Christian.

Am 12.07.2018 um 17:50 schrieb sunnanyong:
>
> Hi All,
>
> When the gtt memory is used up, application continues to use gtt , 
> then the gtt will overflow,
>
> the gtt available will be negative(cat 
> /sys/kernel/debug/dri/1/amdgpu_gtt_mm), and more system memory is used 
> as GTT, is it normal?
>
> My kernel  is newest v4.18 master,  I add “cma=0 amdgpu.gttsize=24576” 
> in kernel boot cmdline.
>
> Please help, Thanks : )
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------F47472819D4FC383B1AA30B2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi,<br>
      <br>
      no that is certainly not normal.<br>
      <br>
      We temporary allow the kernel to allocate more pages than
      available when we bind stuff into the GART, but that shouldn't
      have this effect.<br>
      <br>
      How do you allocate the GTT space?<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 12.07.2018 um 17:50 schrieb sunnanyong:<br>
    </div>
    <blockquote type="cite"
cite="mid:EB021AE3BDDC1742A899855D00BABEB001075B42-0LhPdUyVHB9548jd+VSckwK1hpo4iccwjNknBlVQO8k@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:\5B8B\4F53;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@\5B8B\4F53";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
        <p class="MsoNormal"><span style="color:#1F497D" lang="EN-US">Hi
            All,<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D" lang="EN-US">    
            When the gtt memory is used up, application continues to use
            gtt , then the gtt will overflow,
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D" lang="EN-US">the
            gtt available will be negative(cat
            /sys/kernel/debug/dri/1/amdgpu_gtt_mm), and more system
            memory is used as GTT, is it normal?<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D" lang="EN-US">My
            kernel  is newest v4.18 master,  I add “cma=0
            amdgpu.gttsize=24576” in kernel boot cmdline.<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D" lang="EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="color:#1F497D" lang="EN-US">Please
            help, </span>
          <span style="color:#1F497D" lang="EN-US">Thanks : )</span><span
            style="color:#1F497D" lang="EN-US"><o:p></o:p></span></p>
      </div>
      <!--'"--><br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------F47472819D4FC383B1AA30B2--

--===============1819925969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1819925969==--
