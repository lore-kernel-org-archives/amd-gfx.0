From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
 power_dpm_force_performance_level
Date: Fri, 26 Jan 2018 19:20:31 +0000
Message-ID: <CY4PR12MB1687BFBCA906C0B17D52089BFBE00@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1516879614-11533-1-git-send-email-Rex.Zhu@amd.com>
 <51c6111b-78ec-36f8-b5e0-4a23ccea6de4@amd.com>
 <CY4PR12MB1687930CD8F44390C3791A63FBE10@CY4PR12MB1687.namprd12.prod.outlook.com>
 <0ce63372-dc11-9710-f11d-0cf6abf326b4@amd.com>
 <CY4PR12MB168744ABA067C470390EA34EFBE00@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <ec6ea7dd-0096-dd92-8c49-b2992b5bf506@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2049570415=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ec6ea7dd-0096-dd92-8c49-b2992b5bf506-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2049570415==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687BFBCA906C0B17D52089BFBE00CY4PR12MB1687namp_"

--_000_CY4PR12MB1687BFBCA906C0B17D52089BFBE00CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

>1. You're breaking the semantics of the existing pp_dpm_sclk/mclk/pcie
>    interfaces, which affects existing tools


Rex: I don't think the patch will affects existing tools.


User set "manual" to power_performance_level, and then change the clock ran=
ge through  pp_dpm_sclk/mclk/pcie.


with this patch, User dont need to set "manual" command,  if still receive =
the manual command, driver just return sucess to user in order not  break e=
xisting

tools.


 >2. You're taking the clock limits out of the power profile.
 >  Automatically adjusting the minimum sclk/mclk is a requirement for
 >   the compute power profile

Rex: In vega10, under default comput mode(with busy_set_point/fps/use_rlc_b=
usy/min_active_level set), just two performance levels left
(level0 and level7). and clock just switch between lowest and highest.

I am not sure in this case, driver still can set min sclk/mclk.

Best Regards
Rex


________________________________
From: Kuehling, Felix
Sent: Saturday, January 27, 2018 12:49 AM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for power_dpm_force=
_performance_level

Hi Rex,

I think I understand what you're trying to do. To summarize my concerns,
there are two reasons I'm against your plan:

 1. You're breaking the semantics of the existing pp_dpm_sclk/mclk/pcie
    interfaces, which affects existing tools
 2. You're taking the clock limits out of the power profile.
    Automatically adjusting the minimum sclk/mclk is a requirement for
    the compute power profile

Regards,
  Felix

On 2018-01-26 07:50 AM, Zhu, Rex wrote:
>
> Hi Felix,
>
>
> >That would make sense. But switching to manual mode would disable
> >profiles and automatic profile selection. That was one reason why I
> >objected to your plan to control profile clock limits using these files.
>
> Rex:
>
>
> I am not very clear the old logic of gfx/compute power profile switch.
>
>
> But with new sysfs,
>
>
>
> The logic is(those sysfs are independent)
>
>  1. configure uphyst/downhyst/min_ativity through power_profile_mode,
>
>       2. adjust clock range through pp_dpm_sclk/mclk/pcie.(once this
> sysffs was called, set the dpm level mode to unknown)
>
>       3. adjust power limit through pp_od_power_limit(maybe equal to
> disable power containment).
>
>
>
> In those functions, driver do not check the dpm level mode.
>
> the dpm level mode just used by power_dpm_force_performance_level
> functions.
>
>
> Best Regards
>
> Rex
>
>
>
>
>
> ------------------------------------------------------------------------
> *From:* Kuehling, Felix
> *Sent:* Friday, January 26, 2018 8:26 AM
> *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
> power_dpm_force_performance_level
>
> On 2018-01-25 07:07 PM, Zhu, Rex wrote:
> > I also think about this problem.
> > just think user should unforced clk level through pp dpm
> > sclk/mclk/pcie if they change the clock logic through those sysfs.
> >
> > The logic seems weird, As we supply many sysfs for adjust clock range.
> >
> > We can fix this problem by change current mode to manual mode after
> > user call pp dpm sclk/mclk/pcie.
> >
> > But another think=1B$B!$=1B(Bif user change back the clk range through =
pp dpm clk.
> >
> > we are in manual mode, and user set auto mode, in fact, driver change
> > nothing.
>
> With profiles, switching back to auto mode would select the appropriate
> profile, which may have a different clock mask. For example for compute
> we enable only the highest two sclk levels.
>
> >
> > Comparatively speaking, better set manual mode after user call pp
> dpm clk.
>
> That would make sense. But switching to manual mode would disable
> profiles and automatic profile selection. That was one reason why I
> objected to your plan to control profile clock limits using these files.
>
> Regards,
>   Felix
>
> > Thanks very much.
> >
> > Best Regards
> > Rex
> > -----------------------------------------------------------------------=
-
> > *From:* Kuehling, Felix
> > *Sent:* Friday, January 26, 2018 12:55:19 AM
> > *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex
> > *Subject:* Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
> > power_dpm_force_performance_level
> >
> > This patch breaks unforcing of clocks, which is currently done by
> > switching back from "manual" to "auto". By removing "manual" mode, you
> > remove the ability to unset forced clocks.
> >
> > Regards,
> >   Felix
> >
> >
> > On 2018-01-25 06:26 AM, Rex Zhu wrote:
> > > Driver do not maintain manual mode for dpm_force_performance_level,
> > > User can set sclk/mclk/pcie range through
> > pp_dpm_sclk/pp_dpm_mclk/pp_dpm_pcie
> > > directly.
> > >
> > > In order to not break currently tools,
> > > when set "manual" to power_dpm_force_performance_level
> > > driver will do nothing and just return successful.
> > >
> > > Change-Id: Iaf672b9abc7fa57b765ceb7fa2fba6ad3e80c50b
> > > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  3 +--
> > >  drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |  5 -----
> > >  drivers/gpu/drm/amd/include/kgd_pp_interface.h     | 15
> +++++++--------
> > >  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     |  4 ----
> > >  drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c     |  1 -
> > >  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  6 ------
> > >  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  6 ------
> > >  7 files changed, 8 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > index 1812009..66b4df0 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > > @@ -152,7 +152,6 @@ static ssize_t
> > amdgpu_get_dpm_forced_performance_level(struct device *dev,
> > >                        (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? "au=
to" :
> > >                        (level =3D=3D AMD_DPM_FORCED_LEVEL_LOW) ? "low=
" :
> > >                        (level =3D=3D AMD_DPM_FORCED_LEVEL_HIGH) ? "hi=
gh" :
> > > -                     (level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) ?
> > "manual" :
> > >                        (level =3D=3D
> > AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD) ? "profile_standard" :
> > >                        (level =3D=3D
> > AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) ? "profile_min_sclk" :
> > >                        (level =3D=3D
> > AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) ? "profile_min_mclk" :
> > > @@ -186,7 +185,7 @@ static ssize_t
> > amdgpu_set_dpm_forced_performance_level(struct device *dev,
> > >        } else if (strncmp("auto", buf, strlen("auto")) =3D=3D 0) {
> > >                level =3D AMD_DPM_FORCED_LEVEL_AUTO;
> > >        } else if (strncmp("manual", buf, strlen("manual")) =3D=3D 0) =
{
> > > -             level =3D AMD_DPM_FORCED_LEVEL_MANUAL;
> > > +             pr_info("No need to set manual mode, Just go ahead\n");
> > >        } else if (strncmp("profile_exit", buf,
> > strlen("profile_exit")) =3D=3D 0) {
> > >                level =3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT;
> > >        } else if (strncmp("profile_standard", buf,
> > strlen("profile_standard")) =3D=3D 0) {
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> > b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> > > index ab45232..8ddc978 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
> > > @@ -6639,11 +6639,6 @@ static int ci_dpm_force_clock_level(void
> *handle,
> > >        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > >        struct ci_power_info *pi =3D ci_get_pi(adev);
> > >
> > > -     if (adev->pm.dpm.forced_level & (AMD_DPM_FORCED_LEVEL_AUTO |
> > > -                             AMD_DPM_FORCED_LEVEL_LOW |
> > > -                             AMD_DPM_FORCED_LEVEL_HIGH))
> > > -             return -EINVAL;
> > > -
> > >        switch (type) {
> > >        case PP_SCLK:
> > >                if (!pi->sclk_dpm_key_disabled)
> > > diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > index b9aa9f4..3fab686 100644
> > > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > @@ -41,14 +41,13 @@ struct amd_vce_state {
> > >
> > >  enum amd_dpm_forced_level {
> > >        AMD_DPM_FORCED_LEVEL_AUTO =3D 0x1,
> > > -     AMD_DPM_FORCED_LEVEL_MANUAL =3D 0x2,
> > > -     AMD_DPM_FORCED_LEVEL_LOW =3D 0x4,
> > > -     AMD_DPM_FORCED_LEVEL_HIGH =3D 0x8,
> > > -     AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD =3D 0x10,
> > > -     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK =3D 0x20,
> > > -     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK =3D 0x40,
> > > -     AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =3D 0x80,
> > > -     AMD_DPM_FORCED_LEVEL_PROFILE_EXIT =3D 0x100,
> > > +     AMD_DPM_FORCED_LEVEL_LOW =3D 0x2,
> > > +     AMD_DPM_FORCED_LEVEL_HIGH =3D 0x4,
> > > +     AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD =3D 0x8,
> > > +     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK =3D 0x10,
> > > +     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK =3D 0x20,
> > > +     AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =3D 0x40,
> > > +     AMD_DPM_FORCED_LEVEL_PROFILE_EXIT =3D 0x80,
> > >  };
> > >
> > >  enum amd_pm_state_type {
> > > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> > b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> > > index dec8dd9..60d280c 100644
> > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> > > @@ -1250,7 +1250,6 @@ static int cz_dpm_force_dpm_level(struct
> > pp_hwmgr *hwmgr,
> > >        case AMD_DPM_FORCED_LEVEL_AUTO:
> > >                ret =3D cz_phm_unforce_dpm_levels(hwmgr);
> > >                break;
> > > -     case AMD_DPM_FORCED_LEVEL_MANUAL:
> > >        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> > >        default:
> > >                break;
> > > @@ -1558,9 +1557,6 @@ static int cz_get_dal_power_level(struct
> > pp_hwmgr *hwmgr,
> > >  static int cz_force_clock_level(struct pp_hwmgr *hwmgr,
> > >                enum pp_clock_type type, uint32_t mask)
> > >  {
> > > -     if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
> > > -             return -EINVAL;
> > > -
> > >        switch (type) {
> > >        case PP_SCLK:
> > >                smum_send_msg_to_smc_with_parameter(hwmgr,
> > > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> > b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> > > index 409a56b..eddcbcd 100644
> > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> > > @@ -605,7 +605,6 @@ static int rv_dpm_force_dpm_level(struct
> > pp_hwmgr *hwmgr,
> > >
> > PPSMC_MSG_SetSoftMaxFclkByFreq,
> > >
> > RAVEN_UMD_PSTATE_MIN_FCLK);
> > >                break;
> > > -     case AMD_DPM_FORCED_LEVEL_MANUAL:
> > >        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> > >        default:
> > >                break;
> > > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > > index 13db75c..e3a8374 100644
> > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> > > @@ -2798,7 +2798,6 @@ static int smu7_force_dpm_level(struct
> > pp_hwmgr *hwmgr,
> > >                smu7_force_clock_level(hwmgr, PP_MCLK, 1<<mclk_mask);
> > >                smu7_force_clock_level(hwmgr, PP_PCIE, 1<<pcie_mask);
> > >                break;
> > > -     case AMD_DPM_FORCED_LEVEL_MANUAL:
> > >        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> > >        default:
> > >                break;
> > > @@ -4311,11 +4310,6 @@ static int smu7_force_clock_level(struct
> > pp_hwmgr *hwmgr,
> > >  {
> > >        struct smu7_hwmgr *data =3D (struct smu7_hwmgr
> *)(hwmgr->backend);
> > >
> > > -     if (hwmgr->request_dpm_level & (AMD_DPM_FORCED_LEVEL_AUTO |
> > > -                                     AMD_DPM_FORCED_LEVEL_LOW |
> > > -                                     AMD_DPM_FORCED_LEVEL_HIGH))
> > > -             return -EINVAL;
> > > -
> > >        switch (type) {
> > >        case PP_SCLK:
> > >                if (!data->sclk_dpm_key_disabled)
> > > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> > b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> > > index 6b28896..828677e 100644
> > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> > > @@ -4241,7 +4241,6 @@ static int vega10_dpm_force_dpm_level(struct
> > pp_hwmgr *hwmgr,
> > >                vega10_force_clock_level(hwmgr, PP_SCLK, 1<<sclk_mask)=
;
> > >                vega10_force_clock_level(hwmgr, PP_MCLK, 1<<mclk_mask)=
;
> > >                break;
> > > -     case AMD_DPM_FORCED_LEVEL_MANUAL:
> > >        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> > >        default:
> > >                break;
> > > @@ -4500,11 +4499,6 @@ static int vega10_force_clock_level(struct
> > pp_hwmgr *hwmgr,
> > >  {
> > >        struct vega10_hwmgr *data =3D (struct vega10_hwmgr
> > *)(hwmgr->backend);
> > >
> > > -     if (hwmgr->request_dpm_level & (AMD_DPM_FORCED_LEVEL_AUTO |
> > > -                             AMD_DPM_FORCED_LEVEL_LOW |
> > > -                             AMD_DPM_FORCED_LEVEL_HIGH))
> > > -             return -EINVAL;
> > > -
> > >        switch (type) {
> > >        case PP_SCLK:
> > >                data->smc_state_table.gfx_boot_level =3D mask ?
> > (ffs(mask) - 1) : 0;
> >
>


--_000_CY4PR12MB1687BFBCA906C0B17D52089BFBE00CY4PR12MB1687namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&gt;1. You're break=
ing
 the semantics of the existing pp_dpm_sclk/mclk/pcie</span><br style=3D"fon=
t-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoj=
i&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&=
quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt; &nbsp; &nbsp;interfaces, which affects existing tools</s=
pan></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"></span>Rex: I don't
 think the patch will affects existing tools.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">User set &quot;manual&quot; to po=
wer_performance_level, and then change the clock range through &nbsp;<span =
style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Appl=
e Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Sego=
e UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6=
667px;">pp_dpm_sclk/mclk/pcie.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">with this patch, Us=
er
 dont need to set &quot;manual&quot; command, &nbsp;if still receive the ma=
nual command, driver just return sucess to user in order not &nbsp;break ex=
isting</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;"></span><span style=
=3D"font-size: 14.6667px;">tools.
 &nbsp;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&nbsp;&gt;2. You're=
 taking the
 clock limits out of the power profile.</span><br style=3D"font-family: Cal=
ibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quo=
t;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;=
Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&nbsp;&gt; &nbsp;Automatically adjusting the minimum sclk/mcl=
k is a requirement
 for</span><br style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiF=
ont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEm=
oji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; =
font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&nbsp;&gt; &nbsp; the compute power profile</span><br>
</p>
<br>
Rex: In vega10, under&nbsp;default comput mode(with busy_set_point/fps/use_=
rlc_busy/min_active_level set), just two performance levels left</div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
(level0 and level7). and clock just switch between lowest and highest.</div=
>
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<br>
</div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
I am not sure in this case, driver still can set min sclk/mclk.</div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<br>
</div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
Best Regards</div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
Rex&nbsp;</div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<br>
<div><br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Saturday, January 27, 2018 12:49 AM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for power_dp=
m_force_performance_level</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Rex,<br>
<br>
I think I understand what you're trying to do. To summarize my concerns,<br=
>
there are two reasons I'm against your plan:<br>
<br>
&nbsp;1. You're breaking the semantics of the existing pp_dpm_sclk/mclk/pci=
e<br>
&nbsp;&nbsp;&nbsp; interfaces, which affects existing tools<br>
&nbsp;2. You're taking the clock limits out of the power profile.<br>
&nbsp;&nbsp;&nbsp; Automatically adjusting the minimum sclk/mclk is a requi=
rement for<br>
&nbsp;&nbsp;&nbsp; the compute power profile<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
On 2018-01-26 07:50 AM, Zhu, Rex wrote:<br>
&gt;<br>
&gt; Hi Felix,<br>
&gt;<br>
&gt;<br>
&gt; &gt;That would make sense. But switching to manual mode would disable<=
br>
&gt; &gt;profiles and automatic profile selection. That was one reason why =
I<br>
&gt; &gt;objected to your plan to control profile clock limits using these =
files.<br>
&gt;<br>
&gt; Rex:<br>
&gt;<br>
&gt;<br>
&gt; I am not very&nbsp;clear the old logic of gfx/compute power profile sw=
itch.<br>
&gt;<br>
&gt;<br>
&gt; But with new sysfs,<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; The logic is(those sysfs are independent)&nbsp;<br>
&gt;<br>
&gt;&nbsp; 1. configure uphyst/downhyst/min_ativity through power_profile_m=
ode,<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; 2. adjust clock range through pp_dpm_sclk/mclk/pc=
ie.(once this<br>
&gt; sysffs was called,&nbsp;set the dpm level mode to unknown)<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; 3.&nbsp;adjust power limit through pp_od_power_li=
mit(maybe equal to<br>
&gt; disable power containment).<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp;&nbsp;<br>
&gt;<br>
&gt; In those functions, driver do not check the dpm level mode.&nbsp;<br>
&gt;<br>
&gt; the dpm level mode just used by&nbsp;power_dpm_force_performance_level=
<br>
&gt; functions.<br>
&gt;<br>
&gt;<br>
&gt; Best Regards<br>
&gt;<br>
&gt; Rex<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* Kuehling, Felix<br>
&gt; *Sent:* Friday, January 26, 2018 8:26 AM<br>
&gt; *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; *Subject:* Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for<br>
&gt; power_dpm_force_performance_level<br>
&gt; &nbsp;<br>
&gt; On 2018-01-25 07:07 PM, Zhu, Rex wrote:<br>
&gt; &gt; I also think about this problem.<br>
&gt; &gt; just think user should unforced clk level through pp dpm<br>
&gt; &gt; sclk/mclk/pcie if they change the clock logic through those sysfs=
.<br>
&gt; &gt;<br>
&gt; &gt; The logic seems weird, As we supply many sysfs for adjust clock r=
ange.<br>
&gt; &gt;<br>
&gt; &gt; We can fix this problem by change current mode to manual mode aft=
er<br>
&gt; &gt; user call pp dpm sclk/mclk/pcie.<br>
&gt; &gt;<br>
&gt; &gt; But another think=1B$B!$=1B(Bif user change back the clk range th=
rough pp dpm clk.<br>
&gt; &gt;<br>
&gt; &gt; we are in manual mode, and user set auto mode, in fact, driver ch=
ange<br>
&gt; &gt; nothing.<br>
&gt;<br>
&gt; With profiles, switching back to auto mode would select the appropriat=
e<br>
&gt; profile, which may have a different clock mask. For example for comput=
e<br>
&gt; we enable only the highest two sclk levels.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Comparatively speaking, better set manual mode after user call pp=
<br>
&gt; dpm clk.<br>
&gt;<br>
&gt; That would make sense. But switching to manual mode would disable<br>
&gt; profiles and automatic profile selection. That was one reason why I<br=
>
&gt; objected to your plan to control profile clock limits using these file=
s.<br>
&gt;<br>
&gt; Regards,<br>
&gt; &nbsp; Felix<br>
&gt;<br>
&gt; &gt; Thanks very much.<br>
&gt; &gt;<br>
&gt; &gt; Best Regards<br>
&gt; &gt; Rex<br>
&gt; &gt; -----------------------------------------------------------------=
-------<br>
&gt; &gt; *From:* Kuehling, Felix<br>
&gt; &gt; *Sent:* Friday, January 26, 2018 12:55:19 AM<br>
&gt; &gt; *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex<br>
&gt; &gt; *Subject:* Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for<br>
&gt; &gt; power_dpm_force_performance_level<br>
&gt; &gt; &nbsp;<br>
&gt; &gt; This patch breaks unforcing of clocks, which is currently done by=
<br>
&gt; &gt; switching back from &quot;manual&quot; to &quot;auto&quot;. By re=
moving &quot;manual&quot; mode, you<br>
&gt; &gt; remove the ability to unset forced clocks.<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; &nbsp; Felix<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On 2018-01-25 06:26 AM, Rex Zhu wrote:<br>
&gt; &gt; &gt; Driver do not maintain manual mode for dpm_force_performance=
_level,<br>
&gt; &gt; &gt; User can set sclk/mclk/pcie range through<br>
&gt; &gt; pp_dpm_sclk/pp_dpm_mclk/pp_dpm_pcie<br>
&gt; &gt; &gt; directly.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; In order to not break currently tools,<br>
&gt; &gt; &gt; when set &quot;manual&quot; to power_dpm_force_performance_l=
evel<br>
&gt; &gt; &gt; driver will do nothing and just return successful.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Change-Id: Iaf672b9abc7fa57b765ceb7fa2fba6ad3e80c50b<br>
&gt; &gt; &gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 &#43;--<=
br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/ci_dpm.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 5 -----<br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&n=
bsp;&nbsp;&nbsp; | 15<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;--------<br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 4 ----<br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 1 -<br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;=
&nbsp; |&nbsp; 6 ------<br>
&gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |&n=
bsp; 6 ------<br>
&gt; &gt; &gt;&nbsp; 7 files changed, 8 insertions(&#43;), 32 deletions(-)<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; index 1812009..66b4df0 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &gt; &gt; @@ -152,7 &#43;152,6 @@ static ssize_t<br>
&gt; &gt; amdgpu_get_dpm_forced_performance_level(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ? &quot;auto&quot; :<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (level =3D=3D AMD_DPM_FORCED_LEVEL_LOW) ? &quot;low&quot; :<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (level =3D=3D AMD_DPM_FORCED_LEVEL_HIGH) ? &quot;high&quot; :<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (level =3D=3D=
 AMD_DPM_FORCED_LEVEL_MANUAL) ?<br>
&gt; &gt; &quot;manual&quot; :<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (level =3D=3D<br>
&gt; &gt; AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD) ? &quot;profile_standard&q=
uot; :<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (level =3D=3D<br>
&gt; &gt; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) ? &quot;profile_min_sclk&q=
uot; :<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (level =3D=3D<br>
&gt; &gt; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) ? &quot;profile_min_mclk&q=
uot; :<br>
&gt; &gt; &gt; @@ -186,7 &#43;185,7 @@ static ssize_t<br>
&gt; &gt; amdgpu_set_dpm_forced_performance_level(struct device *dev,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp=
(&quot;auto&quot;, buf, strlen(&quot;auto&quot;)) =3D=3D 0) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEVEL_AUTO;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp=
(&quot;manual&quot;, buf, strlen(&quot;manual&quot;)) =3D=3D 0) {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEVEL_MANUAL;<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; pr_info(&quot;No need to set manual mode, Just go ahead\n=
&quot;);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp=
(&quot;profile_exit&quot;, buf,<br>
&gt; &gt; strlen(&quot;profile_exit&quot;)) =3D=3D 0) {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT;<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (strncmp=
(&quot;profile_standard&quot;, buf,<br>
&gt; &gt; strlen(&quot;profile_standard&quot;)) =3D=3D 0) {<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt; &gt; &gt; index ab45232..8ddc978 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt; &gt; &gt; @@ -6639,11 &#43;6639,6 @@ static int ci_dpm_force_clock_lev=
el(void<br>
&gt; *handle,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_devi=
ce *adev =3D (struct amdgpu_device *)handle;<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_in=
fo *pi =3D ci_get_pi(adev);<br>
&gt; &gt; &gt;&nbsp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.dpm.forced_level &=
amp; (AMD_DPM_FORCED_LEVEL_AUTO |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LOW |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SCLK:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pi-&gt;sclk_dpm_key_disabled)<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<=
br>
&gt; &gt; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &gt; &gt; index b9aa9f4..3fab686 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_interfa=
ce.h<br>
&gt; &gt; &gt; @@ -41,14 &#43;41,13 @@ struct amd_vce_state {<br>
&gt; &gt; &gt;&nbsp;<br>
&gt; &gt; &gt;&nbsp; enum amd_dpm_forced_level {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEV=
EL_AUTO =3D 0x1,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_MANUAL =3D 0x=
2,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LOW =3D 0x4,<=
br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH =3D 0x8,=
<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_STAND=
ARD =3D 0x10,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_S=
CLK =3D 0x20,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_M=
CLK =3D 0x40,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =
=3D 0x80,<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_EXIT =
=3D 0x100,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LOW =3D 0=
x2,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH =3D =
0x4,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_S=
TANDARD =3D 0x8,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_M=
IN_SCLK =3D 0x10,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_M=
IN_MCLK =3D 0x20,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_P=
EAK =3D 0x40,<br>
&gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_PROFILE_E=
XIT =3D 0x80,<br>
&gt; &gt; &gt;&nbsp; };<br>
&gt; &gt; &gt;&nbsp;<br>
&gt; &gt; &gt;&nbsp; enum amd_pm_state_type {<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<=
br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; &gt; &gt; index dec8dd9..60d280c 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwm=
gr.c<br>
&gt; &gt; &gt; @@ -1250,7 &#43;1250,6 @@ static int cz_dpm_force_dpm_level(=
struct<br>
&gt; &gt; pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCE=
D_LEVEL_AUTO:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cz_phm_unforce_dpm_levels(hwmgr);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_MANUAL:<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCE=
D_LEVEL_PROFILE_EXIT:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; @@ -1558,9 &#43;1557,6 @@ static int cz_get_dal_power_level(=
struct<br>
&gt; &gt; pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt;&nbsp; static int cz_force_clock_level(struct pp_hwmgr *hwmgr=
,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type, uint32_t mask)<br>
&gt; &gt; &gt;&nbsp; {<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=3D AMD_D=
PM_FORCED_LEVEL_MANUAL)<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SCLK:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br=
>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<=
br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; &gt; &gt; index 409a56b..eddcbcd 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwm=
gr.c<br>
&gt; &gt; &gt; @@ -605,7 &#43;605,6 @@ static int rv_dpm_force_dpm_level(st=
ruct<br>
&gt; &gt; pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; &gt; PPSMC_MSG_SetSoftMaxFclkByFreq,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
&gt; &gt; RAVEN_UMD_PSTATE_MIN_FCLK);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_MANUAL:<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCE=
D_LEVEL_PROFILE_EXIT:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.=
c<br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &gt; &gt; index 13db75c..e3a8374 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_h=
wmgr.c<br>
&gt; &gt; &gt; @@ -2798,7 &#43;2798,6 @@ static int smu7_force_dpm_level(st=
ruct<br>
&gt; &gt; pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_force_clock_level(hwmgr, PP_MCLK, 1&lt;&=
lt;mclk_mask);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_force_clock_level(hwmgr, PP_PCIE, 1&lt;&=
lt;pcie_mask);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_MANUAL:<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCE=
D_LEVEL_PROFILE_EXIT:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; @@ -4311,11 &#43;4310,6 @@ static int smu7_force_clock_level=
(struct<br>
&gt; &gt; pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr =
*data =3D (struct smu7_hwmgr<br>
&gt; *)(hwmgr-&gt;backend);<br>
&gt; &gt; &gt;&nbsp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;request_dpm_level &a=
mp; (AMD_DPM_FORCED_LEVEL_AUTO |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; AMD_DPM_FORCED_LEVEL_LOW |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SCLK:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;sclk_dpm_key_disabled)<br>
&gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmg=
r.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &gt; &gt; index 6b28896..828677e 100644<br>
&gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10=
_hwmgr.c<br>
&gt; &gt; &gt; @@ -4241,7 &#43;4241,6 @@ static int vega10_dpm_force_dpm_le=
vel(struct<br>
&gt; &gt; pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_force_clock_level(hwmgr, PP_SCLK, 1&lt=
;&lt;sclk_mask);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_force_clock_level(hwmgr, PP_MCLK, 1&lt=
;&lt;mclk_mask);<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_MANUAL:<=
br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCE=
D_LEVEL_PROFILE_EXIT:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &gt; @@ -4500,11 &#43;4499,6 @@ static int vega10_force_clock_lev=
el(struct<br>
&gt; &gt; pp_hwmgr *hwmgr,<br>
&gt; &gt; &gt;&nbsp; {<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmg=
r *data =3D (struct vega10_hwmgr<br>
&gt; &gt; *)(hwmgr-&gt;backend);<br>
&gt; &gt; &gt;&nbsp;<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;request_dpm_level &a=
mp; (AMD_DPM_FORCED_LEVEL_AUTO |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LOW |<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH))<br>
&gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; &gt; -<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br=
>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_SCLK:<br>
&gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smc_state_table.gfx_boot_level =3D m=
ask ?<br>
&gt; &gt; (ffs(mask) - 1) : 0;<br>
&gt; &gt;<br>
&gt;<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687BFBCA906C0B17D52089BFBE00CY4PR12MB1687namp_--

--===============2049570415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2049570415==--
