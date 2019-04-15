From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] SWDEV-183622 4k@60hz dp monitor always flicking
Date: Mon, 15 Apr 2019 14:00:10 +0000
Message-ID: <BN6PR12MB1809DCA485322E878285C1F7F72B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190415135244.8377-1-hersenxs.wu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0368820448=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190415135244.8377-1-hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
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
To: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============0368820448==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809DCA485322E878285C1F7F72B0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809DCA485322E878285C1F7F72B0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Maybe mention that this fixes issues with stutter mode and 4k.  With that,
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of hersen w=
u <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, April 15, 2019 9:52 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Feng, Kenneth
Cc: Wu, Hersen
Subject: [PATCH] SWDEV-183622 4k@60hz dp monitor always flicking

[WHY] clock unit mis-match between caller DC and SMU interface.
      dc pass lock in mhz. the same unit as smu. no covert is needed.

[HOW] remove covert_10k_to_mhz in smu interface

Signed-off-by: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
---
 .../gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c   | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index f32e3d0aaea6..078613348e78 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -204,18 +204,13 @@ static int smu10_set_clock_limit(struct pp_hwmgr *hwm=
gr, const void *input)
         return 0;
 }

-static inline uint32_t convert_10k_to_mhz(uint32_t clock)
-{
-       return (clock + 99) / 100;
-}
-
 static int smu10_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, uint32=
_t clock)
 {
         struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->b=
ackend);

         if (smu10_data->need_min_deep_sleep_dcefclk &&
-               smu10_data->deep_sleep_dcefclk !=3D convert_10k_to_mhz(cloc=
k)) {
-               smu10_data->deep_sleep_dcefclk =3D convert_10k_to_mhz(clock=
);
+               smu10_data->deep_sleep_dcefclk !=3D clock) {
+               smu10_data->deep_sleep_dcefclk =3D clock;
                 smum_send_msg_to_smc_with_parameter(hwmgr,
                                         PPSMC_MSG_SetMinDeepSleepDcefclk,
                                         smu10_data->deep_sleep_dcefclk);
@@ -228,8 +223,8 @@ static int smu10_set_hard_min_dcefclk_by_freq(struct pp=
_hwmgr *hwmgr, uint32_t c
         struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->b=
ackend);

         if (smu10_data->dcf_actual_hard_min_freq &&
-               smu10_data->dcf_actual_hard_min_freq !=3D convert_10k_to_mh=
z(clock)) {
-               smu10_data->dcf_actual_hard_min_freq =3D convert_10k_to_mhz=
(clock);
+               smu10_data->dcf_actual_hard_min_freq !=3D clock) {
+               smu10_data->dcf_actual_hard_min_freq =3D clock;
                 smum_send_msg_to_smc_with_parameter(hwmgr,
                                         PPSMC_MSG_SetHardMinDcefclkByFreq,
                                         smu10_data->dcf_actual_hard_min_fr=
eq);
@@ -242,8 +237,8 @@ static int smu10_set_hard_min_fclk_by_freq(struct pp_hw=
mgr *hwmgr, uint32_t cloc
         struct smu10_hwmgr *smu10_data =3D (struct smu10_hwmgr *)(hwmgr->b=
ackend);

         if (smu10_data->f_actual_hard_min_freq &&
-               smu10_data->f_actual_hard_min_freq !=3D convert_10k_to_mhz(=
clock)) {
-               smu10_data->f_actual_hard_min_freq =3D convert_10k_to_mhz(c=
lock);
+               smu10_data->f_actual_hard_min_freq !=3D clock) {
+               smu10_data->f_actual_hard_min_freq =3D clock;
                 smum_send_msg_to_smc_with_parameter(hwmgr,
                                         PPSMC_MSG_SetHardMinFclkByFreq,
                                         smu10_data->f_actual_hard_min_freq=
);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809DCA485322E878285C1F7F72B0BN6PR12MB1809namp_
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
Maybe mention that this fixes issues with stutter mode and 4k.&nbsp; With t=
hat,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of hersen wu &lt;hersenxs.wu@amd=
.com&gt;<br>
<b>Sent:</b> Monday, April 15, 2019 9:52 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Feng, Kenneth<br>
<b>Cc:</b> Wu, Hersen<br>
<b>Subject:</b> [PATCH] SWDEV-183622 4k@60hz dp monitor always flicking</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[WHY] clock unit mis-match between caller DC and S=
MU interface.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc pass lock in mhz. the same unit as smu. n=
o covert is needed.<br>
<br>
[HOW] remove covert_10k_to_mhz in smu interface<br>
<br>
Signed-off-by: hersen wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c&nbsp;&nbsp; | 17 &#43;&=
#43;&#43;&#43;&#43;&#43;-----------<br>
&nbsp;1 file changed, 6 insertions(&#43;), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gp=
u/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
index f32e3d0aaea6..078613348e78 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
@@ -204,18 &#43;204,13 @@ static int smu10_set_clock_limit(struct pp_hwmgr =
*hwmgr, const void *input)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static inline uint32_t convert_10k_to_mhz(uint32_t clock)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (clock &#43; 99) / 100;<br>
-}<br>
-<br>
&nbsp;static int smu10_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, u=
int32_t clock)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_=
data =3D (struct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu10_data-&gt;need_mi=
n_deep_sleep_dcefclk &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;deep_sleep_dcefclk !=3D convert_10k_to_mhz(clock)=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;deep_sleep_dcefclk =3D convert_10k_to_mhz(clock);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;deep_sleep_dcefclk !=3D clock) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;deep_sleep_dcefclk =3D clock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PPSMC_MSG_SetMinDeepSleepDcefclk,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu10_data-&gt;deep_sleep_dcefclk);<br>
@@ -228,8 &#43;223,8 @@ static int smu10_set_hard_min_dcefclk_by_freq(struc=
t pp_hwmgr *hwmgr, uint32_t c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_=
data =3D (struct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu10_data-&gt;dcf_act=
ual_hard_min_freq &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;dcf_actual_hard_min_freq !=3D convert_10k_to_mhz(=
clock)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;dcf_actual_hard_min_freq =3D convert_10k_to_mhz(c=
lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;dcf_actual_hard_min_freq !=3D clock) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;dcf_actual_hard_min_freq =3D clock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PPSMC_MSG_SetHardMinDcefclkByFreq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu10_data-&gt;dcf_actual_hard_min_freq);<br>
@@ -242,8 &#43;237,8 @@ static int smu10_set_hard_min_fclk_by_freq(struct p=
p_hwmgr *hwmgr, uint32_t cloc<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu10_hwmgr *smu10_=
data =3D (struct smu10_hwmgr *)(hwmgr-&gt;backend);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu10_data-&gt;f_actua=
l_hard_min_freq &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;f_actual_hard_min_freq !=3D convert_10k_to_mhz(cl=
ock)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu10_data-&gt;f_actual_hard_min_freq =3D convert_10k_to_mhz(clo=
ck);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;f_actual_hard_min_freq !=3D clock) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu10_data-&gt;f_actual_hard_min_freq =3D clock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; PPSMC_MSG_SetHardMinFclkByFreq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; smu10_data-&gt;f_actual_hard_min_freq);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809DCA485322E878285C1F7F72B0BN6PR12MB1809namp_--

--===============0368820448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0368820448==--
