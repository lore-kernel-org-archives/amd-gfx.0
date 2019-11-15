From: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 00/12] Initial TMZ support for libdrm and amdgpu_test
Date: Fri, 15 Nov 2019 03:34:41 +0000
Message-ID: <MN2PR12MB3838F61E68479F97A65B7E6EF0700@MN2PR12MB3838.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0698823465=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Tuikov, Luben" <Luben.Tuikov-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0698823465==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3838F61E68479F97A65B7E6EF0700MN2PR12MB3838namp_"

--_000_MN2PR12MB3838F61E68479F97A65B7E6EF0700MN2PR12MB3838namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

These series of patches are to initial TMZ support for libdrm and amdgpu_te=
st. They are based on amd-staging-hybrid-master20190125 branch. So far, gfx=
/sdma TMZ tests are passed on Raven.

Please review them.



Thanks,

Aaron

Aaron Liu (6):
  amdgpu: using IB flags for TMZ or non-TMZ
  tests/amdgpu: expand secure param for exec_cs_helper
  tests/amdgpu: add atomic_mem cp_packet to verify the secure buffer
  tests/amdgpu: add test to submit a gfx command with secure context
  tests/amdgpu: add atomic dma command to verify the secure buffer
  tests/amdgpu: add test to submit a sdma command with secure context

Huang Rui (6):
  amdgpu: add UAPI for creating encrypted buffers
  tests/amdgpu: add security test suite (v2)
  tests/amdgpu: add secure buffer allocation test for system memory
  tests/amdgpu: add secure buffer allocation test for invisible VRAM
  tests/amdgpu: expand write linear helper for security (v3)
  tests/amdgpu: add device handle as input param for exec_cs_helper and
    write_linear_helper (v4)

amdgpu/amdgpu.h               |   4 +-
amdgpu/amdgpu_cs.c            |   4 ++
include/drm/amdgpu_drm.h      |   5 ++
tests/amdgpu/amdgpu_test.c    |   7 ++
tests/amdgpu/amdgpu_test.h    |  27 +++++++
tests/amdgpu/basic_tests.c    | 161 ++++++++++++++++++++++++++++++++++++---=
---
tests/amdgpu/meson.build      |   2 +-
tests/amdgpu/security_tests.c | 134 +++++++++++++++++++++++++++++++++++
8 files changed, 322 insertions(+), 22 deletions(-)
create mode 100644 tests/amdgpu/security_tests.c

BR,
Aaron Liu


--_000_MN2PR12MB3838F61E68479F97A65B7E6EF0700MN2PR12MB3838namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
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
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">These series of patches are to initial TMZ suppor=
t for libdrm and amdgpu_test. They are based on amd-staging-hybrid-master20=
190125 branch. So far, gfx/sdma TMZ tests are passed on Raven.<o:p></o:p></=
p>
<p class=3D"MsoPlainText">Please review them.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks,<o:p></o:p></p>
<p class=3D"MsoPlainText">Aaron<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Aaron Liu (6):<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; amdgpu: using IB flags for TMZ or non-TMZ<o:p=
></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: expand secure param for exec_cs=
_helper<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add atomic_mem cp_packet to ver=
ify the secure buffer<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add test to submit a gfx comman=
d with secure context<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add atomic dma command to verif=
y the secure buffer<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add test to submit a sdma comma=
nd with secure context<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Huang Rui (6):<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; amdgpu: add UAPI for creating encrypted buffe=
rs<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add security test suite (v2)<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add secure buffer allocation te=
st for system memory<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add secure buffer allocation te=
st for invisible VRAM<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: expand write linear helper for =
security (v3)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; tests/amdgpu: add device handle as input para=
m for exec_cs_helper and<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; write_linear_helper (v4)<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 &#43;-<o:p>=
</o:p></p>
<p class=3D"MsoNormal">amdgpu/amdgpu_cs.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 4 &#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">include/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp;&nbsp; 5 &#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">tests/amdgpu/amdgpu_test.c&nbsp;&nbsp;&nbsp; |&nbsp;=
&nbsp; 7 &#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">tests/amdgpu/amdgpu_test.h&nbsp;&nbsp;&nbsp; |&nbsp;=
 27 &#43;&#43;&#43;&#43;&#43;&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">tests/amdgpu/basic_tests.c&nbsp;&nbsp;&nbsp; | 161 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;------<o:p></o:p></p>
<p class=3D"MsoNormal">tests/amdgpu/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp;&nbsp; 2 &#43;-<o:p></o:p></p>
<p class=3D"MsoNormal">tests/amdgpu/security_tests.c | 134 &#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">8 files changed, 322 insertions(&#43;), 22 deletions=
(-)<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 tests/amdgpu/security_tests.c<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Aaron Liu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3838F61E68479F97A65B7E6EF0700MN2PR12MB3838namp_--

--===============0698823465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0698823465==--
