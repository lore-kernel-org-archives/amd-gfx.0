From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mode on smu7
Date: Wed, 24 Jan 2018 23:05:11 +0000
Message-ID: <CY4PR12MB1687A95AD6A9C584060686F8FBE20@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1516786649-14914-1-git-send-email-Rex.Zhu@amd.com>
 <1516786649-14914-4-git-send-email-Rex.Zhu@amd.com>
 <e21a2657-7a80-5b59-6c1c-a578d3bf79a9@amd.com>
 <CY4PR12MB1687B4CBFF3BC4DD121752A4FBE20@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <e86e1a66-37d4-f3cc-8eae-689c81356526@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0474592301=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e86e1a66-37d4-f3cc-8eae-689c81356526-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0474592301==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687A95AD6A9C584060686F8FBE20CY4PR12MB1687namp_"

--_000_CY4PR12MB1687A95AD6A9C584060686F8FBE20CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Felix,

The logic of gfx/computer profile setting works in such way as you said,nee=
d under =1B$B!H=1B(Bauto=1B$B!I=1B(B state.
But in new sysfs of power profile setting, we do not check the performance
Level.

And The =1B$B!H=1B(Bmanual=1B$B!I=1B(B state is a confusing flag=1B$B!$=1B(=
Bwhen user set manual state=1B$B!$=1B(Band then change the clk range throug=
h pp-dpm-sclk/mclk=1B$B!$=1B(Bthe dpm still works automatically in new cloc=
k range, I think we can remove this flag.

So  My idea is
in the sysfs of pp dpm sclk/mclk, user can set clock range.
In the sysfs of power profile state, user can configure the parameters smu/=
driver exposed. They are independent.






Best Regards
Rex
________________________________
From: Kuehling, Felix
Sent: Thursday, January 25, 2018 5:41:43 AM
To: Zhu, Rex; Huang, JinHuiEric; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mode on sm=
u7

Hi Rex,

As I understand it (the way power profiles currently work),
pp_dpm_sclk/mclk only apply if pp_dpm_force_performance_level is set to
"manual". Power profiles and automatic switching between profiles only
happens when pp_dpm_force_performance_level is set to "auto".

This means pp_dpm_sclk/mclk don't apply when profiles are in effect.
Also, there would be no way to set different minimum clocks for
different profiles.

I think minimum clocks should be part of the profiles.

Regards,
  Felix


On 2018-01-24 03:13 PM, Zhu, Rex wrote:
> Hi Eric,
>
> We have sysfs pp-dpm-sclk/mclk to set min dpm level
>
> Best Regards
> Rex
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
> Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Thursday, January 25, 2018 12:04:55 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 4/4] drm/amd/pp: Implement
> set_power_profile_mode on smu7
>
> We have min_sclk and min_mclk in previous power profile parameters for
> VI, which are similar with min_active_level for Vega10. How to implement
> these parameters?
>
> Regards,
> Eric
>
> On 2018-01-24 04:37 AM, Rex Zhu wrote:
> > User can set smu7 profile pamameters through sysfs
> >
> > echo "0/1/2/3/4">pp_power_profile_mode
> > to select 3D_FULL_SCREEN/POWER_SAVING/VIDEO/VR/COMPUTE
> > mode.
> > echo "5 * * * * * * * *">pp_power_profile_mode
> > to config custom mode.
> > "5 * * * * * * * *" mean "CUSTOM enable_sclk SCLK_UP_HYST
> > SCLK_DOWN_HYST SCLK_ACTIVE_LEVEL enable_mclk MCLK_UP_HYST
> > MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL"
> >
> > Change-Id: Ic6d6f37363bc81ab17051285f6ace847edf725de
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 49
> +++++++++++++++++++++++-
> >   1 file changed, 48 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > index 9f6afd5..13db75c 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > @@ -5036,7 +5036,54 @@ static int smu7_get_power_profile_mode(struct
> pp_hwmgr *hwmgr, char *buf)
> >
> >   static int smu7_set_power_profile_mode(struct pp_hwmgr *hwmgr,
> long *input, uint32_t size)
> >   {
> > -     /* To Do */
> > +     struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> > +     struct profile_mode_setting tmp;
> > +
> > +     hwmgr->power_profile_mode =3D input[size];
> > +
> > +     switch (hwmgr->power_profile_mode) {
> > +     case PP_SMC_POWER_PROFILE_CUSTOM:
> > +             if (size < 8)
> > +                     return -EINVAL;
> > +
> > +             data->custom_profile_setting.bupdate_sclk =3D input[0];
> > +             data->custom_profile_setting.sclk_up_hyst =3D input[1];
> > +             data->custom_profile_setting.sclk_down_hyst =3D input[2];
> > +             data->custom_profile_setting.sclk_activity =3D  input[3];
> > +             data->custom_profile_setting.bupdate_mclk =3D input[4];
> > +             data->custom_profile_setting.mclk_up_hyst =3D input[5];
> > +             data->custom_profile_setting.mclk_down_hyst =3D input[6];
> > +             data->custom_profile_setting.mclk_activity =3D  input[7];
> > +             if (!smum_update_dpm_settings(hwmgr,
> &data->custom_profile_setting))
> > +                     memcpy(&data->current_profile_setting,
> &data->custom_profile_setting, sizeof(struct profile_mode_setting));
> > +             break;
> > +     case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
> > +     case PP_SMC_POWER_PROFILE_POWERSAVING:
> > +     case PP_SMC_POWER_PROFILE_VIDEO:
> > +     case PP_SMC_POWER_PROFILE_VR:
> > +     case PP_SMC_POWER_PROFILE_COMPUTE:
> > +             memcpy(&tmp,
> &smu7_profiling[hwmgr->power_profile_mode], sizeof(struct
> profile_mode_setting));
> > +             if (!smum_update_dpm_settings(hwmgr, &tmp)) {
> > +                     if (tmp.bupdate_sclk) {
> > +
> data->current_profile_setting.bupdate_sclk =3D tmp.bupdate_sclk;
> > +
> data->current_profile_setting.sclk_up_hyst =3D tmp.sclk_up_hyst;
> > +
> data->current_profile_setting.sclk_down_hyst =3D tmp.sclk_down_hyst;
> > +
> data->current_profile_setting.sclk_activity =3D tmp.sclk_activity;
> > +                     }
> > +                     if (tmp.bupdate_mclk) {
> > +
> data->current_profile_setting.bupdate_mclk =3D tmp.bupdate_mclk;
> > +
> data->current_profile_setting.mclk_up_hyst =3D tmp.mclk_up_hyst;
> > +
> data->current_profile_setting.mclk_down_hyst =3D tmp.mclk_down_hyst;
> > +
> data->current_profile_setting.mclk_activity =3D tmp.mclk_activity;
> > +                     }
> > +             }
> > +             break;
> > +     case PP_SMC_POWER_PROFILE_AUTO: /* TO DO auto wattman feature
> not implement */
> > +             return 0;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> >        return 0;
> >   }
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_CY4PR12MB1687A95AD6A9C584060686F8FBE20CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
</head>
<body>
Hi Felix,<br>
<br>
The logic of gfx/computer profile setting works in such way as you said,nee=
d under =1B$B!H=1B(Bauto=1B$B!I=1B(B state.<br>
But in new sysfs of power profile setting, we do not check the performance<=
br>
Level.<br>
<br>
And The =1B$B!H=1B(Bmanual=1B$B!I=1B(B state is a confusing flag=1B$B!$=1B(=
Bwhen user set manual state=1B$B!$=1B(Band then change the clk range throug=
h pp-dpm-sclk/mclk=1B$B!$=1B(Bthe dpm still works automatically in new cloc=
k range, I think we can remove this flag.<br>
<br>
So&nbsp; My idea is <br>
in the sysfs of pp dpm sclk/mclk, user can set clock range.<br>
In the sysfs of power profile state, user can configure the parameters smu/=
driver exposed. They are independent.<br>
<br>
<br>
<br>
<br>
<br>
<br>
Best Regards<br>
Rex
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Thursday, January 25, 2018 5:41:43 AM<br>
<b>To:</b> Zhu, Rex; Huang, JinHuiEric; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mod=
e on smu7</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Rex,<br>
<br>
As I understand it (the way power profiles currently work),<br>
pp_dpm_sclk/mclk only apply if pp_dpm_force_performance_level is set to<br>
&quot;manual&quot;. Power profiles and automatic switching between profiles=
 only<br>
happens when pp_dpm_force_performance_level is set to &quot;auto&quot;.<br>
<br>
This means pp_dpm_sclk/mclk don't apply when profiles are in effect.<br>
Also, there would be no way to set different minimum clocks for<br>
different profiles.<br>
<br>
I think minimum clocks should be part of the profiles.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
<br>
On 2018-01-24 03:13 PM, Zhu, Rex wrote:<br>
&gt; Hi Eric,<br>
&gt;<br>
&gt; We have sysfs pp-dpm-sclk/mclk to set min dpm level<br>
&gt;<br>
&gt; Best Regards<br>
&gt; Rex<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behal=
f of<br>
&gt; Eric Huang &lt;jinhuieric.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; *Sent:* Thursday, January 25, 2018 12:04:55 AM<br>
&gt; *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; *Subject:* Re: [PATCH 4/4] drm/amd/pp: Implement<br>
&gt; set_power_profile_mode on smu7<br>
&gt; &nbsp;<br>
&gt; We have min_sclk and min_mclk in previous power profile parameters for=
<br>
&gt; VI, which are similar with min_active_level for Vega10. How to impleme=
nt<br>
&gt; these parameters?<br>
&gt;<br>
&gt; Regards,<br>
&gt; Eric<br>
&gt;<br>
&gt; On 2018-01-24 04:37 AM, Rex Zhu wrote:<br>
&gt; &gt; User can set smu7 profile pamameters through sysfs<br>
&gt; &gt;<br>
&gt; &gt; echo &quot;0/1/2/3/4&quot;&gt;pp_power_profile_mode<br>
&gt; &gt; to select 3D_FULL_SCREEN/POWER_SAVING/VIDEO/VR/COMPUTE<br>
&gt; &gt; mode.<br>
&gt; &gt; echo &quot;5 * * * * * * * *&quot;&gt;pp_power_profile_mode<br>
&gt; &gt; to config custom mode.<br>
&gt; &gt; &quot;5 * * * * * * * *&quot; mean &quot;CUSTOM enable_sclk SCLK_=
UP_HYST<br>
&gt; &gt; SCLK_DOWN_HYST SCLK_ACTIVE_LEVEL enable_mclk MCLK_UP_HYST<br>
&gt; &gt; MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL&quot;<br>
&gt; &gt;<br>
&gt; &gt; Change-Id: Ic6d6f37363bc81ab17051285f6ace847edf725de<br>
&gt; &gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 49=
<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 48 insertions(&#43;), 1 deletion(-)<b=
r>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &gt; index 9f6afd5..13db75c 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.=
c<br>
&gt; &gt; @@ -5036,7 &#43;5036,54 @@ static int smu7_get_power_profile_mode=
(struct<br>
&gt; pp_hwmgr *hwmgr, char *buf)<br>
&gt; &gt;&nbsp;&nbsp;<br>
&gt; &gt;&nbsp;&nbsp; static int smu7_set_power_profile_mode(struct pp_hwmg=
r *hwmgr,<br>
&gt; long *input, uint32_t size)<br>
&gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* To Do */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D (struct=
 smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct profile_mode_setting tmp;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mode =3D in=
put[size];<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (hwmgr-&gt;power_profile_mod=
e) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_CUSTOM:<b=
r>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (size &lt; 8)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL=
;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; data-&gt;custom_profile_setting.bupdate_sclk =3D input[0];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; data-&gt;custom_profile_setting.sclk_up_hyst =3D input[1];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; data-&gt;custom_profile_setting.sclk_down_hyst =3D input[2];<b=
r>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; data-&gt;custom_profile_setting.sclk_activity =3D&nbsp; input[=
3];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; data-&gt;custom_profile_setting.bupdate_mclk =3D input[4];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; data-&gt;custom_profile_setting.mclk_up_hyst =3D input[5];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; data-&gt;custom_profile_setting.mclk_down_hyst =3D input[6];<b=
r>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; data-&gt;custom_profile_setting.mclk_activity =3D&nbsp; input[=
7];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (!smum_update_dpm_settings(hwmgr,<br>
&gt; &amp;data-&gt;custom_profile_setting))<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&amp;da=
ta-&gt;current_profile_setting,<br>
&gt; &amp;data-&gt;custom_profile_setting, sizeof(struct profile_mode_setti=
ng));<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_FULLSCREE=
N3D:<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_POWERSAVI=
NG:<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_VIDEO:<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_VR:<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_COMPUTE:<=
br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; memcpy(&amp;tmp,<br>
&gt; &amp;smu7_profiling[hwmgr-&gt;power_profile_mode], sizeof(struct<br>
&gt; profile_mode_setting));<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (!smum_update_dpm_settings(hwmgr, &amp;tmp)) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp.bupdat=
e_sclk) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; data-&gt;current_profile_setting.bupdate_sclk =3D tmp.bupdate_sclk;<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; data-&gt;current_profile_setting.sclk_up_hyst =3D tmp.sclk_up_hyst;<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; data-&gt;current_profile_setting.sclk_down_hyst =3D tmp.sclk_down_hyst=
;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; data-&gt;current_profile_setting.sclk_activity =3D tmp.sclk_activity;<=
br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp.bupdat=
e_mclk) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; data-&gt;current_profile_setting.bupdate_mclk =3D tmp.bupdate_mclk;<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; data-&gt;current_profile_setting.mclk_up_hyst =3D tmp.mclk_up_hyst;<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; data-&gt;current_profile_setting.mclk_down_hyst =3D tmp.mclk_down_hyst=
;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; data-&gt;current_profile_setting.mclk_activity =3D tmp.mclk_activity;<=
br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; break;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_AUTO: /* =
TO DO auto wattman feature<br>
&gt; not implement */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return 0;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1687A95AD6A9C584060686F8FBE20CY4PR12MB1687namp_--

--===============0474592301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0474592301==--
