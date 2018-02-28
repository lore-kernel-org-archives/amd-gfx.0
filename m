From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Revert gfx/compute profile switch sysfs
Date: Wed, 28 Feb 2018 12:43:05 +0000
Message-ID: <CY4PR12MB16878777B1924926E2F48BB8FBC70@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1519730509-6709-1-git-send-email-Rex.Zhu@amd.com>
 <CADnq5_N-Uu0Ztcjv0+-KSBYr=CfQ9DHH14YC5xVg0NMxrA3_RQ@mail.gmail.com>
 <d8e2c5f0-f5d3-a2d4-642f-fdb257f9b92e@amd.com>
 <2f99eee4-611c-6b1d-0766-61000627aedf@amd.com>
 <CADnq5_OArNM0-WJ3oksmgmz8iVKzHf0MFbnTfTd50WVVVtJNkg@mail.gmail.com>
 <a0437314-2152-db81-2293-9d883148a1a7@amd.com>,
 <CY4PR12MB1687ED25339F7A5B6ABCC9D6FBC70@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1130802473=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687ED25339F7A5B6ABCC9D6FBC70-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>
Cc: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1130802473==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16878777B1924926E2F48BB8FBC70CY4PR12MB1687namp_"

--_000_CY4PR12MB16878777B1924926E2F48BB8FBC70CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>When compute ring begin, if we just fix sclk in level7 directly, ,
>Is there any difference in performance or performance in watt, compared to=
 set compute profile mode (include apply min sclk to level6)?

I think the expected result is:


performance similar,  and performance in watt: fixed in level7 < compute pr=
ofile setting.


Best Regards

Rex



________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhu, Rex=
 <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, February 28, 2018 7:08 PM
To: Kuehling, Felix; Alex Deucher; Huang, JinHuiEric
Cc: Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH] drm/amd/pp: Revert gfx/compute profile switch sysfs

I went through the power profiling feature in windows - Auto Wattman suppor=
ted on Polaris and Vega. Initially apply to Polaris.

The Goal is to maximize performance/watt without impacting performance and =
no visual impact per system/use case

On smu7, 3 parameters control how SMU responds to sclk/mclk activity, up/do=
wn hysteresis and activity threshold.

My understanding is:
When sclk_activity large than threshold, adjust uphyst/downhyst/activity th=
reshold to go higher dpm level more faster or stay in higher dpm level long=
er for boost performance.
Otherwise, for power saving.

Those parameters were used to change the behavior of dpm switching for perf=
ormance in watt. So we wish to add an independent sysfs to configure them.

When this feature enabled, the performance in watt is improved in most case=
(low activity and Multimedia) from pplib's test. I do not find compute test=
 result.

So there is a question:

When compute ring begin, if we just fix sclk in level7 directly, ,
Is there any difference in performance or performance in watt, compared to =
set compute profile mode (include apply min sclk to level6)?


Best Regards
Rex





-----Original Message-----
From: Kuehling, Felix
Sent: Wednesday, February 28, 2018 2:55 AM
To: Alex Deucher; Huang, JinHuiEric
Cc: Zhu, Rex; Russell, Kent; amd-gfx list
Subject: Re: [PATCH] drm/amd/pp: Revert gfx/compute profile switch sysfs

On 2018-02-27 11:27 AM, Alex Deucher wrote:
> On Tue, Feb 27, 2018 at 11:22 AM, Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org> w=
rote:
>> As I mentioned in code review for new power profile, old gfx/compute pow=
er
>> profile have two scenarios for auto switching. One is
>> gfx->compute(default)->gfx and other is gfx->compute(custom)->gfx. New p=
ower
>> profile only satisfies first one, but in second one for user debugging, =
user
>> setting of power profile will be over-written when switching to compute
>> profile.
> For debugging, the idea would be to select manual mode via
> force_performance_level and then force a profile via sysfs.  If manual
> mode was selected, none of the automatic profile changing would
> happen.  Is that adequate or do you need the automatic switching even
> with a custom profile?

It would result in higher power consumption while no compute work is
running by applying minimum clocks (if that's still part of the
profile). If minimum clock is not part of the profile, then that's
another major regression for us.

I would prefer to add the ability to tweak all the power profiles so we
can have workload-specific customization, not just for compute. Maybe
that's something we can add later.

Regards,
  Felix

>
> Alex
>
>
>> Regards,
>> Eric
>>
>> On 2018-02-27 10:52 AM, Felix Kuehling wrote:
>>> [+Eric]
>>>
>>> Compute profile switching code as well as KFD compute support for most
>>> GPUs is not upstream yet. As such, there is probably no requirement
>>> (yet) to keep the compute profile API stable, that we added specificall=
y
>>> for KFD. Once we are upstream that will change.
>>>
>>> If you change it now, we'll have to adapt, like we have often done.
>>>
>>> I'll let Eric comment on whether the new power profile code and API is
>>> an adequate replacement from a functionality perspective. Eric, Kent,
>>> have we done any testing with Rex's new profile code?
>>>
>>> Regards,
>>>    Felix
>>>
>>>
>>> On 2018-02-27 10:41 AM, Alex Deucher wrote:
>>>> + Kent and Felix for comment
>>>>
>>>> On Tue, Feb 27, 2018 at 6:21 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
>>>>> The gfx/compute profiling mode switch is only for internally
>>>>> test. Not a complete solution and unexpectly upstream.
>>>>> so revert it.
>>>>>
>>>>> Change-Id: I1af1b64a63b6fc12c24cf73df03b083b3661ca02
>>>>> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |   8 -
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             | 180
>>>>> ---------------
>>>>>   drivers/gpu/drm/amd/amdgpu/ci_dpm.c                | 256
>>>>> ---------------------
>>>>>   drivers/gpu/drm/amd/amdgpu/ci_dpm.h                |   7 -
>>>>>   drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   7 -
>>>>>   drivers/gpu/drm/amd/powerplay/amd_powerplay.c      | 114 ---------
>>>>>   .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c  |  17 --
>>>>>   drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       |   2 -
>>>>>   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  84 -------
>>>>>   drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  86 -------
>>>>>   .../gpu/drm/amd/powerplay/inc/hardwaremanager.h    |   1 -
>>>>>   drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |   9 -
>>>>>   drivers/gpu/drm/amd/powerplay/inc/smumgr.h         |   3 -
>>>>>   drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c   |  27 ---
>>>>>   drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c |  66 ------
>>>>>   .../drm/amd/powerplay/smumgr/polaris10_smumgr.c    |  64 ------
>>>>>   drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c      |  10 -
>>>>>   .../gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c    |  64 ------
>>>>>   18 files changed, 1005 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>>>> index bd745a4..9c373f8f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
>>>>> @@ -341,14 +341,6 @@ enum amdgpu_pcie_gen {
>>>>>
>>>>> ((adev)->powerplay.pp_funcs->reset_power_profile_state(\
>>>>>                          (adev)->powerplay.pp_handle, request))
>>>>>
>>>>> -#define amdgpu_dpm_get_power_profile_state(adev, query) \
>>>>> -               ((adev)->powerplay.pp_funcs->get_power_profile_state(=
\
>>>>> -                       (adev)->powerplay.pp_handle, query))
>>>>> -
>>>>> -#define amdgpu_dpm_set_power_profile_state(adev, request) \
>>>>> -               ((adev)->powerplay.pp_funcs->set_power_profile_state(=
\
>>>>> -                       (adev)->powerplay.pp_handle, request))
>>>>> -
>>>>>   #define amdgpu_dpm_switch_power_profile(adev, type) \
>>>>>                  ((adev)->powerplay.pp_funcs->switch_power_profile(\
>>>>>                          (adev)->powerplay.pp_handle, type))
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>>>> index 9e73cbc..632b186 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
>>>>> @@ -734,161 +734,6 @@ static ssize_t
>>>>> amdgpu_set_pp_power_profile_mode(struct device *dev,
>>>>>          return -EINVAL;
>>>>>   }
>>>>>
>>>>> -static ssize_t amdgpu_get_pp_power_profile(struct device *dev,
>>>>> -               char *buf, struct amd_pp_profile *query)
>>>>> -{
>>>>> -       struct drm_device *ddev =3D dev_get_drvdata(dev);
>>>>> -       struct amdgpu_device *adev =3D ddev->dev_private;
>>>>> -       int ret =3D 0xff;
>>>>> -
>>>>> -       if (adev->powerplay.pp_funcs->get_power_profile_state)
>>>>> -               ret =3D amdgpu_dpm_get_power_profile_state(
>>>>> -                               adev, query);
>>>>> -
>>>>> -       if (ret)
>>>>> -               return ret;
>>>>> -
>>>>> -       return snprintf(buf, PAGE_SIZE,
>>>>> -                       "%d %d %d %d %d\n",
>>>>> -                       query->min_sclk / 100,
>>>>> -                       query->min_mclk / 100,
>>>>> -                       query->activity_threshold,
>>>>> -                       query->up_hyst,
>>>>> -                       query->down_hyst);
>>>>> -}
>>>>> -
>>>>> -static ssize_t amdgpu_get_pp_gfx_power_profile(struct device *dev,
>>>>> -               struct device_attribute *attr,
>>>>> -               char *buf)
>>>>> -{
>>>>> -       struct amd_pp_profile query =3D {0};
>>>>> -
>>>>> -       query.type =3D AMD_PP_GFX_PROFILE;
>>>>> -
>>>>> -       return amdgpu_get_pp_power_profile(dev, buf, &query);
>>>>> -}
>>>>> -
>>>>> -static ssize_t amdgpu_get_pp_compute_power_profile(struct device *de=
v,
>>>>> -               struct device_attribute *attr,
>>>>> -               char *buf)
>>>>> -{
>>>>> -       struct amd_pp_profile query =3D {0};
>>>>> -
>>>>> -       query.type =3D AMD_PP_COMPUTE_PROFILE;
>>>>> -
>>>>> -       return amdgpu_get_pp_power_profile(dev, buf, &query);
>>>>> -}
>>>>> -
>>>>> -static ssize_t amdgpu_set_pp_power_profile(struct device *dev,
>>>>> -               const char *buf,
>>>>> -               size_t count,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct drm_device *ddev =3D dev_get_drvdata(dev);
>>>>> -       struct amdgpu_device *adev =3D ddev->dev_private;
>>>>> -       uint32_t loop =3D 0;
>>>>> -       char *sub_str, buf_cpy[128], *tmp_str;
>>>>> -       const char delimiter[3] =3D {' ', '\n', '\0'};
>>>>> -       long int value;
>>>>> -       int ret =3D 0xff;
>>>>> -
>>>>> -       if (strncmp("reset", buf, strlen("reset")) =3D=3D 0) {
>>>>> -               if (adev->powerplay.pp_funcs->reset_power_profile_sta=
te)
>>>>> -                       ret =3D amdgpu_dpm_reset_power_profile_state(
>>>>> -                                       adev, request);
>>>>> -               if (ret) {
>>>>> -                       count =3D -EINVAL;
>>>>> -                       goto fail;
>>>>> -               }
>>>>> -               return count;
>>>>> -       }
>>>>> -
>>>>> -       if (strncmp("set", buf, strlen("set")) =3D=3D 0) {
>>>>> -               if (adev->powerplay.pp_funcs->set_power_profile_state=
)
>>>>> -                       ret =3D amdgpu_dpm_set_power_profile_state(
>>>>> -                                       adev, request);
>>>>> -
>>>>> -               if (ret) {
>>>>> -                       count =3D -EINVAL;
>>>>> -                       goto fail;
>>>>> -               }
>>>>> -               return count;
>>>>> -       }
>>>>> -
>>>>> -       if (count + 1 >=3D 128) {
>>>>> -               count =3D -EINVAL;
>>>>> -               goto fail;
>>>>> -       }
>>>>> -
>>>>> -       memcpy(buf_cpy, buf, count + 1);
>>>>> -       tmp_str =3D buf_cpy;
>>>>> -
>>>>> -       while (tmp_str[0]) {
>>>>> -               sub_str =3D strsep(&tmp_str, delimiter);
>>>>> -               ret =3D kstrtol(sub_str, 0, &value);
>>>>> -               if (ret) {
>>>>> -                       count =3D -EINVAL;
>>>>> -                       goto fail;
>>>>> -               }
>>>>> -
>>>>> -               switch (loop) {
>>>>> -               case 0:
>>>>> -                       /* input unit MHz convert to dpm table unit
>>>>> 10KHz*/
>>>>> -                       request->min_sclk =3D (uint32_t)value * 100;
>>>>> -                       break;
>>>>> -               case 1:
>>>>> -                       /* input unit MHz convert to dpm table unit
>>>>> 10KHz*/
>>>>> -                       request->min_mclk =3D (uint32_t)value * 100;
>>>>> -                       break;
>>>>> -               case 2:
>>>>> -                       request->activity_threshold =3D (uint16_t)val=
ue;
>>>>> -                       break;
>>>>> -               case 3:
>>>>> -                       request->up_hyst =3D (uint8_t)value;
>>>>> -                       break;
>>>>> -               case 4:
>>>>> -                       request->down_hyst =3D (uint8_t)value;
>>>>> -                       break;
>>>>> -               default:
>>>>> -                       break;
>>>>> -               }
>>>>> -
>>>>> -               loop++;
>>>>> -       }
>>>>> -       if (adev->powerplay.pp_funcs->set_power_profile_state)
>>>>> -               ret =3D amdgpu_dpm_set_power_profile_state(adev, requ=
est);
>>>>> -
>>>>> -       if (ret)
>>>>> -               count =3D -EINVAL;
>>>>> -
>>>>> -fail:
>>>>> -       return count;
>>>>> -}
>>>>> -
>>>>> -static ssize_t amdgpu_set_pp_gfx_power_profile(struct device *dev,
>>>>> -               struct device_attribute *attr,
>>>>> -               const char *buf,
>>>>> -               size_t count)
>>>>> -{
>>>>> -       struct amd_pp_profile request =3D {0};
>>>>> -
>>>>> -       request.type =3D AMD_PP_GFX_PROFILE;
>>>>> -
>>>>> -       return amdgpu_set_pp_power_profile(dev, buf, count, &request)=
;
>>>>> -}
>>>>> -
>>>>> -static ssize_t amdgpu_set_pp_compute_power_profile(struct device *de=
v,
>>>>> -               struct device_attribute *attr,
>>>>> -               const char *buf,
>>>>> -               size_t count)
>>>>> -{
>>>>> -       struct amd_pp_profile request =3D {0};
>>>>> -
>>>>> -       request.type =3D AMD_PP_COMPUTE_PROFILE;
>>>>> -
>>>>> -       return amdgpu_set_pp_power_profile(dev, buf, count, &request)=
;
>>>>> -}
>>>>> -
>>>>>   static DEVICE_ATTR(power_dpm_state, S_IRUGO | S_IWUSR,
>>>>> amdgpu_get_dpm_state, amdgpu_set_dpm_state);
>>>>>   static DEVICE_ATTR(power_dpm_force_performance_level, S_IRUGO |
>>>>> S_IWUSR,
>>>>>                     amdgpu_get_dpm_forced_performance_level,
>>>>> @@ -916,12 +761,6 @@ static DEVICE_ATTR(pp_sclk_od, S_IRUGO | S_IWUSR=
,
>>>>>   static DEVICE_ATTR(pp_mclk_od, S_IRUGO | S_IWUSR,
>>>>>                  amdgpu_get_pp_mclk_od,
>>>>>                  amdgpu_set_pp_mclk_od);
>>>>> -static DEVICE_ATTR(pp_gfx_power_profile, S_IRUGO | S_IWUSR,
>>>>> -               amdgpu_get_pp_gfx_power_profile,
>>>>> -               amdgpu_set_pp_gfx_power_profile);
>>>>> -static DEVICE_ATTR(pp_compute_power_profile, S_IRUGO | S_IWUSR,
>>>>> -               amdgpu_get_pp_compute_power_profile,
>>>>> -               amdgpu_set_pp_compute_power_profile);
>>>>>   static DEVICE_ATTR(pp_power_profile_mode, S_IRUGO | S_IWUSR,
>>>>>                  amdgpu_get_pp_power_profile_mode,
>>>>>                  amdgpu_set_pp_power_profile_mode);
>>>>> @@ -1767,21 +1606,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device
>>>>> *adev)
>>>>>                  return ret;
>>>>>          }
>>>>>          ret =3D device_create_file(adev->dev,
>>>>> -                       &dev_attr_pp_gfx_power_profile);
>>>>> -       if (ret) {
>>>>> -               DRM_ERROR("failed to create device file "
>>>>> -                               "pp_gfx_power_profile\n");
>>>>> -               return ret;
>>>>> -       }
>>>>> -       ret =3D device_create_file(adev->dev,
>>>>> -                       &dev_attr_pp_compute_power_profile);
>>>>> -       if (ret) {
>>>>> -               DRM_ERROR("failed to create device file "
>>>>> -                               "pp_compute_power_profile\n");
>>>>> -               return ret;
>>>>> -       }
>>>>> -
>>>>> -       ret =3D device_create_file(adev->dev,
>>>>>                          &dev_attr_pp_power_profile_mode);
>>>>>          if (ret) {
>>>>>                  DRM_ERROR("failed to create device file "
>>>>> @@ -1827,10 +1651,6 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device
>>>>> *adev)
>>>>>          device_remove_file(adev->dev, &dev_attr_pp_sclk_od);
>>>>>          device_remove_file(adev->dev, &dev_attr_pp_mclk_od);
>>>>>          device_remove_file(adev->dev,
>>>>> -                       &dev_attr_pp_gfx_power_profile);
>>>>> -       device_remove_file(adev->dev,
>>>>> -                       &dev_attr_pp_compute_power_profile);
>>>>> -       device_remove_file(adev->dev,
>>>>>                          &dev_attr_pp_power_profile_mode);
>>>>>          device_remove_file(adev->dev,
>>>>>                          &dev_attr_pp_od_clk_voltage);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>>> index f82f40f..ddb814f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>>> @@ -3695,40 +3695,6 @@ static int ci_find_boot_level(struct
>>>>> ci_single_dpm_table *table,
>>>>>          return ret;
>>>>>   }
>>>>>
>>>>> -static void ci_save_default_power_profile(struct amdgpu_device *adev=
)
>>>>> -{
>>>>> -       struct ci_power_info *pi =3D ci_get_pi(adev);
>>>>> -       struct SMU7_Discrete_GraphicsLevel *levels =3D
>>>>> -                               pi->smc_state_table.GraphicsLevel;
>>>>> -       uint32_t min_level =3D 0;
>>>>> -
>>>>> -       pi->default_gfx_power_profile.activity_threshold =3D
>>>>> -                       be16_to_cpu(levels[0].ActivityLevel);
>>>>> -       pi->default_gfx_power_profile.up_hyst =3D levels[0].UpH;
>>>>> -       pi->default_gfx_power_profile.down_hyst =3D levels[0].DownH;
>>>>> -       pi->default_gfx_power_profile.type =3D AMD_PP_GFX_PROFILE;
>>>>> -
>>>>> -       pi->default_compute_power_profile =3D
>>>>> pi->default_gfx_power_profile;
>>>>> -       pi->default_compute_power_profile.type =3D AMD_PP_COMPUTE_PRO=
FILE;
>>>>> -
>>>>> -       /* Optimize compute power profile: Use only highest
>>>>> -        * 2 power levels (if more than 2 are available), Hysteresis:
>>>>> -        * 0ms up, 5ms down
>>>>> -        */
>>>>> -       if (pi->smc_state_table.GraphicsDpmLevelCount > 2)
>>>>> -               min_level =3D pi->smc_state_table.GraphicsDpmLevelCou=
nt -
>>>>> 2;
>>>>> -       else if (pi->smc_state_table.GraphicsDpmLevelCount =3D=3D 2)
>>>>> -               min_level =3D 1;
>>>>> -       pi->default_compute_power_profile.min_sclk =3D
>>>>> -                       be32_to_cpu(levels[min_level].SclkFrequency);
>>>>> -
>>>>> -       pi->default_compute_power_profile.up_hyst =3D 0;
>>>>> -       pi->default_compute_power_profile.down_hyst =3D 5;
>>>>> -
>>>>> -       pi->gfx_power_profile =3D pi->default_gfx_power_profile;
>>>>> -       pi->compute_power_profile =3D pi->default_compute_power_profi=
le;
>>>>> -}
>>>>> -
>>>>>   static int ci_init_smc_table(struct amdgpu_device *adev)
>>>>>   {
>>>>>          struct ci_power_info *pi =3D ci_get_pi(adev);
>>>>> @@ -3874,8 +3840,6 @@ static int ci_init_smc_table(struct amdgpu_devi=
ce
>>>>> *adev)
>>>>>          if (ret)
>>>>>                  return ret;
>>>>>
>>>>> -       ci_save_default_power_profile(adev);
>>>>> -
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> @@ -6753,222 +6717,6 @@ static int ci_dpm_set_mclk_od(void *handle,
>>>>> uint32_t value)
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> -static int ci_dpm_get_power_profile_state(void *handle,
>>>>> -               struct amd_pp_profile *query)
>>>>> -{
>>>>> -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle=
;
>>>>> -       struct ci_power_info *pi =3D ci_get_pi(adev);
>>>>> -
>>>>> -       if (!pi || !query)
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       if (query->type =3D=3D AMD_PP_GFX_PROFILE)
>>>>> -               memcpy(query, &pi->gfx_power_profile,
>>>>> -                               sizeof(struct amd_pp_profile));
>>>>> -       else if (query->type =3D=3D AMD_PP_COMPUTE_PROFILE)
>>>>> -               memcpy(query, &pi->compute_power_profile,
>>>>> -                               sizeof(struct amd_pp_profile));
>>>>> -       else
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       return 0;
>>>>> -}
>>>>> -
>>>>> -static int ci_populate_requested_graphic_levels(struct amdgpu_device
>>>>> *adev,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct ci_power_info *pi =3D ci_get_pi(adev);
>>>>> -       struct ci_dpm_table *dpm_table =3D &(pi->dpm_table);
>>>>> -       struct SMU7_Discrete_GraphicsLevel *levels =3D
>>>>> -                       pi->smc_state_table.GraphicsLevel;
>>>>> -       uint32_t array =3D pi->dpm_table_start +
>>>>> -                       offsetof(SMU7_Discrete_DpmTable, GraphicsLeve=
l);
>>>>> -       uint32_t array_size =3D sizeof(struct SMU7_Discrete_GraphicsL=
evel)
>>>>> *
>>>>> -                       SMU7_MAX_LEVELS_GRAPHICS;
>>>>> -       uint32_t i;
>>>>> -
>>>>> -       for (i =3D 0; i < dpm_table->sclk_table.count; i++) {
>>>>> -               levels[i].ActivityLevel =3D
>>>>> -
>>>>> cpu_to_be16(request->activity_threshold);
>>>>> -               levels[i].EnabledForActivity =3D 1;
>>>>> -               levels[i].UpH =3D request->up_hyst;
>>>>> -               levels[i].DownH =3D request->down_hyst;
>>>>> -       }
>>>>> -
>>>>> -       return amdgpu_ci_copy_bytes_to_smc(adev, array, (uint8_t
>>>>> *)levels,
>>>>> -                               array_size, pi->sram_end);
>>>>> -}
>>>>> -
>>>>> -static void ci_find_min_clock_masks(struct amdgpu_device *adev,
>>>>> -               uint32_t *sclk_mask, uint32_t *mclk_mask,
>>>>> -               uint32_t min_sclk, uint32_t min_mclk)
>>>>> -{
>>>>> -       struct ci_power_info *pi =3D ci_get_pi(adev);
>>>>> -       struct ci_dpm_table *dpm_table =3D &(pi->dpm_table);
>>>>> -       uint32_t i;
>>>>> -
>>>>> -       for (i =3D 0; i < dpm_table->sclk_table.count; i++) {
>>>>> -               if (dpm_table->sclk_table.dpm_levels[i].enabled &&
>>>>> -                       dpm_table->sclk_table.dpm_levels[i].value >=
=3D
>>>>> min_sclk)
>>>>> -                       *sclk_mask |=3D 1 << i;
>>>>> -       }
>>>>> -
>>>>> -       for (i =3D 0; i < dpm_table->mclk_table.count; i++) {
>>>>> -               if (dpm_table->mclk_table.dpm_levels[i].enabled &&
>>>>> -                       dpm_table->mclk_table.dpm_levels[i].value >=
=3D
>>>>> min_mclk)
>>>>> -                       *mclk_mask |=3D 1 << i;
>>>>> -       }
>>>>> -}
>>>>> -
>>>>> -static int ci_set_power_profile_state(struct amdgpu_device *adev,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct ci_power_info *pi =3D ci_get_pi(adev);
>>>>> -       int tmp_result, result =3D 0;
>>>>> -       uint32_t sclk_mask =3D 0, mclk_mask =3D 0;
>>>>> -
>>>>> -       tmp_result =3D ci_freeze_sclk_mclk_dpm(adev);
>>>>> -       if (tmp_result) {
>>>>> -               DRM_ERROR("Failed to freeze SCLK MCLK DPM!");
>>>>> -               result =3D tmp_result;
>>>>> -       }
>>>>> -
>>>>> -       tmp_result =3D ci_populate_requested_graphic_levels(adev,
>>>>> -                       request);
>>>>> -       if (tmp_result) {
>>>>> -               DRM_ERROR("Failed to populate requested graphic
>>>>> levels!");
>>>>> -               result =3D tmp_result;
>>>>> -       }
>>>>> -
>>>>> -       tmp_result =3D ci_unfreeze_sclk_mclk_dpm(adev);
>>>>> -       if (tmp_result) {
>>>>> -               DRM_ERROR("Failed to unfreeze SCLK MCLK DPM!");
>>>>> -               result =3D tmp_result;
>>>>> -       }
>>>>> -
>>>>> -       ci_find_min_clock_masks(adev, &sclk_mask, &mclk_mask,
>>>>> -                       request->min_sclk, request->min_mclk);
>>>>> -
>>>>> -       if (sclk_mask) {
>>>>> -               if (!pi->sclk_dpm_key_disabled)
>>>>> -                       amdgpu_ci_send_msg_to_smc_with_parameter(
>>>>> -                               adev,
>>>>> -                               PPSMC_MSG_SCLKDPM_SetEnabledMask,
>>>>> -                               pi->dpm_level_enable_mask.
>>>>> -                               sclk_dpm_enable_mask &
>>>>> -                               sclk_mask);
>>>>> -       }
>>>>> -
>>>>> -       if (mclk_mask) {
>>>>> -               if (!pi->mclk_dpm_key_disabled)
>>>>> -                       amdgpu_ci_send_msg_to_smc_with_parameter(
>>>>> -                               adev,
>>>>> -                               PPSMC_MSG_MCLKDPM_SetEnabledMask,
>>>>> -                               pi->dpm_level_enable_mask.
>>>>> -                               mclk_dpm_enable_mask &
>>>>> -                               mclk_mask);
>>>>> -       }
>>>>> -
>>>>> -
>>>>> -       return result;
>>>>> -}
>>>>> -
>>>>> -static int ci_dpm_set_power_profile_state(void *handle,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle=
;
>>>>> -       struct ci_power_info *pi =3D ci_get_pi(adev);
>>>>> -       int ret =3D -1;
>>>>> -
>>>>> -       if (!pi || !request)
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       if (adev->pm.dpm.forced_level !=3D
>>>>> -                       AMD_DPM_FORCED_LEVEL_AUTO)
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       if (request->min_sclk ||
>>>>> -               request->min_mclk ||
>>>>> -               request->activity_threshold ||
>>>>> -               request->up_hyst ||
>>>>> -               request->down_hyst) {
>>>>> -               if (request->type =3D=3D AMD_PP_GFX_PROFILE)
>>>>> -                       memcpy(&pi->gfx_power_profile, request,
>>>>> -                                       sizeof(struct amd_pp_profile)=
);
>>>>> -               else if (request->type =3D=3D AMD_PP_COMPUTE_PROFILE)
>>>>> -                       memcpy(&pi->compute_power_profile, request,
>>>>> -                                       sizeof(struct amd_pp_profile)=
);
>>>>> -               else
>>>>> -                       return -EINVAL;
>>>>> -
>>>>> -               if (request->type =3D=3D pi->current_power_profile)
>>>>> -                       ret =3D ci_set_power_profile_state(
>>>>> -                                       adev,
>>>>> -                                       request);
>>>>> -       } else {
>>>>> -               /* set power profile if it exists */
>>>>> -               switch (request->type) {
>>>>> -               case AMD_PP_GFX_PROFILE:
>>>>> -                       ret =3D ci_set_power_profile_state(
>>>>> -                               adev,
>>>>> -                               &pi->gfx_power_profile);
>>>>> -                       break;
>>>>> -               case AMD_PP_COMPUTE_PROFILE:
>>>>> -                       ret =3D ci_set_power_profile_state(
>>>>> -                               adev,
>>>>> -                               &pi->compute_power_profile);
>>>>> -                       break;
>>>>> -               default:
>>>>> -                       return -EINVAL;
>>>>> -               }
>>>>> -       }
>>>>> -
>>>>> -       if (!ret)
>>>>> -               pi->current_power_profile =3D request->type;
>>>>> -
>>>>> -       return 0;
>>>>> -}
>>>>> -
>>>>> -static int ci_dpm_reset_power_profile_state(void *handle,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle=
;
>>>>> -       struct ci_power_info *pi =3D ci_get_pi(adev);
>>>>> -
>>>>> -       if (!pi || !request)
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       if (request->type =3D=3D AMD_PP_GFX_PROFILE) {
>>>>> -               pi->gfx_power_profile =3D pi->default_gfx_power_profi=
le;
>>>>> -               return ci_dpm_set_power_profile_state(adev,
>>>>> -                                         &pi->gfx_power_profile);
>>>>> -       } else if (request->type =3D=3D AMD_PP_COMPUTE_PROFILE) {
>>>>> -               pi->compute_power_profile =3D
>>>>> -                       pi->default_compute_power_profile;
>>>>> -               return ci_dpm_set_power_profile_state(adev,
>>>>> -                                         &pi->compute_power_profile)=
;
>>>>> -       } else
>>>>> -               return -EINVAL;
>>>>> -}
>>>>> -
>>>>> -static int ci_dpm_switch_power_profile(void *handle,
>>>>> -               enum amd_pp_profile_type type)
>>>>> -{
>>>>> -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle=
;
>>>>> -       struct ci_power_info *pi =3D ci_get_pi(adev);
>>>>> -       struct amd_pp_profile request =3D {0};
>>>>> -
>>>>> -       if (!pi)
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       if (pi->current_power_profile !=3D type) {
>>>>> -               request.type =3D type;
>>>>> -               return ci_dpm_set_power_profile_state(adev, &request)=
;
>>>>> -       }
>>>>> -
>>>>> -       return 0;
>>>>> -}
>>>>> -
>>>>>   static int ci_dpm_read_sensor(void *handle, int idx,
>>>>>                                void *value, int *size)
>>>>>   {
>>>>> @@ -7053,10 +6801,6 @@ static int ci_dpm_read_sensor(void *handle, in=
t
>>>>> idx,
>>>>>          .set_mclk_od =3D ci_dpm_set_mclk_od,
>>>>>          .check_state_equal =3D ci_check_state_equal,
>>>>>          .get_vce_clock_state =3D amdgpu_get_vce_clock_state,
>>>>> -       .get_power_profile_state =3D ci_dpm_get_power_profile_state,
>>>>> -       .set_power_profile_state =3D ci_dpm_set_power_profile_state,
>>>>> -       .reset_power_profile_state =3D ci_dpm_reset_power_profile_sta=
te,
>>>>> -       .switch_power_profile =3D ci_dpm_switch_power_profile,
>>>>>          .read_sensor =3D ci_dpm_read_sensor,
>>>>>   };
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.h
>>>>> b/drivers/gpu/drm/amd/amdgpu/ci_dpm.h
>>>>> index 84cbc9c..91be299 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.h
>>>>> @@ -295,13 +295,6 @@ struct ci_power_info {
>>>>>          bool fan_is_controlled_by_smc;
>>>>>          u32 t_min;
>>>>>          u32 fan_ctrl_default_mode;
>>>>> -
>>>>> -       /* power profile */
>>>>> -       struct amd_pp_profile gfx_power_profile;
>>>>> -       struct amd_pp_profile compute_power_profile;
>>>>> -       struct amd_pp_profile default_gfx_power_profile;
>>>>> -       struct amd_pp_profile default_compute_power_profile;
>>>>> -       enum amd_pp_profile_type current_power_profile;
>>>>>   };
>>>>>
>>>>>   #define CISLANDS_VOLTAGE_CONTROL_NONE                   0x0
>>>>> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>>> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>>> index 22c2fa3..7dfba2d 100644
>>>>> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>>> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>>>>> @@ -260,13 +260,6 @@ struct amd_pm_funcs {
>>>>>          int (*get_pp_table)(void *handle, char **table);
>>>>>          int (*set_pp_table)(void *handle, const char *buf, size_t
>>>>> size);
>>>>>          void (*debugfs_print_current_performance_level)(void *handle=
,
>>>>> struct seq_file *m);
>>>>> -
>>>>> -       int (*reset_power_profile_state)(void *handle,
>>>>> -                       struct amd_pp_profile *request);
>>>>> -       int (*get_power_profile_state)(void *handle,
>>>>> -                       struct amd_pp_profile *query);
>>>>> -       int (*set_power_profile_state)(void *handle,
>>>>> -                       struct amd_pp_profile *request);
>>>>>          int (*switch_power_profile)(void *handle,
>>>>>                          enum amd_pp_profile_type type);
>>>>>   /* export to amdgpu */
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>>>>> b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>>>>> index 5feb91b..5f5fbb6 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>>>>> @@ -1014,58 +1014,6 @@ static int pp_dpm_read_sensor(void *handle, in=
t
>>>>> idx,
>>>>>          return NULL;
>>>>>   }
>>>>>
>>>>> -static int pp_dpm_reset_power_profile_state(void *handle,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct pp_hwmgr *hwmgr;
>>>>> -       struct pp_instance *pp_handle =3D (struct pp_instance *)handl=
e;
>>>>> -
>>>>> -       if (!request || pp_check(pp_handle))
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       hwmgr =3D pp_handle->hwmgr;
>>>>> -
>>>>> -       if (hwmgr->hwmgr_func->set_power_profile_state =3D=3D NULL) {
>>>>> -               pr_info("%s was not implemented.\n", __func__);
>>>>> -               return 0;
>>>>> -       }
>>>>> -
>>>>> -       if (request->type =3D=3D AMD_PP_GFX_PROFILE) {
>>>>> -               hwmgr->gfx_power_profile =3D
>>>>> hwmgr->default_gfx_power_profile;
>>>>> -               return hwmgr->hwmgr_func->set_power_profile_state(hwm=
gr,
>>>>> -                               &hwmgr->gfx_power_profile);
>>>>> -       } else if (request->type =3D=3D AMD_PP_COMPUTE_PROFILE) {
>>>>> -               hwmgr->compute_power_profile =3D
>>>>> -                               hwmgr->default_compute_power_profile;
>>>>> -               return hwmgr->hwmgr_func->set_power_profile_state(hwm=
gr,
>>>>> -                               &hwmgr->compute_power_profile);
>>>>> -       } else
>>>>> -               return -EINVAL;
>>>>> -}
>>>>> -
>>>>> -static int pp_dpm_get_power_profile_state(void *handle,
>>>>> -               struct amd_pp_profile *query)
>>>>> -{
>>>>> -       struct pp_hwmgr *hwmgr;
>>>>> -       struct pp_instance *pp_handle =3D (struct pp_instance *)handl=
e;
>>>>> -
>>>>> -       if (!query || pp_check(pp_handle))
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       hwmgr =3D pp_handle->hwmgr;
>>>>> -
>>>>> -       if (query->type =3D=3D AMD_PP_GFX_PROFILE)
>>>>> -               memcpy(query, &hwmgr->gfx_power_profile,
>>>>> -                               sizeof(struct amd_pp_profile));
>>>>> -       else if (query->type =3D=3D AMD_PP_COMPUTE_PROFILE)
>>>>> -               memcpy(query, &hwmgr->compute_power_profile,
>>>>> -                               sizeof(struct amd_pp_profile));
>>>>> -       else
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       return 0;
>>>>> -}
>>>>> -
>>>>>   static int pp_get_power_profile_mode(void *handle, char *buf)
>>>>>   {
>>>>>          struct pp_hwmgr *hwmgr;
>>>>> @@ -1124,65 +1072,6 @@ static int pp_odn_edit_dpm_table(void *handle,
>>>>> uint32_t type, long *input, uint3
>>>>>          return hwmgr->hwmgr_func->odn_edit_dpm_table(hwmgr, type,
>>>>> input, size);
>>>>>   }
>>>>>
>>>>> -static int pp_dpm_set_power_profile_state(void *handle,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct pp_hwmgr *hwmgr;
>>>>> -       struct pp_instance *pp_handle =3D (struct pp_instance *)handl=
e;
>>>>> -       int ret =3D -1;
>>>>> -
>>>>> -       if (!request || pp_check(pp_handle))
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       hwmgr =3D pp_handle->hwmgr;
>>>>> -
>>>>> -       if (hwmgr->hwmgr_func->set_power_profile_state =3D=3D NULL) {
>>>>> -               pr_info("%s was not implemented.\n", __func__);
>>>>> -               return 0;
>>>>> -       }
>>>>> -
>>>>> -       if (request->min_sclk ||
>>>>> -               request->min_mclk ||
>>>>> -               request->activity_threshold ||
>>>>> -               request->up_hyst ||
>>>>> -               request->down_hyst) {
>>>>> -               if (request->type =3D=3D AMD_PP_GFX_PROFILE)
>>>>> -                       memcpy(&hwmgr->gfx_power_profile, request,
>>>>> -                                       sizeof(struct amd_pp_profile)=
);
>>>>> -               else if (request->type =3D=3D AMD_PP_COMPUTE_PROFILE)
>>>>> -                       memcpy(&hwmgr->compute_power_profile, request=
,
>>>>> -                                       sizeof(struct amd_pp_profile)=
);
>>>>> -               else
>>>>> -                       return -EINVAL;
>>>>> -
>>>>> -               if (request->type =3D=3D hwmgr->current_power_profile=
)
>>>>> -                       ret =3D
>>>>> hwmgr->hwmgr_func->set_power_profile_state(
>>>>> -                                       hwmgr,
>>>>> -                                       request);
>>>>> -       } else {
>>>>> -               /* set power profile if it exists */
>>>>> -               switch (request->type) {
>>>>> -               case AMD_PP_GFX_PROFILE:
>>>>> -                       ret =3D
>>>>> hwmgr->hwmgr_func->set_power_profile_state(
>>>>> -                                       hwmgr,
>>>>> -                                       &hwmgr->gfx_power_profile);
>>>>> -                       break;
>>>>> -               case AMD_PP_COMPUTE_PROFILE:
>>>>> -                       ret =3D
>>>>> hwmgr->hwmgr_func->set_power_profile_state(
>>>>> -                                       hwmgr,
>>>>> -                                       &hwmgr->compute_power_profile=
);
>>>>> -                       break;
>>>>> -               default:
>>>>> -                       return -EINVAL;
>>>>> -               }
>>>>> -       }
>>>>> -
>>>>> -       if (!ret)
>>>>> -               hwmgr->current_power_profile =3D request->type;
>>>>> -
>>>>> -       return 0;
>>>>> -}
>>>>> -
>>>>>   static int pp_dpm_switch_power_profile(void *handle,
>>>>>                  enum amd_pp_profile_type type)
>>>>>   {
>>>>> @@ -1590,9 +1479,6 @@ static int pp_set_mmhub_powergating_by_smu(void
>>>>> *handle)
>>>>>          .set_mclk_od =3D pp_dpm_set_mclk_od,
>>>>>          .read_sensor =3D pp_dpm_read_sensor,
>>>>>          .get_vce_clock_state =3D pp_dpm_get_vce_clock_state,
>>>>> -       .reset_power_profile_state =3D pp_dpm_reset_power_profile_sta=
te,
>>>>> -       .get_power_profile_state =3D pp_dpm_get_power_profile_state,
>>>>> -       .set_power_profile_state =3D pp_dpm_set_power_profile_state,
>>>>>          .switch_power_profile =3D pp_dpm_switch_power_profile,
>>>>>          .set_clockgating_by_smu =3D pp_set_clockgating_by_smu,
>>>>>          .notify_smu_memory_info =3D pp_dpm_notify_smu_memory_info,
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
>>>>> b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
>>>>> index 33480de..f06f8f4 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c
>>>>> @@ -128,23 +128,6 @@ int phm_force_dpm_levels(struct pp_hwmgr *hwmgr,
>>>>> enum amd_dpm_forced_level level
>>>>>          return ret;
>>>>>   }
>>>>>
>>>>> -int phm_reset_power_profile_state(struct pp_hwmgr *hwmgr)
>>>>> -{
>>>>> -       int ret =3D 0;
>>>>> -
>>>>> -       if (hwmgr->hwmgr_func->set_power_profile_state) {
>>>>> -               if (hwmgr->current_power_profile =3D=3D AMD_PP_GFX_PR=
OFILE)
>>>>> -                       ret =3D
>>>>> hwmgr->hwmgr_func->set_power_profile_state(
>>>>> -                                       hwmgr,
>>>>> -                                       &hwmgr->gfx_power_profile);
>>>>> -               else if (hwmgr->current_power_profile =3D=3D
>>>>> AMD_PP_COMPUTE_PROFILE)
>>>>> -                       ret =3D
>>>>> hwmgr->hwmgr_func->set_power_profile_state(
>>>>> -                                       hwmgr,
>>>>> -                                       &hwmgr->compute_power_profile=
);
>>>>> -       }
>>>>> -       return ret;
>>>>> -}
>>>>> -
>>>>>   int phm_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
>>>>>                                     struct pp_power_state *adjusted_p=
s,
>>>>>                               const struct pp_power_state *current_ps=
)
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
>>>>> b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
>>>>> index 95ab772..ed3bd15 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
>>>>> @@ -247,8 +247,6 @@ int psm_adjust_power_state_dynamic(struct pp_hwmg=
r
>>>>> *hwmgr, bool skip,
>>>>>          if (!phm_force_dpm_levels(hwmgr, hwmgr->request_dpm_level))
>>>>>                  hwmgr->dpm_level =3D hwmgr->request_dpm_level;
>>>>>
>>>>> -       phm_reset_power_profile_state(hwmgr);
>>>>> -
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>>>> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>>>> index f09c76a..cb75c4f 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
>>>>> @@ -4622,89 +4622,6 @@ static int smu7_get_clock_by_type(struct pp_hw=
mgr
>>>>> *hwmgr, enum amd_pp_clock_type
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> -static void smu7_find_min_clock_masks(struct pp_hwmgr *hwmgr,
>>>>> -               uint32_t *sclk_mask, uint32_t *mclk_mask,
>>>>> -               uint32_t min_sclk, uint32_t min_mclk)
>>>>> -{
>>>>> -       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->back=
end);
>>>>> -       struct smu7_dpm_table *dpm_table =3D &(data->dpm_table);
>>>>> -       uint32_t i;
>>>>> -
>>>>> -       for (i =3D 0; i < dpm_table->sclk_table.count; i++) {
>>>>> -               if (dpm_table->sclk_table.dpm_levels[i].enabled &&
>>>>> -                       dpm_table->sclk_table.dpm_levels[i].value >=
=3D
>>>>> min_sclk)
>>>>> -                       *sclk_mask |=3D 1 << i;
>>>>> -       }
>>>>> -
>>>>> -       for (i =3D 0; i < dpm_table->mclk_table.count; i++) {
>>>>> -               if (dpm_table->mclk_table.dpm_levels[i].enabled &&
>>>>> -                       dpm_table->mclk_table.dpm_levels[i].value >=
=3D
>>>>> min_mclk)
>>>>> -                       *mclk_mask |=3D 1 << i;
>>>>> -       }
>>>>> -}
>>>>> -
>>>>> -static int smu7_set_power_profile_state(struct pp_hwmgr *hwmgr,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->back=
end);
>>>>> -       int tmp_result, result =3D 0;
>>>>> -       uint32_t sclk_mask =3D 0, mclk_mask =3D 0;
>>>>> -
>>>>> -       if (hwmgr->chip_id =3D=3D CHIP_FIJI) {
>>>>> -               if (request->type =3D=3D AMD_PP_GFX_PROFILE)
>>>>> -                       smu7_enable_power_containment(hwmgr);
>>>>> -               else if (request->type =3D=3D AMD_PP_COMPUTE_PROFILE)
>>>>> -                       smu7_disable_power_containment(hwmgr);
>>>>> -       }
>>>>> -
>>>>> -       if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_AUTO)
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       if (smum_is_dpm_running(hwmgr)) {
>>>>> -               if (!data->sclk_dpm_key_disabled)
>>>>> -                       smum_send_msg_to_smc(hwmgr,
>>>>> PPSMC_MSG_SCLKDPM_FreezeLevel);
>>>>> -
>>>>> -               if (!data->mclk_dpm_key_disabled)
>>>>> -                       smum_send_msg_to_smc(hwmgr,
>>>>> PPSMC_MSG_MCLKDPM_FreezeLevel);
>>>>> -       }
>>>>> -
>>>>> -       tmp_result =3D smum_populate_requested_graphic_levels(hwmgr,
>>>>> request);
>>>>> -       PP_ASSERT_WITH_CODE(!tmp_result,
>>>>> -                       "Failed to populate requested graphic levels!=
",
>>>>> -                       result =3D tmp_result);
>>>>> -
>>>>> -       if (smum_is_dpm_running(hwmgr)) {
>>>>> -               if (!data->sclk_dpm_key_disabled)
>>>>> -                       smum_send_msg_to_smc(hwmgr,
>>>>> PPSMC_MSG_SCLKDPM_UnfreezeLevel);
>>>>> -
>>>>> -               if (!data->mclk_dpm_key_disabled)
>>>>> -                       smum_send_msg_to_smc(hwmgr,
>>>>> PPSMC_MSG_MCLKDPM_UnfreezeLevel);
>>>>> -       }
>>>>> -
>>>>> -       smu7_find_min_clock_masks(hwmgr, &sclk_mask, &mclk_mask,
>>>>> -                       request->min_sclk, request->min_mclk);
>>>>> -
>>>>> -       if (sclk_mask) {
>>>>> -               if (!data->sclk_dpm_key_disabled)
>>>>> -                       smum_send_msg_to_smc_with_parameter(hwmgr,
>>>>> -                               PPSMC_MSG_SCLKDPM_SetEnabledMask,
>>>>> -                               data->dpm_level_enable_mask.
>>>>> -                               sclk_dpm_enable_mask &
>>>>> -                               sclk_mask);
>>>>> -       }
>>>>> -
>>>>> -       if (mclk_mask) {
>>>>> -               if (!data->mclk_dpm_key_disabled)
>>>>> -                       smum_send_msg_to_smc_with_parameter(hwmgr,
>>>>> -                               PPSMC_MSG_MCLKDPM_SetEnabledMask,
>>>>> -                               data->dpm_level_enable_mask.
>>>>> -                               mclk_dpm_enable_mask &
>>>>> -                               mclk_mask);
>>>>> -       }
>>>>> -
>>>>> -       return result;
>>>>> -}
>>>>> -
>>>>>   static int smu7_notify_cac_buffer_info(struct pp_hwmgr *hwmgr,
>>>>>                                          uint32_t virtual_addr_low,
>>>>>                                          uint32_t virtual_addr_hi,
>>>>> @@ -5154,7 +5071,6 @@ static int smu7_set_power_profile_mode(struct
>>>>> pp_hwmgr *hwmgr, long *input, uint
>>>>>          .get_clock_by_type =3D smu7_get_clock_by_type,
>>>>>          .read_sensor =3D smu7_read_sensor,
>>>>>          .dynamic_state_management_disable =3D smu7_disable_dpm_tasks=
,
>>>>> -       .set_power_profile_state =3D smu7_set_power_profile_state,
>>>>>          .avfs_control =3D smu7_avfs_control,
>>>>>          .disable_smc_firmware_ctf =3D smu7_thermal_disable_alert,
>>>>>          .start_thermal_controller =3D smu7_start_thermal_controller,
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>>>>> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>>>>> index f5df20a..1416d2a 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
>>>>> @@ -2405,34 +2405,6 @@ static int
>>>>> vega10_populate_and_upload_avfs_fuse_override(struct pp_hwmgr *hwmgr)
>>>>>          return result;
>>>>>   }
>>>>>
>>>>> -static int vega10_save_default_power_profile(struct pp_hwmgr *hwmgr)
>>>>> -{
>>>>> -       struct vega10_hwmgr *data =3D (struct vega10_hwmgr
>>>>> *)(hwmgr->backend);
>>>>> -       struct vega10_single_dpm_table *dpm_table =3D
>>>>> &(data->dpm_table.gfx_table);
>>>>> -       uint32_t min_level;
>>>>> -
>>>>> -       hwmgr->default_gfx_power_profile.type =3D AMD_PP_GFX_PROFILE;
>>>>> -       hwmgr->default_compute_power_profile.type =3D
>>>>> AMD_PP_COMPUTE_PROFILE;
>>>>> -
>>>>> -       /* Optimize compute power profile: Use only highest
>>>>> -        * 2 power levels (if more than 2 are available)
>>>>> -        */
>>>>> -       if (dpm_table->count > 2)
>>>>> -               min_level =3D dpm_table->count - 2;
>>>>> -       else if (dpm_table->count =3D=3D 2)
>>>>> -               min_level =3D 1;
>>>>> -       else
>>>>> -               min_level =3D 0;
>>>>> -
>>>>> -       hwmgr->default_compute_power_profile.min_sclk =3D
>>>>> -                       dpm_table->dpm_levels[min_level].value;
>>>>> -
>>>>> -       hwmgr->gfx_power_profile =3D hwmgr->default_gfx_power_profile=
;
>>>>> -       hwmgr->compute_power_profile =3D
>>>>> hwmgr->default_compute_power_profile;
>>>>> -
>>>>> -       return 0;
>>>>> -}
>>>>> -
>>>>>   /**
>>>>>   * Initializes the SMC table and uploads it
>>>>>   *
>>>>> @@ -2576,7 +2548,6 @@ static int vega10_init_smc_table(struct pp_hwmg=
r
>>>>> *hwmgr)
>>>>>          PP_ASSERT_WITH_CODE(!result, "Attempt to enable AVFS feature
>>>>> Failed!",
>>>>>                                          return result);
>>>>>          vega10_acg_enable(hwmgr);
>>>>> -       vega10_save_default_power_profile(hwmgr);
>>>>>
>>>>>          return 0;
>>>>>   }
>>>>> @@ -4729,62 +4700,6 @@ static int vega10_power_off_asic(struct pp_hwm=
gr
>>>>> *hwmgr)
>>>>>          return result;
>>>>>   }
>>>>>
>>>>> -static void vega10_find_min_clock_index(struct pp_hwmgr *hwmgr,
>>>>> -               uint32_t *sclk_idx, uint32_t *mclk_idx,
>>>>> -               uint32_t min_sclk, uint32_t min_mclk)
>>>>> -{
>>>>> -       struct vega10_hwmgr *data =3D (struct vega10_hwmgr
>>>>> *)(hwmgr->backend);
>>>>> -       struct vega10_dpm_table *dpm_table =3D &(data->dpm_table);
>>>>> -       uint32_t i;
>>>>> -
>>>>> -       for (i =3D 0; i < dpm_table->gfx_table.count; i++) {
>>>>> -               if (dpm_table->gfx_table.dpm_levels[i].enabled &&
>>>>> -                       dpm_table->gfx_table.dpm_levels[i].value >=3D
>>>>> min_sclk) {
>>>>> -                       *sclk_idx =3D i;
>>>>> -                       break;
>>>>> -               }
>>>>> -       }
>>>>> -
>>>>> -       for (i =3D 0; i < dpm_table->mem_table.count; i++) {
>>>>> -               if (dpm_table->mem_table.dpm_levels[i].enabled &&
>>>>> -                       dpm_table->mem_table.dpm_levels[i].value >=3D
>>>>> min_mclk) {
>>>>> -                       *mclk_idx =3D i;
>>>>> -                       break;
>>>>> -               }
>>>>> -       }
>>>>> -}
>>>>> -
>>>>> -static int vega10_set_power_profile_state(struct pp_hwmgr *hwmgr,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct vega10_hwmgr *data =3D (struct vega10_hwmgr
>>>>> *)(hwmgr->backend);
>>>>> -       uint32_t sclk_idx =3D ~0, mclk_idx =3D ~0;
>>>>> -
>>>>> -       if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_AUTO)
>>>>> -               return -EINVAL;
>>>>> -
>>>>> -       vega10_find_min_clock_index(hwmgr, &sclk_idx, &mclk_idx,
>>>>> -                       request->min_sclk, request->min_mclk);
>>>>> -
>>>>> -       if (sclk_idx !=3D ~0) {
>>>>> -               if (!data->registry_data.sclk_dpm_key_disabled)
>>>>> -                       smum_send_msg_to_smc_with_parameter(
>>>>> -                                       hwmgr,
>>>>> -
>>>>> PPSMC_MSG_SetSoftMinGfxclkByIndex,
>>>>> -                                       sclk_idx);
>>>>> -       }
>>>>> -
>>>>> -       if (mclk_idx !=3D ~0) {
>>>>> -               if (!data->registry_data.mclk_dpm_key_disabled)
>>>>> -                       smum_send_msg_to_smc_with_parameter(
>>>>> -                                       hwmgr,
>>>>> -                                       PPSMC_MSG_SetSoftMinUclkByInd=
ex,
>>>>> -                                       mclk_idx);
>>>>> -       }
>>>>> -
>>>>> -       return 0;
>>>>> -}
>>>>> -
>>>>>   static int vega10_get_sclk_od(struct pp_hwmgr *hwmgr)
>>>>>   {
>>>>>          struct vega10_hwmgr *data =3D (struct vega10_hwmgr
>>>>> *)(hwmgr->backend);
>>>>> @@ -5078,7 +4993,6 @@ static int vega10_set_power_profile_mode(struct
>>>>> pp_hwmgr *hwmgr, long *input, ui
>>>>>
>>>>> vega10_check_smc_update_required_for_display_configuration,
>>>>>          .power_off_asic =3D vega10_power_off_asic,
>>>>>          .disable_smc_firmware_ctf =3D vega10_thermal_disable_alert,
>>>>> -       .set_power_profile_state =3D vega10_set_power_profile_state,
>>>>>          .get_sclk_od =3D vega10_get_sclk_od,
>>>>>          .set_sclk_od =3D vega10_set_sclk_od,
>>>>>          .get_mclk_od =3D vega10_get_mclk_od,
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
>>>>> b/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
>>>>> index 6f528e6..b366a5b 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h
>>>>> @@ -448,6 +448,5 @@ extern int phm_display_clock_voltage_request(stru=
ct
>>>>> pp_hwmgr *hwmgr,
>>>>>
>>>>>   extern int phm_get_max_high_clocks(struct pp_hwmgr *hwmgr, struct
>>>>> amd_pp_simple_clock_info *clocks);
>>>>>   extern int phm_disable_smc_firmware_ctf(struct pp_hwmgr *hwmgr);
>>>>> -extern int phm_reset_power_profile_state(struct pp_hwmgr *hwmgr);
>>>>>   #endif /* _HARDWARE_MANAGER_H_ */
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
>>>>> b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
>>>>> index 7b19be4..a3beb31 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
>>>>> @@ -236,8 +236,6 @@ struct pp_smumgr_func {
>>>>>          uint32_t (*get_offsetof)(uint32_t type, uint32_t member);
>>>>>          uint32_t (*get_mac_definition)(uint32_t value);
>>>>>          bool (*is_dpm_running)(struct pp_hwmgr *hwmgr);
>>>>> -       int (*populate_requested_graphic_levels)(struct pp_hwmgr *hwm=
gr,
>>>>> -                       struct amd_pp_profile *request);
>>>>>          bool (*is_hw_avfs_present)(struct pp_hwmgr  *hwmgr);
>>>>>          int (*update_dpm_settings)(struct pp_hwmgr *hwmgr, void
>>>>> *profile_setting);
>>>>>   };
>>>>> @@ -329,8 +327,6 @@ struct pp_hwmgr_func {
>>>>>          int (*get_mclk_od)(struct pp_hwmgr *hwmgr);
>>>>>          int (*set_mclk_od)(struct pp_hwmgr *hwmgr, uint32_t value);
>>>>>          int (*read_sensor)(struct pp_hwmgr *hwmgr, int idx, void
>>>>> *value, int *size);
>>>>> -       int (*set_power_profile_state)(struct pp_hwmgr *hwmgr,
>>>>> -                       struct amd_pp_profile *request);
>>>>>          int (*avfs_control)(struct pp_hwmgr *hwmgr, bool enable);
>>>>>          int (*disable_smc_firmware_ctf)(struct pp_hwmgr *hwmgr);
>>>>>          int (*set_active_display_count)(struct pp_hwmgr *hwmgr,
>>>>> uint32_t count);
>>>>> @@ -752,11 +748,6 @@ struct pp_hwmgr {
>>>>>          uint32_t feature_mask;
>>>>>
>>>>>          /* UMD Pstate */
>>>>> -       struct amd_pp_profile gfx_power_profile;
>>>>> -       struct amd_pp_profile compute_power_profile;
>>>>> -       struct amd_pp_profile default_gfx_power_profile;
>>>>> -       struct amd_pp_profile default_compute_power_profile;
>>>>> -       enum amd_pp_profile_type current_power_profile;
>>>>>          bool en_umd_pstate;
>>>>>          uint32_t power_profile_mode;
>>>>>          uint32_t default_power_profile_mode;
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
>>>>> b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
>>>>> index e05a57e..e1f6e83 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
>>>>> @@ -129,9 +129,6 @@ extern uint32_t smum_get_offsetof(struct pp_hwmgr
>>>>> *hwmgr,
>>>>>
>>>>>   extern bool smum_is_dpm_running(struct pp_hwmgr *hwmgr);
>>>>>
>>>>> -extern int smum_populate_requested_graphic_levels(struct pp_hwmgr
>>>>> *hwmgr,
>>>>> -               struct amd_pp_profile *request);
>>>>> -
>>>>>   extern bool smum_is_hw_avfs_present(struct pp_hwmgr *hwmgr);
>>>>>
>>>>>   extern int smum_update_dpm_settings(struct pp_hwmgr *hwmgr, void
>>>>> *profile_setting);
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
>>>>> b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
>>>>> index 6dd10ef..6f4bf7e 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
>>>>> @@ -2772,32 +2772,6 @@ static bool ci_is_dpm_running(struct pp_hwmgr
>>>>> *hwmgr)
>>>>>          return ci_is_smc_ram_running(hwmgr);
>>>>>   }
>>>>>
>>>>> -static int ci_populate_requested_graphic_levels(struct pp_hwmgr *hwm=
gr,
>>>>> -                                               struct amd_pp_profile
>>>>> *request)
>>>>> -{
>>>>> -       struct ci_smumgr *smu_data =3D (struct ci_smumgr *)
>>>>> -                       (hwmgr->smu_backend);
>>>>> -       struct SMU7_Discrete_GraphicsLevel *levels =3D
>>>>> -                       smu_data->smc_state_table.GraphicsLevel;
>>>>> -       uint32_t array =3D smu_data->dpm_table_start +
>>>>> -                       offsetof(SMU7_Discrete_DpmTable, GraphicsLeve=
l);
>>>>> -       uint32_t array_size =3D sizeof(struct SMU7_Discrete_GraphicsL=
evel)
>>>>> *
>>>>> -                       SMU7_MAX_LEVELS_GRAPHICS;
>>>>> -       uint32_t i;
>>>>> -
>>>>> -       for (i =3D 0; i < smu_data->smc_state_table.GraphicsDpmLevelC=
ount;
>>>>> i++) {
>>>>> -               levels[i].ActivityLevel =3D
>>>>> -
>>>>> cpu_to_be16(request->activity_threshold);
>>>>> -               levels[i].EnabledForActivity =3D 1;
>>>>> -               levels[i].UpH =3D request->up_hyst;
>>>>> -               levels[i].DownH =3D request->down_hyst;
>>>>> -       }
>>>>> -
>>>>> -       return ci_copy_bytes_to_smc(hwmgr, array, (uint8_t *)levels,
>>>>> -                               array_size, SMC_RAM_END);
>>>>> -}
>>>>> -
>>>>> -
>>>>>   static int ci_smu_init(struct pp_hwmgr *hwmgr)
>>>>>   {
>>>>>          struct ci_smumgr *ci_priv =3D NULL;
>>>>> @@ -2942,6 +2916,5 @@ static int ci_update_dpm_settings(struct pp_hwm=
gr
>>>>> *hwmgr,
>>>>>          .get_mac_definition =3D ci_get_mac_definition,
>>>>>          .initialize_mc_reg_table =3D ci_initialize_mc_reg_table,
>>>>>          .is_dpm_running =3D ci_is_dpm_running,
>>>>> -       .populate_requested_graphic_levels =3D
>>>>> ci_populate_requested_graphic_levels,
>>>>>          .update_dpm_settings =3D ci_update_dpm_settings,
>>>>>   };
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
>>>>> b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
>>>>> index f7f58f77..220159f 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
>>>>> @@ -1960,44 +1960,6 @@ static int fiji_init_arb_table_index(struct
>>>>> pp_hwmgr *hwmgr)
>>>>>                          smu_data->smu7_data.arb_table_start,  tmp,
>>>>> SMC_RAM_END);
>>>>>   }
>>>>>
>>>>> -static int fiji_save_default_power_profile(struct pp_hwmgr *hwmgr)
>>>>> -{
>>>>> -       struct fiji_smumgr *data =3D (struct fiji_smumgr
>>>>> *)(hwmgr->smu_backend);
>>>>> -       struct SMU73_Discrete_GraphicsLevel *levels =3D
>>>>> -                               data->smc_state_table.GraphicsLevel;
>>>>> -       unsigned min_level =3D 1;
>>>>> -
>>>>> -       hwmgr->default_gfx_power_profile.activity_threshold =3D
>>>>> -                       be16_to_cpu(levels[0].ActivityLevel);
>>>>> -       hwmgr->default_gfx_power_profile.up_hyst =3D levels[0].UpHyst=
;
>>>>> -       hwmgr->default_gfx_power_profile.down_hyst =3D levels[0].Down=
Hyst;
>>>>> -       hwmgr->default_gfx_power_profile.type =3D AMD_PP_GFX_PROFILE;
>>>>> -
>>>>> -       hwmgr->default_compute_power_profile =3D
>>>>> hwmgr->default_gfx_power_profile;
>>>>> -       hwmgr->default_compute_power_profile.type =3D
>>>>> AMD_PP_COMPUTE_PROFILE;
>>>>> -
>>>>> -       /* Workaround compute SDMA instability: disable lowest SCLK
>>>>> -        * DPM level. Optimize compute power profile: Use only highes=
t
>>>>> -        * 2 power levels (if more than 2 are available), Hysteresis:
>>>>> -        * 0ms up, 5ms down
>>>>> -        */
>>>>> -       if (data->smc_state_table.GraphicsDpmLevelCount > 2)
>>>>> -               min_level =3D data->smc_state_table.GraphicsDpmLevelC=
ount
>>>>> - 2;
>>>>> -       else if (data->smc_state_table.GraphicsDpmLevelCount =3D=3D 2=
)
>>>>> -               min_level =3D 1;
>>>>> -       else
>>>>> -               min_level =3D 0;
>>>>> -       hwmgr->default_compute_power_profile.min_sclk =3D
>>>>> -                       be32_to_cpu(levels[min_level].SclkFrequency);
>>>>> -       hwmgr->default_compute_power_profile.up_hyst =3D 0;
>>>>> -       hwmgr->default_compute_power_profile.down_hyst =3D 5;
>>>>> -
>>>>> -       hwmgr->gfx_power_profile =3D hwmgr->default_gfx_power_profile=
;
>>>>> -       hwmgr->compute_power_profile =3D
>>>>> hwmgr->default_compute_power_profile;
>>>>> -
>>>>> -       return 0;
>>>>> -}
>>>>> -
>>>>>   static int fiji_setup_dpm_led_config(struct pp_hwmgr *hwmgr)
>>>>>   {
>>>>>          pp_atomctrl_voltage_table param_led_dpm;
>>>>> @@ -2238,8 +2200,6 @@ static int fiji_init_smc_table(struct pp_hwmgr
>>>>> *hwmgr)
>>>>>          PP_ASSERT_WITH_CODE(0 =3D=3D result,
>>>>>                              "Failed to setup dpm led config", return
>>>>> result);
>>>>>
>>>>> -       fiji_save_default_power_profile(hwmgr);
>>>>> -
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> @@ -2694,31 +2654,6 @@ static bool fiji_is_dpm_running(struct pp_hwmg=
r
>>>>> *hwmgr)
>>>>>                          ? true : false;
>>>>>   }
>>>>>
>>>>> -static int fiji_populate_requested_graphic_levels(struct pp_hwmgr
>>>>> *hwmgr,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct fiji_smumgr *smu_data =3D (struct fiji_smumgr *)
>>>>> -                       (hwmgr->smu_backend);
>>>>> -       struct SMU73_Discrete_GraphicsLevel *levels =3D
>>>>> -                       smu_data->smc_state_table.GraphicsLevel;
>>>>> -       uint32_t array =3D smu_data->smu7_data.dpm_table_start +
>>>>> -                       offsetof(SMU73_Discrete_DpmTable,
>>>>> GraphicsLevel);
>>>>> -       uint32_t array_size =3D sizeof(struct
>>>>> SMU73_Discrete_GraphicsLevel) *
>>>>> -                       SMU73_MAX_LEVELS_GRAPHICS;
>>>>> -       uint32_t i;
>>>>> -
>>>>> -       for (i =3D 0; i < smu_data->smc_state_table.GraphicsDpmLevelC=
ount;
>>>>> i++) {
>>>>> -               levels[i].ActivityLevel =3D
>>>>> -
>>>>> cpu_to_be16(request->activity_threshold);
>>>>> -               levels[i].EnabledForActivity =3D 1;
>>>>> -               levels[i].UpHyst =3D request->up_hyst;
>>>>> -               levels[i].DownHyst =3D request->down_hyst;
>>>>> -       }
>>>>> -
>>>>> -       return smu7_copy_bytes_to_smc(hwmgr, array, (uint8_t *)levels=
,
>>>>> -                               array_size, SMC_RAM_END);
>>>>> -}
>>>>> -
>>>>>   static int fiji_update_dpm_settings(struct pp_hwmgr *hwmgr,
>>>>>                                  void *profile_setting)
>>>>>   {
>>>>> @@ -2838,7 +2773,6 @@ static int fiji_update_dpm_settings(struct
>>>>> pp_hwmgr *hwmgr,
>>>>>          .get_mac_definition =3D fiji_get_mac_definition,
>>>>>          .initialize_mc_reg_table =3D fiji_initialize_mc_reg_table,
>>>>>          .is_dpm_running =3D fiji_is_dpm_running,
>>>>> -       .populate_requested_graphic_levels =3D
>>>>> fiji_populate_requested_graphic_levels,
>>>>>          .is_hw_avfs_present =3D fiji_is_hw_avfs_present,
>>>>>          .update_dpm_settings =3D fiji_update_dpm_settings,
>>>>>   };
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
>>>>> b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
>>>>> index ae07b5d..75f46ed 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
>>>>> @@ -1840,42 +1840,6 @@ static void
>>>>> polaris10_initialize_power_tune_defaults(struct pp_hwmgr *hwmgr)
>>>>>
>>>>>   }
>>>>>
>>>>> -static void polaris10_save_default_power_profile(struct pp_hwmgr
>>>>> *hwmgr)
>>>>> -{
>>>>> -       struct polaris10_smumgr *data =3D (struct polaris10_smumgr
>>>>> *)(hwmgr->smu_backend);
>>>>> -       struct SMU74_Discrete_GraphicsLevel *levels =3D
>>>>> -                               data->smc_state_table.GraphicsLevel;
>>>>> -       unsigned min_level =3D 1;
>>>>> -
>>>>> -       hwmgr->default_gfx_power_profile.activity_threshold =3D
>>>>> -                       be16_to_cpu(levels[0].ActivityLevel);
>>>>> -       hwmgr->default_gfx_power_profile.up_hyst =3D levels[0].UpHyst=
;
>>>>> -       hwmgr->default_gfx_power_profile.down_hyst =3D levels[0].Down=
Hyst;
>>>>> -       hwmgr->default_gfx_power_profile.type =3D AMD_PP_GFX_PROFILE;
>>>>> -
>>>>> -       hwmgr->default_compute_power_profile =3D
>>>>> hwmgr->default_gfx_power_profile;
>>>>> -       hwmgr->default_compute_power_profile.type =3D
>>>>> AMD_PP_COMPUTE_PROFILE;
>>>>> -
>>>>> -       /* Workaround compute SDMA instability: disable lowest SCLK
>>>>> -        * DPM level. Optimize compute power profile: Use only highes=
t
>>>>> -        * 2 power levels (if more than 2 are available), Hysteresis:
>>>>> -        * 0ms up, 5ms down
>>>>> -        */
>>>>> -       if (data->smc_state_table.GraphicsDpmLevelCount > 2)
>>>>> -               min_level =3D data->smc_state_table.GraphicsDpmLevelC=
ount
>>>>> - 2;
>>>>> -       else if (data->smc_state_table.GraphicsDpmLevelCount =3D=3D 2=
)
>>>>> -               min_level =3D 1;
>>>>> -       else
>>>>> -               min_level =3D 0;
>>>>> -       hwmgr->default_compute_power_profile.min_sclk =3D
>>>>> -
>>>>> be32_to_cpu(levels[min_level].SclkSetting.SclkFrequency);
>>>>> -       hwmgr->default_compute_power_profile.up_hyst =3D 0;
>>>>> -       hwmgr->default_compute_power_profile.down_hyst =3D 5;
>>>>> -
>>>>> -       hwmgr->gfx_power_profile =3D hwmgr->default_gfx_power_profile=
;
>>>>> -       hwmgr->compute_power_profile =3D
>>>>> hwmgr->default_compute_power_profile;
>>>>> -}
>>>>> -
>>>>>   static int polaris10_init_smc_table(struct pp_hwmgr *hwmgr)
>>>>>   {
>>>>>          int result;
>>>>> @@ -2090,8 +2054,6 @@ static int polaris10_init_smc_table(struct
>>>>> pp_hwmgr *hwmgr)
>>>>>          PP_ASSERT_WITH_CODE(0 =3D=3D result,
>>>>>                          "Failed to  populate PM fuses to SMC memory!=
",
>>>>> return result);
>>>>>
>>>>> -       polaris10_save_default_power_profile(hwmgr);
>>>>> -
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> @@ -2550,31 +2512,6 @@ static bool polaris10_is_dpm_running(struct
>>>>> pp_hwmgr *hwmgr)
>>>>>                          ? true : false;
>>>>>   }
>>>>>
>>>>> -static int polaris10_populate_requested_graphic_levels(struct pp_hwm=
gr
>>>>> *hwmgr,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct polaris10_smumgr *smu_data =3D (struct polaris10_smumg=
r *)
>>>>> -                       (hwmgr->smu_backend);
>>>>> -       struct SMU74_Discrete_GraphicsLevel *levels =3D
>>>>> -                       smu_data->smc_state_table.GraphicsLevel;
>>>>> -       uint32_t array =3D smu_data->smu7_data.dpm_table_start +
>>>>> -                       offsetof(SMU74_Discrete_DpmTable,
>>>>> GraphicsLevel);
>>>>> -       uint32_t array_size =3D sizeof(struct
>>>>> SMU74_Discrete_GraphicsLevel) *
>>>>> -                       SMU74_MAX_LEVELS_GRAPHICS;
>>>>> -       uint32_t i;
>>>>> -
>>>>> -       for (i =3D 0; i < smu_data->smc_state_table.GraphicsDpmLevelC=
ount;
>>>>> i++) {
>>>>> -               levels[i].ActivityLevel =3D
>>>>> -
>>>>> cpu_to_be16(request->activity_threshold);
>>>>> -               levels[i].EnabledForActivity =3D 1;
>>>>> -               levels[i].UpHyst =3D request->up_hyst;
>>>>> -               levels[i].DownHyst =3D request->down_hyst;
>>>>> -       }
>>>>> -
>>>>> -       return smu7_copy_bytes_to_smc(hwmgr, array, (uint8_t *)levels=
,
>>>>> -                               array_size, SMC_RAM_END);
>>>>> -}
>>>>> -
>>>>>   static int polaris10_update_dpm_settings(struct pp_hwmgr *hwmgr,
>>>>>                                  void *profile_setting)
>>>>>   {
>>>>> @@ -2693,7 +2630,6 @@ static int polaris10_update_dpm_settings(struct
>>>>> pp_hwmgr *hwmgr,
>>>>>          .populate_all_memory_levels =3D
>>>>> polaris10_populate_all_memory_levels,
>>>>>          .get_mac_definition =3D polaris10_get_mac_definition,
>>>>>          .is_dpm_running =3D polaris10_is_dpm_running,
>>>>> -       .populate_requested_graphic_levels =3D
>>>>> polaris10_populate_requested_graphic_levels,
>>>>>          .is_hw_avfs_present =3D polaris10_is_hw_avfs_present,
>>>>>          .update_dpm_settings =3D polaris10_update_dpm_settings,
>>>>>   };
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
>>>>> b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
>>>>> index 1ce4959..43b1010 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c
>>>>> @@ -236,16 +236,6 @@ bool smum_is_dpm_running(struct pp_hwmgr *hwmgr)
>>>>>          return true;
>>>>>   }
>>>>>
>>>>> -int smum_populate_requested_graphic_levels(struct pp_hwmgr *hwmgr,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       if (hwmgr->smumgr_funcs->populate_requested_graphic_levels)
>>>>> -               return
>>>>> hwmgr->smumgr_funcs->populate_requested_graphic_levels(
>>>>> -                               hwmgr, request);
>>>>> -
>>>>> -       return 0;
>>>>> -}
>>>>> -
>>>>>   bool smum_is_hw_avfs_present(struct pp_hwmgr *hwmgr)
>>>>>   {
>>>>>          if (hwmgr->smumgr_funcs->is_hw_avfs_present)
>>>>> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
>>>>> b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
>>>>> index 1fe5b77..8856cc1 100644
>>>>> --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
>>>>> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
>>>>> @@ -2263,42 +2263,6 @@ static void
>>>>> tonga_initialize_power_tune_defaults(struct pp_hwmgr *hwmgr)
>>>>>                  smu_data->power_tune_defaults =3D
>>>>> &tonga_power_tune_data_set_array[0];
>>>>>   }
>>>>>
>>>>> -static void tonga_save_default_power_profile(struct pp_hwmgr *hwmgr)
>>>>> -{
>>>>> -       struct tonga_smumgr *data =3D (struct tonga_smumgr
>>>>> *)(hwmgr->smu_backend);
>>>>> -       struct SMU72_Discrete_GraphicsLevel *levels =3D
>>>>> -                               data->smc_state_table.GraphicsLevel;
>>>>> -       unsigned min_level =3D 1;
>>>>> -
>>>>> -       hwmgr->default_gfx_power_profile.activity_threshold =3D
>>>>> -                       be16_to_cpu(levels[0].ActivityLevel);
>>>>> -       hwmgr->default_gfx_power_profile.up_hyst =3D levels[0].UpHyst=
;
>>>>> -       hwmgr->default_gfx_power_profile.down_hyst =3D levels[0].Down=
Hyst;
>>>>> -       hwmgr->default_gfx_power_profile.type =3D AMD_PP_GFX_PROFILE;
>>>>> -
>>>>> -       hwmgr->default_compute_power_profile =3D
>>>>> hwmgr->default_gfx_power_profile;
>>>>> -       hwmgr->default_compute_power_profile.type =3D
>>>>> AMD_PP_COMPUTE_PROFILE;
>>>>> -
>>>>> -       /* Workaround compute SDMA instability: disable lowest SCLK
>>>>> -        * DPM level. Optimize compute power profile: Use only highes=
t
>>>>> -        * 2 power levels (if more than 2 are available), Hysteresis:
>>>>> -        * 0ms up, 5ms down
>>>>> -        */
>>>>> -       if (data->smc_state_table.GraphicsDpmLevelCount > 2)
>>>>> -               min_level =3D data->smc_state_table.GraphicsDpmLevelC=
ount
>>>>> - 2;
>>>>> -       else if (data->smc_state_table.GraphicsDpmLevelCount =3D=3D 2=
)
>>>>> -               min_level =3D 1;
>>>>> -       else
>>>>> -               min_level =3D 0;
>>>>> -       hwmgr->default_compute_power_profile.min_sclk =3D
>>>>> -                       be32_to_cpu(levels[min_level].SclkFrequency);
>>>>> -       hwmgr->default_compute_power_profile.up_hyst =3D 0;
>>>>> -       hwmgr->default_compute_power_profile.down_hyst =3D 5;
>>>>> -
>>>>> -       hwmgr->gfx_power_profile =3D hwmgr->default_gfx_power_profile=
;
>>>>> -       hwmgr->compute_power_profile =3D
>>>>> hwmgr->default_compute_power_profile;
>>>>> -}
>>>>> -
>>>>>   static int tonga_init_smc_table(struct pp_hwmgr *hwmgr)
>>>>>   {
>>>>>          int result;
>>>>> @@ -2540,8 +2504,6 @@ static int tonga_init_smc_table(struct pp_hwmgr
>>>>> *hwmgr)
>>>>>          PP_ASSERT_WITH_CODE((!result),
>>>>>                  "Failed to populate initialize MC Reg table !", retu=
rn
>>>>> result);
>>>>>
>>>>> -       tonga_save_default_power_profile(hwmgr);
>>>>> -
>>>>>          return 0;
>>>>>   }
>>>>>
>>>>> @@ -3259,31 +3221,6 @@ static bool tonga_is_dpm_running(struct pp_hwm=
gr
>>>>> *hwmgr)
>>>>>                          ? true : false;
>>>>>   }
>>>>>
>>>>> -static int tonga_populate_requested_graphic_levels(struct pp_hwmgr
>>>>> *hwmgr,
>>>>> -               struct amd_pp_profile *request)
>>>>> -{
>>>>> -       struct tonga_smumgr *smu_data =3D (struct tonga_smumgr *)
>>>>> -                       (hwmgr->smu_backend);
>>>>> -       struct SMU72_Discrete_GraphicsLevel *levels =3D
>>>>> -                       smu_data->smc_state_table.GraphicsLevel;
>>>>> -       uint32_t array =3D smu_data->smu7_data.dpm_table_start +
>>>>> -                       offsetof(SMU72_Discrete_DpmTable,
>>>>> GraphicsLevel);

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




--_000_CY4PR12MB16878777B1924926E2F48BB8FBC70CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&gt;When compute ri=
ng begin,
 if we just fix sclk in level7 directly, ,&nbsp;</span><br style=3D"font-fa=
mily: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&qu=
ot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot=
;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;Is there any difference in performance or performance in =
watt,
 compared to set compute profile mode (include apply min sclk to level6)?</=
span><br style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &=
quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &=
quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-s=
ize: 14.6667px;">
<br>
I think the expected result is:</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">performance similar, &nbsp;and pe=
rformance in watt: fixed in level7 &lt; compute profile setting.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br style=3D"font-family: Cali=
bri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot=
;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;A=
ndroid Emoji&quot;, EmojiSymbols;">
<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&=
gt;<br>
<b>Sent:</b> Wednesday, February 28, 2018 7:08 PM<br>
<b>To:</b> Kuehling, Felix; Alex Deucher; Huang, JinHuiEric<br>
<b>Cc:</b> Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH] drm/amd/pp: Revert gfx/compute profile switch s=
ysfs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I went through the power profiling feature in wind=
ows - Auto Wattman supported on Polaris and Vega. Initially apply to Polari=
s.<br>
<br>
The Goal is to maximize performance/watt without impacting performance and =
no visual impact per system/use case<br>
<br>
On smu7, 3 parameters control how SMU responds to sclk/mclk activity, up/do=
wn hysteresis and activity threshold.<br>
<br>
My understanding is:<br>
When sclk_activity large than threshold, adjust uphyst/downhyst/activity th=
reshold to go higher dpm level more faster or stay in higher dpm level long=
er for boost performance.<br>
Otherwise, for power saving.<br>
<br>
Those parameters were used to change the behavior of dpm switching for perf=
ormance in watt. So we wish to add an independent sysfs to configure them.<=
br>
<br>
When this feature enabled, the performance in watt is improved in most case=
(low activity and Multimedia) from pplib's test. I do not find compute test=
 result.<br>
<br>
So there is a question: <br>
<br>
When compute ring begin, if we just fix sclk in level7 directly, , <br>
Is there any difference in performance or performance in watt, compared to =
set compute profile mode (include apply min sclk to level6)?<br>
<br>
<br>
Best Regards<br>
Rex<br>
<br>
<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: Kuehling, Felix <br>
Sent: Wednesday, February 28, 2018 2:55 AM<br>
To: Alex Deucher; Huang, JinHuiEric<br>
Cc: Zhu, Rex; Russell, Kent; amd-gfx list<br>
Subject: Re: [PATCH] drm/amd/pp: Revert gfx/compute profile switch sysfs<br=
>
<br>
On 2018-02-27 11:27 AM, Alex Deucher wrote:<br>
&gt; On Tue, Feb 27, 2018 at 11:22 AM, Eric Huang &lt;jinhuieric.huang@amd.=
com&gt; wrote:<br>
&gt;&gt; As I mentioned in code review for new power profile, old gfx/compu=
te power<br>
&gt;&gt; profile have two scenarios for auto switching. One is<br>
&gt;&gt; gfx-&gt;compute(default)-&gt;gfx and other is gfx-&gt;compute(cust=
om)-&gt;gfx. New power<br>
&gt;&gt; profile only satisfies first one, but in second one for user debug=
ging, user<br>
&gt;&gt; setting of power profile will be over-written when switching to co=
mpute<br>
&gt;&gt; profile.<br>
&gt; For debugging, the idea would be to select manual mode via<br>
&gt; force_performance_level and then force a profile via sysfs.&nbsp; If m=
anual<br>
&gt; mode was selected, none of the automatic profile changing would<br>
&gt; happen.&nbsp; Is that adequate or do you need the automatic switching =
even<br>
&gt; with a custom profile?<br>
<br>
It would result in higher power consumption while no compute work is<br>
running by applying minimum clocks (if that's still part of the<br>
profile). If minimum clock is not part of the profile, then that's<br>
another major regression for us.<br>
<br>
I would prefer to add the ability to tweak all the power profiles so we<br>
can have workload-specific customization, not just for compute. Maybe<br>
that's something we can add later.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Eric<br>
&gt;&gt;<br>
&gt;&gt; On 2018-02-27 10:52 AM, Felix Kuehling wrote:<br>
&gt;&gt;&gt; [&#43;Eric]<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Compute profile switching code as well as KFD compute support =
for most<br>
&gt;&gt;&gt; GPUs is not upstream yet. As such, there is probably no requir=
ement<br>
&gt;&gt;&gt; (yet) to keep the compute profile API stable, that we added sp=
ecifically<br>
&gt;&gt;&gt; for KFD. Once we are upstream that will change.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If you change it now, we'll have to adapt, like we have often =
done.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I'll let Eric comment on whether the new power profile code an=
d API is<br>
&gt;&gt;&gt; an adequate replacement from a functionality perspective. Eric=
, Kent,<br>
&gt;&gt;&gt; have we done any testing with Rex's new profile code?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp; Felix<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 2018-02-27 10:41 AM, Alex Deucher wrote:<br>
&gt;&gt;&gt;&gt; &#43; Kent and Felix for comment<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Tue, Feb 27, 2018 at 6:21 AM, Rex Zhu &lt;Rex.Zhu@amd.c=
om&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt; The gfx/compute profiling mode switch is only for inte=
rnally<br>
&gt;&gt;&gt;&gt;&gt; test. Not a complete solution and unexpectly upstream.=
<br>
&gt;&gt;&gt;&gt;&gt; so revert it.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Change-Id: I1af1b64a63b6fc12c24cf73df03b083b3661ca02<b=
r>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbs=
p; 8 -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 180<=
br>
&gt;&gt;&gt;&gt;&gt; ---------------<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/ci_dpm.c&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; | 256<br>
&gt;&gt;&gt;&gt;&gt; ---------------------<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/ci_dpm.h&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp;&nbsp; 7 -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/include/kgd_pp_interfa=
ce.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 7 -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerpla=
y.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 114 ---------<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/hardwarema=
nager.c&nbsp; |&nbsp; 17 --<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm=
.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_h=
wmgr.c&nbsp;&nbsp; |&nbsp; 84 -------<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10=
_hwmgr.c |&nbsp; 86 -------<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; .../gpu/drm/amd/powerplay/inc/hardwaremana=
ger.h&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 9 -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/inc/smumgr.h=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/ci_sm=
umgr.c&nbsp;&nbsp; |&nbsp; 27 ---<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/fiji_=
smumgr.c |&nbsp; 66 ------<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; .../drm/amd/powerplay/smumgr/polaris10_smu=
mgr.c&nbsp;&nbsp;&nbsp; |&nbsp; 64 ------<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/smumg=
r.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 10 -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; .../gpu/drm/amd/powerplay/smumgr/tonga_smu=
mgr.c&nbsp;&nbsp;&nbsp; |&nbsp; 64 ------<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; 18 files changed, 1005 deletions(-)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<b=
r>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&gt;&gt;&gt;&gt;&gt; index bd745a4..9c373f8f 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dp=
m.h<br>
&gt;&gt;&gt;&gt;&gt; @@ -341,14 &#43;341,6 @@ enum amdgpu_pcie_gen {<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; ((adev)-&gt;powerplay.pp_funcs-&gt;reset_power_profile=
_state(\<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; (adev)-&gt;powerplay.pp_handle, request))<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -#define amdgpu_dpm_get_power_profile_state(adev, quer=
y) \<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;get_powe=
r_profile_state(\<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (adev)-&gt;powerplay.pp_handle, query))<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -#define amdgpu_dpm_set_power_profile_state(adev, requ=
est) \<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_funcs-&gt;set_powe=
r_profile_state(\<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (adev)-&gt;powerplay.pp_handle, request))<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; #define amdgpu_dpm_switch_power_profile(ad=
ev, type) \<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;powerplay.pp_fu=
ncs-&gt;switch_power_profile(\<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; (adev)-&gt;powerplay.pp_handle, type))<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br=
>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt;&gt;&gt;&gt;&gt; index 9e73cbc..632b186 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm=
.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -734,161 &#43;734,6 @@ static ssize_t<br>
&gt;&gt;&gt;&gt;&gt; amdgpu_set_pp_power_profile_mode(struct device *dev,<b=
r>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static ssize_t amdgpu_get_pp_power_profile(struct dev=
ice *dev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf, struct amd_pp_profile *query)<br=
>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_devic=
e *ddev =3D dev_get_drvdata(dev);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_de=
vice *adev =3D ddev-&gt;dev_private;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0xff=
;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pow=
erplay.pp_funcs-&gt;get_power_profile_state)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_get_power_profile_state(=
<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, query);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(=
buf, PAGE_SIZE,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;%d %d %d %d %d\n&quot;,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; query-&gt;min_sclk / 100,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; query-&gt;min_mclk / 100,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; query-&gt;activity_threshold,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; query-&gt;up_hyst,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; query-&gt;down_hyst);<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static ssize_t amdgpu_get_pp_gfx_power_profile(struct=
 device *dev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile query =3D {0};<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query.type =3D A=
MD_PP_GFX_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_ge=
t_pp_power_profile(dev, buf, &amp;query);<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static ssize_t amdgpu_get_pp_compute_power_profile(st=
ruct device *dev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile query =3D {0};<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query.type =3D A=
MD_PP_COMPUTE_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_ge=
t_pp_power_profile(dev, buf, &amp;query);<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static ssize_t amdgpu_set_pp_power_profile(struct dev=
ice *dev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_devic=
e *ddev =3D dev_get_drvdata(dev);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_de=
vice *adev =3D ddev-&gt;dev_private;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t loop =
=3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char *sub_str, b=
uf_cpy[128], *tmp_str;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char delim=
iter[3] =3D {' ', '\n', '\0'};<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long int value;<=
br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0xff=
;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strncmp(&quo=
t;reset&quot;, buf, strlen(&quot;reset&quot;)) =3D=3D 0) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;reset_p=
ower_profile_state)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D amdgpu_dpm_reset_power_profile_state(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev, request);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; count =3D -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto fail;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (strncmp(&quo=
t;set&quot;, buf, strlen(&quot;set&quot;)) =3D=3D 0) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;set_pow=
er_profile_state)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D amdgpu_dpm_set_power_profile_state(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev, request);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; count =3D -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto fail;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (count &#43; =
1 &gt;=3D 128) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fail;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(buf_cpy, =
buf, count &#43; 1);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_str =3D buf_=
cpy;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (tmp_str[0=
]) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_str =3D strsep(&amp;tmp_str, delimiter)=
;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kstrtol(sub_str, 0, &amp;value);<br=
>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; count =3D -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; goto fail;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (loop) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* input unit MHz convert to dpm table unit<br>
&gt;&gt;&gt;&gt;&gt; 10KHz*/<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; request-&gt;min_sclk =3D (uint32_t)value * 100;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; /* input unit MHz convert to dpm table unit<br>
&gt;&gt;&gt;&gt;&gt; 10KHz*/<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; request-&gt;min_mclk =3D (uint32_t)value * 100;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; request-&gt;activity_threshold =3D (uint16_t)value;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 3:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; request-&gt;up_hyst =3D (uint8_t)value;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 4:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; request-&gt;down_hyst =3D (uint8_t)value;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loop&#43;&#43;;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pow=
erplay.pp_funcs-&gt;set_power_profile_state)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_dpm_set_power_profile_state(=
adev, request);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -fail:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br=
>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static ssize_t amdgpu_set_pp_gfx_power_profile(struct=
 device *dev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile request =3D {0};<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request.type =3D=
 AMD_PP_GFX_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_se=
t_pp_power_profile(dev, buf, count, &amp;request);<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static ssize_t amdgpu_set_pp_compute_power_profile(st=
ruct device *dev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile request =3D {0};<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request.type =3D=
 AMD_PP_COMPUTE_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_se=
t_pp_power_profile(dev, buf, count, &amp;request);<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static DEVICE_ATTR(power_dpm_state, S_IRUG=
O | S_IWUSR,<br>
&gt;&gt;&gt;&gt;&gt; amdgpu_get_dpm_state, amdgpu_set_dpm_state);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static DEVICE_ATTR(power_dpm_force_perform=
ance_level, S_IRUGO |<br>
&gt;&gt;&gt;&gt;&gt; S_IWUSR,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ge=
t_dpm_forced_performance_level,<br>
&gt;&gt;&gt;&gt;&gt; @@ -916,12 &#43;761,6 @@ static DEVICE_ATTR(pp_sclk_od=
, S_IRUGO | S_IWUSR,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static DEVICE_ATTR(pp_mclk_od, S_IRUGO | S=
_IWUSR,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_mclk_od,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_mclk_od);<br>
&gt;&gt;&gt;&gt;&gt; -static DEVICE_ATTR(pp_gfx_power_profile, S_IRUGO | S_=
IWUSR,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_gfx_power_profile,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_gfx_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -static DEVICE_ATTR(pp_compute_power_profile, S_IRUGO =
| S_IWUSR,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_compute_power_profile,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_compute_power_profile);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static DEVICE_ATTR(pp_power_profile_mode, =
S_IRUGO | S_IWUSR,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_get_pp_power_profile=
_mode,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_set_pp_power_profile=
_mode);<br>
&gt;&gt;&gt;&gt;&gt; @@ -1767,21 &#43;1606,6 @@ int amdgpu_pm_sysfs_init(st=
ruct amdgpu_device<br>
&gt;&gt;&gt;&gt;&gt; *adev)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ret =3D device_create_file(adev-&gt;dev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;dev_attr_pp_gfx_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device fil=
e &quot;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_gfx_power_pro=
file\n&quot;);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_c=
reate_file(adev-&gt;dev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;dev_attr_pp_compute_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to create device fil=
e &quot;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;pp_compute_power=
_profile\n&quot;);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D device_c=
reate_file(adev-&gt;dev,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp_power_profile_mode);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (ret) {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;failed to c=
reate device file &quot;<br>
&gt;&gt;&gt;&gt;&gt; @@ -1827,10 &#43;1651,6 @@ void amdgpu_pm_sysfs_fini(s=
truct amdgpu_device<br>
&gt;&gt;&gt;&gt;&gt; *adev)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
device_remove_file(adev-&gt;dev, &amp;dev_attr_pp_sclk_od);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
device_remove_file(adev-&gt;dev, &amp;dev_attr_pp_mclk_od);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
device_remove_file(adev-&gt;dev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;dev_attr_pp_gfx_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_fi=
le(adev-&gt;dev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;dev_attr_pp_compute_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_remove_fi=
le(adev-&gt;dev,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp_power_profile_mode);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
device_remove_file(adev-&gt;dev,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp_od_clk_voltage);<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt;&gt;&gt;&gt;&gt; index f82f40f..ddb814f 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<=
br>
&gt;&gt;&gt;&gt;&gt; @@ -3695,40 &#43;3695,6 @@ static int ci_find_boot_lev=
el(struct<br>
&gt;&gt;&gt;&gt;&gt; ci_single_dpm_table *table,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return ret;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static void ci_save_default_power_profile(struct amdg=
pu_device *adev)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_=
info *pi =3D ci_get_pi(adev);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU7_Disc=
rete_GraphicsLevel *levels =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;smc_state_table=
.GraphicsLevel;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_lev=
el =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;default_g=
fx_power_profile.activity_threshold =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; be16_to_cpu(levels[0].ActivityLevel);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;default_g=
fx_power_profile.up_hyst =3D levels[0].UpH;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;default_g=
fx_power_profile.down_hyst =3D levels[0].DownH;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;default_g=
fx_power_profile.type =3D AMD_PP_GFX_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;default_c=
ompute_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; pi-&gt;default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;default_c=
ompute_power_profile.type =3D AMD_PP_COMPUTE_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Optimize comp=
ute power profile: Use only highest<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2 power =
levels (if more than 2 are available), Hysteresis:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 0ms up, =
5ms down<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pi-&gt;smc_s=
tate_table.GraphicsDpmLevelCount &gt; 2)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D pi-&gt;smc_state_table.Graphi=
csDpmLevelCount -<br>
&gt;&gt;&gt;&gt;&gt; 2;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (pi-&gt;=
smc_state_table.GraphicsDpmLevelCount =3D=3D 2)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;default_c=
ompute_power_profile.min_sclk =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; be32_to_cpu(levels[min_level].SclkFrequency);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;default_c=
ompute_power_profile.up_hyst =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;default_c=
ompute_power_profile.down_hyst =3D 5;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;gfx_power=
_profile =3D pi-&gt;default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;compute_p=
ower_profile =3D pi-&gt;default_compute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int ci_init_smc_table(struct amdgpu=
_device *adev)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct ci_power_info *pi =3D ci_get_pi(adev);<br>
&gt;&gt;&gt;&gt;&gt; @@ -3874,8 &#43;3840,6 @@ static int ci_init_smc_table=
(struct amdgpu_device<br>
&gt;&gt;&gt;&gt;&gt; *adev)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (ret)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ci_save_default_=
power_profile(adev);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; @@ -6753,222 &#43;6717,6 @@ static int ci_dpm_set_mclk=
_od(void *handle,<br>
&gt;&gt;&gt;&gt;&gt; uint32_t value)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static int ci_dpm_get_power_profile_state(void *handl=
e,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *query)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_de=
vice *adev =3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_=
info *pi =3D ci_get_pi(adev);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pi || !quer=
y)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (query-&gt;ty=
pe =3D=3D AMD_PP_GFX_PROFILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(query, &amp;pi-&gt;gfx_power_profile=
,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct amd_pp_p=
rofile));<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (query-&=
gt;type =3D=3D AMD_PP_COMPUTE_PROFILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(query, &amp;pi-&gt;compute_power_pro=
file,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct amd_pp_p=
rofile));<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static int ci_populate_requested_graphic_levels(struc=
t amdgpu_device<br>
&gt;&gt;&gt;&gt;&gt; *adev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_=
info *pi =3D ci_get_pi(adev);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_dpm_ta=
ble *dpm_table =3D &amp;(pi-&gt;dpm_table);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU7_Disc=
rete_GraphicsLevel *levels =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pi-&gt;smc_state_table.GraphicsLevel;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t array =
=3D pi-&gt;dpm_table_start &#43;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; offsetof(SMU7_Discrete_DpmTable, GraphicsLevel);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t array_s=
ize =3D sizeof(struct SMU7_Discrete_GraphicsLevel)<br>
&gt;&gt;&gt;&gt;&gt; *<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; SMU7_MAX_LEVELS_GRAPHICS;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; dpm_table-&gt;sclk_table.count; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].ActivityLevel =3D<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; cpu_to_be16(request-&gt;activity_threshold);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].EnabledForActivity =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].UpH =3D request-&gt;up_hyst;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].DownH =3D request-&gt;down_hyst;<=
br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_ci=
_copy_bytes_to_smc(adev, array, (uint8_t<br>
&gt;&gt;&gt;&gt;&gt; *)levels,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; array_size, pi-&gt;sra=
m_end);<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static void ci_find_min_clock_masks(struct amdgpu_dev=
ice *adev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *sclk_mask, uint32_t *mclk_mask,<b=
r>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_sclk, uint32_t min_mclk)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_=
info *pi =3D ci_get_pi(adev);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_dpm_ta=
ble *dpm_table =3D &amp;(pi-&gt;dpm_table);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; dpm_table-&gt;sclk_table.count; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&gt;sclk_table.dpm_levels[i].=
enabled &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dpm_table-&gt;sclk_table.dpm_levels[i].value &gt;=3D<br>
&gt;&gt;&gt;&gt;&gt; min_sclk)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; *sclk_mask |=3D 1 &lt;&lt; i;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; dpm_table-&gt;mclk_table.count; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&gt;mclk_table.dpm_levels[i].=
enabled &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dpm_table-&gt;mclk_table.dpm_levels[i].value &gt;=3D<br>
&gt;&gt;&gt;&gt;&gt; min_mclk)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; *mclk_mask |=3D 1 &lt;&lt; i;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static int ci_set_power_profile_state(struct amdgpu_d=
evice *adev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_=
info *pi =3D ci_get_pi(adev);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int tmp_result, =
result =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_ma=
sk =3D 0, mclk_mask =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_result =3D c=
i_freeze_sclk_mclk_dpm(adev);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp_result) =
{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to freeze SCLK MCLK =
DPM!&quot;);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D tmp_result;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_result =3D c=
i_populate_requested_graphic_levels(adev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; request);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp_result) =
{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to populate requeste=
d graphic<br>
&gt;&gt;&gt;&gt;&gt; levels!&quot;);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D tmp_result;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_result =3D c=
i_unfreeze_sclk_mclk_dpm(adev);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp_result) =
{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to unfreeze SCLK MCL=
K DPM!&quot;);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D tmp_result;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ci_find_min_cloc=
k_masks(adev, &amp;sclk_mask, &amp;mclk_mask,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; request-&gt;min_sclk, request-&gt;min_mclk);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sclk_mask) {=
<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pi-&gt;sclk_dpm_key_disabled)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ci_send_msg_to_smc_with_parameter(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SCLKDPM_SetE=
nabledMask,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;dpm_level_enabl=
e_mask.<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sclk_dpm_enable_mask &=
amp;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sclk_mask);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mclk_mask) {=
<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pi-&gt;mclk_dpm_key_disabled)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ci_send_msg_to_smc_with_parameter(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_MCLKDPM_SetE=
nabledMask,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;dpm_level_enabl=
e_mask.<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mclk_dpm_enable_mask &=
amp;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mclk_mask);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<b=
r>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static int ci_dpm_set_power_profile_state(void *handl=
e,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_de=
vice *adev =3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_=
info *pi =3D ci_get_pi(adev);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -1;<=
br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pi || !requ=
est)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pm.=
dpm.forced_level !=3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AMD_DPM_FORCED_LEVEL_AUTO)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;=
min_sclk ||<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;min_mclk ||<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;activity_threshold ||<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;up_hyst ||<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;down_hyst) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;type =3D=3D AMD_PP_GFX_PROF=
ILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; memcpy(&amp;pi-&gt;gfx_power_profile, request,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct amd_pp_profile));<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (request-&gt;type =3D=3D AMD_PP_COM=
PUTE_PROFILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; memcpy(&amp;pi-&gt;compute_power_profile, request,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct amd_pp_profile));<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;type =3D=3D pi-&gt;current_=
power_profile)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D ci_set_power_profile_state(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; request);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set power profile if it exists */<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (request-&gt;type) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_PP_GFX_PROFILE:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D ci_set_power_profile_state(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pi-&gt;gfx_power_=
profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_PP_COMPUTE_PROFILE:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D ci_set_power_profile_state(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pi-&gt;compute_po=
wer_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;current_power_profile =3D request-&g=
t;type;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static int ci_dpm_reset_power_profile_state(void *han=
dle,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_de=
vice *adev =3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_=
info *pi =3D ci_get_pi(adev);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pi || !requ=
est)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;=
type =3D=3D AMD_PP_GFX_PROFILE) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;gfx_power_profile =3D pi-&gt;default=
_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ci_dpm_set_power_profile_state(adev,=
<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pi-&gt;gfx_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (reque=
st-&gt;type =3D=3D AMD_PP_COMPUTE_PROFILE) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pi-&gt;compute_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; pi-&gt;default_compute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ci_dpm_set_power_profile_state(adev,=
<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pi-&gt;compute_power_profile);<b=
r>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static int ci_dpm_switch_power_profile(void *handle,<=
br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_profile_type type)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_de=
vice *adev =3D (struct amdgpu_device *)handle;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_power_=
info *pi =3D ci_get_pi(adev);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile request =3D {0};<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pi)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pi-&gt;curre=
nt_power_profile !=3D type) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request.type =3D type;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ci_dpm_set_power_profile_state(adev,=
 &amp;request);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int ci_dpm_read_sensor(void *handle=
, int idx,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *value, int *=
size)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt; @@ -7053,10 &#43;6801,6 @@ static int ci_dpm_read_sens=
or(void *handle, int<br>
&gt;&gt;&gt;&gt;&gt; idx,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.set_mclk_od =3D ci_dpm_set_mclk_od,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.check_state_equal =3D ci_check_state_equal,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.get_vce_clock_state =3D amdgpu_get_vce_clock_state,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profi=
le_state =3D ci_dpm_get_power_profile_state,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profi=
le_state =3D ci_dpm_set_power_profile_state,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_power_pro=
file_state =3D ci_dpm_reset_power_profile_state,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .switch_power_pr=
ofile =3D ci_dpm_switch_power_profile,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.read_sensor =3D ci_dpm_read_sensor,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.h<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.h<br>
&gt;&gt;&gt;&gt;&gt; index 84cbc9c..91be299 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.h<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.h<=
br>
&gt;&gt;&gt;&gt;&gt; @@ -295,13 &#43;295,6 @@ struct ci_power_info {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
bool fan_is_controlled_by_smc;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
u32 t_min;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
u32 fan_ctrl_default_mode;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* power profile=
 */<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile compute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile default_compute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_prof=
ile_type current_power_profile;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; #define CISLANDS_VOLTAGE_CONTROL_NONE&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interf=
ace.h<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
&gt;&gt;&gt;&gt;&gt; index 22c2fa3..7dfba2d 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<b=
r>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_pp_i=
nterface.h<br>
&gt;&gt;&gt;&gt;&gt; @@ -260,13 &#43;260,6 @@ struct amd_pm_funcs {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int (*get_pp_table)(void *handle, char **table);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int (*set_pp_table)(void *handle, const char *buf, size_t<br>
&gt;&gt;&gt;&gt;&gt; size);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
void (*debugfs_print_current_performance_level)(void *handle,<br>
&gt;&gt;&gt;&gt;&gt; struct seq_file *m);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*reset_powe=
r_profile_state)(void *handle,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amd_pp_profile *request);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_power_=
profile_state)(void *handle,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amd_pp_profile *query);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_=
profile_state)(void *handle,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amd_pp_profile *request);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int (*switch_power_profile)(void *handle,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; enum amd_pp_profile_type type);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; /* export to amdgpu */<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerpl=
ay.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt;&gt;&gt;&gt;&gt; index 5feb91b..5f5fbb6 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br=
>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_po=
werplay.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -1014,58 &#43;1014,6 @@ static int pp_dpm_read_sens=
or(void *handle, int<br>
&gt;&gt;&gt;&gt;&gt; idx,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return NULL;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static int pp_dpm_reset_power_profile_state(void *han=
dle,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr =
*hwmgr;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_instan=
ce *pp_handle =3D (struct pp_instance *)handle;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!request || =
pp_check(pp_handle))<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr =3D pp_han=
dle-&gt;hwmgr;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hw=
mgr_func-&gt;set_power_profile_state =3D=3D NULL) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quo=
t;, __func__);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;=
type =3D=3D AMD_PP_GFX_PROFILE) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;gfx_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-&gt;set_power_p=
rofile_state(hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hwmgr-&gt;gfx_pow=
er_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (reque=
st-&gt;type =3D=3D AMD_PP_COMPUTE_PROFILE) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;compute_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;default_comp=
ute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;hwmgr_func-&gt;set_power_p=
rofile_state(hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hwmgr-&gt;compute=
_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static int pp_dpm_get_power_profile_state(void *handl=
e,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *query)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr =
*hwmgr;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_instan=
ce *pp_handle =3D (struct pp_instance *)handle;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!query || pp=
_check(pp_handle))<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr =3D pp_han=
dle-&gt;hwmgr;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (query-&gt;ty=
pe =3D=3D AMD_PP_GFX_PROFILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(query, &amp;hwmgr-&gt;gfx_power_prof=
ile,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct amd_pp_p=
rofile));<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (query-&=
gt;type =3D=3D AMD_PP_COMPUTE_PROFILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(query, &amp;hwmgr-&gt;compute_power_=
profile,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct amd_pp_p=
rofile));<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int pp_get_power_profile_mode(void =
*handle, char *buf)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct pp_hwmgr *hwmgr;<br>
&gt;&gt;&gt;&gt;&gt; @@ -1124,65 &#43;1072,6 @@ static int pp_odn_edit_dpm_=
table(void *handle,<br>
&gt;&gt;&gt;&gt;&gt; uint32_t type, long *input, uint3<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return hwmgr-&gt;hwmgr_func-&gt;odn_edit_dpm_table(hwmgr, type,<br>
&gt;&gt;&gt;&gt;&gt; input, size);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static int pp_dpm_set_power_profile_state(void *handl=
e,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr =
*hwmgr;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_instan=
ce *pp_handle =3D (struct pp_instance *)handle;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -1;<=
br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!request || =
pp_check(pp_handle))<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr =3D pp_han=
dle-&gt;hwmgr;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hw=
mgr_func-&gt;set_power_profile_state =3D=3D NULL) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&quo=
t;, __func__);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;=
min_sclk ||<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;min_mclk ||<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;activity_threshold ||<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;up_hyst ||<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;down_hyst) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;type =3D=3D AMD_PP_GFX_PROF=
ILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; memcpy(&amp;hwmgr-&gt;gfx_power_profile, request,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct amd_pp_profile));<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (request-&gt;type =3D=3D AMD_PP_COM=
PUTE_PROFILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; memcpy(&amp;hwmgr-&gt;compute_power_profile, request,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(struct amd_pp_profile));<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;type =3D=3D hwmgr-&gt;curre=
nt_power_profile)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_state(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; request);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set power profile if it exists */<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (request-&gt;type) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_PP_GFX_PROFILE:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_state(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hwmgr-&gt;gfx_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_PP_COMPUTE_PROFILE:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_state(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hwmgr-&gt;compute_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;current_power_profile =3D request=
-&gt;type;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int pp_dpm_switch_power_profile(voi=
d *handle,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_profile_type ty=
pe)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt; @@ -1590,9 &#43;1479,6 @@ static int pp_set_mmhub_powe=
rgating_by_smu(void<br>
&gt;&gt;&gt;&gt;&gt; *handle)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.set_mclk_od =3D pp_dpm_set_mclk_od,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.read_sensor =3D pp_dpm_read_sensor,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.get_vce_clock_state =3D pp_dpm_get_vce_clock_state,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_power_pro=
file_state =3D pp_dpm_reset_power_profile_state,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_power_profi=
le_state =3D pp_dpm_get_power_profile_state,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profi=
le_state =3D pp_dpm_set_power_profile_state,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.switch_power_profile =3D pp_dpm_switch_power_profile,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.set_clockgating_by_smu =3D pp_set_clockgating_by_smu,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.notify_smu_memory_info =3D pp_dpm_notify_smu_memory_info,<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hardw=
aremanager.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremanager.=
c<br>
&gt;&gt;&gt;&gt;&gt; index 33480de..f06f8f4 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hardwaremana=
ger.c<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/=
hardwaremanager.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -128,23 &#43;128,6 @@ int phm_force_dpm_levels(stru=
ct pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; enum amd_dpm_forced_level level<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return ret;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -int phm_reset_power_profile_state(struct pp_hwmgr *hw=
mgr)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<b=
r>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hw=
mgr_func-&gt;set_power_profile_state) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;current_power_profile =3D=3D =
AMD_PP_GFX_PROFILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_state(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hwmgr-&gt;gfx_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (hwmgr-&gt;current_power_profile =
=3D=3D<br>
&gt;&gt;&gt;&gt;&gt; AMD_PP_COMPUTE_PROFILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ret =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;hwmgr_func-&gt;set_power_profile_state(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; &amp;hwmgr-&gt;compute_power_profile);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; int phm_apply_state_adjust_rules(struct pp=
_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; struct pp_power_state *adjusted_ps,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pp_power_st=
ate *current_ps)<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_ps=
m.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c<br>
&gt;&gt;&gt;&gt;&gt; index 95ab772..ed3bd15 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/=
pp_psm.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -247,8 &#43;247,6 @@ int psm_adjust_power_state_dyn=
amic(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr, bool skip,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (!phm_force_dpm_levels(hwmgr, hwmgr-&gt;request_dpm_level))<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dpm_level =3D hwm=
gr-&gt;request_dpm_level;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_reset_power_=
profile_state(hwmgr);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_=
hwmgr.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt;&gt;&gt;&gt;&gt; index f09c76a..cb75c4f 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c=
<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/=
smu7_hwmgr.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -4622,89 &#43;4622,6 @@ static int smu7_get_clock_b=
y_type(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr, enum amd_pp_clock_type<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static void smu7_find_min_clock_masks(struct pp_hwmgr=
 *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *sclk_mask, uint32_t *mclk_mask,<b=
r>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_sclk, uint32_t min_mclk)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmg=
r *data =3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_dpm_=
table *dpm_table =3D &amp;(data-&gt;dpm_table);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; dpm_table-&gt;sclk_table.count; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&gt;sclk_table.dpm_levels[i].=
enabled &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dpm_table-&gt;sclk_table.dpm_levels[i].value &gt;=3D<br>
&gt;&gt;&gt;&gt;&gt; min_sclk)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; *sclk_mask |=3D 1 &lt;&lt; i;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; dpm_table-&gt;mclk_table.count; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&gt;mclk_table.dpm_levels[i].=
enabled &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dpm_table-&gt;mclk_table.dpm_levels[i].value &gt;=3D<br>
&gt;&gt;&gt;&gt;&gt; min_mclk)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; *mclk_mask |=3D 1 &lt;&lt; i;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static int smu7_set_power_profile_state(struct pp_hwm=
gr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmg=
r *data =3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int tmp_result, =
result =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_ma=
sk =3D 0, mclk_mask =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;ch=
ip_id =3D=3D CHIP_FIJI) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;type =3D=3D AMD_PP_GFX_PROF=
ILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu7_enable_power_containment(hwmgr);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (request-&gt;type =3D=3D AMD_PP_COM=
PUTE_PROFILE)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu7_disable_power_containment(hwmgr);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dp=
m_level !=3D AMD_DPM_FORCED_LEVEL_AUTO)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smum_is_dpm_=
running(hwmgr)) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;sclk_dpm_key_disabled)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smum_send_msg_to_smc(hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; PPSMC_MSG_SCLKDPM_FreezeLevel);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;mclk_dpm_key_disabled)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smum_send_msg_to_smc(hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; PPSMC_MSG_MCLKDPM_FreezeLevel);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_result =3D s=
mum_populate_requested_graphic_levels(hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; request);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_C=
ODE(!tmp_result,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;Failed to populate requested graphic levels!&quot;,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; result =3D tmp_result);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smum_is_dpm_=
running(hwmgr)) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;sclk_dpm_key_disabled)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smum_send_msg_to_smc(hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; PPSMC_MSG_SCLKDPM_UnfreezeLevel);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;mclk_dpm_key_disabled)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smum_send_msg_to_smc(hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; PPSMC_MSG_MCLKDPM_UnfreezeLevel);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_find_min_cl=
ock_masks(hwmgr, &amp;sclk_mask, &amp;mclk_mask,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; request-&gt;min_sclk, request-&gt;min_mclk);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sclk_mask) {=
<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;sclk_dpm_key_disabled)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SCLKDPM_SetE=
nabledMask,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_level_ena=
ble_mask.<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sclk_dpm_enable_mask &=
amp;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sclk_mask);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mclk_mask) {=
<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;mclk_dpm_key_disabled)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smum_send_msg_to_smc_with_parameter(hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_MCLKDPM_SetE=
nabledMask,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;dpm_level_ena=
ble_mask.<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mclk_dpm_enable_mask &=
amp;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mclk_mask);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<b=
r>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int smu7_notify_cac_buffer_info(str=
uct pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t virtual_addr_low,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t virtual_addr_hi,<br>
&gt;&gt;&gt;&gt;&gt; @@ -5154,7 &#43;5071,6 @@ static int smu7_set_power_pr=
ofile_mode(struct<br>
&gt;&gt;&gt;&gt;&gt; pp_hwmgr *hwmgr, long *input, uint<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.get_clock_by_type =3D smu7_get_clock_by_type,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.read_sensor =3D smu7_read_sensor,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.dynamic_state_management_disable =3D smu7_disable_dpm_tasks,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profi=
le_state =3D smu7_set_power_profile_state,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.avfs_control =3D smu7_avfs_control,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.disable_smc_firmware_ctf =3D smu7_thermal_disable_alert,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.start_thermal_controller =3D smu7_start_thermal_controller,<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega1=
0_hwmgr.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt;&gt;&gt;&gt;&gt; index f5df20a..1416d2a 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr=
.c<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/=
vega10_hwmgr.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -2405,34 &#43;2405,6 @@ static int<br>
&gt;&gt;&gt;&gt;&gt; vega10_populate_and_upload_avfs_fuse_override(struct p=
p_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return result;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static int vega10_save_default_power_profile(struct p=
p_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hw=
mgr *data =3D (struct vega10_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *)(hwmgr-&gt;backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_si=
ngle_dpm_table *dpm_table =3D<br>
&gt;&gt;&gt;&gt;&gt; &amp;(data-&gt;dpm_table.gfx_table);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_lev=
el;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.type =3D AMD_PP_GFX_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.type =3D<br>
&gt;&gt;&gt;&gt;&gt; AMD_PP_COMPUTE_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Optimize comp=
ute power profile: Use only highest<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2 power =
levels (if more than 2 are available)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&g=
t;count &gt; 2)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D dpm_table-&gt;count - 2;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (dpm_tab=
le-&gt;count =3D=3D 2)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.min_sclk =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dpm_table-&gt;dpm_levels[min_level].value;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;gfx_po=
wer_profile =3D hwmgr-&gt;default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;comput=
e_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;default_compute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; /**<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; * Initializes the SMC table and uploads it=
<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; *<br>
&gt;&gt;&gt;&gt;&gt; @@ -2576,7 &#43;2548,6 @@ static int vega10_init_smc_t=
able(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PP_ASSERT_WITH_CODE(!result, &quot;Attempt to enable AVFS feature<br>
&gt;&gt;&gt;&gt;&gt; Failed!&quot;,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
vega10_acg_enable(hwmgr);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_save_defa=
ult_power_profile(hwmgr);<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; @@ -4729,62 &#43;4700,6 @@ static int vega10_power_off=
_asic(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return result;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static void vega10_find_min_clock_index(struct pp_hwm=
gr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *sclk_idx, uint32_t *mclk_idx,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t min_sclk, uint32_t min_mclk)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hw=
mgr *data =3D (struct vega10_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *)(hwmgr-&gt;backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_dp=
m_table *dpm_table =3D &amp;(data-&gt;dpm_table);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; dpm_table-&gt;gfx_table.count; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&gt;gfx_table.dpm_levels[i].e=
nabled &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dpm_table-&gt;gfx_table.dpm_levels[i].value &gt;=3D<br>
&gt;&gt;&gt;&gt;&gt; min_sclk) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; *sclk_idx =3D i;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; dpm_table-&gt;mem_table.count; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&gt;mem_table.dpm_levels[i].e=
nabled &amp;&amp;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dpm_table-&gt;mem_table.dpm_levels[i].value &gt;=3D<br>
&gt;&gt;&gt;&gt;&gt; min_mclk) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; *mclk_idx =3D i;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -static int vega10_set_power_profile_state(struct pp_h=
wmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hw=
mgr *data =3D (struct vega10_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *)(hwmgr-&gt;backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_id=
x =3D ~0, mclk_idx =3D ~0;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dp=
m_level !=3D AMD_DPM_FORCED_LEVEL_AUTO)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_find_min_=
clock_index(hwmgr, &amp;sclk_idx, &amp;mclk_idx,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; request-&gt;min_sclk, request-&gt;min_mclk);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sclk_idx !=
=3D ~0) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;registry_data.sclk_dpm_key_di=
sabled)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smum_send_msg_to_smc_with_parameter(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; PPSMC_MSG_SetSoftMinGfxclkByIndex,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; sclk_idx);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mclk_idx !=
=3D ~0) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data-&gt;registry_data.mclk_dpm_key_di=
sabled)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smum_send_msg_to_smc_with_parameter(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; PPSMC_MSG_SetSoftMinUclkByIndex,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; mclk_idx);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int vega10_get_sclk_od(struct pp_hw=
mgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct vega10_hwmgr *data =3D (struct vega10_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *)(hwmgr-&gt;backend);<br>
&gt;&gt;&gt;&gt;&gt; @@ -5078,7 &#43;4993,6 @@ static int vega10_set_power_=
profile_mode(struct<br>
&gt;&gt;&gt;&gt;&gt; pp_hwmgr *hwmgr, long *input, ui<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; vega10_check_smc_update_required_for_display_configura=
tion,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.power_off_asic =3D vega10_power_off_asic,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.disable_smc_firmware_ctf =3D vega10_thermal_disable_alert,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_power_profi=
le_state =3D vega10_set_power_profile_state,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.get_sclk_od =3D vega10_get_sclk_od,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.set_sclk_od =3D vega10_set_sclk_od,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.get_mclk_od =3D vega10_get_mclk_od,<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/hardwar=
emanager.h<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/inc/hardwaremanager.h<=
br>
&gt;&gt;&gt;&gt;&gt; index 6f528e6..b366a5b 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hardwaremanage=
r.h<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/ha=
rdwaremanager.h<br>
&gt;&gt;&gt;&gt;&gt; @@ -448,6 &#43;448,5 @@ extern int phm_display_clock_v=
oltage_request(struct<br>
&gt;&gt;&gt;&gt;&gt; pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; extern int phm_get_max_high_clocks(struct =
pp_hwmgr *hwmgr, struct<br>
&gt;&gt;&gt;&gt;&gt; amd_pp_simple_clock_info *clocks);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; extern int phm_disable_smc_firmware_ctf(st=
ruct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt;&gt;&gt; -extern int phm_reset_power_profile_state(struct pp_hw=
mgr *hwmgr);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; #endif /* _HARDWARE_MANAGER_H_ */<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h=
<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt;&gt;&gt;&gt;&gt; index 7b19be4..a3beb31 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hw=
mgr.h<br>
&gt;&gt;&gt;&gt;&gt; @@ -236,8 &#43;236,6 @@ struct pp_smumgr_func {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
uint32_t (*get_offsetof)(uint32_t type, uint32_t member);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
uint32_t (*get_mac_definition)(uint32_t value);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
bool (*is_dpm_running)(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*populate_r=
equested_graphic_levels)(struct pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amd_pp_profile *request);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
bool (*is_hw_avfs_present)(struct pp_hwmgr&nbsp; *hwmgr);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int (*update_dpm_settings)(struct pp_hwmgr *hwmgr, void<br>
&gt;&gt;&gt;&gt;&gt; *profile_setting);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&gt; @@ -329,8 &#43;327,6 @@ struct pp_hwmgr_func {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int (*get_mclk_od)(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int (*set_mclk_od)(struct pp_hwmgr *hwmgr, uint32_t value);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int (*read_sensor)(struct pp_hwmgr *hwmgr, int idx, void<br>
&gt;&gt;&gt;&gt;&gt; *value, int *size);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_power_=
profile_state)(struct pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amd_pp_profile *request);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int (*avfs_control)(struct pp_hwmgr *hwmgr, bool enable);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int (*disable_smc_firmware_ctf)(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int (*set_active_display_count)(struct pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; uint32_t count);<br>
&gt;&gt;&gt;&gt;&gt; @@ -752,11 &#43;748,6 @@ struct pp_hwmgr {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
uint32_t feature_mask;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/* UMD Pstate */<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile compute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_pr=
ofile default_compute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_prof=
ile_type current_power_profile;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
bool en_umd_pstate;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
uint32_t power_profile_mode;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
uint32_t default_power_profile_mode;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.=
h<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
&gt;&gt;&gt;&gt;&gt; index e05a57e..e1f6e83 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/sm=
umgr.h<br>
&gt;&gt;&gt;&gt;&gt; @@ -129,9 &#43;129,6 @@ extern uint32_t smum_get_offse=
tof(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; extern bool smum_is_dpm_running(struct pp_=
hwmgr *hwmgr);<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -extern int smum_populate_requested_graphic_levels(str=
uct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; extern bool smum_is_hw_avfs_present(struct=
 pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; extern int smum_update_dpm_settings(struct=
 pp_hwmgr *hwmgr, void<br>
&gt;&gt;&gt;&gt;&gt; *profile_setting);<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_s=
mumgr.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c<br>
&gt;&gt;&gt;&gt;&gt; index 6dd10ef..6f4bf7e 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c=
<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr=
/ci_smumgr.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -2772,32 &#43;2772,6 @@ static bool ci_is_dpm_runni=
ng(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return ci_is_smc_ram_running(hwmgr);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static int ci_populate_requested_graphic_levels(struc=
t pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct amd_pp_profile<br>
&gt;&gt;&gt;&gt;&gt; *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ci_smumgr=
 *smu_data =3D (struct ci_smumgr *)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (hwmgr-&gt;smu_backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU7_Disc=
rete_GraphicsLevel *levels =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu_data-&gt;smc_state_table.GraphicsLevel;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t array =
=3D smu_data-&gt;dpm_table_start &#43;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; offsetof(SMU7_Discrete_DpmTable, GraphicsLevel);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t array_s=
ize =3D sizeof(struct SMU7_Discrete_GraphicsLevel)<br>
&gt;&gt;&gt;&gt;&gt; *<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; SMU7_MAX_LEVELS_GRAPHICS;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; smu_data-&gt;smc_state_table.GraphicsDpmLevelCount;<br>
&gt;&gt;&gt;&gt;&gt; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].ActivityLevel =3D<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; cpu_to_be16(request-&gt;activity_threshold);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].EnabledForActivity =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].UpH =3D request-&gt;up_hyst;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].DownH =3D request-&gt;down_hyst;<=
br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ci_copy_b=
ytes_to_smc(hwmgr, array, (uint8_t *)levels,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; array_size, SMC_RAM_EN=
D);<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int ci_smu_init(struct pp_hwmgr *hw=
mgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
struct ci_smumgr *ci_priv =3D NULL;<br>
&gt;&gt;&gt;&gt;&gt; @@ -2942,6 &#43;2916,5 @@ static int ci_update_dpm_set=
tings(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.get_mac_definition =3D ci_get_mac_definition,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.initialize_mc_reg_table =3D ci_initialize_mc_reg_table,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.is_dpm_running =3D ci_is_dpm_running,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .populate_reques=
ted_graphic_levels =3D<br>
&gt;&gt;&gt;&gt;&gt; ci_populate_requested_graphic_levels,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.update_dpm_settings =3D ci_update_dpm_settings,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji=
_smumgr.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<b=
r>
&gt;&gt;&gt;&gt;&gt; index f7f58f77..220159f 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr=
.c<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr=
/fiji_smumgr.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -1960,44 &#43;1960,6 @@ static int fiji_init_arb_ta=
ble_index(struct<br>
&gt;&gt;&gt;&gt;&gt; pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; smu_data-&gt;smu7_data.arb_table_start,&nbsp; tmp,<br>
&gt;&gt;&gt;&gt;&gt; SMC_RAM_END);<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static int fiji_save_default_power_profile(struct pp_=
hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct fiji_smum=
gr *data =3D (struct fiji_smumgr<br>
&gt;&gt;&gt;&gt;&gt; *)(hwmgr-&gt;smu_backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU73_Dis=
crete_GraphicsLevel *levels =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smc_state_tab=
le.GraphicsLevel;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned min_lev=
el =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.activity_threshold =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; be16_to_cpu(levels[0].ActivityLevel);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.up_hyst =3D levels[0].UpHyst;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.down_hyst =3D levels[0].DownHyst;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.type =3D AMD_PP_GFX_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.type =3D<br>
&gt;&gt;&gt;&gt;&gt; AMD_PP_COMPUTE_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaround co=
mpute SDMA instability: disable lowest SCLK<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * DPM leve=
l. Optimize compute power profile: Use only highest<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2 power =
levels (if more than 2 are available), Hysteresis:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 0ms up, =
5ms down<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smc=
_state_table.GraphicsDpmLevelCount &gt; 2)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D data-&gt;smc_state_table.Grap=
hicsDpmLevelCount<br>
&gt;&gt;&gt;&gt;&gt; - 2;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (data-&g=
t;smc_state_table.GraphicsDpmLevelCount =3D=3D 2)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.min_sclk =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; be32_to_cpu(levels[min_level].SclkFrequency);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.up_hyst =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.down_hyst =3D 5;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;gfx_po=
wer_profile =3D hwmgr-&gt;default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;comput=
e_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;default_compute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int fiji_setup_dpm_led_config(struc=
t pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
pp_atomctrl_voltage_table param_led_dpm;<br>
&gt;&gt;&gt;&gt;&gt; @@ -2238,8 &#43;2200,6 @@ static int fiji_init_smc_tab=
le(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PP_ASSERT_WITH_CODE(0 =3D=3D result,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to setup dpm led =
config&quot;, return<br>
&gt;&gt;&gt;&gt;&gt; result);<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fiji_save_defaul=
t_power_profile(hwmgr);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; @@ -2694,31 &#43;2654,6 @@ static bool fiji_is_dpm_run=
ning(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ? true : false;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static int fiji_populate_requested_graphic_levels(str=
uct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct fiji_smum=
gr *smu_data =3D (struct fiji_smumgr *)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (hwmgr-&gt;smu_backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU73_Dis=
crete_GraphicsLevel *levels =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu_data-&gt;smc_state_table.GraphicsLevel;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t array =
=3D smu_data-&gt;smu7_data.dpm_table_start &#43;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; offsetof(SMU73_Discrete_DpmTable,<br>
&gt;&gt;&gt;&gt;&gt; GraphicsLevel);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t array_s=
ize =3D sizeof(struct<br>
&gt;&gt;&gt;&gt;&gt; SMU73_Discrete_GraphicsLevel) *<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; SMU73_MAX_LEVELS_GRAPHICS;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; smu_data-&gt;smc_state_table.GraphicsDpmLevelCount;<br>
&gt;&gt;&gt;&gt;&gt; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].ActivityLevel =3D<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; cpu_to_be16(request-&gt;activity_threshold);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].EnabledForActivity =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].UpHyst =3D request-&gt;up_hyst;<b=
r>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].DownHyst =3D request-&gt;down_hys=
t;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu7_copy=
_bytes_to_smc(hwmgr, array, (uint8_t *)levels,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; array_size, SMC_RAM_EN=
D);<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int fiji_update_dpm_settings(struct=
 pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *=
profile_setting)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt; @@ -2838,7 &#43;2773,6 @@ static int fiji_update_dpm_s=
ettings(struct<br>
&gt;&gt;&gt;&gt;&gt; pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.get_mac_definition =3D fiji_get_mac_definition,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.initialize_mc_reg_table =3D fiji_initialize_mc_reg_table,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.is_dpm_running =3D fiji_is_dpm_running,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .populate_reques=
ted_graphic_levels =3D<br>
&gt;&gt;&gt;&gt;&gt; fiji_populate_requested_graphic_levels,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.is_hw_avfs_present =3D fiji_is_hw_avfs_present,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.update_dpm_settings =3D fiji_update_dpm_settings,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/pola=
ris10_smumgr.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumg=
r.c<br>
&gt;&gt;&gt;&gt;&gt; index ae07b5d..75f46ed 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_s=
mumgr.c<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr=
/polaris10_smumgr.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -1840,42 &#43;1840,6 @@ static void<br>
&gt;&gt;&gt;&gt;&gt; polaris10_initialize_power_tune_defaults(struct pp_hwm=
gr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static void polaris10_save_default_power_profile(stru=
ct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct polaris10=
_smumgr *data =3D (struct polaris10_smumgr<br>
&gt;&gt;&gt;&gt;&gt; *)(hwmgr-&gt;smu_backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU74_Dis=
crete_GraphicsLevel *levels =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smc_state_tab=
le.GraphicsLevel;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned min_lev=
el =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.activity_threshold =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; be16_to_cpu(levels[0].ActivityLevel);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.up_hyst =3D levels[0].UpHyst;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.down_hyst =3D levels[0].DownHyst;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.type =3D AMD_PP_GFX_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.type =3D<br>
&gt;&gt;&gt;&gt;&gt; AMD_PP_COMPUTE_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaround co=
mpute SDMA instability: disable lowest SCLK<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * DPM leve=
l. Optimize compute power profile: Use only highest<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2 power =
levels (if more than 2 are available), Hysteresis:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 0ms up, =
5ms down<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smc=
_state_table.GraphicsDpmLevelCount &gt; 2)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D data-&gt;smc_state_table.Grap=
hicsDpmLevelCount<br>
&gt;&gt;&gt;&gt;&gt; - 2;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (data-&g=
t;smc_state_table.GraphicsDpmLevelCount =3D=3D 2)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.min_sclk =3D<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; be32_to_cpu(levels[min_level].SclkSetting.SclkFrequenc=
y);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.up_hyst =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.down_hyst =3D 5;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;gfx_po=
wer_profile =3D hwmgr-&gt;default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;comput=
e_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;default_compute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int polaris10_init_smc_table(struct=
 pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int result;<br>
&gt;&gt;&gt;&gt;&gt; @@ -2090,8 &#43;2054,6 @@ static int polaris10_init_sm=
c_table(struct<br>
&gt;&gt;&gt;&gt;&gt; pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PP_ASSERT_WITH_CODE(0 =3D=3D result,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &quot;Failed to&nbsp; populate PM fuses to SMC memory!=
&quot;,<br>
&gt;&gt;&gt;&gt;&gt; return result);<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; polaris10_save_d=
efault_power_profile(hwmgr);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; @@ -2550,31 &#43;2512,6 @@ static bool polaris10_is_dp=
m_running(struct<br>
&gt;&gt;&gt;&gt;&gt; pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ? true : false;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static int polaris10_populate_requested_graphic_level=
s(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct polaris10=
_smumgr *smu_data =3D (struct polaris10_smumgr *)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (hwmgr-&gt;smu_backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU74_Dis=
crete_GraphicsLevel *levels =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu_data-&gt;smc_state_table.GraphicsLevel;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t array =
=3D smu_data-&gt;smu7_data.dpm_table_start &#43;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; offsetof(SMU74_Discrete_DpmTable,<br>
&gt;&gt;&gt;&gt;&gt; GraphicsLevel);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t array_s=
ize =3D sizeof(struct<br>
&gt;&gt;&gt;&gt;&gt; SMU74_Discrete_GraphicsLevel) *<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; SMU74_MAX_LEVELS_GRAPHICS;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i =
&lt; smu_data-&gt;smc_state_table.GraphicsDpmLevelCount;<br>
&gt;&gt;&gt;&gt;&gt; i&#43;&#43;) {<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].ActivityLevel =3D<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; cpu_to_be16(request-&gt;activity_threshold);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].EnabledForActivity =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].UpHyst =3D request-&gt;up_hyst;<b=
r>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels[i].DownHyst =3D request-&gt;down_hys=
t;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu7_copy=
_bytes_to_smc(hwmgr, array, (uint8_t *)levels,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; array_size, SMC_RAM_EN=
D);<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int polaris10_update_dpm_settings(s=
truct pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *=
profile_setting)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt; @@ -2693,7 &#43;2630,6 @@ static int polaris10_update_=
dpm_settings(struct<br>
&gt;&gt;&gt;&gt;&gt; pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.populate_all_memory_levels =3D<br>
&gt;&gt;&gt;&gt;&gt; polaris10_populate_all_memory_levels,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.get_mac_definition =3D polaris10_get_mac_definition,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.is_dpm_running =3D polaris10_is_dpm_running,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .populate_reques=
ted_graphic_levels =3D<br>
&gt;&gt;&gt;&gt;&gt; polaris10_populate_requested_graphic_levels,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.is_hw_avfs_present =3D polaris10_is_hw_avfs_present,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.update_dpm_settings =3D polaris10_update_dpm_settings,<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; };<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smum=
gr.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c<br>
&gt;&gt;&gt;&gt;&gt; index 1ce4959..43b1010 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c<br=
>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr=
/smumgr.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -236,16 &#43;236,6 @@ bool smum_is_dpm_running(stru=
ct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return true;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -int smum_populate_requested_graphic_levels(struct pp_=
hwmgr *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;sm=
umgr_funcs-&gt;populate_requested_graphic_levels)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;smumgr_funcs-&gt;populate_requested_graphic_=
levels(<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr, request);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; bool smum_is_hw_avfs_present(struct pp_hwm=
gr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (hwmgr-&gt;smumgr_funcs-&gt;is_hw_avfs_present)<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tong=
a_smumgr.c<br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c<=
br>
&gt;&gt;&gt;&gt;&gt; index 1fe5b77..8856cc1 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumg=
r.c<br>
&gt;&gt;&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr=
/tonga_smumgr.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -2263,42 &#43;2263,6 @@ static void<br>
&gt;&gt;&gt;&gt;&gt; tonga_initialize_power_tune_defaults(struct pp_hwmgr *=
hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_data-&gt;power_tune_def=
aults =3D<br>
&gt;&gt;&gt;&gt;&gt; &amp;tonga_power_tune_data_set_array[0];<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static void tonga_save_default_power_profile(struct p=
p_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tonga_smu=
mgr *data =3D (struct tonga_smumgr<br>
&gt;&gt;&gt;&gt;&gt; *)(hwmgr-&gt;smu_backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU72_Dis=
crete_GraphicsLevel *levels =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;smc_state_tab=
le.GraphicsLevel;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned min_lev=
el =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.activity_threshold =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; be16_to_cpu(levels[0].ActivityLevel);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.up_hyst =3D levels[0].UpHyst;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.down_hyst =3D levels[0].DownHyst;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_gfx_power_profile.type =3D AMD_PP_GFX_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.type =3D<br>
&gt;&gt;&gt;&gt;&gt; AMD_PP_COMPUTE_PROFILE;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaround co=
mpute SDMA instability: disable lowest SCLK<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * DPM leve=
l. Optimize compute power profile: Use only highest<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2 power =
levels (if more than 2 are available), Hysteresis:<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 0ms up, =
5ms down<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smc=
_state_table.GraphicsDpmLevelCount &gt; 2)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D data-&gt;smc_state_table.Grap=
hicsDpmLevelCount<br>
&gt;&gt;&gt;&gt;&gt; - 2;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (data-&g=
t;smc_state_table.GraphicsDpmLevelCount =3D=3D 2)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D 1;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_level =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.min_sclk =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; be32_to_cpu(levels[min_level].SclkFrequency);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.up_hyst =3D 0;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;defaul=
t_compute_power_profile.down_hyst =3D 5;<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;gfx_po=
wer_profile =3D hwmgr-&gt;default_gfx_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;comput=
e_power_profile =3D<br>
&gt;&gt;&gt;&gt;&gt; hwmgr-&gt;default_compute_power_profile;<br>
&gt;&gt;&gt;&gt;&gt; -}<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; static int tonga_init_smc_table(struct pp_=
hwmgr *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; {<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
int result;<br>
&gt;&gt;&gt;&gt;&gt; @@ -2540,8 &#43;2504,6 @@ static int tonga_init_smc_ta=
ble(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PP_ASSERT_WITH_CODE((!result),<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to populate in=
itialize MC Reg table !&quot;, return<br>
&gt;&gt;&gt;&gt;&gt; result);<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tonga_save_defau=
lt_power_profile(hwmgr);<br>
&gt;&gt;&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; @@ -3259,31 &#43;3221,6 @@ static bool tonga_is_dpm_ru=
nning(struct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr)<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ? true : false;<br>
&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; -static int tonga_populate_requested_graphic_levels(st=
ruct pp_hwmgr<br>
&gt;&gt;&gt;&gt;&gt; *hwmgr,<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_profile *request)<br>
&gt;&gt;&gt;&gt;&gt; -{<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tonga_smu=
mgr *smu_data =3D (struct tonga_smumgr *)<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (hwmgr-&gt;smu_backend);<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct SMU72_Dis=
crete_GraphicsLevel *levels =3D<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; smu_data-&gt;smc_state_table.GraphicsLevel;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t array =
=3D smu_data-&gt;smu7_data.dpm_table_start &#43;<br>
&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; offsetof(SMU72_Discrete_DpmTable,<br>
&gt;&gt;&gt;&gt;&gt; GraphicsLevel);<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk332971" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15198213378460.011846198638625571" style=3D"margin-b=
ottom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15198213378410.3675979622063321" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15198213378430.4061625134332365" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15198213378440.4754310012077867"></div>
<div id=3D"LPTitle_15198213378440.8517533794060275" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15198213378440.05217627377197198" href=3D"https://list=
s.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text=
-decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15198213378450.7000805730375337" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15198213378450.08534817982192977" style=3D"display=
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
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16878777B1924926E2F48BB8FBC70CY4PR12MB1687namp_--

--===============1130802473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1130802473==--
