From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: fix possible hang with 3+ 4K monitors
Date: Tue, 26 Mar 2019 12:58:11 +0000
Message-ID: <BN6PR12MB1809586CEF4DAEC4FB8A5CABF75F0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190326101313.27104-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0773364049=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190326101313.27104-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0773364049==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809586CEF4DAEC4FB8A5CABF75F0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809586CEF4DAEC4FB8A5CABF75F0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, March 26, 2019 6:13 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan
Subject: [PATCH] drm/amd/powerplay: fix possible hang with 3+ 4K monitors

If DAL requires to force MCLK high, the FCLK will be
forced to high also.

Change-Id: Iaff8956ca1faafaf904f0bec108f566e8bbf6a64
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 3f349ada8de0..38dbec3caa01 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -3471,6 +3471,7 @@ static int vega20_apply_clocks_adjust_rules(struct pp=
_hwmgr *hwmgr)
         struct vega20_single_dpm_table *dpm_table;
         bool vblank_too_short =3D false;
         bool disable_mclk_switching;
+       bool disable_fclk_switching;
         uint32_t i, latency;

         disable_mclk_switching =3D ((1 < hwmgr->display_config->num_displa=
y) &&
@@ -3546,13 +3547,20 @@ static int vega20_apply_clocks_adjust_rules(struct =
pp_hwmgr *hwmgr)
         if (hwmgr->display_config->nb_pstate_switch_disable)
                 dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_lev=
els[dpm_table->count - 1].value;

+       if ((disable_mclk_switching &&
+           (dpm_table->dpm_state.hard_min_level =3D=3D dpm_table->dpm_leve=
ls[dpm_table->count - 1].value)) ||
+            hwmgr->display_config->min_mem_set_clock / 100 >=3D dpm_table-=
>dpm_levels[dpm_table->count - 1].value)
+               disable_fclk_switching =3D true;
+       else
+               disable_fclk_switching =3D false;
+
         /* fclk */
         dpm_table =3D &(data->dpm_table.fclk_table);
         dpm_table->dpm_state.soft_min_level =3D dpm_table->dpm_levels[0].v=
alue;
         dpm_table->dpm_state.soft_max_level =3D VG20_CLOCK_MAX_DEFAULT;
         dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_levels[0].v=
alue;
         dpm_table->dpm_state.hard_max_level =3D VG20_CLOCK_MAX_DEFAULT;
-       if (hwmgr->display_config->nb_pstate_switch_disable)
+       if (hwmgr->display_config->nb_pstate_switch_disable || disable_fclk=
_switching)
                 dpm_table->dpm_state.soft_min_level =3D dpm_table->dpm_lev=
els[dpm_table->count - 1].value;

         /* vclk */
--
2.21.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809586CEF4DAEC4FB8A5CABF75F0BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Tuesday, March 26, 2019 6:13 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: fix possible hang with 3&#43; 4K=
 monitors</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If DAL requires to force MCLK high, the FCLK will =
be<br>
forced to high also.<br>
<br>
Change-Id: Iaff8956ca1faafaf904f0bec108f566e8bbf6a64<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 10 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;1 file changed, 9 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index 3f349ada8de0..38dbec3caa01 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -3471,6 &#43;3471,7 @@ static int vega20_apply_clocks_adjust_rules(struc=
t pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_single_dpm_t=
able *dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vblank_too_short =3D =
false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_mclk_switchin=
g;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_fclk_switching;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, latency;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_mclk_switching =3D=
 ((1 &lt; hwmgr-&gt;display_config-&gt;num_display) &amp;&amp;<br>
@@ -3546,13 &#43;3547,20 @@ static int vega20_apply_clocks_adjust_rules(str=
uct pp_hwmgr *hwmgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;display_conf=
ig-&gt;nb_pstate_switch_disable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard_min_level =3D dpm_table-=
&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((disable_mclk_switching &amp;=
&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (dpm_tabl=
e-&gt;dpm_state.hard_min_level =3D=3D dpm_table-&gt;dpm_levels[dpm_table-&g=
t;count - 1].value)) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwm=
gr-&gt;display_config-&gt;min_mem_set_clock / 100 &gt;=3D dpm_table-&gt;dpm=
_levels[dpm_table-&gt;count - 1].value)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; disable_fclk_switching =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; disable_fclk_switching =3D false;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fclk */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(data-&=
gt;dpm_table.fclk_table);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.so=
ft_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.so=
ft_max_level =3D VG20_CLOCK_MAX_DEFAULT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.ha=
rd_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.ha=
rd_max_level =3D VG20_CLOCK_MAX_DEFAULT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;display_config-&gt;nb_p=
state_switch_disable)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;display_config-&gt;=
nb_pstate_switch_disable || disable_fclk_switching)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft_min_level =3D dpm_table-=
&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* vclk */<br>
-- <br>
2.21.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809586CEF4DAEC4FB8A5CABF75F0BN6PR12MB1809namp_--

--===============0773364049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0773364049==--
