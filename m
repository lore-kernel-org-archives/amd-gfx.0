From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/pp: Refine get_gpu_power for VI
Date: Wed, 4 Apr 2018 16:05:14 +0000
Message-ID: <CY4PR12MB1687A15A9D2A5016B6577C17FBA40@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1522830304-15505-1-git-send-email-Rex.Zhu@amd.com>
 <1522830304-15505-2-git-send-email-Rex.Zhu@amd.com>
 <a3566d2f-4b35-00b4-1df1-ab50076f704c@amd.com>
 <CY4PR12MB1687C34CD0753343A795544CFBA40@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <dfcb5127-c6ad-2a09-793e-42ca3cdcff1d@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0183769046=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <dfcb5127-c6ad-2a09-793e-42ca3cdcff1d-5C7GfCeVMHo@public.gmane.org>
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

--===============0183769046==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687A15A9D2A5016B6577C17FBA40CY4PR12MB1687namp_"

--_000_CY4PR12MB1687A15A9D2A5016B6577C17FBA40CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

with this patch, there should be no difference between AGT and sysfs.



Best Regards

Rex

________________________________
From: Huang, JinHuiEric
Sent: Thursday, April 5, 2018 12:00 AM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 2/3] drm/amd/pp: Refine get_gpu_power for VI


So you didn't compare the result with AGT, but I did. The reality is not li=
ke your speculation.


Regards,

Eric

On 2018-04-04 11:50 AM, Zhu, Rex wrote:

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
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>=
<mailto:jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, April 4, 2018 11:36 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org><mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.





--_000_CY4PR12MB1687A15A9D2A5016B6577C17FBA40CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">with this patch, there should be =
no difference between&nbsp;AGT and sysfs.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, JinHuiEric<br>
<b>Sent:</b> Thursday, April 5, 2018 12:00 AM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amd/pp: Refine get_gpu_power for VI</fo=
nt>
<div>&nbsp;</div>
</div>
<div style=3D"background-color:#FFFFFF">
<p>So you didn't compare the result with AGT, but I did. The reality is not=
 like your speculation.</p>
<p><br>
</p>
<p>Regards,</p>
<p>Eric<br>
</p>
<br>
<div class=3D"x_moz-cite-prefix">On 2018-04-04 11:50 AM, Zhu, Rex wrote:<br=
>
</div>
<blockquote type=3D"cite">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">If user send&nbsp;<span style=3D=
"">message PPSMC_MSG_GetCurrPkgPwr, firmware will return the pkgpwr immedia=
tely as current&nbsp;power value.</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"">as no&nbsp;<spa=
n style=3D"">PPSMC_MSG_GetCurrPkgPwr support, so send message &nbsp;let fir=
mware write&nbsp;<span style=3D"">pkgpwr &nbsp;to&nbsp;<span style=3D"">ixS=
MU_PM_STATUS_94,</span></span></span></span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D""><span style=3D"=
"><span style=3D""><span style=3D"">and driver delay 10ms to read
<span style=3D"">ixSMU_PM_STATUS_94.</span></span></span></span></span></p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">I don't think there is any probl=
em. otherwise, there is same issue on polaris/vega.</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">I clean <span style=3D"">ixSMU_P=
M_STATUS_94 before let smu write it.</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"">The delay time =
is enough unless we got 0 from
<span style=3D"">ixSMU_PM_STATUS_94&nbsp;</span>.</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D""><br>
</span></p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0; margin-bottom:0">Rex</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org" id=3D"LPlnk680627" previewremoved=3D"true">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Eric Huang <=
a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:jinhuieric.huang-5C7GfCeVMHo@public.gmane.org=
" id=3D"LPlnk55605" previewremoved=3D"true">
&lt;jinhuieric.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Wednesday, April 4, 2018 11:36 PM<br>
<b>To:</b> <a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@l=
ists.freedesktop.org" id=3D"LPlnk367731" previewremoved=3D"true">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amd/pp: Refine get_gpu_power for VI</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Sampling period is too short. The power reading =
value will be not
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
&gt; Signed-off-by: Rex Zhu <a class=3D"x_moz-txt-link-rfc2396E" href=3D"ma=
ilto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" id=3D"LPlnk268038" previewremoved=3D"true">
&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
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
<a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org" id=3D"LPlnk801665" previewremoved=3D"true">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk731909" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15228562333390.979542144089784" style=3D"margin-bott=
om:20px; overflow:auto; width:100%; text-indent:0px" contenteditable=3D"fal=
se">
<table id=3D"LPContainer_15228562333280.30238014676002334" cellspacing=3D"0=
" style=3D"width:90%; background-color:rgb(255,255,255); overflow:auto; pad=
ding-top:20px; padding-bottom:20px; margin-top:20px; border-top:1px dotted =
rgb(200,200,200); border-bottom:1px dotted rgb(200,200,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"x_TextCell_15228562333320.0901521230341924" colspan=3D"2" style=
=3D"vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPTitle_15228562333330.17088493377011438" style=3D""><a id=3D"LP=
UrlAnchor_15228562333350.45851088175032095" href=3D"https://lists.freedeskt=
op.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-decoration=
:none">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15228562333360.9650973279775443" style=3D"">lists.fre=
edesktop.org</div>
<div id=3D"LPDescription_15228562333370.9839175290800748" style=3D"">Subscr=
ibing to amd-gfx: Subscribe to amd-gfx by filling out the following form. U=
se of all freedesktop.org lists is subject to our Code of Conduct.</div>
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
</blockquote>
<br>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687A15A9D2A5016B6577C17FBA40CY4PR12MB1687namp_--

--===============0183769046==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0183769046==--
