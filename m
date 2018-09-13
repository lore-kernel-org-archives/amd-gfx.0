From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu] Bail from drmmode_cm_init if there's no
 CRTC
Date: Thu, 13 Sep 2018 14:17:30 +0000
Message-ID: <BN6PR12MB180970BEFD08CC749DE18727F71A0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180913094729.2355-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0744074313=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180913094729.2355-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0744074313==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180970BEFD08CC749DE18727F71A0BN6PR12MB1809namp_"

--_000_BN6PR12MB180970BEFD08CC749DE18727F71A0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Thursday, September 13, 2018 5:47:29 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-amdgpu] Bail from drmmode_cm_init if there's no =
CRTC

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

We would crash due to dereferencing the NULL mode_res->crtc pointer.

Bugzilla: https://bugs.freedesktop.org/107913
Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/drmmode_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/drmmode_display.c b/src/drmmode_display.c
index 6ef6a98e2..cbda8ad35 100644
--- a/src/drmmode_display.c
+++ b/src/drmmode_display.c
@@ -3198,6 +3198,9 @@ static void drmmode_cm_init(int drm_fd, drmmode_ptr d=
rmmode,
         memset(drmmode->cm_prop_ids, 0, sizeof(drmmode->cm_prop_ids));
         drmmode->gamma_lut_size =3D drmmode->degamma_lut_size =3D 0;

+       if (!mode_res->crtcs)
+               return;
+
         /* AMD hardware has color management support on all pipes. It is
          * therefore sufficient to only check the first CRTC.
          */
--
2.19.0.rc2

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180970BEFD08CC749DE18727F71A0BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFo=
nt&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols;">
<p style=3D"margin-top:0; margin-bottom:0">Reviewed-by: Alex Deucher &lt;al=
exander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@=
daenzer.net&gt;<br>
<b>Sent:</b> Thursday, September 13, 2018 5:47:29 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-amdgpu] Bail from drmmode_cm_init if ther=
e's no CRTC</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
We would crash due to dereferencing the NULL mode_res-&gt;crtc pointer.<br>
<br>
Bugzilla: <a href=3D"https://bugs.freedesktop.org/107913" id=3D"LPlnk315283=
" class=3D"OWAAutoLink" previewremoved=3D"true">
https://bugs.freedesktop.org/107913</a><br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/drmmode_display.c | 3 &#43;&#43;&#43;<br>
&nbsp;1 file changed, 3 insertions(&#43;)<br>
<br>
diff --git a/src/drmmode_display.c b/src/drmmode_display.c<br>
index 6ef6a98e2..cbda8ad35 100644<br>
--- a/src/drmmode_display.c<br>
&#43;&#43;&#43; b/src/drmmode_display.c<br>
@@ -3198,6 &#43;3198,9 @@ static void drmmode_cm_init(int drm_fd, drmmode_p=
tr drmmode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(drmmode-&gt;cm_prop=
_ids, 0, sizeof(drmmode-&gt;cm_prop_ids));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmmode-&gt;gamma_lut_size=
 =3D drmmode-&gt;degamma_lut_size =3D 0;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!mode_res-&gt;crtcs)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* AMD hardware has color =
management support on all pipes. It is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * therefore sufficie=
nt to only check the first CRTC.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-- <br>
2.19.0.rc2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk971804" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB180970BEFD08CC749DE18727F71A0BN6PR12MB1809namp_--

--===============0744074313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0744074313==--
