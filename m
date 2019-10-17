From: "Liu, Zhan" <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH v2] drm/amd/display: Modify display link stream setup
 sequence.
Date: Thu, 17 Oct 2019 20:53:31 +0000
Message-ID: <DM6PR12MB3466ECB8AA076B5344C2D6619E6D0@DM6PR12MB3466.namprd12.prod.outlook.com>
References: <DM6PR12MB3466E0D0DADF7599F877F0859E6D0@DM6PR12MB3466.namprd12.prod.outlook.com>
 <BYAPR12MB35608C9F6518E2E0ECF8FB91EC6D0@BYAPR12MB3560.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0527424165=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB35608C9F6518E2E0ECF8FB91EC6D0-ZGDeBxoHBPn7R3asTXea4wdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0527424165==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3466ECB8AA076B5344C2D6619E6D0DM6PR12MB3466namp_"

--_000_DM6PR12MB3466ECB8AA076B5344C2D6619E6D0DM6PR12MB3466namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thx! Will do it.

Zhan

From: Kazlauskas, Nicholas <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Sent: 2019/October/17, Thursday 4:51 PM
To: Liu, Zhan <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH v2] drm/amd/display: Modify display link stream setup s=
equence.

This is actually setting DIG mode a second time, right? I don't think this =
is what sets GC_SEND.

Please mention that this is setting the DIG_MODE to the correct value after=
 having been overridden by the call to transmitter control in your patch de=
scription. Also correct the HACK comment to mention that this second call i=
s needed to reconfigure the DIG as a workaround for the incorrect value bei=
ng applied from transmitter control. Specifics help in source.

I don't think there is a case where we'd want HDMI changed to DVI so it's p=
robably fine to leave this as is for now...

With those fixed, you can add my:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org<mailto:nichol=
as.kazlauskas-5C7GfCeVMHo@public.gmane.org>>

Thanks,

Nicholas Kazlauskas

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Liu, Zhan <Zhan.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Zh=
an.Liu-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, October 17, 2019, 3:04 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Li=
u, Zhan
Subject: [PATCH v2] drm/amd/display: Modify display link stream setup seque=
nce.


[Why]
This patch is for fixing Navi14 pink screen issue. With this
patch, stream->link->link_enc->funcs->setup will be called
twice: this will make sure GC_SEND is set to 1. Though we
still need to look into why the issue only happens on
Linux, but not on Windows side.

[How]
Call stream->link->link_enc->funcs->setup twice.

Signed-off-by: Zhan liu <zhan.liu-5C7GfCeVMHo@public.gmane.org<mailto:zhan.liu-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c
index 935053664160..8683e8613ec2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2842,6 +2842,12 @@ void core_link_enable_stream(
                                        CONTROLLER_DP_TEST_PATTERN_VIDEOMOD=
E,
                                        COLOR_DEPTH_UNDEFINED);

+               /* Hack on Navi14: fixes Navi14 HDMI pink screen issue */
+               if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
+                       stream->link->link_enc->funcs->setup(
+                               stream->link->link_enc,
+                               pipe_ctx->stream->signal);
+
 #ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
                if (pipe_ctx->stream->timing.flags.DSC) {
                        if (dc_is_dp_signal(pipe_ctx->stream->signal) ||
--
2.17.0
_______________________________________________
amd-gfx mailing list
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_DM6PR12MB3466ECB8AA076B5344C2D6619E6D0DM6PR12MB3466namp_
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
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.emailquote, li.emailquote, div.emailquote
	{mso-style-name:emailquote;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:1.0pt;
	border:none;
	padding:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<p class=3D"MsoNormal">Thx! Will do it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Zhan<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazla=
uskas-5C7GfCeVMHo@public.gmane.org&gt;
<br>
<b>Sent:</b> 2019/October/17, Thursday 4:51 PM<br>
<b>To:</b> Liu, Zhan &lt;Zhan.Liu-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g<br>
<b>Subject:</b> Re: [PATCH v2] drm/amd/display: Modify display link stream =
setup sequence.<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">This is actually setting DIG mode a second time, right? I don't think =
this is what sets GC_SEND.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Please mention that this is setting the DIG_MODE to the correct value =
after having been overridden by the call to transmitter control in your pat=
ch description. Also correct the HACK
 comment to mention that this second call is needed to reconfigure the DIG =
as a workaround for the incorrect value being applied from transmitter cont=
rol. Specifics help in source.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">I don't think there is a case where we'd want HDMI changed to DVI so i=
t's probably fine to leave this as is for now...<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">With those fixed, you can add my:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Reviewed-by: Nicholas Kazlauskas &lt;<a href=3D"mailto:nicholas.kazlau=
skas-5C7GfCeVMHo@public.gmane.org">nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Nicholas Kazlauskas<o:p></o:p></span></p>
<div id=3D"id-77342fb2-e4ed-464c-97e1-4a1a620e36e9">
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><strong><span style=3D"font-family:&quot;Calibri&quo=
t;,sans-serif">From:</span></strong> amd-gfx &lt;<a href=3D"mailto:amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt=
; on behalf of Liu, Zhan &lt;<a href=3D"mailto:Zhan.Liu-5C7GfCeVMHo@public.gmane.org">Zhan.Liu@a=
md.com</a>&gt;<br>
<strong><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">Sent:</s=
pan></strong> Thursday, October 17, 2019, 3:04 PM<br>
<strong><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">To:</spa=
n></strong> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Liu, Zhan<br>
<strong><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">Subject:=
</span></strong> [PATCH v2] drm/amd/display: Modify display link stream set=
up sequence.<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><br>
<br>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">[Why]<br>
This patch is for fixing Navi14 pink screen issue. With this<br>
patch, stream-&gt;link-&gt;link_enc-&gt;funcs-&gt;setup will be called<br>
twice: this will make sure GC_SEND is set to 1. Though we<br>
still need to look into why the issue only happens on<br>
Linux, but not on Windows side.<br>
<br>
[How]<br>
Call stream-&gt;link-&gt;link_enc-&gt;funcs-&gt;setup twice.<br>
<br>
Signed-off-by: Zhan liu &lt;<a href=3D"mailto:zhan.liu-5C7GfCeVMHo@public.gmane.org">zhan.liu@am=
d.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 &#43;&#43;&#43;&#43=
;&#43;&#43;<br>
&nbsp;1 file changed, 6 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/dr=
m/amd/display/dc/core/dc_link.c<br>
index 935053664160..8683e8613ec2 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc_link.c<br>
@@ -2842,6 &#43;2842,12 @@ void core_link_enable_stream(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; COLOR_DEPTH_UNDEFINED);<br>
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Hack on Navi14: fixes Navi14 HDMI pink screen issue */<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!dc_is_virtual_signal(pipe_ctx-&gt;stream-&gt;signal))<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream-&gt;l=
ink-&gt;link_enc-&gt;funcs-&gt;setup(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream-&gt;link-&gt;link_enc,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_ctx-&gt;stream-&gt;signal);<br>
&#43;<br>
&nbsp;#ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (pipe_ctx-&gt;stream-&gt;timing.flags.DSC) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc_is_d=
p_signal(pipe_ctx-&gt;stream-&gt;signal) ||<br>
--<br>
2.17.0<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3466ECB8AA076B5344C2D6619E6D0DM6PR12MB3466namp_--

--===============0527424165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0527424165==--
