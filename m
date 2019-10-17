From: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amd/display: Modify display link stream setup
 sequence.
Date: Thu, 17 Oct 2019 20:50:34 +0000
Message-ID: <BYAPR12MB35608C9F6518E2E0ECF8FB91EC6D0@BYAPR12MB3560.namprd12.prod.outlook.com>
References: <DM6PR12MB3466E0D0DADF7599F877F0859E6D0@DM6PR12MB3466.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0388726509=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM6PR12MB3466E0D0DADF7599F877F0859E6D0-lmeGfMZKVrFD9+oK+SxdZAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Zhan" <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0388726509==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB35608C9F6518E2E0ECF8FB91EC6D0BYAPR12MB3560namp_"

--_000_BYAPR12MB35608C9F6518E2E0ECF8FB91EC6D0BYAPR12MB3560namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>

Thanks,

Nicholas Kazlauskas

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Liu, Zha=
n <Zhan.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, October 17, 2019, 3:04 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Liu, Zhan
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

Signed-off-by: Zhan liu <zhan.liu-5C7GfCeVMHo@public.gmane.org>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_BYAPR12MB35608C9F6518E2E0ECF8FB91EC6D0BYAPR12MB3560namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"ltr" text-align=3D"left">
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
This is actually setting DIG mode a second time, right? I don't think this =
is what sets GC_SEND.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
Please mention that this is setting the DIG_MODE to the correct value after=
 having been overridden by the call to transmitter control in your patch de=
scription. Also correct the HACK comment to mention that this second call i=
s needed to reconfigure the DIG
 as a workaround for the incorrect value being applied from transmitter con=
trol. Specifics help in source.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
I don't think there is a case where we'd want HDMI changed to DVI so it's p=
robably fine to leave this as is for now...</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
With those fixed, you can add my:</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
Reviewed-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
Thanks,</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"ltr">
Nicholas Kazlauskas</div>
<div id=3D"id-77342fb2-e4ed-464c-97e1-4a1a620e36e9" class=3D"ms-outlook-mob=
ile-reference-message">
<div style=3D"font-family: sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;"><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg"><strong>From:</strong> amd-gfx &lt;amd-gfx-bounce=
s@lists.freedesktop.org&gt; on behalf of Liu, Zhan &lt;Zhan.Liu-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
<strong>Sent:</strong> Thursday, October 17, 2019, 3:04 PM<br>
<strong>To:</strong> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Liu, Zhan<br>
<strong>Subject:</strong> [PATCH v2] drm/amd/display: Modify display link s=
tream setup sequence.<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style><font size=3D"=
2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">[Why]<br>
This patch is for fixing Navi14 pink screen issue. With this<br>
patch, stream-&gt;link-&gt;link_enc-&gt;funcs-&gt;setup will be called<br>
twice: this will make sure GC_SEND is set to 1. Though we<br>
still need to look into why the issue only happens on<br>
Linux, but not on Windows side.<br>
<br>
[How]<br>
Call stream-&gt;link-&gt;link_enc-&gt;funcs-&gt;setup twice.<br>
<br>
Signed-off-by: Zhan liu &lt;zhan.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font><br>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB35608C9F6518E2E0ECF8FB91EC6D0BYAPR12MB3560namp_--

--===============0388726509==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0388726509==--
