From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mode on smu7
Date: Thu, 25 Jan 2018 02:28:02 +0000
Message-ID: <CY4PR12MB168748FA26D74B6E01890EBAFBE10@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1516786649-14914-1-git-send-email-Rex.Zhu@amd.com>
 <1516786649-14914-4-git-send-email-Rex.Zhu@amd.com>
 <e21a2657-7a80-5b59-6c1c-a578d3bf79a9@amd.com>
 <CY4PR12MB1687B4CBFF3BC4DD121752A4FBE20@CY4PR12MB1687.namprd12.prod.outlook.com>
 <e86e1a66-37d4-f3cc-8eae-689c81356526@amd.com>
 <CY4PR12MB1687A95AD6A9C584060686F8FBE20@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <e63767e6-9900-d377-9e61-6ac75179e95d@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1365085892=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e63767e6-9900-d377-9e61-6ac75179e95d-5C7GfCeVMHo@public.gmane.org>
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

--===============1365085892==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB168748FA26D74B6E01890EBAFBE10CY4PR12MB1687namp_"

--_000_CY4PR12MB168748FA26D74B6E01890EBAFBE10CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

>But then you're changing the semantics of how pp_dpm_sclk/mclk wok
>together with pp_dpm_force_performance_level.

Rex:The two sysfs are all for clock range setting.


pp_dpm_sclk/mclk/pcie can set sclk/mclk/pcie range separately.


and pp_dpm_force_performance_level, we can support low/high/umd-pstate that=
 set all the clocks  range.

(manual state, driver do nothing except set the flag)


No matter what state user enter in, driver can support to continue to chang=
e the clock range through pp_dpm_sclk/mclk/pcie.


so in fact, don't need manual state for sepalately set the clock range.


>Sysfs interfaces should be maintained stable. I'm OK with breaking the
>old power profile stuff, because it only affects KFD which isn't
>upstream yet.


Rex: As the old power profile interface can't support Vega.

so add new interface and we are try to support old asics with new sysfs.



>But the old pp_dpm_sclk/mclk and
>pp_dpm_force_performance_level affect code that's currently upstream and
>used by existing tools.

Rex:  Yes, we are trying to maintain the sysfs stable.
if we change the old sysfs code,  we will try to not affect existing tools.

Best Regards
Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Felix Ku=
ehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, January 25, 2018 7:12 AM
To: Zhu, Rex; Huang, JinHuiEric; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mode on sm=
u7

On 2018-01-24 06:05 PM, Zhu, Rex wrote:
> Hi Felix,
>
> The logic of gfx/computer profile setting works in such way as you
> said,need under =1B$B!H=1B(Bauto=1B$B!I=1B(B state.
> But in new sysfs of power profile setting, we do not check the performanc=
e
> Level.
>
> And The =1B$B!H=1B(Bmanual=1B$B!I=1B(B state is a confusing flag=1B$B!$=
=1B(Bwhen user set manual
> state=1B$B!$=1B(Band then change the clk range through pp-dpm-sclk/mclk=
=1B$B!$=1B(Bthe dpm
> still works automatically in new clock range, I think we can remove
> this flag.

But then you're changing the semantics of how pp_dpm_sclk/mclk wok
together with pp_dpm_force_performance_level.

Sysfs interfaces should be maintained stable. I'm OK with breaking the
old power profile stuff, because it only affects KFD which isn't
upstream yet. But the old pp_dpm_sclk/mclk and
pp_dpm_force_performance_level affect code that's currently upstream and
used by existing tools.

>
> So  My idea is
> in the sysfs of pp dpm sclk/mclk, user can set clock range.
> In the sysfs of power profile state, user can configure the parameters
> smu/driver exposed. They are independent.

I disagree. the clock range is not independent of the profile. Profiles
correspond to use cases. Different use cases have different clock
requirements. For compute we want the clocks to be high. For video you
may have requirements for minimum mclks to ensure smooth playback. For
power saving you may want to limit maximum clocks, etc. So setting the
clock range independent of the profile in "auto" mode does not make
sense to me.

Regards,
  Felix

>
>
>
>
>
>
> Best Regards
> Rex
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix
> *Sent:* Thursday, January 25, 2018 5:41:43 AM
> *To:* Zhu, Rex; Huang, JinHuiEric; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 4/4] drm/amd/pp: Implement
> set_power_profile_mode on smu7
>
> Hi Rex,
>
> As I understand it (the way power profiles currently work),
> pp_dpm_sclk/mclk only apply if pp_dpm_force_performance_level is set to
> "manual". Power profiles and automatic switching between profiles only
> happens when pp_dpm_force_performance_level is set to "auto".
>
> This means pp_dpm_sclk/mclk don't apply when profiles are in effect.
> Also, there would be no way to set different minimum clocks for
> different profiles.
>
> I think minimum clocks should be part of the profiles.
>
> Regards,
>   Felix
>
>
> On 2018-01-24 03:13 PM, Zhu, Rex wrote:
> > Hi Eric,
> >
> > We have sysfs pp-dpm-sclk/mclk to set min dpm level
> >
> > Best Regards
> > Rex
> > -----------------------------------------------------------------------=
-
> > *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of
> > Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
> > *Sent:* Thursday, January 25, 2018 12:04:55 AM
> > *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > *Subject:* Re: [PATCH 4/4] drm/amd/pp: Implement
> > set_power_profile_mode on smu7
> >
> > We have min_sclk and min_mclk in previous power profile parameters for
> > VI, which are similar with min_active_level for Vega10. How to implemen=
t
> > these parameters?
> >
> > Regards,
> > Eric
> >
> > On 2018-01-24 04:37 AM, Rex Zhu wrote:
> > > User can set smu7 profile pamameters through sysfs
> > >
> > > echo "0/1/2/3/4">pp_power_profile_mode
> > > to select 3D_FULL_SCREEN/POWER_SAVING/VIDEO/VR/COMPUTE
> > > mode.
> > > echo "5 * * * * * * * *">pp_power_profile_mode
> > > to config custom mode.
> > > "5 * * * * * * * *" mean "CUSTOM enable_sclk SCLK_UP_HYST
> > > SCLK_DOWN_HYST SCLK_ACTIVE_LEVEL enable_mclk MCLK_UP_HYST
> > > MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL"
> > >
> > > Change-Id: Ic6d6f37363bc81ab17051285f6ace847edf725de
> > > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > > ---
> > >   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 49
> > +++++++++++++++++++++++-
> > >   1 file changed, 48 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > > index 9f6afd5..13db75c 100644
> > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > > @@ -5036,7 +5036,54 @@ static int smu7_get_power_profile_mode(struct
> > pp_hwmgr *hwmgr, char *buf)
> > >
> > >   static int smu7_set_power_profile_mode(struct pp_hwmgr *hwmgr,
> > long *input, uint32_t size)
> > >   {
> > > -     /* To Do */
> > > +     struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backen=
d);
> > > +     struct profile_mode_setting tmp;
> > > +
> > > +     hwmgr->power_profile_mode =3D input[size];
> > > +
> > > +     switch (hwmgr->power_profile_mode) {
> > > +     case PP_SMC_POWER_PROFILE_CUSTOM:
> > > +             if (size < 8)
> > > +                     return -EINVAL;
> > > +
> > > +             data->custom_profile_setting.bupdate_sclk =3D input[0];
> > > +             data->custom_profile_setting.sclk_up_hyst =3D input[1];
> > > +             data->custom_profile_setting.sclk_down_hyst =3D input[2=
];
> > > +             data->custom_profile_setting.sclk_activity =3D  input[3=
];
> > > +             data->custom_profile_setting.bupdate_mclk =3D input[4];
> > > +             data->custom_profile_setting.mclk_up_hyst =3D input[5];
> > > +             data->custom_profile_setting.mclk_down_hyst =3D input[6=
];
> > > +             data->custom_profile_setting.mclk_activity =3D  input[7=
];
> > > +             if (!smum_update_dpm_settings(hwmgr,
> > &data->custom_profile_setting))
> > > +                     memcpy(&data->current_profile_setting,
> > &data->custom_profile_setting, sizeof(struct profile_mode_setting));
> > > +             break;
> > > +     case PP_SMC_POWER_PROFILE_FULLSCREEN3D:
> > > +     case PP_SMC_POWER_PROFILE_POWERSAVING:
> > > +     case PP_SMC_POWER_PROFILE_VIDEO:
> > > +     case PP_SMC_POWER_PROFILE_VR:
> > > +     case PP_SMC_POWER_PROFILE_COMPUTE:
> > > +             memcpy(&tmp,
> > &smu7_profiling[hwmgr->power_profile_mode], sizeof(struct
> > profile_mode_setting));
> > > +             if (!smum_update_dpm_settings(hwmgr, &tmp)) {
> > > +                     if (tmp.bupdate_sclk) {
> > > +
> > data->current_profile_setting.bupdate_sclk =3D tmp.bupdate_sclk;
> > > +
> > data->current_profile_setting.sclk_up_hyst =3D tmp.sclk_up_hyst;
> > > +
> > data->current_profile_setting.sclk_down_hyst =3D tmp.sclk_down_hyst;
> > > +
> > data->current_profile_setting.sclk_activity =3D tmp.sclk_activity;
> > > +                     }
> > > +                     if (tmp.bupdate_mclk) {
> > > +
> > data->current_profile_setting.bupdate_mclk =3D tmp.bupdate_mclk;
> > > +
> > data->current_profile_setting.mclk_up_hyst =3D tmp.mclk_up_hyst;
> > > +
> > data->current_profile_setting.mclk_down_hyst =3D tmp.mclk_down_hyst;
> > > +
> > data->current_profile_setting.mclk_activity =3D tmp.mclk_activity;
> > > +                     }
> > > +             }
> > > +             break;
> > > +     case PP_SMC_POWER_PROFILE_AUTO: /* TO DO auto wattman feature
> > not implement */
> > > +             return 0;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +
> > >        return 0;
> > >   }
> > >
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...



> >
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...



>

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




--_000_CY4PR12MB168748FA26D74B6E01890EBAFBE10CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&gt;But then you're=
 changing
 the semantics of how pp_dpm_sclk/mclk wok</span><br style=3D"font-family: =
Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &=
quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &qu=
ot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;together with pp_dpm_force_performance_level.</span><br s=
tyle=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple=
 Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe=
 UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.66=
67px;">
<br>
Rex:The two sysfs are all for clock range setting.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">pp_dpm_sclk/mclk/pc=
ie
 can set sclk/mclk/pcie range separately.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"></span>and
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">
pp_dpm_force_performance_level, we can support low/high/umd-pstate that set=
 all the clocks &nbsp;range</span><span style=3D"font-size: 14.6667px;">.</=
span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;">(manual state, driver do nothing except set the flag</span><span style=
=3D"font-size: 14.6667px;">)</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">No matter what state user enter i=
n, driver can support to continue to change the clock range through pp_dpm_=
sclk/mclk/pcie.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">so in fact, don't need manual sta=
te for sepalately set the clock range.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&gt;Sysfs interface=
s should
 be maintained stable. I'm OK with breaking the</span><br style=3D"font-fam=
ily: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quo=
t;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;=
, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;old power profile stuff, because it only affects KFD whic=
h
 isn't</span><br style=3D"font-family: Calibri, Helvetica, sans-serif, Emoj=
iFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColor=
Emoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols=
; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;upstream yet.&nbsp;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex: As the old power profile int=
erface can't support Vega.</p>
<p style=3D"margin-top:0;margin-bottom:0">so add new interface and we are t=
ry to support old asics with new sysfs.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&gt;But the old pp_=
dpm_sclk/mclk
 and</span><br style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiF=
ont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEm=
oji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; =
font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;pp_dpm_force_performance_level affect code that's current=
ly
 upstream and</span><br style=3D"font-family: Calibri, Helvetica, sans-seri=
f, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, No=
toColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, Emoji=
Symbols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;used by existing tools.</span><br>
</p>
<br>
Rex: &nbsp;Yes, we are&nbsp;trying to maintain the sysfs stable.
<div>
<div>if we change the old&nbsp;sysfs code, &nbsp;we will try to not affect =
existing tools.</div>
<div><br>
</div>
<div>Best Regards</div>
<div>Rex</div>
<div><br>
<div>&nbsp;<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Felix Kuehling &lt;felix.kueh=
ling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, January 25, 2018 7:12 AM<br>
<b>To:</b> Zhu, Rex; Huang, JinHuiEric; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 4/4] drm/amd/pp: Implement set_power_profile_mod=
e on smu7</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2018-01-24 06:05 PM, Zhu, Rex wrote:<br>
&gt; Hi Felix,<br>
&gt;<br>
&gt; The logic of gfx/computer profile setting works in such way as you<br>
&gt; said,need under =1B$B!H=1B(Bauto=1B$B!I=1B(B state.<br>
&gt; But in new sysfs of power profile setting, we do not check the perform=
ance<br>
&gt; Level.<br>
&gt;<br>
&gt; And The =1B$B!H=1B(Bmanual=1B$B!I=1B(B state is a confusing flag=1B$B!=
$=1B(Bwhen user set manual<br>
&gt; state=1B$B!$=1B(Band then change the clk range through pp-dpm-sclk/mcl=
k=1B$B!$=1B(Bthe dpm<br>
&gt; still works automatically in new clock range, I think we can remove<br=
>
&gt; this flag.<br>
<br>
But then you're changing the semantics of how pp_dpm_sclk/mclk wok<br>
together with pp_dpm_force_performance_level.<br>
<br>
Sysfs interfaces should be maintained stable. I'm OK with breaking the<br>
old power profile stuff, because it only affects KFD which isn't<br>
upstream yet. But the old pp_dpm_sclk/mclk and<br>
pp_dpm_force_performance_level affect code that's currently upstream and<br=
>
used by existing tools.<br>
<br>
&gt;<br>
&gt; So&nbsp; My idea is<br>
&gt; in the sysfs of pp dpm sclk/mclk, user can set clock range.<br>
&gt; In the sysfs of power profile state, user can configure the parameters=
<br>
&gt; smu/driver exposed. They are independent.<br>
<br>
I disagree. the clock range is not independent of the profile. Profiles<br>
correspond to use cases. Different use cases have different clock<br>
requirements. For compute we want the clocks to be high. For video you<br>
may have requirements for minimum mclks to ensure smooth playback. For<br>
power saving you may want to limit maximum clocks, etc. So setting the<br>
clock range independent of the profile in &quot;auto&quot; mode does not ma=
ke<br>
sense to me.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Best Regards<br>
&gt; Rex<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Kuehling, Felix<br>
&gt; *Sent:* Thursday, January 25, 2018 5:41:43 AM<br>
&gt; *To:* Zhu, Rex; Huang, JinHuiEric; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; *Subject:* Re: [PATCH 4/4] drm/amd/pp: Implement<br>
&gt; set_power_profile_mode on smu7<br>
&gt; &nbsp;<br>
&gt; Hi Rex,<br>
&gt;<br>
&gt; As I understand it (the way power profiles currently work),<br>
&gt; pp_dpm_sclk/mclk only apply if pp_dpm_force_performance_level is set t=
o<br>
&gt; &quot;manual&quot;. Power profiles and automatic switching between pro=
files only<br>
&gt; happens when pp_dpm_force_performance_level is set to &quot;auto&quot;=
.<br>
&gt;<br>
&gt; This means pp_dpm_sclk/mclk don't apply when profiles are in effect.<b=
r>
&gt; Also, there would be no way to set different minimum clocks for<br>
&gt; different profiles.<br>
&gt;<br>
&gt; I think minimum clocks should be part of the profiles.<br>
&gt;<br>
&gt; Regards,<br>
&gt; &nbsp; Felix<br>
&gt;<br>
&gt;<br>
&gt; On 2018-01-24 03:13 PM, Zhu, Rex wrote:<br>
&gt; &gt; Hi Eric,<br>
&gt; &gt;<br>
&gt; &gt; We have sysfs pp-dpm-sclk/mclk to set min dpm level<br>
&gt; &gt;<br>
&gt; &gt; Best Regards<br>
&gt; &gt; Rex<br>
&gt; &gt; -----------------------------------------------------------------=
-------<br>
&gt; &gt; *From:* amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on =
behalf of<br>
&gt; &gt; Eric Huang &lt;jinhuieric.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; *Sent:* Thursday, January 25, 2018 12:04:55 AM<br>
&gt; &gt; *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; *Subject:* Re: [PATCH 4/4] drm/amd/pp: Implement<br>
&gt; &gt; set_power_profile_mode on smu7<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; We have min_sclk and min_mclk in previous power profile parameter=
s for<br>
&gt; &gt; VI, which are similar with min_active_level for Vega10. How to im=
plement<br>
&gt; &gt; these parameters?<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; Eric<br>
&gt; &gt;<br>
&gt; &gt; On 2018-01-24 04:37 AM, Rex Zhu wrote:<br>
&gt; &gt; &gt; User can set smu7 profile pamameters through sysfs<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; echo &quot;0/1/2/3/4&quot;&gt;pp_power_profile_mode<br>
&gt; &gt; &gt; to select 3D_FULL_SCREEN/POWER_SAVING/VIDEO/VR/COMPUTE<br>
&gt; &gt; &gt; mode.<br>
&gt; &gt; &gt; echo &quot;5 * * * * * * * *&quot;&gt;pp_power_profile_mode<=
br>
&gt; &gt; &gt; to config custom mode.<br>
&gt; &gt; &gt; &quot;5 * * * * * * * *&quot; mean &quot;CUSTOM enable_sclk =
SCLK_UP_HYST<br>
&gt; &gt; &gt; SCLK_DOWN_HYST SCLK_ACTIVE_LEVEL enable_mclk MCLK_UP_HYST<br=
>
&gt; &gt; &gt; MCLK_DOWN_HYST MCLK_ACTIVE_LEVEL&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Change-Id: Ic6d6f37363bc81ab17051285f6ace847edf725de<br>
&gt; &gt; &gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c=
 | 49<br>
&gt; &gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt; &gt; &gt;&nbsp;&nbsp; 1 file changed, 48 insertions(&#43;), 1 deletion=
(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.=
c<br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &gt; &gt; index 9f6afd5..13db75c 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_h=
wmgr.c<br>
&gt; &gt; &gt; @@ -5036,7 &#43;5036,54 @@ static int smu7_get_power_profile=
_mode(struct<br>
&gt; &gt; pp_hwmgr *hwmgr, char *buf)<br>
&gt; &gt; &gt;&nbsp;&nbsp;<br>
&gt; &gt; &gt;&nbsp;&nbsp; static int smu7_set_power_profile_mode(struct pp=
_hwmgr *hwmgr,<br>
&gt; &gt; long *input, uint32_t size)<br>
&gt; &gt; &gt;&nbsp;&nbsp; {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* To Do */<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *data =3D (s=
truct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct profile_mode_setting tm=
p;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;power_profile_mode =
=3D input[size];<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (hwmgr-&gt;power_profil=
e_mode) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_CUST=
OM:<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (size &lt; 8)<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -E=
INVAL;<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; data-&gt;custom_profile_setting.bupdate_sclk =3D input[0]=
;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; data-&gt;custom_profile_setting.sclk_up_hyst =3D input[1]=
;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; data-&gt;custom_profile_setting.sclk_down_hyst =3D input[=
2];<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; data-&gt;custom_profile_setting.sclk_activity =3D&nbsp; i=
nput[3];<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; data-&gt;custom_profile_setting.bupdate_mclk =3D input[4]=
;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; data-&gt;custom_profile_setting.mclk_up_hyst =3D input[5]=
;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; data-&gt;custom_profile_setting.mclk_down_hyst =3D input[=
6];<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; data-&gt;custom_profile_setting.mclk_activity =3D&nbsp; i=
nput[7];<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!smum_update_dpm_settings(hwmgr,<br>
&gt; &gt; &amp;data-&gt;custom_profile_setting))<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(&a=
mp;data-&gt;current_profile_setting,<br>
&gt; &gt; &amp;data-&gt;custom_profile_setting, sizeof(struct profile_mode_=
setting));<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_FULL=
SCREEN3D:<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_POWE=
RSAVING:<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_VIDE=
O:<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_VR:<=
br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_COMP=
UTE:<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; memcpy(&amp;tmp,<br>
&gt; &gt; &amp;smu7_profiling[hwmgr-&gt;power_profile_mode], sizeof(struct<=
br>
&gt; &gt; profile_mode_setting));<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!smum_update_dpm_settings(hwmgr, &amp;tmp)) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp.b=
update_sclk) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; &gt; data-&gt;current_profile_setting.bupdate_sclk =3D tmp.bupdate_scl=
k;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; &gt; data-&gt;current_profile_setting.sclk_up_hyst =3D tmp.sclk_up_hys=
t;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; &gt; data-&gt;current_profile_setting.sclk_down_hyst =3D tmp.sclk_down=
_hyst;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; &gt; data-&gt;current_profile_setting.sclk_activity =3D tmp.sclk_activ=
ity;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp.b=
update_mclk) {<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; &gt; data-&gt;current_profile_setting.bupdate_mclk =3D tmp.bupdate_mcl=
k;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; &gt; data-&gt;current_profile_setting.mclk_up_hyst =3D tmp.mclk_up_hys=
t;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; &gt; data-&gt;current_profile_setting.mclk_down_hyst =3D tmp.mclk_down=
_hyst;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; &gt; data-&gt;current_profile_setting.mclk_activity =3D tmp.mclk_activ=
ity;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SMC_POWER_PROFILE_AUTO=
: /* TO DO auto wattman feature<br>
&gt; &gt; not implement */<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &gt; &#43;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; &gt;&nbsp;&nbsp;<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
" id=3D"LPlnk116130" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15168443615140.18904089582307582" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15168443615110.9369293005739279" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15168443615120.7141443438644193" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15168443615120.7288004803108545"></div>
<div id=3D"LPTitle_15168443615120.45608151553398635" style=3D"top: 0px; col=
or: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf=
_segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-h=
eight: 21px;">
<a id=3D"LPUrlAnchor_15168443615130.27792507939647537" href=3D"https://list=
s.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text=
-decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15168443615130.44790212604518453" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: w=
f_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Aria=
l, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15168443615140.6035005662253765" style=3D"display:=
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
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
" id=3D"LPlnk400816" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15168443901350.3268077149595048" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15168443901330.04114037224069644" role=3D"presenta=
tion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255=
, 255); position: relative; overflow: auto; padding-top: 20px; padding-bott=
om: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); bord=
er-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15168443901340.20393856627357554" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_15168443901340.3461142991338786"></div>
<div id=3D"LPTitle_15168443901340.0711806868259599" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15168443901340.445507855496746" href=3D"https://lists.=
freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-d=
ecoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15168443901340.41864238261746256" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: w=
f_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Aria=
l, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15168443901350.09666274708634548" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_se=
goe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, s=
ans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow:=
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
&gt;<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk835368" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15168443901140.15714823066250583" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15168443901110.20088538357508035" role=3D"presenta=
tion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255=
, 255); position: relative; overflow: auto; padding-top: 20px; padding-bott=
om: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); bord=
er-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15168443901120.48169933476563265" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_15168443901120.40773235136434316"></div=
>
<div id=3D"LPTitle_15168443901120.3517092937396349" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15168443901130.3988099467492132" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15168443901130.9812527659618873" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15168443901140.7276090524428998" style=3D"display:=
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
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB168748FA26D74B6E01890EBAFBE10CY4PR12MB1687namp_--

--===============1365085892==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1365085892==--
