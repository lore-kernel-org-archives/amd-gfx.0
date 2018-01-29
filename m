From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
 power_dpm_force_performance_level
Date: Mon, 29 Jan 2018 22:45:51 +0000
Message-ID: <CY4PR12MB16876AFDCAE195D8DF162F14FBE50@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1516879614-11533-1-git-send-email-Rex.Zhu@amd.com>
 <51c6111b-78ec-36f8-b5e0-4a23ccea6de4@amd.com>
 <CY4PR12MB1687930CD8F44390C3791A63FBE10@CY4PR12MB1687.namprd12.prod.outlook.com>
 <0ce63372-dc11-9710-f11d-0cf6abf326b4@amd.com>
 <CY4PR12MB168744ABA067C470390EA34EFBE00@CY4PR12MB1687.namprd12.prod.outlook.com>
 <ec6ea7dd-0096-dd92-8c49-b2992b5bf506@amd.com>
 <CY4PR12MB1687BFBCA906C0B17D52089BFBE00@CY4PR12MB1687.namprd12.prod.outlook.com>
 <cc9e6d84-9720-15fb-15ec-f608f8d9392d@amd.com>
 <CY4PR12MB1687274014BDD739BE44DF6CFBE00@CY4PR12MB1687.namprd12.prod.outlook.com>
 <CADnq5_Ni6j8ONe7f5rDMprbeB6Mq1RVXJAonUO2VTp+1Dgf+Gw@mail.gmail.com>
 <CY4PR12MB1687A63BA8F717170700292DFBE50@CY4PR12MB1687.namprd12.prod.outlook.com>
 <CADnq5_Njpv+OnXRD0bo4ZefjxR8LLnfsyTCoTmdmYzgYAuBXOA@mail.gmail.com>
 <CY4PR12MB16876451346CA39EE72B4844FBE50@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <CADnq5_O-43_fW4_4D=ztPDhww44fADHFLyHkNCT+WRLv3usQxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0401585917=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_O-43_fW4_4D=ztPDhww44fADHFLyHkNCT+WRLv3usQxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0401585917==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16876AFDCAE195D8DF162F14FBE50CY4PR12MB1687namp_"

--_000_CY4PR12MB16876AFDCAE195D8DF162F14FBE50CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


It's Ok, I got it.

Thanks.


Best Regards
Rex

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, January 30, 2018 6:26 AM
To: Zhu, Rex
Cc: Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for power_dpm_force=
_performance_level

On Mon, Jan 29, 2018 at 4:51 PM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
>>I'd prefer to keep the requirement to select manual mode to be able to
>>manually mess with the clock levels.  This also makes simplifies the
>>profile interface by only allowing you to change the profile if you
>>select manual mode first.  That way we don't have to add an AUTO
>>profile to the profile selection to let the driver pick the profile.
>>that can happen automatically if the user sets the force_performance
>>level to auto.
>
>
> Hi Alex=1B$B!$=1B(B
>
>
> so you mean use "auto"  state of force_performance_leve as reset mode to =
all
> the performance related sysfs.

My thinking was that with force_performance_level set to auto, the
driver will handle everything by itself.  The driver would pick the
power profile dynamically, all of the dpm states relevant to the power
profiles would be enabled, etc.  If the user selects manual in
force_performance_level, then they can select which sclk/mclk/pcie dpm
states are active as before, and now with the profile stuff, they can
select either a predefined profile (video, vr, 3d, etc.) or a custom
one.  If they want to go back to automatic driver control, they just
switch force_performance_level back to auto.  That way we have just
one interface to control the behavior and there are fewer corner cases
where features interact.  Either select auto and let the driver handle
it all, or select manual and tweak everything manually.

Alex

>
>
> Currently we just unfore the clock range in the auto state.
>
>
> Anyway, I will drop this patch.
>
>
> Best Regards
>
> Rex
>
>
>
> ________________________________
> From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Tuesday, January 30, 2018 2:02 AM
>
> To: Zhu, Rex
> Cc: Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
> power_dpm_force_performance_level
>
> On Mon, Jan 29, 2018 at 7:03 AM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
>> Hi Alex,
>>
>>>How about we make the profile selection dependent on selecting the manua=
l
>>> force_performance_level
>>
>> If so, we need to check pm.dpm.forced_level  before "profile heuristics"
>> and "disable power containment" as same as pp_dpm_sclk/mclk/pcie.
>>
>> if (adev->pm.dpm.forced_level & (AMD_DPM_FORCED_LEVEL_AUTO |
>>                                AMD_DPM_FORCED_LEVEL_LOW |
>>                                AMD_DPM_FORCED_LEVEL_HIGH))
>>                return -EINVAL;
>>
>> How about delete judging code before force_clock_level and just change
>> force_level to manual after force_clock_level. Please see the attached
>> patch.
>>
>> This change have no impact on existing interface and tools.
>> It just refine the logic of power_dpm_force_performance_level and
>> pp_dpm_sclk/mclk/pcie.
>> Also has no impact to power/computer profile mode on smu7.
>>
>> The difference is:
>>
>> New user can have one less command need to input if they want to use
>> pp_dpm_sclk/mclk/pcie.
>
> I'd prefer to keep the requirement to select manual mode to be able to
> manually mess with the clock levels.  This also makes simplifies the
> profile interface by only allowing you to change the profile if you
> select manual mode first.  That way we don't have to add an AUTO
> profile to the profile selection to let the driver pick the profile.
> that can happen automatically if the user sets the force_performance
> level to auto.
>
> Alex
>
>>
>>
>> Best Regards
>> Rex
>> -----Original Message-----
>> From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>> Sent: Saturday, January 27, 2018 7:51 AM
>> To: Zhu, Rex
>> Cc: Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
>> power_dpm_force_performance_level
>>
>> I think we have two use cases for the profiles:
>>
>> 1. automatic profile switching for different driver use cases 2. manuall=
y
>> tweaking profiles/clocks/power for testing
>>
>> How about we make the profile selection dependent on selecting the manua=
l
>> force_performance_level and not add an auto to the profile selector.  Th=
en
>> when you select manual you can tweak the clocks and profile heuristics a=
nd
>> power containment via their respective knobs.
>>
>>
>> Alex
>>
>> On Fri, Jan 26, 2018 at 3:08 PM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
>>>>Existing tools and users expect that switching back to auto removes
>>>>the manual clock settings. If you allow changing the clock in auto
>>>>mode, that won't happen any more.
>>>
>>>
>>> I have sent the patch v2 to fix this problem. user can swith back auto
>>> mode and all manual clock setting will be removed.
>>>
>>>
>>>>One more reason why allowing the user to set pp_dpm_sckl/mclk
>>>>shouldn't be  allowed in auto-mode.
>>>
>>> this is an old logic, maybe ref radeon driver.
>>> Driver can allow to set pp_dpm_sclk/mclk range in auto/high/low mode.
>>>
>>> Best Regards
>>> Rex
>>> ________________________________
>>> From: Kuehling, Felix
>>> Sent: Saturday, January 27, 2018 3:32 AM
>>> To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
>>> power_dpm_force_performance_level
>>>
>>> On 2018-01-26 02:20 PM, Zhu, Rex wrote:
>>>>
>>>> >1. You're breaking the semantics of the existing pp_dpm_sclk/mclk/pci=
e
>>>> >    interfaces, which affects existing tools
>>>>
>>>>
>>>> Rex: I don't think the patch will affects existing tools.
>>>>
>>>>
>>>> User set "manual" to power_performance_level, and then change the
>>>> clock range through  pp_dpm_sclk/mclk/pcie.
>>>>
>>>>
>>>> with this patch, User dont need to set "manual" command,  if still
>>>> receive the manual command, driver just return sucess to user in
>>>> order not  break existing
>>>>
>>>> tools.
>>>>
>>>
>>> Existing tools and users expect that switching back to auto removes
>>> the manual clock settings. If you allow changing the clock in auto
>>> mode, that won't happen any more.
>>>
>>>>
>>>>  >2. You're taking the clock limits out of the power profile.
>>>>  >  Automatically adjusting the minimum sclk/mclk is a requirement for
>>>>  >   the compute power profile
>>>>
>>>>
>>>> Rex: In vega10, under default comput mode(with
>>>> busy_set_point/fps/use_rlc_busy/min_active_level set), just two
>>>> performance levels left
>>>> (level0 and level7). and clock just switch between lowest and highest.
>>>>
>>>> I am not sure in this case, driver still can set min sclk/mclk.
>>>
>>> One more reason why allowing the user to set pp_dpm_sckl/mclk
>>> shouldn't be allowed in auto-mode.
>>>
>>> Regards,
>>>   Felix
>>>
>>>>
>>>> Best Regards
>>>> Rex
>>>>
>>>>
>>>> ---------------------------------------------------------------------
>>>> ---
>>>> *From:* Kuehling, Felix
>>>> *Sent:* Saturday, January 27, 2018 12:49 AM
>>>> *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> *Subject:* Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
>>>> power_dpm_force_performance_level
>>>>
>>>> Hi Rex,
>>>>
>>>> I think I understand what you're trying to do. To summarize my
>>>> concerns, there are two reasons I'm against your plan:
>>>>
>>>>  1. You're breaking the semantics of the existing pp_dpm_sclk/mclk/pci=
e
>>>>     interfaces, which affects existing tools  2. You're taking the
>>>> clock limits out of the power profile.
>>>>     Automatically adjusting the minimum sclk/mclk is a requirement for
>>>>     the compute power profile
>>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>> On 2018-01-26 07:50 AM, Zhu, Rex wrote:
>>>> >
>>>> > Hi Felix,
>>>> >
>>>> >
>>>> > >That would make sense. But switching to manual mode would disable
>>>> > >profiles and automatic profile selection. That was one reason why
>>>> > >I objected to your plan to control profile clock limits using
>>>> > >these
>>>> files.
>>>> >
>>>> > Rex:
>>>> >
>>>> >
>>>> > I am not very clear the old logic of gfx/compute power profile switc=
h.
>>>> >
>>>> >
>>>> > But with new sysfs,
>>>> >
>>>> >
>>>> >
>>>> > The logic is(those sysfs are independent)
>>>> >
>>>> >  1. configure uphyst/downhyst/min_ativity through
>>>> > power_profile_mode,
>>>> >
>>>> >       2. adjust clock range through pp_dpm_sclk/mclk/pcie.(once
>>>> > this sysffs was called, set the dpm level mode to unknown)
>>>> >
>>>> >       3. adjust power limit through pp_od_power_limit(maybe equal
>>>> > to disable power containment).
>>>> >
>>>> >
>>>> >
>>>> > In those functions, driver do not check the dpm level mode.
>>>> >
>>>> > the dpm level mode just used by power_dpm_force_performance_level
>>>> > functions.
>>>> >
>>>> >
>>>> > Best Regards
>>>> >
>>>> > Rex
>>>> >
>>>> >
>>>> >
>>>> >
>>>> >
>>>> > -------------------------------------------------------------------
>>>> > -----
>>>> > *From:* Kuehling, Felix
>>>> > *Sent:* Friday, January 26, 2018 8:26 AM
>>>> > *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> > *Subject:* Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
>>>> > power_dpm_force_performance_level
>>>> >
>>>> > On 2018-01-25 07:07 PM, Zhu, Rex wrote:
>>>> > > I also think about this problem.
>>>> > > just think user should unforced clk level through pp dpm
>>>> > > sclk/mclk/pcie if they change the clock logic through those sysfs.
>>>> > >
>>>> > > The logic seems weird, As we supply many sysfs for adjust clock
>>>> > > range.
>>>> > >
>>>> > > We can fix this problem by change current mode to manual mode
>>>> > > after user call pp dpm sclk/mclk/pcie.
>>>> > >
>>>> > > But another think=1B$B!$=1B(Bif user change back the clk range thr=
ough pp
>>>> > > dpm
>>>> clk.
>>>> > >
>>>> > > we are in manual mode, and user set auto mode, in fact, driver
>>>> > > change nothing.
>>>> >
>>>> > With profiles, switching back to auto mode would select the
>>>> > appropriate profile, which may have a different clock mask. For
>>>> > example for compute we enable only the highest two sclk levels.
>>>> >
>>>> > >
>>>> > > Comparatively speaking, better set manual mode after user call pp
>>>> > dpm clk.
>>>> >
>>>> > That would make sense. But switching to manual mode would disable
>>>> > profiles and automatic profile selection. That was one reason why I
>>>> > objected to your plan to control profile clock limits using these
>>>> > files.
>>>> >
>>>> > Regards,
>>>> >   Felix
>>>> >
>>>> > > Thanks very much.
>>>> > >
>>>> > > Best Regards
>>>> > > Rex
>>>> > >
>>>> ---------------------------------------------------------------------
>>>> ---
>>>> > > *From:* Kuehling, Felix
>>>> > > *Sent:* Friday, January 26, 2018 12:55:19 AM
>>>> > > *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex
>>>> > > *Subject:* Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for
>>>> > > power_dpm_force_performance_level
>>>> > >
>>>> > > This patch breaks unforcing of clocks, which is currently done by
>>>> > > switching back from "manual" to "auto". By removing "manual"
>>>> > > mode, you remove the ability to unset forced clocks.
>>>> > >
>>>> > > Regards,
>>>> > >   Felix
>>>> > >
>>>> > >
>>>> > > On 2018-01-25 06:26 AM, Rex Zhu wrote:
>>>> > > > Driver do not maintain manual mode for
>>>> > > > dpm_force_performance_level, User can set sclk/mclk/pcie range
>>>> > > > through
>>>> > > pp_dpm_sclk/pp_dpm_mclk/pp_dpm_pcie
>>>> > > > directly.
>>>> > > >
>>>> > > > In order to not break currently tools, when set "manual" to
>>>> > > > power_dpm_force_performance_level driver will do nothing and
>>>> > > > just return successful.
>>>> > > >
>>>> > > > Change-Id: Iaf672b9abc7fa57b765ceb7fa2fba6ad3e80c50b
>>>> > > > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>>>> > > > ---
>>>> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |  3 +--
>>>> > > >  drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |  5 -----
>>>> > > >  drivers/gpu/drm/amd/include/kgd_pp_interface.h     | 15
>>>> > +++++++--------
>>>> > > >  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     |  4 ----
>>>> > > >  drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c     |  1 -
>>>> > > >  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  6 ------
>>>> > > >  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  6 ------
>>>> > > >  7 files changed, 8 insertions(+), 32 deletions(-)
>>>> > > >
>>>> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>>> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>>> > > > index 1812009..66b4df0 100644
>>>> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>>> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>>> > > > @@ -152,7 +152,6 @@ static ssize_t
>>>> > > amdgpu_get_dpm_forced_performance_level(struct device *dev,
>>>> > > >                        (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) =
?
>>>> "auto" :
>>>> > > >                        (level =3D=3D AMD_DPM_FORCED_LEVEL_LOW) ?=
 "low"
>>>> > > > :
>>>> > > >                        (level =3D=3D AMD_DPM_FORCED_LEVEL_HIGH) =
?
>>>> "high" :
>>>> > > > -                     (level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)=
 ?
>>>> > > "manual" :
>>>> > > >                        (level =3D=3D
>>>> > > AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD) ? "profile_standard" :
>>>> > > >                        (level =3D=3D
>>>> > > AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) ? "profile_min_sclk" :
>>>> > > >                        (level =3D=3D
>>>> > > AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) ? "profile_min_mclk" :
>>>> > > > @@ -186,7 +185,7 @@ static ssize_t
>>>> > > amdgpu_set_dpm_forced_performance_level(struct device *dev,
>>>> > > >        } else if (strncmp("auto", buf, strlen("auto")) =3D=3D 0)=
 {
>>>> > > >                level =3D AMD_DPM_FORCED_LEVEL_AUTO;
>>>> > > >        } else if (strncmp("manual", buf, strlen("manual")) =3D=
=3D 0) {
>>>> > > > -             level =3D AMD_DPM_FORCED_LEVEL_MANUAL;
>>>> > > > +             pr_info("No need to set manual mode, Just go
>>>> ahead\n");
>>>> > > >        } else if (strncmp("profile_exit", buf,
>>>> > > strlen("profile_exit")) =3D=3D 0) {
>>>> > > >                level =3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT;
>>>> > > >        } else if (strncmp("profile_standard", buf,
>>>> > > strlen("profile_standard")) =3D=3D 0) {
>>>> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>> > > b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>> > > > index ab45232..8ddc978 100644
>>>> > > > --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>> > > > +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>> > > > @@ -6639,11 +6639,6 @@ static int ci_dpm_force_clock_level(void
>>>> > *handle,
>>>> > > >        struct amdgpu_device *adev =3D (struct amdgpu_device
>>>> > > > *)handle;
>>>> > > >        struct ci_power_info *pi =3D ci_get_pi(adev);
>>>> > > >
>>>> > > > -     if (adev->pm.dpm.forced_level & (AMD_DPM_FORCED_LEVEL_AUTO=
 |
>>>> > > > -                             AMD_DPM_FORCED_LEVEL_LOW |
>>>> > > > -                             AMD_DPM_FORCED_LEVEL_HIGH))
>>>> > > > -             return -EINVAL;
>>>> > > > -
>>>> > > >        switch (type) {
>>>> > > >        case PP_SCLK:
>>>> > > >                if (!pi->sclk_dpm_key_disabled) diff --git
>>>> > > > a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>> > > b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>> > > > index b9aa9f4..3fab686 100644
>>>> > > > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>> > > > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>> > > > @@ -41,14 +41,13 @@ struct amd_vce_state {
>>>> > > >
>>>> > > >  enum amd_dpm_forced_level {
>>>> > > >        AMD_DPM_FORCED_LEVEL_AUTO =3D 0x1,
>>>> > > > -     AMD_DPM_FORCED_LEVEL_MANUAL =3D 0x2,
>>>> > > > -     AMD_DPM_FORCED_LEVEL_LOW =3D 0x4,
>>>> > > > -     AMD_DPM_FORCED_LEVEL_HIGH =3D 0x8,
>>>> > > > -     AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD =3D 0x10,
>>>> > > > -     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK =3D 0x20,
>>>> > > > -     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK =3D 0x40,
>>>> > > > -     AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =3D 0x80,
>>>> > > > -     AMD_DPM_FORCED_LEVEL_PROFILE_EXIT =3D 0x100,
>>>> > > > +     AMD_DPM_FORCED_LEVEL_LOW =3D 0x2,
>>>> > > > +     AMD_DPM_FORCED_LEVEL_HIGH =3D 0x4,
>>>> > > > +     AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD =3D 0x8,
>>>> > > > +     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK =3D 0x10,
>>>> > > > +     AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK =3D 0x20,
>>>> > > > +     AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =3D 0x40,
>>>> > > > +     AMD_DPM_FORCED_LEVEL_PROFILE_EXIT =3D 0x80,
>>>> > > >  };
>>>> > > >
>>>> > > >  enum amd_pm_state_type {
>>>> > > > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>>>> > > b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>>>> > > > index dec8dd9..60d280c 100644
>>>> > > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>>>> > > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
>>>> > > > @@ -1250,7 +1250,6 @@ static int cz_dpm_force_dpm_level(struct
>>>> > > pp_hwmgr *hwmgr,
>>>> > > >        case AMD_DPM_FORCED_LEVEL_AUTO:
>>>> > > >                ret =3D cz_phm_unforce_dpm_levels(hwmgr);
>>>> > > >                break;
>>>> > > > -     case AMD_DPM_FORCED_LEVEL_MANUAL:
>>>> > > >        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>>>> > > >        default:
>>>> > > >                break;
>>>> > > > @@ -1558,9 +1557,6 @@ static int cz_get_dal_power_level(struct
>>>> > > pp_hwmgr *hwmgr,
>>>> > > >  static int cz_force_clock_level(struct pp_hwmgr *hwmgr,
>>>> > > >                enum pp_clock_type type, uint32_t mask)  {
>>>> > > > -     if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
>>>> > > > -             return -EINVAL;
>>>> > > > -
>>>> > > >        switch (type) {
>>>> > > >        case PP_SCLK:
>>>> > > >                smum_send_msg_to_smc_with_parameter(hwmgr,
>>>> > > > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
>>>> > > b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
>>>> > > > index 409a56b..eddcbcd 100644
>>>> > > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
>>>> > > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
>>>> > > > @@ -605,7 +605,6 @@ static int rv_dpm_force_dpm_level(struct
>>>> > > pp_hwmgr *hwmgr,
>>>> > > >
>>>> > > PPSMC_MSG_SetSoftMaxFclkByFreq,
>>>> > > >
>>>> > > RAVEN_UMD_PSTATE_MIN_FCLK);
>>>> > > >                break;
>>>> > > > -     case AMD_DPM_FORCED_LEVEL_MANUAL:
>>>> > > >        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>>>> > > >        default:
>>>> > > >                break;
>>>> > > > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>>> > > b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>>> > > > index 13db75c..e3a8374 100644
>>>> > > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>>> > > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>>> > > > @@ -2798,7 +2798,6 @@ static int smu7_force_dpm_level(struct
>>>> > > pp_hwmgr *hwmgr,
>>>> > > >                smu7_force_clock_level(hwmgr, PP_MCLK,
>>>> > > > 1<<mclk_mask);
>>>> > > >                smu7_force_clock_level(hwmgr, PP_PCIE,
>>>> > > > 1<<pcie_mask);
>>>> > > >                break;
>>>> > > > -     case AMD_DPM_FORCED_LEVEL_MANUAL:
>>>> > > >        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>>>> > > >        default:
>>>> > > >                break;
>>>> > > > @@ -4311,11 +4310,6 @@ static int smu7_force_clock_level(struct
>>>> > > pp_hwmgr *hwmgr,
>>>> > > >  {
>>>> > > >        struct smu7_hwmgr *data =3D (struct smu7_hwmgr
>>>> > *)(hwmgr->backend);
>>>> > > >
>>>> > > > -     if (hwmgr->request_dpm_level & (AMD_DPM_FORCED_LEVEL_AUTO =
|
>>>> > > > -                                     AMD_DPM_FORCED_LEVEL_LOW |
>>>> > > > -                                     AMD_DPM_FORCED_LEVEL_HIGH)=
)
>>>> > > > -             return -EINVAL;
>>>> > > > -
>>>> > > >        switch (type) {
>>>> > > >        case PP_SCLK:
>>>> > > >                if (!data->sclk_dpm_key_disabled) diff --git
>>>> > > > a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>>>> > > b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>>>> > > > index 6b28896..828677e 100644
>>>> > > > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>>>> > > > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>>>> > > > @@ -4241,7 +4241,6 @@ static int
>>>> > > > vega10_dpm_force_dpm_level(struct
>>>> > > pp_hwmgr *hwmgr,
>>>> > > >                vega10_force_clock_level(hwmgr, PP_SCLK,
>>>> 1<<sclk_mask);
>>>> > > >                vega10_force_clock_level(hwmgr, PP_MCLK,
>>>> 1<<mclk_mask);
>>>> > > >                break;
>>>> > > > -     case AMD_DPM_FORCED_LEVEL_MANUAL:
>>>> > > >        case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
>>>> > > >        default:
>>>> > > >                break;
>>>> > > > @@ -4500,11 +4499,6 @@ static int
>>>> > > > vega10_force_clock_level(struct
>>>> > > pp_hwmgr *hwmgr,
>>>> > > >  {
>>>> > > >        struct vega10_hwmgr *data =3D (struct vega10_hwmgr
>>>> > > *)(hwmgr->backend);
>>>> > > >
>>>> > > > -     if (hwmgr->request_dpm_level & (AMD_DPM_FORCED_LEVEL_AUTO =
|
>>>> > > > -                             AMD_DPM_FORCED_LEVEL_LOW |
>>>> > > > -                             AMD_DPM_FORCED_LEVEL_HIGH))
>>>> > > > -             return -EINVAL;
>>>> > > > -
>>>> > > >        switch (type) {
>>>> > > >        case PP_SCLK:
>>>> > > >                data->smc_state_table.gfx_boot_level =3D mask ?
>>>> > > (ffs(mask) - 1) : 0;
>>>> > >
>>>> >
>>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>

--_000_CY4PR12MB16876AFDCAE195D8DF162F14FBE50CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Hi Alex,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">It's Ok,&nbsp;I got it.</p>
<div><span style=3D"font-size: 12pt;">Thanks.</span><br>
</div>
<div><span style=3D"font-size: 12pt;"><br>
</span></div>
<div><span style=3D"font-size: 12pt;"><br>
</span></div>
<div>Best Regards</div>
<div>Rex<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, January 30, 2018 6:26 AM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for power_dp=
m_force_performance_level</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Mon, Jan 29, 2018 at 4:51 PM, Zhu, Rex &lt;Rex.=
Zhu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;&gt;I'd prefer to keep the requirement to select manual mode to be able=
 to<br>
&gt;&gt;manually mess with the clock levels.&nbsp; This also makes simplifi=
es the<br>
&gt;&gt;profile interface by only allowing you to change the profile if you=
<br>
&gt;&gt;select manual mode first.&nbsp; That way we don't have to add an AU=
TO<br>
&gt;&gt;profile to the profile selection to let the driver pick the profile=
.<br>
&gt;&gt;that can happen automatically if the user sets the force_performanc=
e<br>
&gt;&gt;level to auto.<br>
&gt;<br>
&gt;<br>
&gt; Hi Alex=1B$B!$=1B(B<br>
&gt;<br>
&gt;<br>
&gt; so you mean use &quot;auto&quot;&nbsp; state of force_performance_leve=
 as reset mode to all<br>
&gt; the performance related sysfs.<br>
<br>
My thinking was that with force_performance_level set to auto, the<br>
driver will handle everything by itself.&nbsp; The driver would pick the<br=
>
power profile dynamically, all of the dpm states relevant to the power<br>
profiles would be enabled, etc.&nbsp; If the user selects manual in<br>
force_performance_level, then they can select which sclk/mclk/pcie dpm<br>
states are active as before, and now with the profile stuff, they can<br>
select either a predefined profile (video, vr, 3d, etc.) or a custom<br>
one.&nbsp; If they want to go back to automatic driver control, they just<b=
r>
switch force_performance_level back to auto.&nbsp; That way we have just<br=
>
one interface to control the behavior and there are fewer corner cases<br>
where features interact.&nbsp; Either select auto and let the driver handle=
<br>
it all, or select manual and tweak everything manually.<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt;<br>
&gt; Currently we just unfore the clock range in the auto state.<br>
&gt;<br>
&gt;<br>
&gt; Anyway, I will drop this patch.<br>
&gt;<br>
&gt;<br>
&gt; Best Regards<br>
&gt;<br>
&gt; Rex<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ________________________________<br>
&gt; From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; Sent: Tuesday, January 30, 2018 2:02 AM<br>
&gt;<br>
&gt; To: Zhu, Rex<br>
&gt; Cc: Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for<br>
&gt; power_dpm_force_performance_level<br>
&gt;<br>
&gt; On Mon, Jan 29, 2018 at 7:03 AM, Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt; wrot=
e:<br>
&gt;&gt; Hi Alex,<br>
&gt;&gt;<br>
&gt;&gt;&gt;How about we make the profile selection dependent on selecting =
the manual<br>
&gt;&gt;&gt; force_performance_level<br>
&gt;&gt;<br>
&gt;&gt; If so, we need to check pm.dpm.forced_level&nbsp; before &quot;pro=
file heuristics&quot;<br>
&gt;&gt; and &quot;disable power containment&quot; as same as pp_dpm_sclk/m=
clk/pcie.<br>
&gt;&gt;<br>
&gt;&gt; if (adev-&gt;pm.dpm.forced_level &amp; (AMD_DPM_FORCED_LEVEL_AUTO =
|<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LOW |<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH))<br=
>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;<br>
&gt;&gt; How about delete judging code before force_clock_level and just ch=
ange<br>
&gt;&gt; force_level to manual after force_clock_level. Please see the atta=
ched<br>
&gt;&gt; patch.<br>
&gt;&gt;<br>
&gt;&gt; This change have no impact on existing interface and tools.<br>
&gt;&gt; It just refine the logic of power_dpm_force_performance_level and<=
br>
&gt;&gt; pp_dpm_sclk/mclk/pcie.<br>
&gt;&gt; Also has no impact to power/computer profile mode on smu7.<br>
&gt;&gt;<br>
&gt;&gt; The difference is:<br>
&gt;&gt;<br>
&gt;&gt; New user can have one less command need to input if they want to u=
se<br>
&gt;&gt; pp_dpm_sclk/mclk/pcie.<br>
&gt;<br>
&gt; I'd prefer to keep the requirement to select manual mode to be able to=
<br>
&gt; manually mess with the clock levels.&nbsp; This also makes simplifies =
the<br>
&gt; profile interface by only allowing you to change the profile if you<br=
>
&gt; select manual mode first.&nbsp; That way we don't have to add an AUTO<=
br>
&gt; profile to the profile selection to let the driver pick the profile.<b=
r>
&gt; that can happen automatically if the user sets the force_performance<b=
r>
&gt; level to auto.<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Best Regards<br>
&gt;&gt; Rex<br>
&gt;&gt; -----Original Message-----<br>
&gt;&gt; From: Alex Deucher [<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailt=
o:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
&gt;&gt; Sent: Saturday, January 27, 2018 7:51 AM<br>
&gt;&gt; To: Zhu, Rex<br>
&gt;&gt; Cc: Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt; Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for<br>
&gt;&gt; power_dpm_force_performance_level<br>
&gt;&gt;<br>
&gt;&gt; I think we have two use cases for the profiles:<br>
&gt;&gt;<br>
&gt;&gt; 1. automatic profile switching for different driver use cases 2. m=
anually<br>
&gt;&gt; tweaking profiles/clocks/power for testing<br>
&gt;&gt;<br>
&gt;&gt; How about we make the profile selection dependent on selecting the=
 manual<br>
&gt;&gt; force_performance_level and not add an auto to the profile selecto=
r.&nbsp; Then<br>
&gt;&gt; when you select manual you can tweak the clocks and profile heuris=
tics and<br>
&gt;&gt; power containment via their respective knobs.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Jan 26, 2018 at 3:08 PM, Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt; =
wrote:<br>
&gt;&gt;&gt;&gt;Existing tools and users expect that switching back to auto=
 removes<br>
&gt;&gt;&gt;&gt;the manual clock settings. If you allow changing the clock =
in auto<br>
&gt;&gt;&gt;&gt;mode, that won't happen any more.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I have sent the patch v2 to fix this problem. user can swith b=
ack auto<br>
&gt;&gt;&gt; mode and all manual clock setting will be removed.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;One more reason why allowing the user to set pp_dpm_sckl/mc=
lk<br>
&gt;&gt;&gt;&gt;shouldn't be&nbsp; allowed in auto-mode.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; this is an old logic, maybe ref radeon driver.<br>
&gt;&gt;&gt; Driver can allow to set pp_dpm_sclk/mclk range in auto/high/lo=
w mode.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Best Regards<br>
&gt;&gt;&gt; Rex<br>
&gt;&gt;&gt; ________________________________<br>
&gt;&gt;&gt; From: Kuehling, Felix<br>
&gt;&gt;&gt; Sent: Saturday, January 27, 2018 3:32 AM<br>
&gt;&gt;&gt; To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt; Subject: Re: [PATCH 1/2] drm/amd/pp: Remove manual mode for<br=
>
&gt;&gt;&gt; power_dpm_force_performance_level<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 2018-01-26 02:20 PM, Zhu, Rex wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &gt;1. You're breaking the semantics of the existing pp_dp=
m_sclk/mclk/pcie<br>
&gt;&gt;&gt;&gt; &gt;&nbsp;&nbsp;&nbsp; interfaces, which affects existing =
tools<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Rex: I don't think the patch will affects existing tools.<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; User set &quot;manual&quot; to power_performance_level, an=
d then change the<br>
&gt;&gt;&gt;&gt; clock range through&nbsp; pp_dpm_sclk/mclk/pcie.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; with this patch, User dont need to set &quot;manual&quot; =
command,&nbsp; if still<br>
&gt;&gt;&gt;&gt; receive the manual command, driver just return sucess to u=
ser in<br>
&gt;&gt;&gt;&gt; order not&nbsp; break existing<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; tools.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Existing tools and users expect that switching back to auto re=
moves<br>
&gt;&gt;&gt; the manual clock settings. If you allow changing the clock in =
auto<br>
&gt;&gt;&gt; mode, that won't happen any more.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&nbsp; &gt;2. You're taking the clock limits out of the pow=
er profile.<br>
&gt;&gt;&gt;&gt;&nbsp; &gt;&nbsp; Automatically adjusting the minimum sclk/=
mclk is a requirement for<br>
&gt;&gt;&gt;&gt;&nbsp; &gt;&nbsp;&nbsp; the compute power profile<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Rex: In vega10, under default comput mode(with<br>
&gt;&gt;&gt;&gt; busy_set_point/fps/use_rlc_busy/min_active_level set), jus=
t two<br>
&gt;&gt;&gt;&gt; performance levels left<br>
&gt;&gt;&gt;&gt; (level0 and level7). and clock just switch between lowest =
and highest.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I am not sure in this case, driver still can set min sclk/=
mclk.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; One more reason why allowing the user to set pp_dpm_sckl/mclk<=
br>
&gt;&gt;&gt; shouldn't be allowed in auto-mode.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&nbsp;&nbsp; Felix<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Best Regards<br>
&gt;&gt;&gt;&gt; Rex<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ----------------------------------------------------------=
-----------<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt; *From:* Kuehling, Felix<br>
&gt;&gt;&gt;&gt; *Sent:* Saturday, January 27, 2018 12:49 AM<br>
&gt;&gt;&gt;&gt; *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt;&gt; *Subject:* Re: [PATCH 1/2] drm/amd/pp: Remove manual mode =
for<br>
&gt;&gt;&gt;&gt; power_dpm_force_performance_level<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Rex,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I think I understand what you're trying to do. To summariz=
e my<br>
&gt;&gt;&gt;&gt; concerns, there are two reasons I'm against your plan:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&nbsp; 1. You're breaking the semantics of the existing pp_=
dpm_sclk/mclk/pcie<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; interfaces, which affects existing=
 tools&nbsp; 2. You're taking the<br>
&gt;&gt;&gt;&gt; clock limits out of the power profile.<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Automatically adjusting the minimu=
m sclk/mclk is a requirement for<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; the compute power profile<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt;&nbsp;&nbsp; Felix<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 2018-01-26 07:50 AM, Zhu, Rex wrote:<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Hi Felix,<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt;That would make sense. But switching to manual mo=
de would disable<br>
&gt;&gt;&gt;&gt; &gt; &gt;profiles and automatic profile selection. That wa=
s one reason why<br>
&gt;&gt;&gt;&gt; &gt; &gt;I objected to your plan to control profile clock =
limits using<br>
&gt;&gt;&gt;&gt; &gt; &gt;these<br>
&gt;&gt;&gt;&gt; files.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Rex:<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; I am not very clear the old logic of gfx/compute powe=
r profile switch.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; But with new sysfs,<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; The logic is(those sysfs are independent)<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&nbsp; 1. configure uphyst/downhyst/min_ativity throug=
h<br>
&gt;&gt;&gt;&gt; &gt; power_profile_mode,<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2. adjust clock r=
ange through pp_dpm_sclk/mclk/pcie.(once<br>
&gt;&gt;&gt;&gt; &gt; this sysffs was called, set the dpm level mode to unk=
nown)<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. adjust power l=
imit through pp_od_power_limit(maybe equal<br>
&gt;&gt;&gt;&gt; &gt; to disable power containment).<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; In those functions, driver do not check the dpm level=
 mode.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; the dpm level mode just used by power_dpm_force_perfo=
rmance_level<br>
&gt;&gt;&gt;&gt; &gt; functions.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Best Regards<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Rex<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; -----------------------------------------------------=
--------------<br>
&gt;&gt;&gt;&gt; &gt; -----<br>
&gt;&gt;&gt;&gt; &gt; *From:* Kuehling, Felix<br>
&gt;&gt;&gt;&gt; &gt; *Sent:* Friday, January 26, 2018 8:26 AM<br>
&gt;&gt;&gt;&gt; &gt; *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt;&gt; &gt; *Subject:* Re: [PATCH 1/2] drm/amd/pp: Remove manual =
mode for<br>
&gt;&gt;&gt;&gt; &gt; power_dpm_force_performance_level<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; On 2018-01-25 07:07 PM, Zhu, Rex wrote:<br>
&gt;&gt;&gt;&gt; &gt; &gt; I also think about this problem.<br>
&gt;&gt;&gt;&gt; &gt; &gt; just think user should unforced clk level throug=
h pp dpm<br>
&gt;&gt;&gt;&gt; &gt; &gt; sclk/mclk/pcie if they change the clock logic th=
rough those sysfs.<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; The logic seems weird, As we supply many sysfs f=
or adjust clock<br>
&gt;&gt;&gt;&gt; &gt; &gt; range.<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; We can fix this problem by change current mode t=
o manual mode<br>
&gt;&gt;&gt;&gt; &gt; &gt; after user call pp dpm sclk/mclk/pcie.<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; But another think=1B$B!$=1B(Bif user change back=
 the clk range through pp<br>
&gt;&gt;&gt;&gt; &gt; &gt; dpm<br>
&gt;&gt;&gt;&gt; clk.<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; we are in manual mode, and user set auto mode, i=
n fact, driver<br>
&gt;&gt;&gt;&gt; &gt; &gt; change nothing.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; With profiles, switching back to auto mode would sele=
ct the<br>
&gt;&gt;&gt;&gt; &gt; appropriate profile, which may have a different clock=
 mask. For<br>
&gt;&gt;&gt;&gt; &gt; example for compute we enable only the highest two sc=
lk levels.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; Comparatively speaking, better set manual mode a=
fter user call pp<br>
&gt;&gt;&gt;&gt; &gt; dpm clk.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; That would make sense. But switching to manual mode w=
ould disable<br>
&gt;&gt;&gt;&gt; &gt; profiles and automatic profile selection. That was on=
e reason why I<br>
&gt;&gt;&gt;&gt; &gt; objected to your plan to control profile clock limits=
 using these<br>
&gt;&gt;&gt;&gt; &gt; files.<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; Regards,<br>
&gt;&gt;&gt;&gt; &gt;&nbsp;&nbsp; Felix<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; Thanks very much.<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; Best Regards<br>
&gt;&gt;&gt;&gt; &gt; &gt; Rex<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; ----------------------------------------------------------=
-----------<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt; &gt; &gt; *From:* Kuehling, Felix<br>
&gt;&gt;&gt;&gt; &gt; &gt; *Sent:* Friday, January 26, 2018 12:55:19 AM<br>
&gt;&gt;&gt;&gt; &gt; &gt; *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhu, Rex<br=
>
&gt;&gt;&gt;&gt; &gt; &gt; *Subject:* Re: [PATCH 1/2] drm/amd/pp: Remove ma=
nual mode for<br>
&gt;&gt;&gt;&gt; &gt; &gt; power_dpm_force_performance_level<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; This patch breaks unforcing of clocks, which is =
currently done by<br>
&gt;&gt;&gt;&gt; &gt; &gt; switching back from &quot;manual&quot; to &quot;=
auto&quot;. By removing &quot;manual&quot;<br>
&gt;&gt;&gt;&gt; &gt; &gt; mode, you remove the ability to unset forced clo=
cks.<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; Regards,<br>
&gt;&gt;&gt;&gt; &gt; &gt;&nbsp;&nbsp; Felix<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; On 2018-01-25 06:26 AM, Rex Zhu wrote:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; Driver do not maintain manual mode for<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; dpm_force_performance_level, User can set s=
clk/mclk/pcie range<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; through<br>
&gt;&gt;&gt;&gt; &gt; &gt; pp_dpm_sclk/pp_dpm_mclk/pp_dpm_pcie<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; directly.<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; In order to not break currently tools, when=
 set &quot;manual&quot; to<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; power_dpm_force_performance_level driver wi=
ll do nothing and<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; just return successful.<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; Change-Id: Iaf672b9abc7fa57b765ceb7fa2fba6a=
d3e80c50b<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&=
gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; ---<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.=
c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 3 &#43;--<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/ci_dpm.c&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; |&nbsp; 5 -----<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/include/kgd_pp_in=
terface.h&nbsp;&nbsp;&nbsp;&nbsp; | 15<br>
&gt;&gt;&gt;&gt; &gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;--------<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/c=
z_hwmgr.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 ----<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/r=
v_hwmgr.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 -<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/s=
mu7_hwmgr.c&nbsp;&nbsp; |&nbsp; 6 ------<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/v=
ega10_hwmgr.c |&nbsp; 6 ------<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; 7 files changed, 8 insertions(&#43;),=
 32 deletions(-)<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amd=
gpu_pm.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; index 1812009..66b4df0 100644<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.=
c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgp=
u/amdgpu_pm.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -152,7 &#43;152,6 @@ static ssize_t<br>
&gt;&gt;&gt;&gt; &gt; &gt; amdgpu_get_dpm_forced_performance_level(struct d=
evice *dev,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO) ?<br>
&gt;&gt;&gt;&gt; &quot;auto&quot; :<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (level =3D=3D AMD_DPM_FORCED_LEVEL_LOW) ? &quot;low&quo=
t;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; :<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (level =3D=3D AMD_DPM_FORCED_LEVEL_HIGH) ?<br>
&gt;&gt;&gt;&gt; &quot;high&quot; :<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; (level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) ?<br>
&gt;&gt;&gt;&gt; &gt; &gt; &quot;manual&quot; :<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (level =3D=3D<br>
&gt;&gt;&gt;&gt; &gt; &gt; AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD) ? &quot;p=
rofile_standard&quot; :<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (level =3D=3D<br>
&gt;&gt;&gt;&gt; &gt; &gt; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) ? &quot;p=
rofile_min_sclk&quot; :<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (level =3D=3D<br>
&gt;&gt;&gt;&gt; &gt; &gt; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) ? &quot;p=
rofile_min_mclk&quot; :<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -186,7 &#43;185,7 @@ static ssize_t<br>
&gt;&gt;&gt;&gt; &gt; &gt; amdgpu_set_dpm_forced_performance_level(struct d=
evice *dev,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
 else if (strncmp(&quot;auto&quot;, buf, strlen(&quot;auto&quot;)) =3D=3D 0=
) {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEV=
EL_AUTO;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
 else if (strncmp(&quot;manual&quot;, buf, strlen(&quot;manual&quot;)) =3D=
=3D 0) {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEVEL_MANUAL;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;No need to set manual mode=
, Just go<br>
&gt;&gt;&gt;&gt; ahead\n&quot;);<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
 else if (strncmp(&quot;profile_exit&quot;, buf,<br>
&gt;&gt;&gt;&gt; &gt; &gt; strlen(&quot;profile_exit&quot;)) =3D=3D 0) {<br=
>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; level =3D AMD_DPM_FORCED_LEV=
EL_PROFILE_EXIT;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
 else if (strncmp(&quot;profile_standard&quot;, buf,<br>
&gt;&gt;&gt;&gt; &gt; &gt; strlen(&quot;profile_standard&quot;)) =3D=3D 0) =
{<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/ci_=
dpm.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; index ab45232..8ddc978 100644<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<b=
r>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgp=
u/ci_dpm.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -6639,11 &#43;6639,6 @@ static int ci_dp=
m_force_clock_level(void<br>
&gt;&gt;&gt;&gt; &gt; *handle,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct amdgpu_device *adev =3D (struct amdgpu_device<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; *)handle;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct ci_power_info *pi =3D ci_get_pi(adev);<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.d=
pm.forced_level &amp; (AMD_DPM_FORCED_LEVEL_AUTO |<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LO=
W |<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HI=
GH))<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
witch (type) {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ase PP_SCLK:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pi-&gt;sclk_dpm_key_dis=
abled) diff --git<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; a/drivers/gpu/drm/amd/include/kgd_pp_interf=
ace.h<br>
&gt;&gt;&gt;&gt; &gt; &gt; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h=
<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; index b9aa9f4..3fab686 100644<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_in=
terface.h<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/inclu=
de/kgd_pp_interface.h<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -41,14 &#43;41,13 @@ struct amd_vce_stat=
e {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; enum amd_dpm_forced_level {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MD_DPM_FORCED_LEVEL_AUTO =3D 0x1,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LE=
VEL_MANUAL =3D 0x2,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LE=
VEL_LOW =3D 0x4,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LE=
VEL_HIGH =3D 0x8,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LE=
VEL_PROFILE_STANDARD =3D 0x10,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LE=
VEL_PROFILE_MIN_SCLK =3D 0x20,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LE=
VEL_PROFILE_MIN_MCLK =3D 0x40,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LE=
VEL_PROFILE_PEAK =3D 0x80,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LE=
VEL_PROFILE_EXIT =3D 0x100,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCE=
D_LEVEL_LOW =3D 0x2,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCE=
D_LEVEL_HIGH =3D 0x4,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCE=
D_LEVEL_PROFILE_STANDARD =3D 0x8,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCE=
D_LEVEL_PROFILE_MIN_SCLK =3D 0x10,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCE=
D_LEVEL_PROFILE_MIN_MCLK =3D 0x20,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCE=
D_LEVEL_PROFILE_PEAK =3D 0x40,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCE=
D_LEVEL_PROFILE_EXIT =3D 0x80,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; };<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; enum amd_pm_state_type {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/=
hwmgr/cz_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c=
<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; index dec8dd9..60d280c 100644<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/c=
z_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/power=
play/hwmgr/cz_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -1250,7 &#43;1250,6 @@ static int cz_dpm=
_force_dpm_level(struct<br>
&gt;&gt;&gt;&gt; &gt; &gt; pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ase AMD_DPM_FORCED_LEVEL_AUTO:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D cz_phm_unforce_dpm_l=
evels(hwmgr);<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORC=
ED_LEVEL_MANUAL:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ase AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
efault:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -1558,9 &#43;1557,6 @@ static int cz_get=
_dal_power_level(struct<br>
&gt;&gt;&gt;&gt; &gt; &gt; pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; static int cz_force_clock_level(struc=
t pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type, uin=
t32_t mask)&nbsp; {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm=
_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
witch (type) {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ase PP_SCLK:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc_with_pa=
rameter(hwmgr,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/=
hwmgr/rv_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c=
<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; index 409a56b..eddcbcd 100644<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/r=
v_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/power=
play/hwmgr/rv_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -605,7 &#43;605,6 @@ static int rv_dpm_f=
orce_dpm_level(struct<br>
&gt;&gt;&gt;&gt; &gt; &gt; pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; PPSMC_MSG_SetSoftMaxFclkByFreq,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; RAVEN_UMD_PSTATE_MIN_FCLK);<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORC=
ED_LEVEL_MANUAL:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ase AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
efault:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/=
hwmgr/smu7_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr=
.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; index 13db75c..e3a8374 100644<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/s=
mu7_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/power=
play/hwmgr/smu7_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -2798,7 &#43;2798,6 @@ static int smu7_f=
orce_dpm_level(struct<br>
&gt;&gt;&gt;&gt; &gt; &gt; pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_force_clock_level(hwmgr=
, PP_MCLK,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; 1&lt;&lt;mclk_mask);<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_force_clock_level(hwmgr=
, PP_PCIE,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; 1&lt;&lt;pcie_mask);<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORC=
ED_LEVEL_MANUAL:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ase AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
efault:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -4311,11 &#43;4310,6 @@ static int smu7_=
force_clock_level(struct<br>
&gt;&gt;&gt;&gt; &gt; &gt; pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct smu7_hwmgr *data =3D (struct smu7_hwmgr<br>
&gt;&gt;&gt;&gt; &gt; *)(hwmgr-&gt;backend);<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;req=
uest_dpm_level &amp; (AMD_DPM_FORCED_LEVEL_AUTO |<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LOW |<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HIGH))<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
witch (type) {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ase PP_SCLK:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;sclk_dpm_key_d=
isabled) diff --git<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; a/drivers/gpu/drm/amd/powerplay/hwmgr/vega1=
0_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwm=
gr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; index 6b28896..828677e 100644<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/v=
ega10_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/power=
play/hwmgr/vega10_hwmgr.c<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -4241,7 &#43;4241,6 @@ static int<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; vega10_dpm_force_dpm_level(struct<br>
&gt;&gt;&gt;&gt; &gt; &gt; pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_force_clock_level(hwm=
gr, PP_SCLK,<br>
&gt;&gt;&gt;&gt; 1&lt;&lt;sclk_mask);<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_force_clock_level(hwm=
gr, PP_MCLK,<br>
&gt;&gt;&gt;&gt; 1&lt;&lt;mclk_mask);<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORC=
ED_LEVEL_MANUAL:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ase AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
efault:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; @@ -4500,11 &#43;4499,6 @@ static int<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; vega10_force_clock_level(struct<br>
&gt;&gt;&gt;&gt; &gt; &gt; pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp; {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct vega10_hwmgr *data =3D (struct vega10_hwmgr<br>
&gt;&gt;&gt;&gt; &gt; &gt; *)(hwmgr-&gt;backend);<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;req=
uest_dpm_level &amp; (AMD_DPM_FORCED_LEVEL_AUTO |<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_LO=
W |<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_DPM_FORCED_LEVEL_HI=
GH))<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt; -<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
witch (type) {<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
ase PP_SCLK:<br>
&gt;&gt;&gt;&gt; &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smc_state_table.gfx=
_boot_level =3D mask ?<br>
&gt;&gt;&gt;&gt; &gt; &gt; (ffs(mask) - 1) : 0;<br>
&gt;&gt;&gt;&gt; &gt; &gt;<br>
&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;&gt;&gt;<br>
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16876AFDCAE195D8DF162F14FBE50CY4PR12MB1687namp_--

--===============0401585917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0401585917==--
