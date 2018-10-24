From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: commonize the API for retrieving
 current clocks
Date: Wed, 24 Oct 2018 08:41:58 +0000
Message-ID: <BYAPR12MB2775410EBF6229A46DBBB1A9FBF60@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <20181024080910.18544-1-evan.quan@amd.com>,
 <20181024080910.18544-2-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0306147684=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181024080910.18544-2-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--===============0306147684==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2775410EBF6229A46DBBB1A9FBF60BYAPR12MB2775namp_"

--_000_BYAPR12MB2775410EBF6229A46DBBB1A9FBF60BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>


Best Regards

Rex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 24, 2018 4:09 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Quan, Evan
Subject: [PATCH 2/2] drm/amd/powerplay: commonize the API for retrieving cu=
rrent clocks

So that it can be shared between all clocks.

Change-Id: Ibac99b2aa81c1cb3e988b4eae6c98d32b7f35bed
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 44 +++++++------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 8a1ee9ce7386..57143d51e3ee 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -1875,38 +1875,20 @@ static int vega20_get_gpu_power(struct pp_hwmgr *hw=
mgr,
         return ret;
 }

-static int vega20_get_current_gfx_clk_freq(struct pp_hwmgr *hwmgr, uint32_=
t *gfx_freq)
+static int vega20_get_current_clk_freq(struct pp_hwmgr *hwmgr,
+               PPCLK_e clk_id, uint32_t *clk_freq)
 {
-       uint32_t gfx_clk =3D 0;
         int ret =3D 0;

-       *gfx_freq =3D 0;
+       *clk_freq =3D 0;

         PP_ASSERT_WITH_CODE((ret =3D smum_send_msg_to_smc_with_parameter(h=
wmgr,
-                       PPSMC_MSG_GetDpmClockFreq, (PPCLK_GFXCLK << 16))) =
=3D=3D 0,
-                       "[GetCurrentGfxClkFreq] Attempt to get Current GFXC=
LK Frequency Failed!",
+                       PPSMC_MSG_GetDpmClockFreq, (clk_id << 16))) =3D=3D =
0,
+                       "[GetCurrentClkFreq] Attempt to get Current Frequen=
cy Failed!",
                         return ret);
-       gfx_clk =3D smum_get_argument(hwmgr);
+       *clk_freq =3D smum_get_argument(hwmgr);

-       *gfx_freq =3D gfx_clk * 100;
-
-       return 0;
-}
-
-static int vega20_get_current_mclk_freq(struct pp_hwmgr *hwmgr, uint32_t *=
mclk_freq)
-{
-       uint32_t mem_clk =3D 0;
-       int ret =3D 0;
-
-       *mclk_freq =3D 0;
-
-       PP_ASSERT_WITH_CODE((ret =3D smum_send_msg_to_smc_with_parameter(hw=
mgr,
-                       PPSMC_MSG_GetDpmClockFreq, (PPCLK_UCLK << 16))) =3D=
=3D 0,
-                       "[GetCurrentMClkFreq] Attempt to get Current MCLK F=
requency Failed!",
-                       return ret);
-       mem_clk =3D smum_get_argument(hwmgr);
-
-       *mclk_freq =3D mem_clk * 100;
+       *clk_freq =3D *clk_freq * 100;

         return 0;
 }
@@ -1937,12 +1919,16 @@ static int vega20_read_sensor(struct pp_hwmgr *hwmg=
r, int idx,

         switch (idx) {
         case AMDGPU_PP_SENSOR_GFX_SCLK:
-               ret =3D vega20_get_current_gfx_clk_freq(hwmgr, (uint32_t *)=
value);
+               ret =3D vega20_get_current_clk_freq(hwmgr,
+                               PPCLK_GFXCLK,
+                               (uint32_t *)value);
                 if (!ret)
                         *size =3D 4;
                 break;
         case AMDGPU_PP_SENSOR_GFX_MCLK:
-               ret =3D vega20_get_current_mclk_freq(hwmgr, (uint32_t *)val=
ue);
+               ret =3D vega20_get_current_clk_freq(hwmgr,
+                               PPCLK_UCLK,
+                               (uint32_t *)value);
                 if (!ret)
                         *size =3D 4;
                 break;
@@ -2743,7 +2729,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr =
*hwmgr,

         switch (type) {
         case PP_SCLK:
-               ret =3D vega20_get_current_gfx_clk_freq(hwmgr, &now);
+               ret =3D vega20_get_current_clk_freq(hwmgr, PPCLK_GFXCLK, &n=
ow);
                 PP_ASSERT_WITH_CODE(!ret,
                                 "Attempt to get current gfx clk Failed!",
                                 return ret);
@@ -2760,7 +2746,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr =
*hwmgr,
                 break;

         case PP_MCLK:
-               ret =3D vega20_get_current_mclk_freq(hwmgr, &now);
+               ret =3D vega20_get_current_clk_freq(hwmgr, PPCLK_UCLK, &now=
);
                 PP_ASSERT_WITH_CODE(!ret,
                                 "Attempt to get current mclk freq Failed!"=
,
                                 return ret);
--
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_BYAPR12MB2775410EBF6229A46DBBB1A9FBF60BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: <span>Rex Zhu &lt;Re=
x.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</span><span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
<span></span><span class=3D"li-61 "></span></p>
<p></p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> amd-gfx &lt;amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.=
com&gt;<br>
<b>Sent:</b> Wednesday, October 24, 2018 4:09 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/powerplay: commonize the API for retrie=
ving current clocks</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">So that it can be shared between all clocks.<br>
<br>
Change-Id: Ibac99b2aa81c1cb3e988b4eae6c98d32b7f35bed<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp; | 44 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;------------<br>
&nbsp;1 file changed, 15 insertions(&#43;), 29 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
index 8a1ee9ce7386..57143d51e3ee 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
@@ -1875,38 &#43;1875,20 @@ static int vega20_get_gpu_power(struct pp_hwmgr=
 *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
-static int vega20_get_current_gfx_clk_freq(struct pp_hwmgr *hwmgr, uint32_=
t *gfx_freq)<br>
&#43;static int vega20_get_current_clk_freq(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PPCLK_e clk_id, uint32_t *clk_freq)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gfx_clk =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gfx_freq =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *clk_freq =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE((ret =
=3D smum_send_msg_to_smc_with_parameter(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetDpm=
ClockFreq, (PPCLK_GFXCLK &lt;&lt; 16))) =3D=3D 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[GetCurren=
tGfxClkFreq] Attempt to get Current GFXCLK Frequency Failed!&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_Ge=
tDpmClockFreq, (clk_id &lt;&lt; 16))) =3D=3D 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[GetCu=
rrentClkFreq] Attempt to get Current Frequency Failed!&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_clk =3D smum_get_argument(hwmgr);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *clk_freq =3D smum_get_argument(h=
wmgr);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gfx_freq =3D gfx_clk * 100;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-static int vega20_get_current_mclk_freq(struct pp_hwmgr *hwmgr, uint32_t *=
mclk_freq)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mem_clk =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mclk_freq =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE((ret =3D smum_sen=
d_msg_to_smc_with_parameter(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_GetDpm=
ClockFreq, (PPCLK_UCLK &lt;&lt; 16))) =3D=3D 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[GetCurren=
tMClkFreq] Attempt to get Current MCLK Frequency Failed!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem_clk =3D smum_get_argument(hwmgr);=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *mclk_freq =3D mem_clk * 100;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *clk_freq =3D *clk_freq * 100;<br=
>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -1937,12 &#43;1919,16 @@ static int vega20_read_sensor(struct pp_hwmgr *=
hwmgr, int idx,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (idx) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GFX_=
SCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D vega20_get_current_gfx_clk_freq(hwmgr, (uint32_t *)value=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D vega20_get_current_clk_freq(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPCLK_GFXCLK,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t *)value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *size=
 =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_SENSOR_GFX_=
MCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D vega20_get_current_mclk_freq(hwmgr, (uint32_t *)value);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D vega20_get_current_clk_freq(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPCLK_UCLK,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint32_t *)value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *size=
 =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
@@ -2743,7 &#43;2729,7 @@ static int vega20_print_clock_levels(struct pp_hw=
mgr *hwmgr,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D vega20_get_current_gfx_clk_freq(hwmgr, &amp;now);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D vega20_get_current_clk_freq(hwmgr, PPCLK_GFXCLK, &am=
p;now);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Attempt to get current gfx=
 clk Failed!&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
@@ -2760,7 &#43;2746,7 @@ static int vega20_print_clock_levels(struct pp_hw=
mgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MCLK:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D vega20_get_current_mclk_freq(hwmgr, &amp;now);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D vega20_get_current_clk_freq(hwmgr, PPCLK_UCLK, &amp;=
now);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Attempt to get current mcl=
k freq Failed!&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
-- <br>
2.19.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk591263" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15403702740060.3029944789547515" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15403702740040.3674420542081086" style=3D"width: 9=
0%; background-color: rgb(255, 255, 255); position: relative; overflow: aut=
o; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1=
px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);=
" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15403702740040.7718602022154916" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15403702740040.4704212625450027"></div>
<div id=3D"LPTitle_15403702740040.051381412236660484" style=3D"top: 0px; co=
lor: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quo=
t;wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light=
&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-ser=
if; line-height: 21px;">
<a id=3D"LPUrlAnchor_15403702740040.8846730316909506" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15403702740060.30198120680135265" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quo=
t;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tah=
oma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15403702740060.6995795013409524" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, =
Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; o=
verflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2775410EBF6229A46DBBB1A9FBF60BYAPR12MB2775namp_--

--===============0306147684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0306147684==--
