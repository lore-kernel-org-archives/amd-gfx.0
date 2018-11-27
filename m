From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/display: limit high pixel clock modes on ST/CZ
Date: Tue, 27 Nov 2018 08:58:12 +0000
Message-ID: <BLUPR12MB045213B336F6D1D61674CFEFF2D00@BLUPR12MB0452.namprd12.prod.outlook.com>
References: <1543214171-12460-1-git-send-email-shirish.s@amd.com>
 <BN6PR12MB1809F50687D05789C14E6C61F7D70@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BLUPR12MB0452C3CF56CBB8089FB9D5CBF2D00@BLUPR12MB0452.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1002405692=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0452C3CF56CBB8089FB9D5CBF2D00-7LeqcoF/hwohIaQXubWUmgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1002405692==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB045213B336F6D1D61674CFEFF2D00BLUPR12MB0452namp_"

--_000_BLUPR12MB045213B336F6D1D61674CFEFF2D00BLUPR12MB0452namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

However, while using Type-C connectors noted that the signal type is actual=
ly SIGNAL_TYPE_DISPLAY_PORT and found that the check was missing.
Hence have added the same in https://patchwork.freedesktop.org/patch/264033=
/

Regards,
Shirish S

From: S, Shirish
Sent: Tuesday, November 27, 2018 9:54 AM
To: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Li, Sun peng (Leo) <Sun=
peng.Li-5C7GfCeVMHo@public.gmane.org>; Wentland, Harry <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH] drm/amd/display: limit high pixel clock modes on ST/CZ

Thanks Alex, found that patch.
My patch is no more required.


Regards,
Shirish S

From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deuche=
r@amd.com>>
Sent: Monday, November 26, 2018 7:46 PM
To: S, Shirish <Shirish.S-5C7GfCeVMHo@public.gmane.org<mailto:Shirish.S-5C7GfCeVMHo@public.gmane.org>>; Li, Sun peng =
(Leo) <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org<mailto:Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>>; Wentland, Harry <Har=
ry.Wentland-5C7GfCeVMHo@public.gmane.org<mailto:Harry.Wentland-5C7GfCeVMHo@public.gmane.org>>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: limit high pixel clock modes on ST/CZ


I thought there was a patch to do this already that got sent out a few week=
s ago.  Basically limit ST/CZ to modes that do not require a retimer.  Is a=
n additional patch needed?



Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of S, Shirish <Shirish.S-5C7GfCeVMHo@public.gmane.org<mailto:=
Shirish.S-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, November 26, 2018 1:36:30 AM
To: Li, Sun peng (Leo); Wentland, Harry
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; S,=
 Shirish
Subject: [PATCH] drm/amd/display: limit high pixel clock modes on ST/CZ

[Why]
ST/CZ (dce110) advertises modes such as 4k@60Hz etc.,
that it cannot handle correctly, hence  resulting in
several issues like flickering, black lines/flashes and so on.

[How]
These modes are basically high pixel clock ones, hence
limit the same to be advertised to avoid bad user experiences

Signed-off-by: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org<mailto:shirish.s-5C7GfCeVMHo@public.gmane.org>>
Suggested-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org<mailto:harry.wentland@=
amd.com>>
---
 .../gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c    | 10 ++++++=
++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.=
c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
index 1b2fe0d..1b8fe99 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
@@ -1121,6 +1121,16 @@ bool dce110_timing_generator_validate_timing(
         if (!timing)
                 return false;

+       /* Limit all modes that have a high pixel clock
+        * which seems to be problematic on dce110
+        * These include: 4k@60Hz, 1080p@144Hz,1440p@120Hz
+        * based on the below formula:
+        * refresh rate =3D pixel clock / (htotal * vtotal)
+        */
+       if (timing->pix_clk_khz > 300000)
+               return false;
+
+
         hsync_offset =3D timing->h_border_right + timing->h_front_porch;
         h_sync_start =3D timing->h_addressable + hsync_offset;

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BLUPR12MB045213B336F6D1D61674CFEFF2D00BLUPR12MB0452namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">However, while using Type-C connectors noted that th=
e signal type is actually SIGNAL_TYPE_DISPLAY_PORT and found that the check=
 was missing.<o:p></o:p></p>
<p class=3D"MsoNormal">Hence have added the same in <a href=3D"https://patc=
hwork.freedesktop.org/patch/264033/">
https://patchwork.freedesktop.org/patch/264033/</a><o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Shirish S<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> S, Shirish <br>
<b>Sent:</b> Tuesday, November 27, 2018 9:54 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Li, Sun pe=
ng (Leo) &lt;Sunpeng.Li-5C7GfCeVMHo@public.gmane.org&gt;; Wentland, Harry &lt;Harry.Wentland@amd=
.com&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH] drm/amd/display: limit high pixel clock modes o=
n ST/CZ<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks Alex, found that patch.<o:p></o:p></p>
<p class=3D"MsoNormal">My patch is no more required.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Shirish S<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;<a href=3D"mailt=
o:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;
<br>
<b>Sent:</b> Monday, November 26, 2018 7:46 PM<br>
<b>To:</b> S, Shirish &lt;<a href=3D"mailto:Shirish.S-5C7GfCeVMHo@public.gmane.org">Shirish.S@am=
d.com</a>&gt;; Li, Sun peng (Leo) &lt;<a href=3D"mailto:Sunpeng.Li-5C7GfCeVMHo@public.gmane.org"=
>Sunpeng.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;; Wentland, Harry &lt;<a href=3D"mailto:Harry.We=
ntland-5C7GfCeVMHo@public.gmane.org">Harry.Wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: limit high pixel clock modes o=
n ST/CZ<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">I thought there was a patch=
 to do this already that got sent out a few weeks ago.&nbsp; Basically limi=
t ST/CZ to modes that do not require a retimer.&nbsp; Is an additional patc=
h needed?<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<p><span style=3D"font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f S, Shirish &lt;<a href=3D"mailto:Shirish.S-5C7GfCeVMHo@public.gmane.org">Shirish.S-5C7GfCeVMHo@public.gmane.org</a>=
&gt;<br>
<b>Sent:</b> Monday, November 26, 2018 1:36:30 AM<br>
<b>To:</b> Li, Sun peng (Leo); Wentland, Harry<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a>; S, Shirish<br>
<b>Subject:</b> [PATCH] drm/amd/display: limit high pixel clock modes on ST=
/CZ</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[Why]<br>
ST/CZ (dce110) advertises modes such as 4k@60Hz etc.,<br>
that it cannot handle correctly, hence&nbsp; resulting in<br>
several issues like flickering, black lines/flashes and so on.<br>
<br>
[How]<br>
These modes are basically high pixel clock ones, hence<br>
limit the same to be advertised to avoid bad user experiences<br>
<br>
Signed-off-by: Shirish S &lt;<a href=3D"mailto:shirish.s-5C7GfCeVMHo@public.gmane.org">shirish.s=
@amd.com</a>&gt;<br>
Suggested-by: Harry Wentland &lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">=
harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c&nbsp;&nbs=
p;&nbsp; | 10 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 10 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.=
c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c<br>
index 1b2fe0d..1b8fe99 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_gener=
ator.c<br>
@@ -1121,6 &#43;1121,16 @@ bool dce110_timing_generator_validate_timing(<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!timing)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Limit all modes that have a hi=
gh pixel clock<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * which seems to be problem=
atic on dce110<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * These include: 4k@60Hz, 1=
080p@144Hz,1440p@120Hz<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * based on the below formul=
a:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * refresh rate =3D pixel cl=
ock / (htotal * vtotal)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timing-&gt;pix_clk_khz &gt; 3=
00000)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return false;<br>
&#43;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hsync_offset =3D timing-&g=
t;h_border_right &#43; timing-&gt;h_front_porch;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; h_sync_start =3D timing-&g=
t;h_addressable &#43; hsync_offset;<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_BLUPR12MB045213B336F6D1D61674CFEFF2D00BLUPR12MB0452namp_--

--===============1002405692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1002405692==--
