From: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv for
 compute
Date: Mon, 11 Nov 2019 06:34:27 +0000
Message-ID: <MN2PR12MB3598E632B3CC0520FB24B08B8E740@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <1573191771-8071-1-git-send-email-kenneth.feng@amd.com>
 <DM5PR12MB18204B23450D8B0E427E4C8AF77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0242833439=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB18204B23450D8B0E427E4C8AF77B0-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0242833439==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3598E632B3CC0520FB24B08B8E740MN2PR12MB3598namp_"

--_000_MN2PR12MB3598E632B3CC0520FB24B08B8E740MN2PR12MB3598namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex,
We have confirmed that the performance on Vega20 in the compute mode is exp=
ected and doesn't need the similar change.
This is because that  by default on Vega20 all the deep sleep features are =
disabled, and ulv feature doesn't involve reducing mclk in Vega20
while it does in Vega10.
We then need this change on MI100/MI200 since these deep sleep features are=
 enabled by default.
Thanks.


From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, November 8, 2019 10:45 PM
To: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv f=
or compute

Do we need something similar for vega20?

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org<ma=
ilto:kenneth.feng-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, November 8, 2019 12:42 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org<mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH v2] drm/amd/powerplay: dynamically disable ds and ulv for c=
ompute

This is to improve the performance in the compute mode
for vega10. For example, the original performance for a rocm
bandwidth test: 2G internal GPU copy, is about 99GB/s.
With the idle power features disabled dynamically, the porformance
is promoted to about 215GB/s.

Signed-off-by: Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org<mailto:kenneth.feng@amd.c=
om>>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      |  7 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 55 ++++++++++++++++++=
++++
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  2 +
 3 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index 0314476..bd35f65 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -969,6 +969,13 @@ static int pp_dpm_switch_power_profile(void *handle,
                 workload =3D hwmgr->workload_setting[index];
         }

+       if (type =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &&
+               hwmgr->hwmgr_func->disable_power_features_for_compute_perfo=
rmance)
+                       if (hwmgr->hwmgr_func->disable_power_features_for_c=
ompute_performance(hwmgr, en)) {
+                               mutex_unlock(&hwmgr->smu_lock);
+                               return -EINVAL;
+                       }
+
         if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
                 hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload=
, 0);
         mutex_unlock(&hwmgr->smu_lock);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 4ea63a2..d3229c2 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -5263,6 +5263,59 @@ static int vega10_get_performance_level(struct pp_hw=
mgr *hwmgr, const struct pp_
         return 0;
 }

+static int vega10_disable_power_features_for_compute_performance(struct pp=
_hwmgr *hwmgr, bool disable)
+{
+       struct vega10_hwmgr *data =3D hwmgr->backend;
+       uint32_t feature_mask =3D 0;
+
+       if (disable) {
+               feature_mask |=3D data->smu_features[GNLD_ULV].enabled ?
+                       data->smu_features[GNLD_ULV].smu_feature_bitmap : 0=
;
+               feature_mask |=3D data->smu_features[GNLD_DS_GFXCLK].enable=
d ?
+                       data->smu_features[GNLD_DS_GFXCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D data->smu_features[GNLD_DS_SOCCLK].enable=
d ?
+                       data->smu_features[GNLD_DS_SOCCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D data->smu_features[GNLD_DS_LCLK].enabled =
?
+                       data->smu_features[GNLD_DS_LCLK].smu_feature_bitmap=
 : 0;
+               feature_mask |=3D data->smu_features[GNLD_DS_DCEFCLK].enabl=
ed ?
+                       data->smu_features[GNLD_DS_DCEFCLK].smu_feature_bit=
map : 0;
+       } else {
+               feature_mask |=3D (!data->smu_features[GNLD_ULV].enabled) ?
+                       data->smu_features[GNLD_ULV].smu_feature_bitmap : 0=
;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_GFXCLK].enab=
led) ?
+                       data->smu_features[GNLD_DS_GFXCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_SOCCLK].enab=
led) ?
+                       data->smu_features[GNLD_DS_SOCCLK].smu_feature_bitm=
ap : 0;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_LCLK].enable=
d) ?
+                       data->smu_features[GNLD_DS_LCLK].smu_feature_bitmap=
 : 0;
+               feature_mask |=3D (!data->smu_features[GNLD_DS_DCEFCLK].ena=
bled) ?
+                       data->smu_features[GNLD_DS_DCEFCLK].smu_feature_bit=
map : 0;
+       }
+
+       if (feature_mask)
+               PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,
+                               !disable, feature_mask),
+                               "enable/disable power features for compute =
performance Failed!",
+                               return -EINVAL);
+
+       if (disable) {
+               data->smu_features[GNLD_ULV].enabled =3D false;
+               data->smu_features[GNLD_DS_GFXCLK].enabled =3D false;
+               data->smu_features[GNLD_DS_SOCCLK].enabled =3D false;
+               data->smu_features[GNLD_DS_LCLK].enabled =3D false;
+               data->smu_features[GNLD_DS_DCEFCLK].enabled =3D false;
+       } else {
+               data->smu_features[GNLD_ULV].enabled =3D true;
+               data->smu_features[GNLD_DS_GFXCLK].enabled =3D true;
+               data->smu_features[GNLD_DS_SOCCLK].enabled =3D true;
+               data->smu_features[GNLD_DS_LCLK].enabled =3D true;
+               data->smu_features[GNLD_DS_DCEFCLK].enabled =3D true;
+       }
+
+       return 0;
+
+}
+
 static const struct pp_hwmgr_func vega10_hwmgr_funcs =3D {
         .backend_init =3D vega10_hwmgr_backend_init,
         .backend_fini =3D vega10_hwmgr_backend_fini,
@@ -5330,6 +5383,8 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs =
=3D {
         .get_ppfeature_status =3D vega10_get_ppfeature_status,
         .set_ppfeature_status =3D vega10_set_ppfeature_status,
         .set_mp1_state =3D vega10_set_mp1_state,
+       .disable_power_features_for_compute_performance =3D
+                       vega10_disable_power_features_for_compute_performan=
ce,
 };

 int vega10_hwmgr_init(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h
index 40403bc..af97767 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -357,6 +357,8 @@ struct pp_hwmgr_func {
         int (*smu_i2c_bus_access)(struct pp_hwmgr *hwmgr, bool aquire);
         int (*set_df_cstate)(struct pp_hwmgr *hwmgr, enum pp_df_cstate sta=
te);
         int (*set_xgmi_pstate)(struct pp_hwmgr *hwmgr, uint32_t pstate);
+       int (*disable_power_features_for_compute_performance)(struct pp_hwm=
gr *hwmgr,
+                                       bool disable);
 };

 struct pp_table_func {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3598E632B3CC0520FB24B08B8E740MN2PR12MB3598namp_
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
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
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
<p class=3D"MsoNormal">Hi Alex,<o:p></o:p></p>
<p class=3D"MsoNormal">We have confirmed that the performance on Vega20 in =
the compute mode is expected and doesn&#8217;t need the similar change.<o:p=
></o:p></p>
<p class=3D"MsoNormal">This is because that &nbsp;by default on Vega20 all =
the deep sleep features are disabled, and ulv feature doesn&#8217;t involve=
 reducing mclk in Vega20
<o:p></o:p></p>
<p class=3D"MsoNormal">while it does in Vega10. <o:p></o:p></p>
<p class=3D"MsoNormal">We then need this change on MI100/MI200 since these =
deep sleep features are enabled by default.<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Friday, November 8, 2019 10:45 PM<br>
<b>To:</b> Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org<br>
<b>Subject:</b> Re: [PATCH v2] drm/amd/powerplay: dynamically disable ds an=
d ulv for compute<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Do we n=
eed something similar for vega20?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng-5C7GfCeVMHo@public.gmane.org">kenneth.feng@amd=
.com</a>&gt;<br>
<b>Sent:</b> Friday, November 8, 2019 12:42 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org">Kennet=
h.Feng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amd/powerplay: dynamically disable ds and ul=
v for compute</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">This is to improve the performance in the compute mo=
de<br>
for vega10. For example, the original performance for a rocm<br>
bandwidth test: 2G internal GPU copy, is about 99GB/s.<br>
With the idle power features disabled dynamically, the porformance<br>
is promoted to about 215GB/s.<br>
<br>
Signed-off-by: Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng-5C7GfCeVMHo@public.gmane.org">ken=
neth.feng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 7 &#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 55 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#43;<br>
&nbsp;3 files changed, 64 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index 0314476..bd35f65 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -969,6 &#43;969,13 @@ static int pp_dpm_switch_power_profile(void *handl=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; workload =3D hwmgr-&gt;workload_setting[index];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D PP_SMC_POWER_PROF=
ILE_COMPUTE &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;disable_power_features_for_compute_=
performance)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&g=
t;hwmgr_func-&gt;disable_power_features_for_compute_performance(hwmgr, en))=
 {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&gt;smu_lock);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=
=3D AMD_DPM_FORCED_LEVEL_MANUAL)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_mode(hwmgr=
, &amp;workload, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;hwmgr-&g=
t;smu_lock);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 4ea63a2..d3229c2 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -5263,6 &#43;5263,59 @@ static int vega10_get_performance_level(struct p=
p_hwmgr *hwmgr, const struct pp_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int vega10_disable_power_features_for_compute_performance(struc=
t pp_hwmgr *hwmgr, bool disable)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =3D hwm=
gr-&gt;backend;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (disable) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_ULV].enabled ?<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_ULV].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_GFXCLK].enab=
led ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_GFXCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_SOCCLK].enab=
led ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_SOCCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_LCLK].enable=
d ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_LCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D data-&gt;smu_features[GNLD_DS_DCEFCLK].ena=
bled ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_DCEFCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_ULV].enabled)=
 ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_ULV].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_GFXCLK].en=
abled) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_GFXCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_SOCCLK].en=
abled) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_SOCCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_LCLK].enab=
led) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_LCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_mask |=3D (!data-&gt;smu_features[GNLD_DS_DCEFCLK].e=
nabled) ?<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smu=
_features[GNLD_DS_DCEFCLK].smu_feature_bitmap : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature_mask)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!vega10_enable_smc_features(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !disable, feature_mask),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;enable/disable power features for=
 compute performance Failed!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (disable) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_ULV].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_GFXCLK].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_SOCCLK].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_LCLK].enabled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_DCEFCLK].enabled =3D false;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_ULV].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_GFXCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_SOCCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_LCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data-&gt;smu_features[GNLD_DS_DCEFCLK].enabled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct pp_hwmgr_func vega10_hwmgr_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_init =3D vega10_h=
wmgr_backend_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .backend_fini =3D vega10_h=
wmgr_backend_fini,<br>
@@ -5330,6 &#43;5383,8 @@ static const struct pp_hwmgr_func vega10_hwmgr_fu=
ncs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ppfeature_status =3D =
vega10_get_ppfeature_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_ppfeature_status =3D =
vega10_set_ppfeature_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mp1_state =3D vega10_=
set_mp1_state,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_power_features_for_compu=
te_performance =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_disab=
le_power_features_for_compute_performance,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int vega10_hwmgr_init(struct pp_hwmgr *hwmgr)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/am=
d/powerplay/inc/hwmgr.h<br>
index 40403bc..af97767 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
@@ -357,6 &#43;357,8 @@ struct pp_hwmgr_func {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*smu_i2c_bus_access)(=
struct pp_hwmgr *hwmgr, bool aquire);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_df_cstate)(struc=
t pp_hwmgr *hwmgr, enum pp_df_cstate state);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_xgmi_pstate)(str=
uct pp_hwmgr *hwmgr, uint32_t pstate);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*disable_power_features_for_=
compute_performance)(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; bool disable);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct pp_table_func {<br>
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

--_000_MN2PR12MB3598E632B3CC0520FB24B08B8E740MN2PR12MB3598namp_--

--===============0242833439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0242833439==--
