From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amd/powerplay: implement interface
 set_power_profile_mode()
Date: Mon, 23 Sep 2019 09:34:36 +0000
Message-ID: <MN2PR12MB329609FC8076F52C45455738A2850@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <1569228167-3120-1-git-send-email-Prike.Liang@amd.com>,
 <1569228167-3120-5-git-send-email-Prike.Liang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0372170809=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1569228167-3120-5-git-send-email-Prike.Liang-5C7GfCeVMHo@public.gmane.org>
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

--===============0372170809==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329609FC8076F52C45455738A2850MN2PR12MB3296namp_"

--_000_MN2PR12MB329609FC8076F52C45455738A2850MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

comment inline.
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Liang, P=
rike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, September 23, 2019 4:43 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: arron.liu-5C7GfCeVMHo@public.gmane.org <arron.liu-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; =
Liang, Prike <Prike.Liang-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Feng, K=
enneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 5/5] drm/amd/powerplay: implement interface set_power_profi=
le_mode()

Add set_power_profile_mode() for none manual dpm level case setting power p=
rofile mode.

Signed-off-by: Prike Liang <Prike.Liang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c
index c6aae1c..6819514 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -473,6 +473,30 @@ static int renoir_force_clk_levels(struct smu_context =
*smu,
         return ret;
 }

+static int renoir_set_power_profile_mode(struct smu_context *smu, long *in=
put, uint32_t size)
+{
+       int workload_type;
+
+       smu->power_profile_mode =3D input[size];
+
+       if (smu->power_profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
+               pr_err("Invalid power profile mode %d\n", smu->power_profil=
e_mode);
+               return -EINVAL;
+       }
+
+       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {
+               if (size < 0)
+                       return -EINVAL;
+
+       /* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
+       workload_type =3D smu_workload_get_type(smu, smu->power_profile_mod=
e);
[kevin]:
you'd better check the return value, when this workload is unmapped, it wil=
l return -EINVAL.
+       smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+                                   1 << workload_type);
[kevin]:
please check return value in smu driver every time.
after fixed:
Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
+       }
+       return 0;
+}
+
+
 static const struct pptable_funcs renoir_ppt_funcs =3D {
         .get_smu_msg_index =3D renoir_get_smu_msg_index,
         .get_smu_table_index =3D renoir_get_smu_table_index,
@@ -487,6 +511,7 @@ static const struct pptable_funcs renoir_ppt_funcs =3D =
{
         .get_workload_type =3D renoir_get_workload_type,
         .get_profiling_clk_mask =3D renoir_get_profiling_clk_mask,
         .force_clk_levels =3D renoir_force_clk_levels,
+       .set_power_profile_mode =3D renoir_set_power_profile_mode,
 };

 void renoir_set_ppt_funcs(struct smu_context *smu)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB329609FC8076F52C45455738A2850MN2PR12MB3296namp_
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
comment inline.</div>
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
<b>Subject:</b> [PATCH 5/5] drm/amd/powerplay: implement interface set_powe=
r_profile_mode()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Add set_power_profile_mode() for none manual dpm l=
evel case setting power profile mode.<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 25 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 25 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/a=
md/powerplay/renoir_ppt.c<br>
index c6aae1c..6819514 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c<br>
@@ -473,6 &#43;473,30 @@ static int renoir_force_clk_levels(struct smu_cont=
ext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int renoir_set_power_profile_mode(struct smu_context *smu, long=
 *input, uint32_t size)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int workload_type;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;power_profile_mode =3D in=
put[size];<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;power_profile_mode &g=
t; PP_SMC_POWER_PROFILE_CUSTOM) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;Invalid power profile mode %d\n&quot;, smu-&gt;=
power_profile_mode);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu-&gt;power_profile_mode =
=3D=3D PP_SMC_POWER_PROFILE_CUSTOM) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (size &lt; 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINV=
AL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* conv PP_SMC_POWER_PROFILE* to =
WORKLOAD_PPLIB_*_BIT */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; workload_type =3D smu_workload_ge=
t_type(smu, smu-&gt;power_profile_mode);</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">you'd better check the return value, when this wor=
kload is unmapped, it will return -EINVAL.</div>
<div class=3D"PlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_send=
_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; work=
load_type);</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">please check return value in smu driver every time=
.</div>
<div class=3D"PlainText">after fixed:</div>
<div class=3D"PlainText">Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;<br>
&nbsp;static const struct pptable_funcs renoir_ppt_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_msg_index =3D ren=
oir_get_smu_msg_index,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_smu_table_index =3D r=
enoir_get_smu_table_index,<br>
@@ -487,6 &#43;511,7 @@ static const struct pptable_funcs renoir_ppt_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_workload_type =3D ren=
oir_get_workload_type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_profiling_clk_mask =
=3D renoir_get_profiling_clk_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clk_levels =3D reno=
ir_force_clk_levels,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profile_mode =3D renoi=
r_set_power_profile_mode,<br>
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

--_000_MN2PR12MB329609FC8076F52C45455738A2850MN2PR12MB3296namp_--

--===============0372170809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0372170809==--
