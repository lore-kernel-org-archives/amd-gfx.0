From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/pp: Add stable Pstate clk display when
 print_clock_levels
Date: Mon, 8 Jan 2018 21:18:33 +0000
Message-ID: <BN6PR12MB1652592A32877B4A306CA655F7130@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1515405451-16492-1-git-send-email-Rex.Zhu@amd.com>
 <1515405451-16492-2-git-send-email-Rex.Zhu@amd.com>
 <b0f6ccfc-eb6b-be04-9122-4b3dd9b73979@amd.com>
 <CADnq5_O_Dqj51NLAYddSsDg_9ZvLF-+niEmVwEZ45=OZ27PMYQ@mail.gmail.com>
 ,
 <BN6PR1201MB0180DCC58FCE82683ED7591485130@BN6PR1201MB0180.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2055416826=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR1201MB0180DCC58FCE82683ED7591485130-6iU6OBHu2P/H0AMcJMwsYmrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2055416826==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652592A32877B4A306CA655F7130BN6PR12MB1652namp_"

--_000_BN6PR12MB1652592A32877B4A306CA655F7130BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The changes to the pp_dpm_files are purely informational with this patch (y=
ou can't actually interact with the stable pstate) so I think they should b=
e dropped and exposed some other way.  Setting the profile modes via force_=
performance_level forces the clocks and disables clock and power gating.  T=
hat is the interface you should use to interact with it.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Russell,=
 Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, January 8, 2018 3:22 PM
To: Alex Deucher; Kuehling, Felix
Cc: amd-gfx list
Subject: RE: [PATCH 2/2] drm/amd/pp: Add stable Pstate clk display when pri=
nt_clock_levels

Sorry, I just re-read and saw that this will be in sclk and mclk, not just =
mclk. So will this have a direct impact on any other functionality, or will=
 it just disable clock/power gating and prevent the clocks from changing?

 Kent

-----Original Message-----
From: Russell, Kent
Sent: Monday, January 08, 2018 2:52 PM
To: 'Alex Deucher'; Kuehling, Felix
Cc: amd-gfx list
Subject: RE: [PATCH 2/2] drm/amd/pp: Add stable Pstate clk display when pri=
nt_clock_levels

And yes, it will confuse the SMI in a couple functions, but thankfully it's=
 nice enough that I can fix it with a couple lines.

So just to make sure that I understand this correctly, if a user were to ec=
ho P to the pp_dpm_mclk file, it would disable clockgating and powergating =
and keep the memory clocks at a stable level (likely level 0)? And this wou=
ld have no impact on the SCLK or Power Profile or anything else, just the m=
clk? Just asking so I know how to implement it in the SMI. Thanks!

 Kent

-----Original Message-----
From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: Monday, January 08, 2018 2:35 PM
To: Kuehling, Felix
Cc: amd-gfx list; Russell, Kent
Subject: Re: [PATCH 2/2] drm/amd/pp: Add stable Pstate clk display when pri=
nt_clock_levels

On Mon, Jan 8, 2018 at 2:20 PM, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org> wro=
te:
> [+Kent]
>
> What does stable pstate mean? What is it used for?

This is used for the profiling stuff in force_performance_level.  It disabl=
es clock and power gating and sets stable clock levels for doing performanc=
e profiling.

Alex

>
> Hi Kent,
>
> Is this going to confuse rocm_smi?
>
> Regards,
>   Felix
>
>
> On 2018-01-08 04:57 AM, Rex Zhu wrote:
>> The additional output are at the end of sclk/mclk info as cat
>> pp_dpm_mclk
>> 0: 300Mhz *
>> 1: 1650Mhz
>> P: 300Mhz
>>
>> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>>
>> Change-Id: Idf8eeedb5d399d9ffb7de7a2fb2976c7fa7c01a8
>> ---
>>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     | 2 ++
>>  drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c     | 2 ++
>>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 2 ++
>>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 ++
>>  4 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>> b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>> index f68dd08..03dfba0 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>> @@ -1601,6 +1601,7 @@ static int cz_print_clock_levels(struct pp_hwmgr *=
hwmgr,
>>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>>                                       i, sclk_table->entries[i].clk / 10=
0,
>>                                       (i =3D=3D now) ? "*" : "");
>> +             size +=3D sprintf(buf + size, "P: %uMhz\n",
>> + hwmgr->pstate_sclk/100);
>>               break;
>>       case PP_MCLK:
>>               now =3D
>> PHM_GET_FIELD(cgs_read_ind_register(hwmgr->device,
>> @@ -1613,6 +1614,7 @@ static int cz_print_clock_levels(struct pp_hwmgr *=
hwmgr,
>>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>>                                       CZ_NUM_NBPMEMORYCLOCK-i, data->sys=
_info.nbp_memory_clock[i-1] / 100,
>>                                       (CZ_NUM_NBPMEMORYCLOCK-i =3D=3D
>> now) ? "*" : "");
>> +             size +=3D sprintf(buf + size, "P: %uMhz\n",
>> + hwmgr->pstate_mclk/100);
>>               break;
>>       default:
>>               break;
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
>> b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
>> index 409a56b..88c6ad8 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
>> @@ -756,6 +756,7 @@ static int rv_print_clock_levels(struct pp_hwmgr *hw=
mgr,
>>                               data->gfx_max_freq_limit / 100,
>>                               ((data->gfx_max_freq_limit / 100)
>>                                =3D=3D now) ? "*" : "");
>> +             size +=3D sprintf(buf + size, "P: %uMhz\n",
>> + hwmgr->pstate_sclk/100);
>>               break;
>>       case PP_MCLK:
>>               PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
>> @@ -773,6 +774,7 @@ static int rv_print_clock_levels(struct pp_hwmgr *hw=
mgr,
>>                                       mclk_table->entries[i].clk / 100,
>>                                       ((mclk_table->entries[i].clk / 100=
)
>>                                        =3D=3D now) ? "*" : "");
>> +             size +=3D sprintf(buf + size, "P: %uMhz\n",
>> + hwmgr->pstate_mclk/100);
>>               break;
>>       default:
>>               break;
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> index 72031bd..1bdcd86 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>> @@ -4372,6 +4372,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr=
 *hwmgr,
>>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>>                                       i, sclk_table->dpm_levels[i].value=
 / 100,
>>                                       (i =3D=3D now) ? "*" : "");
>> +             size +=3D sprintf(buf + size, "P: %uMhz\n",
>> + hwmgr->pstate_sclk/100);
>>               break;
>>       case PP_MCLK:
>>               smum_send_msg_to_smc(hwmgr,
>> PPSMC_MSG_API_GetMclkFrequency); @@ -4388,6 +4389,7 @@ static int smu7_p=
rint_clock_levels(struct pp_hwmgr *hwmgr,
>>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>>                                       i, mclk_table->dpm_levels[i].value=
 / 100,
>>                                       (i =3D=3D now) ? "*" : "");
>> +             size +=3D sprintf(buf + size, "P: %uMhz\n",
>> + hwmgr->pstate_mclk/100);
>>               break;
>>       case PP_PCIE:
>>               pcie_speed =3D smu7_get_current_pcie_speed(hwmgr);
>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>> index cb35f4f..cab50fc 100644
>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>> @@ -4565,6 +4565,7 @@ static int vega10_print_clock_levels(struct pp_hwm=
gr *hwmgr,
>>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>>                                       i, sclk_table->dpm_levels[i].value=
 / 100,
>>                                       (i =3D=3D now) ? "*" : "");
>> +             size +=3D sprintf(buf + size, "P: %uMhz\n",
>> + hwmgr->pstate_sclk/100);
>>               break;
>>       case PP_MCLK:
>>               if (data->registry_data.mclk_dpm_key_disabled)
>> @@ -4583,6 +4584,7 @@ static int vega10_print_clock_levels(struct pp_hwm=
gr *hwmgr,
>>                       size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>>                                       i, mclk_table->dpm_levels[i].value=
 / 100,
>>                                       (i =3D=3D now) ? "*" : "");
>> +             size +=3D sprintf(buf + size, "P: %uMhz\n",
>> + hwmgr->pstate_mclk/100);
>>               break;
>>       case PP_PCIE:
>>               PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652592A32877B4A306CA655F7130BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">The changes to the pp_dpm_files a=
re purely informational with this patch (you can't actually interact with t=
he stable pstate) so I think they should be dropped and exposed some other =
way.&nbsp; Setting the profile modes via
 force_performance_level forces the clocks and disables clock and power gat=
ing.&nbsp; That is the interface you should use to interact with it.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Russell, Kent &lt;Kent.Russ=
ell-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, January 8, 2018 3:22 PM<br>
<b>To:</b> Alex Deucher; Kuehling, Felix<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amd/pp: Add stable Pstate clk display w=
hen print_clock_levels</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Sorry, I just re-read and saw that this will be in=
 sclk and mclk, not just mclk. So will this have a direct impact on any oth=
er functionality, or will it just disable clock/power gating and prevent th=
e clocks from changing?<br>
<br>
&nbsp;Kent<br>
<br>
-----Original Message-----<br>
From: Russell, Kent <br>
Sent: Monday, January 08, 2018 2:52 PM<br>
To: 'Alex Deucher'; Kuehling, Felix<br>
Cc: amd-gfx list<br>
Subject: RE: [PATCH 2/2] drm/amd/pp: Add stable Pstate clk display when pri=
nt_clock_levels<br>
<br>
And yes, it will confuse the SMI in a couple functions, but thankfully it's=
 nice enough that I can fix it with a couple lines.
<br>
<br>
So just to make sure that I understand this correctly, if a user were to ec=
ho P to the pp_dpm_mclk file, it would disable clockgating and powergating =
and keep the memory clocks at a stable level (likely level 0)? And this wou=
ld have no impact on the SCLK or
 Power Profile or anything else, just the mclk? Just asking so I know how t=
o implement it in the SMI. Thanks!<br>
<br>
&nbsp;Kent<br>
<br>
-----Original Message-----<br>
From: Alex Deucher [<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:alexdeu=
cher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
Sent: Monday, January 08, 2018 2:35 PM<br>
To: Kuehling, Felix<br>
Cc: amd-gfx list; Russell, Kent<br>
Subject: Re: [PATCH 2/2] drm/amd/pp: Add stable Pstate clk display when pri=
nt_clock_levels<br>
<br>
On Mon, Jan 8, 2018 at 2:20 PM, Felix Kuehling &lt;felix.kuehling-5C7GfCeVMHo@public.gmane.org&g=
t; wrote:<br>
&gt; [&#43;Kent]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&gt;<br>
&gt; What does stable pstate mean? What is it used for?<br>
<br>
This is used for the profiling stuff in force_performance_level.&nbsp; It d=
isables clock and power gating and sets stable clock levels for doing perfo=
rmance profiling.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Hi Kent,<br>
&gt;<br>
&gt; Is this going to confuse rocm_smi?<br>
&gt;<br>
&gt; Regards,<br>
&gt;&nbsp;&nbsp; Felix<br>
&gt;<br>
&gt;<br>
&gt; On 2018-01-08 04:57 AM, Rex Zhu wrote:<br>
&gt;&gt; The additional output are at the end of sclk/mclk info as cat <br>
&gt;&gt; pp_dpm_mclk<br>
&gt;&gt; 0: 300Mhz *<br>
&gt;&gt; 1: 1650Mhz<br>
&gt;&gt; P: 300Mhz<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;<br>
&gt;&gt; Change-Id: Idf8eeedb5d399d9ffb7de7a2fb2976c7fa7c01a8<br>
&gt;&gt; ---<br>
&gt;&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&nbsp;&n=
bsp;&nbsp; | 2 &#43;&#43;<br>
&gt;&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c&nbsp;&nbsp;&n=
bsp;&nbsp; | 2 &#43;&#43;<br>
&gt;&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp;=
 | 2 &#43;&#43;<br>
&gt;&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 &#43;=
&#43;<br>
&gt;&gt;&nbsp; 4 files changed, 8 insertions(&#43;)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt;&gt; index f68dd08..03dfba0 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<b=
r>
&gt;&gt; @@ -1601,6 &#43;1601,7 @@ static int cz_print_clock_levels(struct =
pp_hwmgr *hwmgr,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43=
;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; i, sclk_table-&gt;entries[i].clk / 100,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&quot;,<b=
r>
&gt;&gt; &#43; hwmgr-&gt;pstate_sclk/100);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MCLK:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; now =3D<br>
&gt;&gt; PHM_GET_FIELD(cgs_read_ind_register(hwmgr-&gt;device,<br>
&gt;&gt; @@ -1613,6 &#43;1614,7 @@ static int cz_print_clock_levels(struct =
pp_hwmgr *hwmgr,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43=
;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; CZ_NUM_NBPMEMORYCLOCK-i, data-&gt;sys_info.nbp_memory_clock[i-1=
] / 100,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (CZ_NUM_NBPMEMORYCLOCK-i =3D=3D<br>
&gt;&gt; now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&quot;,<b=
r>
&gt;&gt; &#43; hwmgr-&gt;pstate_mclk/100);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt;&gt; index 409a56b..88c6ad8 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<b=
r>
&gt;&gt; @@ -756,6 &#43;756,7 @@ static int rv_print_clock_levels(struct pp=
_hwmgr *hwmgr,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;gfx_max_freq_limit / 100,<b=
r>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((data-&gt;gfx_max_freq_limit / 100)=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D now) ? &quot;*&quot; : =
&quot;&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&quot;,<b=
r>
&gt;&gt; &#43; hwmgr-&gt;pstate_sclk/100);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MCLK:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,<br>
&gt;&gt; @@ -773,6 &#43;774,7 @@ static int rv_print_clock_levels(struct pp=
_hwmgr *hwmgr,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; mclk_table-&gt;entries[i].clk / 100,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; ((mclk_table-&gt;entries[i].clk / 100)<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&quot;,<b=
r>
&gt;&gt; &#43; hwmgr-&gt;pstate_mclk/100);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt;&gt; index 72031bd..1bdcd86 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c=
<br>
&gt;&gt; @@ -4372,6 &#43;4372,7 @@ static int smu7_print_clock_levels(struc=
t pp_hwmgr *hwmgr,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43=
;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; i, sclk_table-&gt;dpm_levels[i].value / 100,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&quot;,<b=
r>
&gt;&gt; &#43; hwmgr-&gt;pstate_sclk/100);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MCLK:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, <br>
&gt;&gt; PPSMC_MSG_API_GetMclkFrequency); @@ -4388,6 &#43;4389,7 @@ static =
int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43=
;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; i, mclk_table-&gt;dpm_levels[i].value / 100,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&quot;,<b=
r>
&gt;&gt; &#43; hwmgr-&gt;pstate_mclk/100);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PCIE:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pcie_speed =3D smu7_get_current_pcie_speed(hwmgr);<br>
&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br=
>
&gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt;&gt; index cb35f4f..cab50fc 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr=
.c<br>
&gt;&gt; @@ -4565,6 &#43;4565,7 @@ static int vega10_print_clock_levels(str=
uct pp_hwmgr *hwmgr,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43=
;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; i, sclk_table-&gt;dpm_levels[i].value / 100,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&quot;,<b=
r>
&gt;&gt; &#43; hwmgr-&gt;pstate_sclk/100);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MCLK:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (data-&gt;registry_data.mclk_dpm_key_disabled)<br>
&gt;&gt; @@ -4583,6 &#43;4584,7 @@ static int vega10_print_clock_levels(str=
uct pp_hwmgr *hwmgr,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43=
;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; i, mclk_table-&gt;dpm_levels[i].value / 100,<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&quot;,<b=
r>
&gt;&gt; &#43; hwmgr-&gt;pstate_mclk/100);<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PCIE:<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652592A32877B4A306CA655F7130BN6PR12MB1652namp_--

--===============2055416826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2055416826==--
