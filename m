From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fix NULL ptr when calculating refresh
 rate
Date: Tue, 27 Nov 2018 19:01:05 +0000
Message-ID: <MW2PR12MB25886720FCF7C3C895D3FF00F9D00@MW2PR12MB2588.namprd12.prod.outlook.com>
References: <20181127184554.12527-1-Jerry.Zuo@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0093203236=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181127184554.12527-1-Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Zuo, Jerry" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============0093203236==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW2PR12MB25886720FCF7C3C895D3FF00F9D00MW2PR12MB2588namp_"

--_000_MW2PR12MB25886720FCF7C3C895D3FF00F9D00MW2PR12MB2588namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Jerry (F=
angzhi) Zuo <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>
Sent: November 27, 2018 1:45:54 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harry; Lakha, Bhawanpreet
Cc: Zuo, Jerry
Subject: [PATCH] drm/amd/display: Fix NULL ptr when calculating refresh rat=
e

Calculate preferred refresh rate only when preferred mode exists.

Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 27df3ae945be..3039faf004a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2835,7 +2835,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *ac=
onnector,
         bool native_mode_found =3D false;
         bool scale =3D dm_state ? (dm_state->scaling !=3D RMX_OFF) : false=
;
         int mode_refresh;
-       int preferred_refresh;
+       int preferred_refresh =3D 0;

         struct dc_sink *sink =3D NULL;
         if (aconnector =3D=3D NULL) {
@@ -2889,13 +2889,12 @@ create_stream_for_sink(struct amdgpu_dm_connector *=
aconnector,
                 decide_crtc_timing_for_drm_display_mode(
                                 &mode, preferred_mode,
                                 dm_state ? (dm_state->scaling !=3D RMX_OFF=
) : false);
+               preferred_refresh =3D drm_mode_vrefresh(preferred_mode);
         }

         if (!dm_state)
                 drm_mode_set_crtcinfo(&mode, 0);

-       preferred_refresh =3D drm_mode_vrefresh(preferred_mode);
-
         /*
         * If scaling is enabled and refresh rate didn't change
         * we copy the vic and polarities of the old timings
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MW2PR12MB25886720FCF7C3C895D3FF00F9D00MW2PR12MB2588namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span><span>Reviewed-by:</span> B=
hawanpreet Lakha &lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Jerry (Fangzhi) Zuo &lt;Jerry=
.Zuo-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> November 27, 2018 1:45:54 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Wentland, Harry; Lakha, Bhawanpre=
et<br>
<b>Cc:</b> Zuo, Jerry<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix NULL ptr when calculating refr=
esh rate</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Calculate preferred refresh rate only when preferr=
ed mode exists.<br>
<br>
Signed-off-by: Jerry (Fangzhi) Zuo &lt;Jerry.Zuo-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 &#43;&#43;---<b=
r>
&nbsp;1 file changed, 2 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index 27df3ae945be..3039faf004a8 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -2835,7 &#43;2835,7 @@ create_stream_for_sink(struct amdgpu_dm_connector=
 *aconnector,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool native_mode_found =3D=
 false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool scale =3D dm_state ? =
(dm_state-&gt;scaling !=3D RMX_OFF) : false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int mode_refresh;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int preferred_refresh;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int preferred_refresh =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_sink *sink =3D N=
ULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aconnector =3D=3D NULL=
) {<br>
@@ -2889,13 &#43;2889,12 @@ create_stream_for_sink(struct amdgpu_dm_connect=
or *aconnector,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; decide_crtc_timing_for_drm_display_mode(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;mode, preferred_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_state ? (dm_state-&gt;scaling=
 !=3D RMX_OFF) : false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; preferred_refresh =3D drm_mode_vrefresh(preferred_mode);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dm_state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_mode_set_crtcinfo(&amp;mode, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preferred_refresh =3D drm_mode_vrefre=
sh(preferred_mode);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If scaling is enabled an=
d refresh rate didn't change<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * we copy the vic and pola=
rities of the old timings<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MW2PR12MB25886720FCF7C3C895D3FF00F9D00MW2PR12MB2588namp_--

--===============0093203236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0093203236==--
