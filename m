From: "Mao, David" <David.Mao-5C7GfCeVMHo@public.gmane.org>
Subject: Initial release of AMD Open Source Driver for Vulkan
Date: Fri, 22 Dec 2017 11:03:26 +0000
Message-ID: <BN6PR1201MB012970C5E9B13A10B77FD103EE020@BN6PR1201MB0129.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0439842878=="
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

--===============0439842878==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR1201MB012970C5E9B13A10B77FD103EE020BN6PR1201MB0129_"

--_000_BN6PR1201MB012970C5E9B13A10B77FD103EE020BN6PR1201MB0129_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We are pleased to announce the initial release of AMD Open Source Driver fo=
r Vulkan.



The AMD Open Source Driver for Vulkan is an open-source Vulkan driver for R=
adeon graphics adapters on Linux. It is built on top of AMD's Platform Abst=
raction Library (PAL), a shared component that is designed to encapsulate c=
ertain hardware and OS-specific programming details for many of AMD's 3D an=
d compute drivers. Leveraging PAL can help provide a consistent experience =
across platforms, including support for recently released GPUs and compatib=
ility with AMD developer tools.



The driver uses the LLVM-Based Pipeline Compiler (LLPC) library to compile =
shaders that compose a particular VkPipeline object. LLPC builds on LLVM's =
existing shader compilation infrastructure for AMD GPUs to generate code ob=
jects compatible with PAL's pipeline ABI.



The AMD Open Source Driver for Vulkan is designed to support the following =
features:

- Vulkan 1.0

- More than 30 extensions

- Radeon GPUProfiler tracing

- Built-in debug and profiling tools

- Mid-command buffer preemption and SR-IOV virtualization



The following features and improvements are planned in future releases:

- Upcoming versions of the Vulkan API

- Hardware performance counter collection through RenderDoc

- LLPC optimizations to improve GPU-limited performance and compile time

- Optimizations to improve CPU-limited performance



Please refer to  the README file under https://github.com/GPUOpen-Drivers/A=
MDVLK   for more information.  Looking forward to hearing your feedback.



Thanks,



The AMD driver team for Vulkan


--_000_BN6PR1201MB012970C5E9B13A10B77FD103EE020BN6PR1201MB0129_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
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
<p class=3D"MsoPlainText">We are pleased to announce the initial release of=
 AMD Open Source Driver for Vulkan.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">The AMD Open Source Driver for Vulkan is an open-=
source Vulkan driver for Radeon graphics adapters on Linux. It is built on =
top of AMD's Platform Abstraction Library (PAL), a shared component that is=
 designed to encapsulate certain hardware
 and OS-specific programming details for many of AMD's 3D and compute drive=
rs. Leveraging PAL can help provide a consistent experience across platform=
s, including support for recently released GPUs and compatibility with AMD =
developer tools.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">The driver uses the LLVM-Based Pipeline Compiler =
(LLPC) library to compile shaders that compose a particular VkPipeline obje=
ct. LLPC builds on LLVM's existing shader compilation infrastructure for AM=
D GPUs to generate code objects compatible
 with PAL's pipeline ABI.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">The AMD Open Source Driver for Vulkan is designed=
 to support the following features:<o:p></o:p></p>
<p class=3D"MsoPlainText">- Vulkan 1.0<o:p></o:p></p>
<p class=3D"MsoPlainText">- More than 30 extensions<o:p></o:p></p>
<p class=3D"MsoPlainText">- Radeon GPUProfiler tracing<o:p></o:p></p>
<p class=3D"MsoPlainText">- Built-in debug and profiling tools<o:p></o:p></=
p>
<p class=3D"MsoPlainText">- Mid-command buffer preemption and SR-IOV virtua=
lization<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">The following features and improvements are plann=
ed in future releases:<o:p></o:p></p>
<p class=3D"MsoPlainText">- Upcoming versions of the Vulkan API<o:p></o:p><=
/p>
<p class=3D"MsoPlainText">- Hardware performance counter collection through=
 RenderDoc<o:p></o:p></p>
<p class=3D"MsoPlainText">- LLPC optimizations to improve GPU-limited perfo=
rmance and compile time<o:p></o:p></p>
<p class=3D"MsoPlainText">- Optimizations to improve CPU-limited performanc=
e<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Please refer to&nbsp; the README file under <a hr=
ef=3D"https://github.com/GPUOpen-Drivers/AMDVLK">
https://github.com/GPUOpen-Drivers/AMDVLK</a> &nbsp;&nbsp;for more informat=
ion.&nbsp; Looking forward to hearing your feedback.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">The AMD driver team for Vulkan<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BN6PR1201MB012970C5E9B13A10B77FD103EE020BN6PR1201MB0129_--

--===============0439842878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0439842878==--
