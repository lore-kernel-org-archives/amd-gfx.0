From: "Lvzhihong (ReJohn)" <lvzhihong1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: How to enable Radeon Pro Duo with mesa
Date: Wed, 14 Mar 2018 09:41:42 +0000
Message-ID: <E7DD0E9246072C4A9CA8F1C79F816696018E7743@dggemi505-mbx.china.huawei.com>
References: <EB021AE3BDDC1742A899855D00BABEB0010451CE@DGGEMM506-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0012846268=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <EB021AE3BDDC1742A899855D00BABEB0010451CE-0LhPdUyVHB9548jd+VSckwK1hpo4iccwjNknBlVQO8k@public.gmane.org>
Content-Language: zh-CN
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
Cc: sunnanyong <sunnanyong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

--===============0012846268==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_E7DD0E9246072C4A9CA8F1C79F816696018E7743dggemi505mbxchi_"

--_000_E7DD0E9246072C4A9CA8F1C79F816696018E7743dggemi505mbxchi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All ,
Does mesa support Radeon Pro Duo? I don't know how to configure xorg.conf t=
o use two WX7100 card of DUO , and now I can only use the first card of DUO=
.
Installed software packages: xserver-xorg  xfce4  xinit
Mesa version: 17.2.8  kernel version: 4.15

Pci information:
000d:31:00.0 PCI bridge: PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI =
Express Gen 3 (8.0 GT/s) Switch (rev ca)
000d:32:08.0 PCI bridge: PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI =
Express Gen 3 (8.0 GT/s) Switch (rev ca)
000d:32:10.0 PCI bridge: PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI =
Express Gen 3 (8.0 GT/s) Switch (rev ca)
000d:33:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/A=
TI] Ellesmere [Radeon Pro WX 7100]
000d:33:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device aa=
f0
000d:34:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Ell=
esmere [Radeon Pro WX 7100]

My xorg.conf:
Section "Device"
       Identifier "AMD"
       Driver "amdgpu"
       BusID "pci:51@13:00:00"
EndSection
Section "Monitor"
        Identifier "monitor0"
        Option "enable" "true"
EndSection
Section "Screen"
        Identifier "screen0"
        Device "AMD"
        Monitor "monitor0"
        DefaultDepth 24
        SubSection "Display"
                Depth 24
        EndSubSection
EndSection

I use "startx" to start desktop , and only the first WX7100(PCI Bus ID: 000=
d:33:00.0) being used , the second WX7100(PCI Bus ID: 000d:34:00.0) has no =
load .
         Even if I set BusID as "pci:52@13:00:00" (the second WX7100), it s=
till only the first WX7100 being used.

      So , How to enable Radeon Pro Duo with opensource driver , does my xo=
rg.conf is wrong or mesa doesn't support Radeon Pro Duo?



--_000_E7DD0E9246072C4A9CA8F1C79F816696018E7743dggemi505mbxchi_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
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
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"text-justify-t=
rim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi All , <o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">Do=
es mesa support Radeon Pro D<span style=3D"color:#1F497D">uo</span>? I don&=
#8217;t know how to configure xorg.conf to use two WX7100 card of DUO , and=
 now I can only use the first card of DUO.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">In=
stalled software packages:<span style=3D"layout-grid-mode:line"> xserver-xo=
rg &nbsp;xfce4 &nbsp;xinit
</span><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">Me=
sa version: 17.2.8 &nbsp;kernel version: 4.15
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">Pc=
i information:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">00=
0d:31:00.0 PCI bridge: PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Ex=
press Gen 3 (8.0 GT/s) Switch (rev ca)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">00=
0d:32:08.0 PCI bridge: PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Ex=
press Gen 3 (8.0 GT/s) Switch (rev ca)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">00=
0d:32:10.0 PCI bridge: PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Ex=
press Gen 3 (8.0 GT/s) Switch (rev ca)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">00=
0d:33:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI=
] Ellesmere [Radeon Pro WX 7100]<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">00=
0d:33:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device aaf0=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">00=
0d:34:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Elles=
mere [Radeon Pro WX 7100]<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">My=
 xorg.conf:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">Se=
ction &quot;Device&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Identifier &quot;AMD&quot;<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Driver &quot;amdgpu&quot;<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BusID &quot;pci:51@13:00:00&quot;<o:p></=
o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">En=
dSection<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">Se=
ction &quot;Monitor&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Identifier &quot;monitor0&quot;<o:=
p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Option &quot;enable&quot; &quot;tr=
ue&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">En=
dSection<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">Se=
ction &quot;Screen&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Identifier &quot;screen0&quot;<o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Device &quot;AMD&quot;<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Monitor &quot;monitor0&quot;<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DefaultDepth 24<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SubSection &quot;Display&quot;<o:p=
></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; Depth 24<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EndSubSection<o:p></o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">En=
dSection<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US"><o=
:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:21.0pt"><span lang=3D"EN-US">I =
use &#8220;startx&#8221; to start desktop , and only the first WX7100(PCI B=
us ID: 000d:33:00.0) being used , the second WX7100(PCI Bus ID: 000d:34:00.=
0) has no load .<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D">&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Even if I set BusID as
</span><span lang=3D"EN-US">&quot;pci:52@13:00:00&quot; (the second WX7100)=
, it still only the first WX7100 being used.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;So , How to enable Radeon Pro Duo with opensource driver , does my xor=
g.conf is wrong or mesa doesn&#8217;t support Radeon Pro D<span style=3D"co=
lor:#1F497D">uo?</span><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"color:#1F497D"><o:p>&n=
bsp;</o:p></span></p>
</div>
</body>
</html>

--_000_E7DD0E9246072C4A9CA8F1C79F816696018E7743dggemi505mbxchi_--

--===============0012846268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0012846268==--
