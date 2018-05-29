From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Connect display_clock_voltage_request to a
 function pointer
Date: Tue, 29 May 2018 22:00:20 +0000
Message-ID: <BN6PR12MB18093CDCB3277520E53B1A54F76D0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1527630675-22119-1-git-send-email-mikita.lipski@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0443970000=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1527630675-22119-1-git-send-email-mikita.lipski-5C7GfCeVMHo@public.gmane.org>
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
To: "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>, "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Wu,
 Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>

--===============0443970000==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18093CDCB3277520E53B1A54F76D0BN6PR12MB1809namp_"

--_000_BN6PR12MB18093CDCB3277520E53B1A54F76D0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of mikita.l=
ipski-5C7GfCeVMHo@public.gmane.org <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, May 29, 2018 5:51 PM
To: Zhu, Rex; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Lipski, Mikita; Wu, Hersen; Wentland, Harry
Subject: [PATCH] drm/amd/pp: Connect display_clock_voltage_request to a fun=
ction pointer

From: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>

Get rid of an empty dublicate of smu10_display_clock_voltage_request

Add display_clock_voltage_request to smu10 functions struct so it
can be called from outside the class and connect the pointer to
the function.

That way Display driver can finally apply clock voltage requests
when needed.

Signed-off-by: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 63 +++++++++++--------=
----
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index e160b05..74136ed 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -53,8 +53,36 @@ static const unsigned long SMU10_Magic =3D (unsigned lon=
g) PHM_Rv_Magic;


 static int smu10_display_clock_voltage_request(struct pp_hwmgr *hwmgr,
-               struct pp_display_clock_request *clock_req);
+               struct pp_display_clock_request *clock_req)
+{
+       struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->ba=
ckend);
+       enum amd_pp_clock_type clk_type =3D clock_req->clock_type;
+       uint32_t clk_freq =3D clock_req->clock_freq_in_khz / 1000;
+       PPSMC_Msg        msg;
+
+       switch (clk_type) {
+       case amd_pp_dcf_clock:
+               if (clk_freq =3D=3D smu10_data->dcf_actual_hard_min_freq)
+                       return 0;
+               msg =3D  PPSMC_MSG_SetHardMinDcefclkByFreq;
+               smu10_data->dcf_actual_hard_min_freq =3D clk_freq;
+               break;
+       case amd_pp_soc_clock:
+                msg =3D PPSMC_MSG_SetHardMinSocclkByFreq;
+               break;
+       case amd_pp_f_clock:
+               if (clk_freq =3D=3D smu10_data->f_actual_hard_min_freq)
+                       return 0;
+               smu10_data->f_actual_hard_min_freq =3D clk_freq;
+               msg =3D PPSMC_MSG_SetHardMinFclkByFreq;
+               break;
+       default:
+               return -EINVAL;
+       }
+       smum_send_msg_to_smc_with_parameter(hwmgr, msg, clk_freq);

+       return 0;
+}

 static struct smu10_power_state *cast_smu10_ps(struct pp_hw_power_state *h=
w_ps)
 {
@@ -1023,39 +1051,7 @@ static int smu10_get_clock_by_type_with_voltage(stru=
ct pp_hwmgr *hwmgr,
         return 0;
 }

-static int smu10_display_clock_voltage_request(struct pp_hwmgr *hwmgr,
-               struct pp_display_clock_request *clock_req)
-{
-       struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->ba=
ckend);
-       enum amd_pp_clock_type clk_type =3D clock_req->clock_type;
-       uint32_t clk_freq =3D clock_req->clock_freq_in_khz / 1000;
-       PPSMC_Msg        msg;
-
-       switch (clk_type) {
-       case amd_pp_dcf_clock:
-               if (clk_freq =3D=3D smu10_data->dcf_actual_hard_min_freq)
-                       return 0;
-               msg =3D  PPSMC_MSG_SetHardMinDcefclkByFreq;
-               smu10_data->dcf_actual_hard_min_freq =3D clk_freq;
-               break;
-       case amd_pp_soc_clock:
-                msg =3D PPSMC_MSG_SetHardMinSocclkByFreq;
-               break;
-       case amd_pp_f_clock:
-               if (clk_freq =3D=3D smu10_data->f_actual_hard_min_freq)
-                       return 0;
-               smu10_data->f_actual_hard_min_freq =3D clk_freq;
-               msg =3D PPSMC_MSG_SetHardMinFclkByFreq;
-               break;
-       default:
-               pr_info("[DisplayClockVoltageRequest]Invalid Clock Type!");
-               return -EINVAL;
-       }
-
-       smum_send_msg_to_smc_with_parameter(hwmgr, msg, clk_freq);

-       return 0;
-}

 static int smu10_get_max_high_clocks(struct pp_hwmgr *hwmgr, struct amd_pp=
_simple_clock_info *clocks)
 {
@@ -1188,6 +1184,7 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs =
=3D {
         .set_mmhub_powergating_by_smu =3D smu10_set_mmhub_powergating_by_s=
mu,
         .smus_notify_pwe =3D smu10_smus_notify_pwe,
         .gfx_off_control =3D smu10_gfx_off_control,
+       .display_clock_voltage_request =3D smu10_display_clock_voltage_requ=
est,
 };

 int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18093CDCB3277520E53B1A54F76D0BN6PR12MB1809namp_
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
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of mikita.lipski-5C7GfCeVMHo@public.gmane.org &lt;m=
ikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, May 29, 2018 5:51 PM<br>
<b>To:</b> Zhu, Rex; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Lipski, Mikita; Wu, Hersen; Wentland, Harry<br>
<b>Subject:</b> [PATCH] drm/amd/pp: Connect display_clock_voltage_request t=
o a function pointer</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Mikita Lipski &lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<=
br>
<br>
Get rid of an empty dublicate of smu10_display_clock_voltage_request<br>
<br>
Add display_clock_voltage_request to smu10 functions struct so it<br>
can be called from outside the class and connect the pointer to<br>
the function.<br>
<br>
That way Display driver can finally apply clock voltage requests<br>
when needed.<br>
<br>
Signed-off-by: Mikita Lipski &lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 63 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------------<br>
&nbsp;1 file changed, 30 insertions(&#43;), 33 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
index e160b05..74136ed 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -53,8 &#43;53,36 @@ static const unsigned long SMU10_Magic =3D (unsigned=
 long) PHM_Rv_Magic;<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;static int smu10_display_clock_voltage_request(struct pp_hwmgr *hwmgr=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct pp_display_clock_request *clock_req);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct pp_display_clock_request *clock_req)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_data =
=3D (struct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_clock_type clk_type =
=3D clock_req-&gt;clock_type;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_freq =3D clock_req-&=
gt;clock_freq_in_khz / 1000;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_Msg&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; msg;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (clk_type) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case amd_pp_dcf_clock:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (clk_freq =3D=3D smu10_data-&gt;dcf_actual_hard_min_freq)=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; msg =3D&nbsp; PPSMC_MSG_SetHardMinDcefclkByFreq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;dcf_actual_hard_min_freq =3D clk_freq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case amd_pp_soc_clock:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; msg =3D PPSMC_MSG_SetHardMinSocclkByFreq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case amd_pp_f_clock:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (clk_freq =3D=3D smu10_data-&gt;f_actual_hard_min_freq)<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;f_actual_hard_min_freq =3D clk_freq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; msg =3D PPSMC_MSG_SetHardMinFclkByFreq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_paramet=
er(hwmgr, msg, clk_freq);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&nbsp;<br>
&nbsp;static struct smu10_power_state *cast_smu10_ps(struct pp_hw_power_sta=
te *hw_ps)<br>
&nbsp;{<br>
@@ -1023,39 &#43;1051,7 @@ static int smu10_get_clock_by_type_with_voltage(=
struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int smu10_display_clock_voltage_request(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct pp_display_clock_request *clock_req)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_data =3D (s=
truct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_clock_type clk_type =3D c=
lock_req-&gt;clock_type;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk_freq =3D clock_req-&gt;c=
lock_freq_in_khz / 1000;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_Msg&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; msg;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (clk_type) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case amd_pp_dcf_clock:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (clk_freq =3D=3D smu10_data-&gt;dcf_actual_hard_min_freq)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; msg =3D&nbsp; PPSMC_MSG_SetHardMinDcefclkByFreq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;dcf_actual_hard_min_freq =3D clk_freq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case amd_pp_soc_clock:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; msg =3D PPSMC_MSG_SetHardMinSocclkByFreq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case amd_pp_f_clock:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (clk_freq =3D=3D smu10_data-&gt;f_actual_hard_min_freq)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;f_actual_hard_min_freq =3D clk_freq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; msg =3D PPSMC_MSG_SetHardMinFclkByFreq;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pr_info(&quot;[DisplayClockVoltageRequest]Invalid Clock Type!&qu=
ot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(h=
wmgr, msg, clk_freq);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
&nbsp;<br>
&nbsp;static int smu10_get_max_high_clocks(struct pp_hwmgr *hwmgr, struct a=
md_pp_simple_clock_info *clocks)<br>
&nbsp;{<br>
@@ -1188,6 &#43;1184,7 @@ static const struct pp_hwmgr_func smu10_hwmgr_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mmhub_powergating_by_=
smu =3D smu10_set_mmhub_powergating_by_smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .smus_notify_pwe =3D smu10=
_smus_notify_pwe,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gfx_off_control =3D smu10=
_gfx_off_control,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_voltage_request =
=3D smu10_display_clock_voltage_request,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int smu10_init_function_pointers(struct pp_hwmgr *hwmgr)<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk218336" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB18093CDCB3277520E53B1A54F76D0BN6PR12MB1809namp_--

--===============0443970000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0443970000==--
