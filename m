From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/pp: Refine get_gpu_power for VI
Date: Wed, 4 Apr 2018 15:50:02 +0000
Message-ID: <CY4PR12MB1687C34CD0753343A795544CFBA40@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1522830304-15505-1-git-send-email-Rex.Zhu@amd.com>
 <1522830304-15505-2-git-send-email-Rex.Zhu@amd.com>,
 <a3566d2f-4b35-00b4-1df1-ab50076f704c@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1825478800=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a3566d2f-4b35-00b4-1df1-ab50076f704c-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1825478800==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687C34CD0753343A795544CFBA40CY4PR12MB1687namp_"

--_000_CY4PR12MB1687C34CD0753343A795544CFBA40CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

If user send message PPSMC_MSG_GetCurrPkgPwr, firmware will return the pkgp=
wr immediately as current power value.

as no PPSMC_MSG_GetCurrPkgPwr support, so send message  let firmware write =
pkgpwr  to ixSMU_PM_STATUS_94,

and driver delay 10ms to read ixSMU_PM_STATUS_94.


I don't think there is any problem. otherwise, there is same issue on polar=
is/vega.


I clean ixSMU_PM_STATUS_94 before let smu write it.

The delay time is enough unless we got 0 from ixSMU_PM_STATUS_94 .



Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Eric Hua=
ng <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, April 4, 2018 11:36 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/3] drm/amd/pp: Refine get_gpu_power for VI

Sampling period is too short. The power reading value will be not
aligned with AGT's. It will confuse user that why AMD provides two
different power results.

Regards,
Eric

On 2018-04-04 04:25 AM, Rex Zhu wrote:
> 1. On polaris10/11/12, Sending smu message PPSMC_MSG_GetCurrPkgPwr to
>     read currentpkgpwr directly.
> 2. On Fiji/tonga/bonaire/hawwii, no PPSMC_MSG_GetCurrPkgPwr support.
>     Send PPSMC_MSG_PmStatusLogStart to let smu write currentpkgpwr
>     to ixSMU_PM_STATUS_94. this is asynchronous. need to delay no less
>     than 1ms.
> 3. Clean ixSMU_PM_STATUS_94 immediately when send PPSMC_MSG_PmStatusLogSt=
art
>     to avoid read old value.
> 4. delay 10 ms instand of 20 ms. so the result will more similar to
>     the output of PPSMC_MSG_GetCurrPkgPwr.
> 5. remove max power/vddc/vddci output to keep consistent with vega.
> 6. for vddc/vddci power, we can calculate the average value per
>     [10ms, 4s] in other interface if needed.
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 45 +++++++++++------=
-------
>   1 file changed, 21 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index 40f2f87..c0ce672 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -3363,30 +3363,27 @@ static int smu7_get_pp_table_entry(struct pp_hwmg=
r *hwmgr,
>   static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr,
>                struct pp_gpu_power *query)
>   {
> -     PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
> -                     PPSMC_MSG_PmStatusLogStart),
> -                     "Failed to start pm status log!",
> -                     return -1);
> -
> -     msleep_interruptible(20);
> -
> -     PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
> -                     PPSMC_MSG_PmStatusLogSample),
> -                     "Failed to sample pm status log!",
> -                     return -1);
> -
> -     query->vddc_power =3D cgs_read_ind_register(hwmgr->device,
> -                     CGS_IND_REG__SMC,
> -                     ixSMU_PM_STATUS_40);
> -     query->vddci_power =3D cgs_read_ind_register(hwmgr->device,
> -                     CGS_IND_REG__SMC,
> -                     ixSMU_PM_STATUS_49);
> -     query->max_gpu_power =3D cgs_read_ind_register(hwmgr->device,
> -                     CGS_IND_REG__SMC,
> -                     ixSMU_PM_STATUS_94);
> -     query->average_gpu_power =3D cgs_read_ind_register(hwmgr->device,
> -                     CGS_IND_REG__SMC,
> -                     ixSMU_PM_STATUS_95);
> +     if (!query)
> +             return -EINVAL;
> +
> +     memset(query, 0, sizeof *query);
> +
> +     if (hwmgr->chip_id >=3D CHIP_POLARIS10) {
> +             smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr);
> +             query->average_gpu_power =3D cgs_read_register(hwmgr->devic=
e, mmSMC_MSG_ARG_0);
> +     } else {
> +             smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogStart);
> +             cgs_write_ind_register(hwmgr->device, CGS_IND_REG__SMC,
> +                                     ixSMU_PM_STATUS_94, 0);
> +
> +             msleep_interruptible(10);
> +
> +             smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogSample);
> +
> +             query->average_gpu_power =3D cgs_read_ind_register(hwmgr->d=
evice,
> +                                                     CGS_IND_REG__SMC,
> +                                                     ixSMU_PM_STATUS_94)=
;
> +     }
>
>        return 0;
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.




--_000_CY4PR12MB1687C34CD0753343A795544CFBA40CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">If user send&nbsp;<span style=3D"=
font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color E=
moji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symb=
ol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">m=
essage
 PPSMC_MSG_GetCurrPkgPwr, firmware will return the pkgpwr immediately as cu=
rrent&nbsp;power value.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">as no&nbsp;<span st=
yle=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple =
Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe =
UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.666=
7px;">PPSMC_MSG_GetCurrPkgPwr
 support, so send message &nbsp;let firmware write&nbsp;<span style=3D"font=
-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji=
&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&q=
uot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">pkgpw=
r &nbsp;to&nbsp;<span style=3D"font-family: Calibri, Helvetica, sans-serif,=
 EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, Noto=
ColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSy=
mbols; font-size: 14.6667px;">ixSMU_PM_STATUS_94,</span></span></span></spa=
n></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span style=3D"font=
-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji=
&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&q=
uot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><span=
 style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;App=
le Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Seg=
oe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.=
6667px;"><span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiF=
ont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEm=
oji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; =
font-size: 14.6667px;">and
 driver delay 10ms to read <span style=3D"font-family: Calibri, Helvetica, =
sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&=
quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quo=
t;, EmojiSymbols; font-size: 14.6667px;">
ixSMU_PM_STATUS_94.</span></span></span></span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I don't think there is any proble=
m. otherwise, there is same issue on polaris/vega.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I clean <span style=3D"font-famil=
y: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;=
, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, =
&quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
ixSMU_PM_STATUS_94 before let smu write it.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">The delay time is e=
nough
 unless we got 0 from <span style=3D"font-family: Calibri, Helvetica, sans-=
serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;=
, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, E=
mojiSymbols; font-size: 14.6667px;">
ixSMU_PM_STATUS_94&nbsp;</span>.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Eric Huang &lt;jinhuieric.hua=
ng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, April 4, 2018 11:36 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amd/pp: Refine get_gpu_power for VI</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Sampling period is too short. The power reading va=
lue will be not
<br>
aligned with AGT's. It will confuse user that why AMD provides two <br>
different power results.<br>
<br>
Regards,<br>
Eric<br>
<br>
On 2018-04-04 04:25 AM, Rex Zhu wrote:<br>
&gt; 1. On polaris10/11/12, Sending smu message PPSMC_MSG_GetCurrPkgPwr to<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; read currentpkgpwr directly.<br>
&gt; 2. On Fiji/tonga/bonaire/hawwii, no PPSMC_MSG_GetCurrPkgPwr support.<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Send PPSMC_MSG_PmStatusLogStart to let smu wri=
te currentpkgpwr<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; to ixSMU_PM_STATUS_94. this is asynchronous. n=
eed to delay no less<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; than 1ms.<br>
&gt; 3. Clean ixSMU_PM_STATUS_94 immediately when send PPSMC_MSG_PmStatusLo=
gStart<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; to avoid read old value.<br>
&gt; 4. delay 10 ms instand of 20 ms. so the result will more similar to<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; the output of PPSMC_MSG_GetCurrPkgPwr.<br>
&gt; 5. remove max power/vddc/vddci output to keep consistent with vega.<br=
>
&gt; 6. for vddc/vddci power, we can calculate the average value per<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; [10ms, 4s] in other interface if needed.<br>
&gt;<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 45 &#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------------<br>
&gt;&nbsp;&nbsp; 1 file changed, 21 insertions(&#43;), 24 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; index 40f2f87..c0ce672 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; @@ -3363,30 &#43;3363,27 @@ static int smu7_get_pp_table_entry(struct =
pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp; static int smu7_get_gpu_power(struct pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct pp_gpu_power *query)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hw=
mgr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PmStatusLogSt=
art),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to start p=
m status log!&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; msleep_interruptible(20);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hw=
mgr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_PmStatusLogSa=
mple),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to sample =
pm status log!&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; query-&gt;vddc_power =3D cgs_read_ind_regist=
er(hwmgr-&gt;device,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ixSMU_PM_STATUS_40);<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; query-&gt;vddci_power =3D cgs_read_ind_regis=
ter(hwmgr-&gt;device,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ixSMU_PM_STATUS_49);<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; query-&gt;max_gpu_power =3D cgs_read_ind_reg=
ister(hwmgr-&gt;device,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ixSMU_PM_STATUS_94);<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; query-&gt;average_gpu_power =3D cgs_read_ind=
_register(hwmgr-&gt;device,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ixSMU_PM_STATUS_95);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!query)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; memset(query, 0, sizeof *query);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;chip_id &gt;=3D CHIP_POLAR=
IS10) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrPkgPwr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; query-&gt;average_gpu_power =3D cgs_read_register(hwmgr-&gt;device,=
 mmSMC_MSG_ARG_0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogStart);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; cgs_write_ind_register(hwmgr-&gt;device, CGS_IND_REG__SMC,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; ixSMU_PM_STATUS_94, 0);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; msleep_interruptible(10);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; smum_send_msg_to_smc(hwmgr, PPSMC_MSG_PmStatusLogSample);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; query-&gt;average_gpu_power =3D cgs_read_ind_register(hwmgr-&gt;dev=
ice,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; CGS_IND_REG__SMC,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ixSMU_PM_STATUS_94);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk731909" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15228562333390.979542144089784" style=3D"margin-bott=
om: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15228562333280.30238014676002334" role=3D"presenta=
tion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255=
, 255); position: relative; overflow: auto; padding-top: 20px; padding-bott=
om: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); bord=
er-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15228562333320.0901521230341924" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15228562333330.5335910012443676"></div>
<div id=3D"LPTitle_15228562333330.17088493377011438" style=3D"top: 0px; col=
or: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf=
_segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-h=
eight: 21px;">
<a id=3D"LPUrlAnchor_15228562333350.45851088175032095" href=3D"https://list=
s.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text=
-decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15228562333360.9650973279775443" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15228562333370.9839175290800748" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687C34CD0753343A795544CFBA40CY4PR12MB1687namp_--

--===============1825478800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1825478800==--
