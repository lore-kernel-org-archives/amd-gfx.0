From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/5] drm/amd/powerplay: add interface for getting workload
 type
Date: Mon, 23 Sep 2019 09:25:09 +0000
Message-ID: <MN2PR12MB3296E79B53B6AE2974C534CCA2850@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <1569228167-3120-1-git-send-email-Prike.Liang@amd.com>,
 <1569228167-3120-3-git-send-email-Prike.Liang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0450155697=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1569228167-3120-3-git-send-email-Prike.Liang-5C7GfCeVMHo@public.gmane.org>
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
To: "Liang, Prike" <Prike.Liang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "arron.liu-5C7GfCeVMHo@public.gmane.org" <arron.liu-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>

--===============0450155697==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296E79B53B6AE2974C534CCA2850MN2PR12MB3296namp_"

--_000_MN2PR12MB3296E79B53B6AE2974C534CCA2850MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Liang, P=
rike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, September 23, 2019 4:43 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: arron.liu-5C7GfCeVMHo@public.gmane.org <arron.liu-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; =
Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Feng, K=
enneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/5] drm/amd/powerplay: add interface for getting workload =
type

The workload type was got from the input of power profile mode.

Signed-off-by: Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 29 ++++++++++++++++++++++++++=
+++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index 4bb7e1c..f87aa56 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -364,6 +364,34 @@ static int renoir_unforce_dpm_levels(struct smu_contex=
t *smu) {
         return ret;
 }

+static int renoir_get_workload_type(struct smu_context *smu, uint32_t prof=
ile)
+{
+
+       uint32_t  pplib_workload =3D 0;
+
+       switch (profile) {
+       case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
+               pplib_workload =3D WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT;
+               break;
+       case PP_SMC_POWER_PROFILE_CUSTOM:
+               pplib_workload =3D WORKLOAD_PPLIB_COUNT;
+               break;
+       case PP_SMC_POWER_PROFILE_VIDEO:
+               pplib_workload =3D WORKLOAD_PPLIB_VIDEO_BIT;
+               break;
+       case PP_SMC_POWER_PROFILE_VR:
+               pplib_workload =3D WORKLOAD_PPLIB_VR_BIT;
+               break;
+       case PP_SMC_POWER_PROFILE_COMPUTE:
+               pplib_workload =3D WORKLOAD_PPLIB_COMPUTE_BIT;
+               break;
+       default:
+               return -EINVAL;
+       }
+
+       return pplib_workload;
+}
+
 static const struct pptable_funcs renoir_ppt_funcs =3D {
         .get_smu_msg_index =3D renoir_get_smu_msg_index,
         .get_smu_table_index =3D renoir_get_smu_table_index,
@@ -375,6 +403,7 @@ static const struct pptable_funcs renoir_ppt_funcs =3D =
{
         .dpm_set_uvd_enable =3D renoir_dpm_set_uvd_enable,
         .force_dpm_limit_value =3D renoir_force_dpm_limit_value,
         .unforce_dpm_levels =3D renoir_unforce_dpm_levels,
+       .get_workload_type =3D renoir_get_workload_type,
 };

 void renoir_set_ppt_funcs(struct smu_context *smu)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3296E79B53B6AE2974C534CCA2850MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.=
com&gt;</span><br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Liang, Prike &lt;Prike.Liang@=
amd.com&gt;<br>
<b>Sent:</b> Monday, September 23, 2019 4:43 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> arron.liu-5C7GfCeVMHo@public.gmane.org &lt;arron.liu-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.=
Huang-5C7GfCeVMHo@public.gmane.org&gt;; Liang, Prike &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan &lt=
;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 3/5] drm/amd/powerplay: add interface for getting wo=
rkload type</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">The workload type was got from the input of power =
profile mode.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 29 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 29 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index 4bb7e1c..f87aa56 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -364,6 &#43;364,34 @@ static int renoir_unforce_dpm_levels(struct smu_co=
ntext *smu) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int renoir_get_workload_type(struct smu_context *smu, uint32_t =
profile)<br>
&#43;{<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; pplib_workload =3D=
 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (profile) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_FULLSCR=
EEN3D:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_CUSTOM:=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_COUNT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_VIDEO:<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_VIDEO_BIT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_VR:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_VR_BIT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_COMPUTE=
:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pplib_workload =3D WORKLOAD_PPLIB_COMPUTE_BIT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pplib_workload;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct pptable_funcs renoir_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_msg_index =3D ren=
oir_get_smu_msg_index,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_table_index =3D r=
enoir_get_smu_table_index,<br>
@@ -375,6 &#43;403,7 @@ static const struct pptable_funcs renoir_ppt_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpm_set_uvd_enable =3D re=
noir_dpm_set_uvd_enable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_dpm_limit_value =3D=
 renoir_force_dpm_limit_value,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unforce_dpm_levels =3D re=
noir_unforce_dpm_levels,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_workload_type =3D renoir_get=
_workload_type,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;void renoir_set_ppt_funcs(struct smu_context *smu)<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3296E79B53B6AE2974C534CCA2850MN2PR12MB3296namp_--

--===============0450155697==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0450155697==--
