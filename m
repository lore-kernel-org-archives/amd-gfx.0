From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Expose new interface to DC to ctrl auto
 wattman
Date: Thu, 8 Feb 2018 15:58:56 +0000
Message-ID: <CY4PR12MB1687747073E0E3B90E2DB090FBF30@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1518088825-4744-1-git-send-email-Rex.Zhu@amd.com>
 <1a93901f-528c-b28e-d0c0-57809543a759@amd.com>
 <CY4PR12MB16870B662724C2F6BD1A8014FBF30@CY4PR12MB1687.namprd12.prod.outlook.com>
 <064c9f69-c87e-34c4-b55e-1a9fb43b6075@amd.com>,
 <d1fde114-78ea-3a79-986a-b6292dde8115@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0964347212=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d1fde114-78ea-3a79-986a-b6292dde8115-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Cyr, Aric" <Aric.Cyr-5C7GfCeVMHo@public.gmane.org>, "Koo, Anthony" <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>

--===============0964347212==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687747073E0E3B90E2DB090FBF30CY4PR12MB1687namp_"

--_000_CY4PR12MB1687747073E0E3B90E2DB090FBF30CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Thanks Harry for clarify this question thoroughly.


>We'll still need a patch to call this interface from DC. Is that on your p=
late or is this something we should hook up?

No, I just implemented the interface in pp. DC need to call this function t=
o enable/disable the auto wattman feature when  Freesync disable/enable.


Best Regards

Rex

________________________________
From: Wentland, Harry
Sent: Thursday, February 8, 2018 11:28 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Koo, Anthony; Cyr, Aric
Subject: Re: [PATCH] drm/amd/pp: Expose new interface to DC to ctrl auto wa=
ttman

On 2018-02-08 10:10 AM, Harry Wentland wrote:
> On 2018-02-08 10:07 AM, Zhu, Rex wrote:
>> when autowattman enabled=1B$B!$=1B(Bwe will update uphyst/downhyst/min-s=
clk/mclk activity  value to smu based on the workload.
>>
>
> Why is this incompatible with Freesync?
>

Just had a chat with the Windows guys. Apparently AutoWattman changes clock=
s quite aggressively which can make framerates jump significantly and lead =
to a subpar experience when using Freesync.

We'll still need a patch to call this interface from DC. Is that on your pl=
ate or is this something we should hook up?

Harry

> Harry
>
>> Best Regards
>> Rex
>>
>> ------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------
>> *From:* Wentland, Harry
>> *Sent:* Thursday, February 8, 2018 10:22:16 PM
>> *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *Subject:* Re: [PATCH] drm/amd/pp: Expose new interface to DC to ctrl au=
to wattman
>>
>> On 2018-02-08 06:20 AM, Rex Zhu wrote:
>>> Disable AutoWattman (if enabled) when FreeSync is enabled.
>>
>> Do you have a DC change calling this?
>>
>> What's the use case for this and why do we need to disable AutoWattman w=
hen Freesync is enabled?
>>
>> What does AutoWattman do?
>>
>> Harry
>>
>>>
>>> Change-Id: I9a531321d7913b8b40e60070c569a01c4f202002
>>> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/include/kgd_pp_interface.h |  1 +
>>>   drivers/gpu/drm/amd/powerplay/amd_powerplay.c  | 25 +++++++++++++++++=
++++++++
>>>   2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/g=
pu/drm/amd/include/kgd_pp_interface.h
>>> index 22c2fa3..f7bb565 100644
>>> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>> @@ -313,6 +313,7 @@ struct amd_pm_funcs {
>>>         int (*set_power_profile_mode)(void *handle, long *input, uint32=
_t size);
>>>         int (*odn_edit_dpm_table)(void *handle, uint32_t type, long *in=
put, uint32_t size);
>>>         int (*set_mmhub_powergating_by_smu)(void *handle);
>>> +     int (*notify_free_sync_change)(void *handle, bool en);
>>>   };
>>>
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gp=
u/drm/amd/powerplay/amd_powerplay.c
>>> index 376ed2d..d0306b6 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>>> @@ -1555,6 +1555,30 @@ static int pp_set_mmhub_powergating_by_smu(void =
*handle)
>>>         return hwmgr->hwmgr_func->set_mmhub_powergating_by_smu(hwmgr);
>>>   }
>>>
>>> +static int pp_notify_free_sync_change(void *handle, bool en)
>>> +{
>>> +     struct pp_hwmgr *hwmgr;
>>> +     struct pp_instance *pp_handle =3D (struct pp_instance *)handle;
>>> +     int ret =3D 0;
>>> +
>>> +     ret =3D pp_check(pp_handle);
>>> +
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     hwmgr =3D pp_handle->hwmgr;
>>> +
>>> +     mutex_lock(&pp_handle->pp_lock);
>>> +     if (hwmgr->autowattman_enabled) {
>>> +             if (hwmgr->hwmgr_func->start_auto_wattman !=3D NULL) {
>>> +                     if (!cancel_delayed_work_sync(&hwmgr->wattman_upd=
ate_work))
>>> +                             hwmgr->hwmgr_func->start_auto_wattman(hwm=
gr, en);
>>> +             }
>>> +     }
>>> +     mutex_unlock(&pp_handle->pp_lock);
>>> +     return 0;
>>> +}
>>> +
>>>   const struct amd_pm_funcs pp_dpm_funcs =3D {
>>>         .load_firmware =3D pp_dpm_load_fw,
>>>         .wait_for_fw_loading_complete =3D pp_dpm_fw_loading_complete,
>>> @@ -1604,4 +1628,5 @@ static int pp_set_mmhub_powergating_by_smu(void *=
handle)
>>>         .display_clock_voltage_request =3D pp_display_clock_voltage_req=
uest,
>>>         .get_display_mode_validation_clocks =3D pp_get_display_mode_val=
idation_clocks,
>>>         .set_mmhub_powergating_by_smu =3D pp_set_mmhub_powergating_by_s=
mu,
>>> +     .notify_free_sync_change =3D pp_notify_free_sync_change,
>>>   };
>>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...



>

--_000_CY4PR12MB1687747073E0E3B90E2DB090FBF30CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Thanks Harry for&nbsp;<span style=
=3D"color: rgb(51, 51, 51); font-family: arial; font-size: 13px;">clarify t=
his question thoroughly.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(51, 51,=
 51); font-family: arial; font-size: 13px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(51, 51,=
 51); font-family: arial; font-size: 13px;"><span style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quo=
t;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;=
Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&gt;We'll
 still need a patch to call this interface from DC. Is that on your plate o=
r is this something we should hook up?</span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(51, 51,=
 51); font-family: arial; font-size: 13px;"><span style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quo=
t;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;=
Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"></span>No,
 I just implemented the interface in pp. DC need to call this function to e=
nable/disable the auto&nbsp;wattman feature
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">
when &nbsp;Freesync disable/enable.</span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(51, 51,=
 51);"><font face=3D"arial"><span style=3D"font-size: 13px;"><br>
</span></font></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(51, 51,=
 51);"><font face=3D"arial"><span style=3D"font-size: 13px;"><br>
</span></font>Best Regards</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><font color=3D"#333333">Rex</font=
></p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Wentland, Harry<br>
<b>Sent:</b> Thursday, February 8, 2018 11:28 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Koo, Anthony; Cyr, Aric<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pp: Expose new interface to DC to ctrl =
auto wattman</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2018-02-08 10:10 AM, Harry Wentland wrote:<br>
&gt; On 2018-02-08 10:07 AM, Zhu, Rex wrote:<br>
&gt;&gt; when autowattman enabled=1B$B!$=1B(Bwe will update uphyst/downhyst=
/min-sclk/mclk activity&nbsp; value to smu based on the workload.<br>
&gt;&gt;<br>
&gt; <br>
&gt; Why is this incompatible with Freesync?<br>
&gt; <br>
<br>
Just had a chat with the Windows guys. Apparently AutoWattman changes clock=
s quite aggressively which can make framerates jump significantly and lead =
to a subpar experience when using Freesync.<br>
<br>
We'll still need a patch to call this interface from DC. Is that on your pl=
ate or is this something we should hook up?<br>
<br>
Harry<br>
<br>
&gt; Harry<br>
&gt; <br>
&gt;&gt; Best Regards<br>
&gt;&gt; Rex<br>
&gt;&gt;<br>
&gt;&gt; ------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------<br>
&gt;&gt; *From:* Wentland, Harry<br>
&gt;&gt; *Sent:* Thursday, February 8, 2018 10:22:16 PM<br>
&gt;&gt; *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; *Subject:* Re: [PATCH] drm/amd/pp: Expose new interface to DC to c=
trl auto wattman<br>
&gt;&gt; &nbsp;<br>
&gt;&gt; On 2018-02-08 06:20 AM, Rex Zhu wrote:<br>
&gt;&gt;&gt; Disable AutoWattman (if enabled) when FreeSync is enabled.<br>
&gt;&gt;<br>
&gt;&gt; Do you have a DC change calling this?<br>
&gt;&gt;<br>
&gt;&gt; What's the use case for this and why do we need to disable AutoWat=
tman when Freesync is enabled?<br>
&gt;&gt;<br>
&gt;&gt; What does AutoWattman do?<br>
&gt;&gt;<br>
&gt;&gt; Harry<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Change-Id: I9a531321d7913b8b40e60070c569a01c4f202002<br>
&gt;&gt;&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/include/kgd_pp_interface.h |&nbsp; =
1 &#43;<br>
&gt;&gt;&gt; &nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c&nbsp; | 2=
5 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&gt;&gt; &nbsp; 2 files changed, 26 insertions(&#43;)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/=
drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt;&gt;&gt; index 22c2fa3..f7bb565 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interface=
.h<br>
&gt;&gt;&gt; @@ -313,6 &#43;313,7 @@ struct amd_pm_funcs {<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_pro=
file_mode)(void *handle, long *input, uint32_t size);<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*odn_edit_dpm_=
table)(void *handle, uint32_t type, long *input, uint32_t size);<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_mmhub_pow=
ergating_by_smu)(void *handle);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int (*notify_free_sync_change)(v=
oid *handle, bool en);<br>
&gt;&gt;&gt; &nbsp; };<br>
&gt;&gt;&gt; &nbsp; <br>
&gt;&gt;&gt; &nbsp; #endif<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/d=
rivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt;&gt;&gt; index 376ed2d..d0306b6 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.=
c<br>
&gt;&gt;&gt; @@ -1555,6 &#43;1555,30 @@ static int pp_set_mmhub_powergating=
_by_smu(void *handle)<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hw=
mgr_func-&gt;set_mmhub_powergating_by_smu(hwmgr);<br>
&gt;&gt;&gt; &nbsp; }<br>
&gt;&gt;&gt; &nbsp; <br>
&gt;&gt;&gt; &#43;static int pp_notify_free_sync_change(void *handle, bool =
en)<br>
&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_instance *pp_handle =
=3D (struct pp_instance *)handle;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(pp_handle);<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr =3D pp_handle-&gt;hwmgr;<b=
r>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;pp_handle-&gt;pp=
_lock);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;autowattman_enable=
d) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;start_auto_wattman !=3D NULL) =
{<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cancel=
_delayed_work_sync(&amp;hwmgr-&gt;wattman_update_work))<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_func-&gt;start_auto_wa=
ttman(hwmgr, en);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;pp_handle-&gt;=
pp_lock);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &nbsp; const struct amd_pm_funcs pp_dpm_funcs =3D {<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .load_firmware =3D =
pp_dpm_load_fw,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_fw_loadin=
g_complete =3D pp_dpm_fw_loading_complete,<br>
&gt;&gt;&gt; @@ -1604,4 &#43;1628,5 @@ static int pp_set_mmhub_powergating_=
by_smu(void *handle)<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_volt=
age_request =3D pp_display_clock_voltage_request,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_display_mode_v=
alidation_clocks =3D pp_get_display_mode_validation_clocks,<br>
&gt;&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mmhub_powergat=
ing_by_smu =3D pp_set_mmhub_powergating_by_smu,<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .notify_free_sync_change =3D pp_=
notify_free_sync_change,<br>
&gt;&gt;&gt; &nbsp; };<br>
&gt;&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk958748" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15181049861350.4060229547431593" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15181049861300.22911283410047023" role=3D"presenta=
tion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255=
, 255); position: relative; overflow: auto; padding-top: 20px; padding-bott=
om: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); bord=
er-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15181049861330.12137092720321419" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_15181049861330.8856657762314699"></div>
<div id=3D"LPTitle_15181049861330.9856724405077941" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15181049861340.6964929520917347" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15181049861340.46317979394903386" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: w=
f_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Aria=
l, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15181049861350.5957188687150226" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
&gt; <br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687747073E0E3B90E2DB090FBF30CY4PR12MB1687namp_--

--===============0964347212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0964347212==--
