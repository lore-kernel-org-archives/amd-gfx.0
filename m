From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/12] Initial TMZ support for libdrm and amdgpu_test
Date: Fri, 15 Nov 2019 14:00:09 +0100
Message-ID: <8557eeab-5939-8c9a-1d28-f6b65b1b4b4c@gmail.com>
References: <MN2PR12MB3838F61E68479F97A65B7E6EF0700@MN2PR12MB3838.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0004083816=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3838F61E68479F97A65B7E6EF0700-rweVpJHSKTrcE+Ck/nypMAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Tuikov, Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0004083816==
Content-Type: multipart/alternative;
 boundary="------------EE36D2F0B8E34FA4C4652FAD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EE36D2F0B8E34FA4C4652FAD
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Patches #2-#5, #8, #10-#12  are Acked-by: Christian König 
<christian.koenig-5C7GfCeVMHo@public.gmane.org>

Patch #7 is most likely a NAK. The interface updated here is deprecated 
as far as I know.

Patch #9: How does that actually work?

Thanks,
Christian.

Am 15.11.19 um 04:34 schrieb Liu, Aaron:
>
> These series of patches are to initial TMZ support for libdrm and 
> amdgpu_test. They are based on amd-staging-hybrid-master20190125 
> branch. So far, gfx/sdma TMZ tests are passed on Raven.
>
> Please review them.
>
> Thanks,
>
> Aaron
>
> Aaron Liu (6):
>
>   amdgpu: using IB flags for TMZ or non-TMZ
>
>   tests/amdgpu: expand secure param for exec_cs_helper
>
>   tests/amdgpu: add atomic_mem cp_packet to verify the secure buffer
>
>   tests/amdgpu: add test to submit a gfx command with secure context
>
>   tests/amdgpu: add atomic dma command to verify the secure buffer
>
>   tests/amdgpu: add test to submit a sdma command with secure context
>
> Huang Rui (6):
>
>   amdgpu: add UAPI for creating encrypted buffers
>
>   tests/amdgpu: add security test suite (v2)
>
>   tests/amdgpu: add secure buffer allocation test for system memory
>
>   tests/amdgpu: add secure buffer allocation test for invisible VRAM
>
>   tests/amdgpu: expand write linear helper for security (v3)
>
>   tests/amdgpu: add device handle as input param for exec_cs_helper and
>
>     write_linear_helper (v4)
>
> amdgpu/amdgpu.h               |   4 +-
>
> amdgpu/amdgpu_cs.c            |   4 ++
>
> include/drm/amdgpu_drm.h      |   5 ++
>
> tests/amdgpu/amdgpu_test.c    |   7 ++
>
> tests/amdgpu/amdgpu_test.h    |  27 +++++++
>
> tests/amdgpu/basic_tests.c    | 161 
> ++++++++++++++++++++++++++++++++++++------
>
> tests/amdgpu/meson.build      |   2 +-
>
> tests/amdgpu/security_tests.c | 134 +++++++++++++++++++++++++++++++++++
>
> 8 files changed, 322 insertions(+), 22 deletions(-)
>
> create mode 100644 tests/amdgpu/security_tests.c
>
> BR,
>
> Aaron Liu
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------EE36D2F0B8E34FA4C4652FAD
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Patches #2-#5, #8, #10-#12  are
      Acked-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      <br>
      Patch #7 is most likely a NAK. The interface updated here is
      deprecated as far as I know.<br>
      <br>
      Patch #9: How does that actually work?<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 15.11.19 um 04:34 schrieb Liu, Aaron:<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB3838F61E68479F97A65B7E6EF0700-rweVpJHSKTrcE+Ck/nypMAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoPlainText">These series of patches are to initial
          TMZ support for libdrm and amdgpu_test. They are based on
          amd-staging-hybrid-master20190125 branch. So far, gfx/sdma TMZ
          tests are passed on Raven.<o:p></o:p></p>
        <p class="MsoPlainText">Please review them.<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">Thanks,<o:p></o:p></p>
        <p class="MsoPlainText">Aaron<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Aaron Liu (6):<o:p></o:p></p>
        <p class="MsoNormal">  amdgpu: using IB flags for TMZ or non-TMZ<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: expand secure param for
          exec_cs_helper<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add atomic_mem cp_packet to
          verify the secure buffer<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add test to submit a gfx
          command with secure context<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add atomic dma command to
          verify the secure buffer<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add test to submit a sdma
          command with secure context<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Huang Rui (6):<o:p></o:p></p>
        <p class="MsoNormal">  amdgpu: add UAPI for creating encrypted
          buffers<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add security test suite
          (v2)<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add secure buffer
          allocation test for system memory<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add secure buffer
          allocation test for invisible VRAM<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: expand write linear helper
          for security (v3)<o:p></o:p></p>
        <p class="MsoNormal">  tests/amdgpu: add device handle as input
          param for exec_cs_helper and<o:p></o:p></p>
        <p class="MsoNormal">    write_linear_helper (v4)<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">amdgpu/amdgpu.h               |   4 +-<o:p></o:p></p>
        <p class="MsoNormal">amdgpu/amdgpu_cs.c            |   4 ++<o:p></o:p></p>
        <p class="MsoNormal">include/drm/amdgpu_drm.h      |   5 ++<o:p></o:p></p>
        <p class="MsoNormal">tests/amdgpu/amdgpu_test.c    |   7 ++<o:p></o:p></p>
        <p class="MsoNormal">tests/amdgpu/amdgpu_test.h    |  27 +++++++<o:p></o:p></p>
        <p class="MsoNormal">tests/amdgpu/basic_tests.c    | 161
          ++++++++++++++++++++++++++++++++++++------<o:p></o:p></p>
        <p class="MsoNormal">tests/amdgpu/meson.build      |   2 +-<o:p></o:p></p>
        <p class="MsoNormal">tests/amdgpu/security_tests.c | 134
          +++++++++++++++++++++++++++++++++++<o:p></o:p></p>
        <p class="MsoNormal">8 files changed, 322 insertions(+), 22
          deletions(-)<o:p></o:p></p>
        <p class="MsoNormal">create mode 100644
          tests/amdgpu/security_tests.c<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">BR,<o:p></o:p></p>
        <p class="MsoNormal">Aaron Liu<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------EE36D2F0B8E34FA4C4652FAD--

--===============0004083816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0004083816==--
