From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Fix "Add auto power profilng switch based on
 workloads"
Date: Wed, 7 Mar 2018 04:24:57 +0000
Message-ID: <BN6PR12MB1652EBB7E57567AB8758E5B6F7D80@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1520391365-26884-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2095148446=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1520391365-26884-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2095148446==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652EBB7E57567AB8758E5B6F7D80BN6PR12MB1652namp_"

--_000_BN6PR12MB1652EBB7E57567AB8758E5B6F7D80BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, March 6, 2018 9:56 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/pp: Fix "Add auto power profilng switch based on w=
orkloads"

1. fix typo "<" should be "<<"
2. fix code style
3. fix uninitialized point *workload

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Change-Id: I35d03d19360c75e8eb2021bd3db63e52c93e1e61
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c      | 14 +++++++-------
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        | 10 +++++-----
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       |  2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index 84e65df..b989bf3 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1081,7 +1081,7 @@ static int pp_dpm_switch_power_profile(void *handle,
 {
         struct pp_hwmgr *hwmgr;
         struct pp_instance *pp_handle =3D (struct pp_instance *)handle;
-       long *workload;
+       long workload;
         uint32_t index;

         if (pp_check(pp_handle))
@@ -1100,19 +1100,19 @@ static int pp_dpm_switch_power_profile(void *handle=
,
         mutex_lock(&pp_handle->pp_lock);

         if (!en) {
-               hwmgr->workload_mask &=3D ~(1 < hwmgr->workload_prority[typ=
e]);
+               hwmgr->workload_mask &=3D ~(1 << hwmgr->workload_prority[ty=
pe]);
                 index =3D fls(hwmgr->workload_mask);
-               index =3D index > 0 && index <=3D Workload_Policy_Max? inde=
x - 1 : 0;
-               *workload =3D hwmgr->workload_setting[index];
+               index =3D index > 0 && index <=3D Workload_Policy_Max ? ind=
ex - 1 : 0;
+               workload =3D hwmgr->workload_setting[index];
         } else {
-               hwmgr->workload_mask |=3D (1 < hwmgr->workload_prority[type=
]);
+               hwmgr->workload_mask |=3D (1 << hwmgr->workload_prority[typ=
e]);
                 index =3D fls(hwmgr->workload_mask);
                 index =3D index <=3D Workload_Policy_Max ? index - 1 : 0;
-               *workload =3D hwmgr->workload_setting[index];
+               workload =3D hwmgr->workload_setting[index];
         }

         if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
-               hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, workload, =
0);
+               hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &workload,=
 0);
         mutex_unlock(&pp_handle->pp_lock);

         return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c
index aa83114..af1b22d 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -133,11 +133,11 @@ static void hwmgr_init_workload_prority(struct pp_hwm=
gr *hwmgr)
         hwmgr->workload_prority[PP_SMC_POWER_PROFILE_VR] =3D 3;
         hwmgr->workload_prority[PP_SMC_POWER_PROFILE_COMPUTE] =3D 4;

-       hwmgr->workload_setting[0]=3D PP_SMC_POWER_PROFILE_POWERSAVING;
-       hwmgr->workload_setting[1]=3D PP_SMC_POWER_PROFILE_VIDEO;
-       hwmgr->workload_setting[2]=3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-       hwmgr->workload_setting[3]=3D PP_SMC_POWER_PROFILE_VR;
-       hwmgr->workload_setting[4]=3D PP_SMC_POWER_PROFILE_COMPUTE;
+       hwmgr->workload_setting[0] =3D PP_SMC_POWER_PROFILE_POWERSAVING;
+       hwmgr->workload_setting[1] =3D PP_SMC_POWER_PROFILE_VIDEO;
+       hwmgr->workload_setting[2] =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+       hwmgr->workload_setting[3] =3D PP_SMC_POWER_PROFILE_VR;
+       hwmgr->workload_setting[4] =3D PP_SMC_POWER_PROFILE_COMPUTE;
 }

 int hwmgr_early_init(struct pp_instance *handle)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm=
/amd/powerplay/hwmgr/pp_psm.c
index 51439a1..d0ef8f9 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
@@ -251,7 +251,7 @@ int psm_adjust_power_state_dynamic(struct pp_hwmgr *hwm=
gr, bool skip,

         if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
                 index =3D fls(hwmgr->workload_mask);
-               index =3D index > 0 && index <=3D Workload_Policy_Max? inde=
x - 1 : 0;
+               index =3D index > 0 && index <=3D Workload_Policy_Max ? ind=
ex - 1 : 0;
                 workload =3D hwmgr->workload_setting[index];

                 if (hwmgr->power_profile_mode !=3D workload && hwmgr->hwmg=
r_func->set_power_profile_mode)
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 4f26014..d4d1d2e 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -1510,7 +1510,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *h=
wmgr)
         data->current_profile_setting.mclk_up_hyst =3D 0;
         data->current_profile_setting.mclk_down_hyst =3D 100;
         data->current_profile_setting.mclk_activity =3D SMU7_MCLK_TARGETAC=
TIVITY_DFLT;
-       hwmgr->workload_mask =3D 1 < hwmgr->workload_prority[PP_SMC_POWER_P=
ROFILE_FULLSCREEN3D];
+       hwmgr->workload_mask =3D 1 << hwmgr->workload_prority[PP_SMC_POWER_=
PROFILE_FULLSCREEN3D];
         hwmgr->power_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
         hwmgr->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCR=
EEN3D;

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 25165b4..f23861f 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -766,7 +766,7 @@ static int vega10_hwmgr_backend_init(struct pp_hwmgr *h=
wmgr)

         hwmgr->backend =3D data;

-       hwmgr->workload_mask =3D 1 < hwmgr->workload_prority[PP_SMC_POWER_P=
ROFILE_VIDEO];
+       hwmgr->workload_mask =3D 1 << hwmgr->workload_prority[PP_SMC_POWER_=
PROFILE_VIDEO];
         hwmgr->power_profile_mode =3D PP_SMC_POWER_PROFILE_VIDEO;
         hwmgr->default_power_profile_mode =3D PP_SMC_POWER_PROFILE_VIDEO;

--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652EBB7E57567AB8758E5B6F7D80BN6PR12MB1652namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Tuesday, March 6, 2018 9:56 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/pp: Fix &quot;Add auto power profilng switc=
h based on workloads&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">1. fix typo &quot;&lt;&quot; should be &quot;&lt;&=
lt;&quot;<br>
2. fix code style<br>
3. fix uninitialized point *workload<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Change-Id: I35d03d19360c75e8eb2021bd3db63e52c93e1e61<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 14 &#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 10 &#43;&#43;&#43;&#43;&#43;-----<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp; |&nbsp; =
2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |&nbsp; 2 &#43;-<b=
r>
&nbsp;5 files changed, 15 insertions(&#43;), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c<br>
index 84e65df..b989bf3 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
@@ -1081,7 &#43;1081,7 @@ static int pp_dpm_switch_power_profile(void *hand=
le,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_instance *pp_han=
dle =3D (struct pp_instance *)handle;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long *workload;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long workload;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_check(pp_handle))<b=
r>
@@ -1100,19 &#43;1100,19 @@ static int pp_dpm_switch_power_profile(void *ha=
ndle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pp_handle-=
&gt;pp_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!en) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;workload_mask &amp;=3D ~(1 &lt; hwmgr-&gt;workload_pro=
rity[type]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;workload_mask &amp;=3D ~(1 &lt;&lt; hwmgr-&gt;work=
load_prority[type]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; index =3D fls(hwmgr-&gt;workload_mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; index =3D index &gt; 0 &amp;&amp; index &lt;=3D Workload_Policy_=
Max? index - 1 : 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *workload =3D hwmgr-&gt;workload_setting[index];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; index =3D index &gt; 0 &amp;&amp; index &lt;=3D Workload_Pol=
icy_Max ? index - 1 : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; workload =3D hwmgr-&gt;workload_setting[index];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;workload_mask |=3D (1 &lt; hwmgr-&gt;workload_prority[=
type]);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;workload_mask |=3D (1 &lt;&lt; hwmgr-&gt;workload_=
prority[type]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; index =3D fls(hwmgr-&gt;workload_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; index =3D index &lt;=3D Workload_Policy_Max ? index -=
 1 : 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *workload =3D hwmgr-&gt;workload_setting[index];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; workload =3D hwmgr-&gt;workload_setting[index];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=
=3D AMD_DPM_FORCED_LEVEL_MANUAL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_mode(hwmgr, workload,=
 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_mode(hwmgr, &amp;=
workload, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pp_handl=
e-&gt;pp_lock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/=
amd/powerplay/hwmgr/hwmgr.c<br>
index aa83114..af1b22d 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
@@ -133,11 &#43;133,11 @@ static void hwmgr_init_workload_prority(struct pp=
_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority=
[PP_SMC_POWER_PROFILE_VR] =3D 3;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_prority=
[PP_SMC_POWER_PROFILE_COMPUTE] =3D 4;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[0]=3D PP_S=
MC_POWER_PROFILE_POWERSAVING;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[1]=3D PP_S=
MC_POWER_PROFILE_VIDEO;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[2]=3D PP_S=
MC_POWER_PROFILE_FULLSCREEN3D;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[3]=3D PP_S=
MC_POWER_PROFILE_VR;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[4]=3D PP_S=
MC_POWER_PROFILE_COMPUTE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[0] =3D=
 PP_SMC_POWER_PROFILE_POWERSAVING;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[1] =3D=
 PP_SMC_POWER_PROFILE_VIDEO;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[2] =3D=
 PP_SMC_POWER_PROFILE_FULLSCREEN3D;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[3] =3D=
 PP_SMC_POWER_PROFILE_VR;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_setting[4] =3D=
 PP_SMC_POWER_PROFILE_COMPUTE;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int hwmgr_early_init(struct pp_instance *handle)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm=
/amd/powerplay/hwmgr/pp_psm.c<br>
index 51439a1..d0ef8f9 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c<br>
@@ -251,7 &#43;251,7 @@ int psm_adjust_power_state_dynamic(struct pp_hwmgr =
*hwmgr, bool skip,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=
=3D AMD_DPM_FORCED_LEVEL_MANUAL) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; index =3D fls(hwmgr-&gt;workload_mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; index =3D index &gt; 0 &amp;&amp; index &lt;=3D Workload_Policy_=
Max? index - 1 : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; index =3D index &gt; 0 &amp;&amp; index &lt;=3D Workload_Pol=
icy_Max ? index - 1 : 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; workload =3D hwmgr-&gt;workload_setting[index];<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;power_profile_mode !=3D workload &amp;&=
amp; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_mode)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
index 4f26014..d4d1d2e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
@@ -1510,7 &#43;1510,7 @@ static void smu7_init_dpm_defaults(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_s=
etting.mclk_up_hyst =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_s=
etting.mclk_down_hyst =3D 100;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;current_profile_s=
etting.mclk_activity =3D SMU7_MCLK_TARGETACTIVITY_DFLT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_mask =3D 1 &lt; hw=
mgr-&gt;workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_mask =3D 1 &lt=
;&lt; hwmgr-&gt;workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mo=
de =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;default_power_pr=
ofile_mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
index 25165b4..f23861f 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
@@ -766,7 &#43;766,7 @@ static int vega10_hwmgr_backend_init(struct pp_hwmg=
r *hwmgr)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;backend =3D data=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_mask =3D 1 &lt; hw=
mgr-&gt;workload_prority[PP_SMC_POWER_PROFILE_VIDEO];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;workload_mask =3D 1 &lt=
;&lt; hwmgr-&gt;workload_prority[PP_SMC_POWER_PROFILE_VIDEO];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mo=
de =3D PP_SMC_POWER_PROFILE_VIDEO;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;default_power_pr=
ofile_mode =3D PP_SMC_POWER_PROFILE_VIDEO;<br>
&nbsp;<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk623810" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652EBB7E57567AB8758E5B6F7D80BN6PR12MB1652namp_--

--===============2095148446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2095148446==--
