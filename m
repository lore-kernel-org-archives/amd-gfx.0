From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/6] drm/amd/pp: Add hwmgr_sw_init/fini functioins
Date: Thu, 22 Mar 2018 14:49:14 +0000
Message-ID: <CY4PR12MB1687BB4FAA9E0ED5916B0DB5FBA90@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1521718818-22687-1-git-send-email-Rex.Zhu@amd.com>
 <1521718818-22687-2-git-send-email-Rex.Zhu@amd.com>
 <CADnq5_PsnzfqnsHXsjBY36TaT85d6hVOWpgL-04coK8gcvOyGA@mail.gmail.com>
 <CADnq5_N9uegS=tM+=OEeL+kYy2xhYpBLisjfawQgwqFuLTpwkA@mail.gmail.com>,
 <CADnq5_NbKvyAEqkpGsNGUFBQkVrELctS2_rkRR+YHJMDfSajEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0552781723=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_NbKvyAEqkpGsNGUFBQkVrELctS2_rkRR+YHJMDfSajEg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0552781723==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687BB4FAA9E0ED5916B0DB5FBA90CY4PR12MB1687namp_"

--_000_CY4PR12MB1687BB4FAA9E0ED5916B0DB5FBA90CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks Alex.


I should be more careful when reorder patches .



Best Regards

Rex


________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, March 22, 2018 9:13 PM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 2/6] drm/amd/pp: Add hwmgr_sw_init/fini functioins

On Thu, Mar 22, 2018 at 9:13 AM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> On Thu, Mar 22, 2018 at 9:10 AM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
>> On Thu, Mar 22, 2018 at 7:40 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
>>> Clean up pp ip functions
>>>
>>> Change-Id: Id06159202edabdfcb19fcc20e1291ce93db56d5d
>>> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>>
>> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> Actually, doesn't this patch have a dependency on patch 3?  I think
> this part of patch 3:

Sorry, patch 4.

> +       hwmgr->pm_en =3D (amdgpu_dpm && hwmgr->not_vf) ? true : false;
> should be in this patch rather than the other patch.  With that fixed:
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
>>
>>> ---
>>>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 368 ++++++------------=
--------
>>>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c   |  74 ++++--
>>>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h     |   7 +-
>>>  3 files changed, 145 insertions(+), 304 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gp=
u/drm/amd/powerplay/amd_powerplay.c
>>> index 7e8ad30..5d7d9ec 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
>>> @@ -31,24 +31,11 @@
>>>  #include "amdgpu.h"
>>>  #include "hwmgr.h"
>>>
>>> -#define PP_DPM_DISABLED 0xCCCC
>>> -
>>>  static int pp_dpm_dispatch_tasks(void *handle, enum amd_pp_task task_i=
d,
>>>                 enum amd_pm_state_type *user_state);
>>>
>>>  static const struct amd_pm_funcs pp_dpm_funcs;
>>>
>>> -static inline int pp_check(struct pp_hwmgr *hwmgr)
>>> -{
>>> -       if (hwmgr =3D=3D NULL || hwmgr->smumgr_funcs =3D=3D NULL)
>>> -               return -EINVAL;
>>> -
>>> -       if (hwmgr->pm_en =3D=3D 0 || hwmgr->hwmgr_func =3D=3D NULL)
>>> -               return PP_DPM_DISABLED;
>>> -
>>> -       return 0;
>>> -}
>>> -
>>>  static int amd_powerplay_create(struct amdgpu_device *adev)
>>>  {
>>>         struct pp_hwmgr *hwmgr;
>>> @@ -73,7 +60,7 @@ static int amd_powerplay_create(struct amdgpu_device =
*adev)
>>>  }
>>>
>>>
>>> -static int amd_powerplay_destroy(struct amdgpu_device *adev)
>>> +static void amd_powerplay_destroy(struct amdgpu_device *adev)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>>>
>>> @@ -82,8 +69,6 @@ static int amd_powerplay_destroy(struct amdgpu_device=
 *adev)
>>>
>>>         kfree(hwmgr);
>>>         hwmgr =3D NULL;
>>> -
>>> -       return 0;
>>>  }
>>>
>>>  static int pp_early_init(void *handle)
>>> @@ -109,18 +94,9 @@ static int pp_sw_init(void *handle)
>>>         struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret >=3D 0) {
>>> -               if (hwmgr->smumgr_funcs->smu_init =3D=3D NULL)
>>> -                       return -EINVAL;
>>> +       ret =3D hwmgr_sw_init(hwmgr);
>>>
>>> -               ret =3D hwmgr->smumgr_funcs->smu_init(hwmgr);
>>> -
>>> -               phm_register_irq_handlers(hwmgr);
>>> -
>>> -               pr_debug("amdgpu: powerplay sw initialized\n");
>>> -       }
>>> +       pr_debug("amdgpu: powerplay sw init %s\n", ret ? "failed" : "su=
ccessfully");
>>>
>>>         return ret;
>>>  }
>>> @@ -129,13 +105,8 @@ static int pp_sw_fini(void *handle)
>>>  {
>>>         struct amdgpu_device *adev =3D handle;
>>>         struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>>> -       int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -       if (ret >=3D 0) {
>>> -               if (hwmgr->smumgr_funcs->smu_fini !=3D NULL)
>>> -                       hwmgr->smumgr_funcs->smu_fini(hwmgr);
>>> -       }
>>> +       hwmgr_sw_fini(hwmgr);
>>>
>>>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU)
>>>                 amdgpu_ucode_fini_bo(adev);
>>> @@ -152,40 +123,20 @@ static int pp_hw_init(void *handle)
>>>         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU)
>>>                 amdgpu_ucode_init_bo(adev);
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> +       ret =3D hwmgr_hw_init(hwmgr);
>>>
>>> -       if (ret >=3D 0) {
>>> -               if (hwmgr->smumgr_funcs->start_smu =3D=3D NULL)
>>> -                       return -EINVAL;
>>> +       if (ret)
>>> +               pr_err("amdgpu: powerplay hw init failed\n");
>>>
>>> -               if (hwmgr->smumgr_funcs->start_smu(hwmgr)) {
>>> -                       pr_err("smc start failed\n");
>>> -                       hwmgr->smumgr_funcs->smu_fini(hwmgr);
>>> -                       return -EINVAL;
>>> -               }
>>> -               if (ret =3D=3D PP_DPM_DISABLED)
>>> -                       goto exit;
>>> -               ret =3D hwmgr_hw_init(hwmgr);
>>> -               if (ret)
>>> -                       goto exit;
>>> -       }
>>>         return ret;
>>> -exit:
>>> -       hwmgr->pm_en =3D 0;
>>> -       cgs_notify_dpm_enabled(hwmgr->device, false);
>>> -       return 0;
>>> -
>>>  }
>>>
>>>  static int pp_hw_fini(void *handle)
>>>  {
>>>         struct amdgpu_device *adev =3D handle;
>>>         struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>>> -       int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -       if (ret =3D=3D 0)
>>> -               hwmgr_hw_fini(hwmgr);
>>> +       hwmgr_hw_fini(hwmgr);
>>>
>>>         return 0;
>>>  }
>>> @@ -194,11 +145,8 @@ static int pp_late_init(void *handle)
>>>  {
>>>         struct amdgpu_device *adev =3D handle;
>>>         struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>>> -       int ret =3D 0;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>>
>>> -       if (ret =3D=3D 0)
>>> +       if (hwmgr && hwmgr->pm_en)
>>>                 pp_dpm_dispatch_tasks(hwmgr,
>>>                                         AMD_PP_TASK_COMPLETE_INIT, NULL=
);
>>>
>>> @@ -233,12 +181,9 @@ static int pp_set_powergating_state(void *handle,
>>>  {
>>>         struct amdgpu_device *adev =3D handle;
>>>         struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>>> -       int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return 0;
>>>
>>>         if (hwmgr->hwmgr_func->enable_per_cu_power_gating =3D=3D NULL) =
{
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -254,38 +199,16 @@ static int pp_suspend(void *handle)
>>>  {
>>>         struct amdgpu_device *adev =3D handle;
>>>         struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>>> -       int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -       if (ret =3D=3D 0)
>>> -               hwmgr_hw_suspend(hwmgr);
>>> -       return 0;
>>> +       return hwmgr_suspend(hwmgr);
>>>  }
>>>
>>>  static int pp_resume(void *handle)
>>>  {
>>>         struct amdgpu_device *adev =3D handle;
>>>         struct pp_hwmgr *hwmgr =3D adev->powerplay.pp_handle;
>>> -       int ret;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret < 0)
>>> -               return ret;
>>> -
>>> -       if (hwmgr->smumgr_funcs->start_smu =3D=3D NULL)
>>> -               return -EINVAL;
>>> -
>>> -       if (hwmgr->smumgr_funcs->start_smu(hwmgr)) {
>>> -               pr_err("smc start failed\n");
>>> -               hwmgr->smumgr_funcs->smu_fini(hwmgr);
>>> -               return -EINVAL;
>>> -       }
>>> -
>>> -       if (ret =3D=3D PP_DPM_DISABLED)
>>> -               return 0;
>>>
>>> -       return hwmgr_hw_resume(hwmgr);
>>> +       return hwmgr_resume(hwmgr);
>>>  }
>>>
>>>  static int pp_set_clockgating_state(void *handle,
>>> @@ -334,12 +257,9 @@ static int pp_dpm_fw_loading_complete(void *handle=
)
>>>  static int pp_set_clockgating_by_smu(void *handle, uint32_t msg_id)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>>
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->update_clock_gatings =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -389,12 +309,9 @@ static int pp_dpm_force_performance_level(void *ha=
ndle,
>>>                                         enum amd_dpm_forced_level level=
)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (level =3D=3D hwmgr->dpm_level)
>>>                 return 0;
>>> @@ -412,13 +329,10 @@ static enum amd_dpm_forced_level pp_dpm_get_perfo=
rmance_level(
>>>                                                                 void *h=
andle)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>>         enum amd_dpm_forced_level level;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>>         level =3D hwmgr->dpm_level;
>>> @@ -429,13 +343,10 @@ static enum amd_dpm_forced_level pp_dpm_get_perfo=
rmance_level(
>>>  static uint32_t pp_dpm_get_sclk(void *handle, bool low)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>>         uint32_t clk =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return 0;
>>>
>>>         if (hwmgr->hwmgr_func->get_sclk =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -450,13 +361,10 @@ static uint32_t pp_dpm_get_sclk(void *handle, boo=
l low)
>>>  static uint32_t pp_dpm_get_mclk(void *handle, bool low)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>>         uint32_t clk =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return 0;
>>>
>>>         if (hwmgr->hwmgr_func->get_mclk =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -471,11 +379,8 @@ static uint32_t pp_dpm_get_mclk(void *handle, bool=
 low)
>>>  static void pp_dpm_powergate_vce(void *handle, bool gate)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>>
>>> -       if (ret)
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>>                 return;
>>>
>>>         if (hwmgr->hwmgr_func->powergate_vce =3D=3D NULL) {
>>> @@ -490,11 +395,8 @@ static void pp_dpm_powergate_vce(void *handle, boo=
l gate)
>>>  static void pp_dpm_powergate_uvd(void *handle, bool gate)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>>
>>> -       if (ret)
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>>                 return;
>>>
>>>         if (hwmgr->hwmgr_func->powergate_uvd =3D=3D NULL) {
>>> @@ -512,10 +414,8 @@ static int pp_dpm_dispatch_tasks(void *handle, enu=
m amd_pp_task task_id,
>>>         int ret =3D 0;
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>>         ret =3D hwmgr_handle_task(hwmgr, task_id, user_state);
>>> @@ -528,15 +428,9 @@ static enum amd_pm_state_type pp_dpm_get_current_p=
ower_state(void *handle)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         struct pp_power_state *state;
>>> -       int ret =3D 0;
>>>         enum amd_pm_state_type pm_type;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (hwmgr->current_ps =3D=3D NULL)
>>> +       if (!hwmgr || !hwmgr->pm_en || !hwmgr->current_ps)
>>>                 return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>> @@ -568,11 +462,8 @@ static enum amd_pm_state_type pp_dpm_get_current_p=
ower_state(void *handle)
>>>  static void pp_dpm_set_fan_control_mode(void *handle, uint32_t mode)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>>
>>> -       if (ret)
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>>                 return;
>>>
>>>         if (hwmgr->hwmgr_func->set_fan_control_mode =3D=3D NULL) {
>>> @@ -587,13 +478,10 @@ static void pp_dpm_set_fan_control_mode(void *han=
dle, uint32_t mode)
>>>  static uint32_t pp_dpm_get_fan_control_mode(void *handle)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>>         uint32_t mode =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return 0;
>>>
>>>         if (hwmgr->hwmgr_func->get_fan_control_mode =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -610,10 +498,8 @@ static int pp_dpm_set_fan_speed_percent(void *hand=
le, uint32_t percent)
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->set_fan_speed_percent =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -630,10 +516,8 @@ static int pp_dpm_get_fan_speed_percent(void *hand=
le, uint32_t *speed)
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->get_fan_speed_percent =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -651,10 +535,8 @@ static int pp_dpm_get_fan_speed_rpm(void *handle, =
uint32_t *rpm)
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->get_fan_speed_rpm =3D=3D NULL)
>>>                 return -EINVAL;
>>> @@ -670,16 +552,10 @@ static int pp_dpm_get_pp_num_states(void *handle,
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int i;
>>> -       int ret =3D 0;
>>>
>>>         memset(data, 0, sizeof(*data));
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (hwmgr->ps =3D=3D NULL)
>>> +       if (!hwmgr || !hwmgr->pm_en ||!hwmgr->ps)
>>>                 return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>> @@ -713,15 +589,9 @@ static int pp_dpm_get_pp_num_states(void *handle,
>>>  static int pp_dpm_get_pp_table(void *handle, char **table)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>>         int size =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (!hwmgr->soft_pp_table)
>>> +       if (!hwmgr || !hwmgr->pm_en ||!hwmgr->soft_pp_table)
>>>                 return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>> @@ -736,10 +606,6 @@ static int amd_powerplay_reset(void *handle)
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -       if (ret)
>>> -               return ret;
>>> -
>>>         ret =3D hwmgr_hw_fini(hwmgr);
>>>         if (ret)
>>>                 return ret;
>>> @@ -756,10 +622,8 @@ static int pp_dpm_set_pp_table(void *handle, const=
 char *buf, size_t size)
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>>         if (!hwmgr->hardcode_pp_table) {
>>> @@ -796,10 +660,8 @@ static int pp_dpm_force_clock_level(void *handle,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->force_clock_level =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -820,10 +682,8 @@ static int pp_dpm_print_clock_levels(void *handle,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->print_clock_levels =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -840,10 +700,8 @@ static int pp_dpm_get_sclk_od(void *handle)
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->get_sclk_od =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -860,10 +718,8 @@ static int pp_dpm_set_sclk_od(void *handle, uint32=
_t value)
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->set_sclk_od =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -881,10 +737,8 @@ static int pp_dpm_get_mclk_od(void *handle)
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->get_mclk_od =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -901,10 +755,8 @@ static int pp_dpm_set_mclk_od(void *handle, uint32=
_t value)
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->set_mclk_od =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -922,11 +774,7 @@ static int pp_dpm_read_sensor(void *handle, int id=
x,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (value =3D=3D NULL)
>>> +       if (!hwmgr || !hwmgr->pm_en || !value)
>>>                 return -EINVAL;
>>>
>>>         switch (idx) {
>>> @@ -948,14 +796,11 @@ static int pp_dpm_read_sensor(void *handle, int i=
dx,
>>>  pp_dpm_get_vce_clock_state(void *handle, unsigned idx)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>>
>>> -       if (ret)
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>>                 return NULL;
>>>
>>> -       if (hwmgr && idx < hwmgr->num_vce_state_tables)
>>> +       if (idx < hwmgr->num_vce_state_tables)
>>>                 return &hwmgr->vce_states[idx];
>>>         return NULL;
>>>  }
>>> @@ -964,7 +809,7 @@ static int pp_get_power_profile_mode(void *handle, =
char *buf)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>
>>> -       if (!buf || pp_check(hwmgr))
>>> +       if (!hwmgr || !hwmgr->pm_en || !buf)
>>>                 return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->get_power_profile_mode =3D=3D NULL) {
>>> @@ -980,12 +825,12 @@ static int pp_set_power_profile_mode(void *handle=
, long *input, uint32_t size)
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D -EINVAL;
>>>
>>> -       if (pp_check(hwmgr))
>>> -               return -EINVAL;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return ret;
>>>
>>>         if (hwmgr->hwmgr_func->set_power_profile_mode =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> -               return -EINVAL;
>>> +               return ret;
>>>         }
>>>         mutex_lock(&hwmgr->smu_lock);
>>>         if (hwmgr->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)
>>> @@ -998,7 +843,7 @@ static int pp_odn_edit_dpm_table(void *handle, uint=
32_t type, long *input, uint3
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>
>>> -       if (pp_check(hwmgr))
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>>                 return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->odn_edit_dpm_table =3D=3D NULL) {
>>> @@ -1016,7 +861,7 @@ static int pp_dpm_switch_power_profile(void *handl=
e,
>>>         long workload;
>>>         uint32_t index;
>>>
>>> -       if (pp_check(hwmgr))
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>>                 return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->set_power_profile_mode =3D=3D NULL) {
>>> @@ -1058,10 +903,8 @@ static int pp_dpm_notify_smu_memory_info(void *ha=
ndle,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->notify_cac_buffer_info =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -1082,12 +925,9 @@ static int pp_dpm_notify_smu_memory_info(void *ha=
ndle,
>>>  static int pp_set_power_limit(void *handle, uint32_t limit)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>>
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->set_power_limit =3D=3D NULL) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> @@ -1104,20 +944,14 @@ static int pp_set_power_limit(void *handle, uint=
32_t limit)
>>>         hwmgr->hwmgr_func->set_power_limit(hwmgr, limit);
>>>         hwmgr->power_limit =3D limit;
>>>         mutex_unlock(&hwmgr->smu_lock);
>>> -       return ret;
>>> +       return 0;
>>>  }
>>>
>>>  static int pp_get_power_limit(void *handle, uint32_t *limit, bool defa=
ult_limit)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>>
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (limit =3D=3D NULL)
>>> +       if (!hwmgr || !hwmgr->pm_en ||!limit)
>>>                 return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>> @@ -1129,19 +963,16 @@ static int pp_get_power_limit(void *handle, uint=
32_t *limit, bool default_limit)
>>>
>>>         mutex_unlock(&hwmgr->smu_lock);
>>>
>>> -       return ret;
>>> +       return 0;
>>>  }
>>>
>>>  static int pp_display_configuration_change(void *handle,
>>>         const struct amd_pp_display_configuration *display_config)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>>
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>>         phm_store_dal_configuration_data(hwmgr, display_config);
>>> @@ -1155,12 +986,7 @@ static int pp_get_display_power_level(void *handl=
e,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (output =3D=3D NULL)
>>> +       if (!hwmgr || !hwmgr->pm_en ||!output)
>>>                 return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>> @@ -1177,10 +1003,8 @@ static int pp_get_current_clocks(void *handle,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>>
>>> @@ -1225,10 +1049,8 @@ static int pp_get_clock_by_type(void *handle, en=
um amd_pp_clock_type type, struc
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (clocks =3D=3D NULL)
>>>                 return -EINVAL;
>>> @@ -1246,11 +1068,7 @@ static int pp_get_clock_by_type_with_latency(voi=
d *handle,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (!clocks)
>>> +       if (!hwmgr || !hwmgr->pm_en ||!clocks)
>>>                 return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>> @@ -1266,11 +1084,7 @@ static int pp_get_clock_by_type_with_voltage(voi=
d *handle,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (!clocks)
>>> +       if (!hwmgr || !hwmgr->pm_en ||!clocks)
>>>                 return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>> @@ -1287,11 +1101,7 @@ static int pp_set_watermarks_for_clocks_ranges(v=
oid *handle,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (!wm_with_clock_ranges)
>>> +       if (!hwmgr || !hwmgr->pm_en ||!wm_with_clock_ranges)
>>>                 return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>> @@ -1308,11 +1118,7 @@ static int pp_display_clock_voltage_request(void=
 *handle,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (!clock)
>>> +       if (!hwmgr || !hwmgr->pm_en ||!clock)
>>>                 return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>> @@ -1328,12 +1134,7 @@ static int pp_get_display_mode_validation_clocks=
(void *handle,
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>>         int ret =3D 0;
>>>
>>> -       ret =3D pp_check(hwmgr);
>>> -
>>> -       if (ret)
>>> -               return ret;
>>> -
>>> -       if (clocks =3D=3D NULL)
>>> +       if (!hwmgr || !hwmgr->pm_en ||!clocks)
>>>                 return -EINVAL;
>>>
>>>         mutex_lock(&hwmgr->smu_lock);
>>> @@ -1348,12 +1149,9 @@ static int pp_get_display_mode_validation_clocks=
(void *handle,
>>>  static int pp_set_mmhub_powergating_by_smu(void *handle)
>>>  {
>>>         struct pp_hwmgr *hwmgr =3D handle;
>>> -       int ret =3D 0;
>>> -
>>> -       ret =3D pp_check(hwmgr);
>>>
>>> -       if (ret)
>>> -               return ret;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return -EINVAL;
>>>
>>>         if (hwmgr->hwmgr_func->set_mmhub_powergating_by_smu =3D=3D NULL=
) {
>>>                 pr_info("%s was not implemented.\n", __func__);
>>> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/=
drm/amd/powerplay/hwmgr/hwmgr.c
>>> index 4298205..96a2d01 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
>>> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
>>> @@ -76,7 +76,7 @@ static void hwmgr_init_workload_prority(struct pp_hwm=
gr *hwmgr)
>>>
>>>  int hwmgr_early_init(struct pp_hwmgr *hwmgr)
>>>  {
>>> -       if (hwmgr =3D=3D NULL)
>>> +       if (!hwmgr)
>>>                 return -EINVAL;
>>>
>>>         hwmgr->usec_timeout =3D AMD_MAX_USEC_TIMEOUT;
>>> @@ -170,17 +170,51 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
>>>         return 0;
>>>  }
>>>
>>> +int hwmgr_sw_init(struct pp_hwmgr *hwmgr)
>>> +{
>>> +       if (!hwmgr|| !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->smu_=
init)
>>> +               return -EINVAL;
>>> +
>>> +       phm_register_irq_handlers(hwmgr);
>>> +
>>> +       return hwmgr->smumgr_funcs->smu_init(hwmgr);
>>> +}
>>> +
>>> +
>>> +int hwmgr_sw_fini(struct pp_hwmgr *hwmgr)
>>> +{
>>> +       if (hwmgr && hwmgr->smumgr_funcs && hwmgr->smumgr_funcs->smu_fi=
ni)
>>> +               hwmgr->smumgr_funcs->smu_fini(hwmgr);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>  int hwmgr_hw_init(struct pp_hwmgr *hwmgr)
>>>  {
>>>         int ret =3D 0;
>>>
>>> -       if (hwmgr =3D=3D NULL)
>>> +       if (!hwmgr || !hwmgr->smumgr_funcs)
>>>                 return -EINVAL;
>>>
>>> -       if (hwmgr->pptable_func =3D=3D NULL ||
>>> -           hwmgr->pptable_func->pptable_init =3D=3D NULL ||
>>> -           hwmgr->hwmgr_func->backend_init =3D=3D NULL)
>>> -               return -EINVAL;
>>> +       if (hwmgr->smumgr_funcs->start_smu) {
>>> +               ret =3D hwmgr->smumgr_funcs->start_smu(hwmgr);
>>> +               if (ret) {
>>> +                       pr_err("smc start failed\n");
>>> +                       return -EINVAL;
>>> +               }
>>> +       }
>>> +
>>> +       if (!hwmgr->pm_en)
>>> +               return 0;
>>> +
>>> +       if (!hwmgr->pptable_func ||
>>> +           !hwmgr->pptable_func->pptable_init ||
>>> +           !hwmgr->hwmgr_func->backend_init) {
>>> +               hwmgr->pm_en =3D false;
>>> +               cgs_notify_dpm_enabled(hwmgr->device, false);
>>> +               pr_info("dpm not supported \n");
>>> +               return 0;
>>> +       }
>>>
>>>         ret =3D hwmgr->pptable_func->pptable_init(hwmgr);
>>>         if (ret)
>>> @@ -214,14 +248,13 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)
>>>         if (hwmgr->pptable_func->pptable_fini)
>>>                 hwmgr->pptable_func->pptable_fini(hwmgr);
>>>  err:
>>> -       pr_err("amdgpu: powerplay initialization failed\n");
>>>         return ret;
>>>  }
>>>
>>>  int hwmgr_hw_fini(struct pp_hwmgr *hwmgr)
>>>  {
>>> -       if (hwmgr =3D=3D NULL)
>>> -               return -EINVAL;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return 0;
>>>
>>>         phm_stop_thermal_controller(hwmgr);
>>>         psm_set_boot_states(hwmgr);
>>> @@ -236,12 +269,12 @@ int hwmgr_hw_fini(struct pp_hwmgr *hwmgr)
>>>         return psm_fini_power_state_table(hwmgr);
>>>  }
>>>
>>> -int hwmgr_hw_suspend(struct pp_hwmgr *hwmgr)
>>> +int hwmgr_suspend(struct pp_hwmgr *hwmgr)
>>>  {
>>>         int ret =3D 0;
>>>
>>> -       if (hwmgr =3D=3D NULL)
>>> -               return -EINVAL;
>>> +       if (!hwmgr || !hwmgr->pm_en)
>>> +               return 0;
>>>
>>>         phm_disable_smc_firmware_ctf(hwmgr);
>>>         ret =3D psm_set_boot_states(hwmgr);
>>> @@ -255,13 +288,23 @@ int hwmgr_hw_suspend(struct pp_hwmgr *hwmgr)
>>>         return ret;
>>>  }
>>>
>>> -int hwmgr_hw_resume(struct pp_hwmgr *hwmgr)
>>> +int hwmgr_resume(struct pp_hwmgr *hwmgr)
>>>  {
>>>         int ret =3D 0;
>>>
>>> -       if (hwmgr =3D=3D NULL)
>>> +       if (!hwmgr)
>>>                 return -EINVAL;
>>>
>>> +       if (hwmgr->smumgr_funcs && hwmgr->smumgr_funcs->start_smu) {
>>> +               if (hwmgr->smumgr_funcs->start_smu(hwmgr)) {
>>> +                       pr_err("smc start failed\n");
>>> +                       return -EINVAL;
>>> +               }
>>> +       }
>>> +
>>> +       if (!hwmgr->pm_en)
>>> +               return 0;
>>> +
>>>         ret =3D phm_setup_asic(hwmgr);
>>>         if (ret)
>>>                 return ret;
>>> @@ -270,9 +313,6 @@ int hwmgr_hw_resume(struct pp_hwmgr *hwmgr)
>>>         if (ret)
>>>                 return ret;
>>>         ret =3D phm_start_thermal_controller(hwmgr);
>>> -       if (ret)
>>> -               return ret;
>>> -
>>>         ret |=3D psm_set_performance_states(hwmgr);
>>>         if (ret)
>>>                 return ret;
>>> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/dr=
m/amd/powerplay/inc/hwmgr.h
>>> index 17f811d..d6c9a3b 100644
>>> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
>>> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
>>> @@ -782,10 +782,13 @@ struct pp_hwmgr {
>>>  };
>>>
>>>  int hwmgr_early_init(struct pp_hwmgr *hwmgr);
>>> +int hwmgr_sw_init(struct pp_hwmgr *hwmgr);
>>> +int hwmgr_sw_fini(struct pp_hwmgr *hwmgr);
>>>  int hwmgr_hw_init(struct pp_hwmgr *hwmgr);
>>>  int hwmgr_hw_fini(struct pp_hwmgr *hwmgr);
>>> -int hwmgr_hw_suspend(struct pp_hwmgr *hwmgr);
>>> -int hwmgr_hw_resume(struct pp_hwmgr *hwmgr);
>>> +int hwmgr_suspend(struct pp_hwmgr *hwmgr);
>>> +int hwmgr_resume(struct pp_hwmgr *hwmgr);
>>> +
>>>  int hwmgr_handle_task(struct pp_hwmgr *hwmgr,
>>>                                 enum amd_pp_task task_id,
>>>                                 enum amd_pm_state_type *user_state);
>>> --
>>> 1.9.1
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




--_000_CY4PR12MB1687BB4FAA9E0ED5916B0DB5FBA90CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Thanks Alex.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">I should be more careful when reo=
rder patches&nbsp;.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, March 22, 2018 9:13 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 2/6] drm/amd/pp: Add hwmgr_sw_init/fini functioi=
ns</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Mar 22, 2018 at 9:13 AM, Alex Deucher &lt;=
alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br>
&gt; On Thu, Mar 22, 2018 at 9:10 AM, Alex Deucher &lt;alexdeucher-Re5JQEeQqe8@public.gmane.org=
m&gt; wrote:<br>
&gt;&gt; On Thu, Mar 22, 2018 at 7:40 AM, Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt; w=
rote:<br>
&gt;&gt;&gt; Clean up pp ip functions<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Change-Id: Id06159202edabdfcb19fcc20e1291ce93db56d5d<br>
&gt;&gt;&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;&gt;<br>
&gt;&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Actually, doesn't this patch have a dependency on patch 3?&nbsp; I thi=
nk<br>
&gt; this part of patch 3:<br>
<br>
Sorry, patch 4.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pm_en =3D (amdgpu_=
dpm &amp;&amp; hwmgr-&gt;not_vf) ? true : false;<br>
&gt; should be in this patch rather than the other patch.&nbsp; With that f=
ixed:<br>
&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 368 &#43=
;&#43;&#43;&#43;&#43;&#43;--------------------<br>
&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp; =
|&nbsp; 74 &#43;&#43;&#43;&#43;--<br>
&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp;&nbsp; 7 &#43;-<br>
&gt;&gt;&gt;&nbsp; 3 files changed, 145 insertions(&#43;), 304 deletions(-)=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/d=
rivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt;&gt;&gt; index 7e8ad30..5d7d9ec 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.=
c<br>
&gt;&gt;&gt; @@ -31,24 &#43;31,11 @@<br>
&gt;&gt;&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&gt;&gt;&nbsp; #include &quot;hwmgr.h&quot;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -#define PP_DPM_DISABLED 0xCCCC<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&nbsp; static int pp_dpm_dispatch_tasks(void *handle, enum amd_=
pp_task task_id,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_type *user_state);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; static const struct amd_pm_funcs pp_dpm_funcs;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -static inline int pp_check(struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt; -{<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL ||=
 hwmgr-&gt;smumgr_funcs =3D=3D NULL)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;pm_en =3D=
=3D 0 || hwmgr-&gt;hwmgr_func =3D=3D NULL)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return PP_DPM_DISABLED;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; -}<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&nbsp; static int amd_powerplay_create(struct amdgpu_device *ad=
ev)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr;<br>
&gt;&gt;&gt; @@ -73,7 &#43;60,7 @@ static int amd_powerplay_create(struct a=
mdgpu_device *adev)<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -static int amd_powerplay_destroy(struct amdgpu_device *adev)<=
br>
&gt;&gt;&gt; &#43;static void amd_powerplay_destroy(struct amdgpu_device *a=
dev)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D adev-&gt;powerplay.pp_handle;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @@ -82,8 &#43;69,6 @@ static int amd_powerplay_destroy(struct =
amdgpu_device *adev)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr);<=
br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr =3D NULL=
;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; static int pp_early_init(void *handle)<br>
&gt;&gt;&gt; @@ -109,18 &#43;94,9 @@ static int pp_sw_init(void *handle)<br=
>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D adev-&gt;powerplay.pp_handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &gt;=3D 0) {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs-&gt;smu_init =3D=3D NULL=
)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EINVAL;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr_sw_ini=
t(hwmgr);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;smumgr_funcs-&gt;smu_init(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; phm_register_irq_handlers(hwmgr);<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;amdgpu: powerplay sw initialized\n&q=
uot;);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;amdgp=
u: powerplay sw init %s\n&quot;, ret ? &quot;failed&quot; : &quot;successfu=
lly&quot;);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br=
>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt; @@ -129,13 &#43;105,8 @@ static int pp_sw_fini(void *handle)<b=
r>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
device *adev =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D adev-&gt;powerplay.pp_handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &gt;=3D 0) {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs-&gt;smu_fini !=3D NULL)<=
br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwm=
gr-&gt;smumgr_funcs-&gt;smu_fini(hwmgr);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr_sw_fini(hwmgr)=
;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;f=
irmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_fini_bo(adev);<br>
&gt;&gt;&gt; @@ -152,40 &#43;123,20 @@ static int pp_hw_init(void *handle)<=
br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;f=
irmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_init_bo(adev);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr_hw_ini=
t(hwmgr);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &gt;=3D 0) {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs-&gt;start_smu =3D=3D NUL=
L)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EINVAL;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;amdgpu: powerplay hw init failed\n=
&quot;);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs-&gt;start_smu(hwmgr)) {<=
br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_=
err(&quot;smc start failed\n&quot;);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwm=
gr-&gt;smumgr_funcs-&gt;smu_fini(hwmgr);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn -EINVAL;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D PP_DPM_DISABLED)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; got=
o exit;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr_hw_init(hwmgr);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; got=
o exit;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br=
>
&gt;&gt;&gt; -exit:<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pm_en =3D 0;<b=
r>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_notify_dpm_enabled(h=
wmgr-&gt;device, false);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; static int pp_hw_fini(void *handle)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
device *adev =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D adev-&gt;powerplay.pp_handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; hwmgr_hw_fini(hwmgr);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr_hw_fini(hwmgr)=
;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt; @@ -194,11 &#43;145,8 @@ static int pp_late_init(void *handle)=
<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
device *adev =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D adev-&gt;powerplay.pp_handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr &amp;&amp;=
 hwmgr-&gt;pm_en)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_dpm_dispatch_tasks(hwmgr,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PP_TASK_COMPLETE_INIT, NULL);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @@ -233,12 &#43;181,9 @@ static int pp_set_powergating_state(v=
oid *handle,<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
device *adev =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D adev-&gt;powerplay.pp_handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;enable_per_cu_power_gating =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -254,38 &#43;199,16 @@ static int pp_suspend(void *handle)<=
br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
device *adev =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D adev-&gt;powerplay.pp_handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D 0)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; hwmgr_hw_suspend(hwmgr);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr_suspend=
(hwmgr);<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; static int pp_resume(void *handle)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
device *adev =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D adev-&gt;powerplay.pp_handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_fun=
cs-&gt;start_smu =3D=3D NULL)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_fun=
cs-&gt;start_smu(hwmgr)) {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;smc start failed\n&quot;);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;smumgr_funcs-&gt;smu_fini(hwmgr);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D PP_DPM_DI=
SABLED)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr_hw_resume(h=
wmgr);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr_resume(=
hwmgr);<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; static int pp_set_clockgating_state(void *handle,<br>
&gt;&gt;&gt; @@ -334,12 &#43;257,9 @@ static int pp_dpm_fw_loading_complete=
(void *handle)<br>
&gt;&gt;&gt;&nbsp; static int pp_set_clockgating_by_smu(void *handle, uint3=
2_t msg_id)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;update_clock_gatings =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -389,12 &#43;309,9 @@ static int pp_dpm_force_performance_l=
evel(void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_forced_level level)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (level =3D=
=3D hwmgr-&gt;dpm_level)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; @@ -412,13 &#43;329,10 @@ static enum amd_dpm_forced_level pp_=
dpm_get_performance_level(<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; void *handle)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_dpm_f=
orced_level level;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; level =3D hwmg=
r-&gt;dpm_level;<br>
&gt;&gt;&gt; @@ -429,13 &#43;343,10 @@ static enum amd_dpm_forced_level pp_=
dpm_get_performance_level(<br>
&gt;&gt;&gt;&nbsp; static uint32_t pp_dpm_get_sclk(void *handle, bool low)<=
br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk =
=3D 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;get_sclk =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -450,13 &#43;361,10 @@ static uint32_t pp_dpm_get_sclk(void=
 *handle, bool low)<br>
&gt;&gt;&gt;&nbsp; static uint32_t pp_dpm_get_mclk(void *handle, bool low)<=
br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t clk =
=3D 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;get_mclk =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -471,11 &#43;379,8 @@ static uint32_t pp_dpm_get_mclk(void =
*handle, bool low)<br>
&gt;&gt;&gt;&nbsp; static void pp_dpm_powergate_vce(void *handle, bool gate=
)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;powergate_vce =3D=3D NULL) {<br>
&gt;&gt;&gt; @@ -490,11 &#43;395,8 @@ static void pp_dpm_powergate_vce(void=
 *handle, bool gate)<br>
&gt;&gt;&gt;&nbsp; static void pp_dpm_powergate_uvd(void *handle, bool gate=
)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;powergate_uvd =3D=3D NULL) {<br>
&gt;&gt;&gt; @@ -512,10 &#43;414,8 @@ static int pp_dpm_dispatch_tasks(void=
 *handle, enum amd_pp_task task_id,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr_=
handle_task(hwmgr, task_id, user_state);<br>
&gt;&gt;&gt; @@ -528,15 &#43;428,9 @@ static enum amd_pm_state_type pp_dpm_=
get_current_power_state(void *handle)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_powe=
r_state *state;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_st=
ate_type pm_type;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;current_ps=
 =3D=3D NULL)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en || !hwmgr-&gt;current_ps)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; @@ -568,11 &#43;462,8 @@ static enum amd_pm_state_type pp_dpm_=
get_current_power_state(void *handle)<br>
&gt;&gt;&gt;&nbsp; static void pp_dpm_set_fan_control_mode(void *handle, ui=
nt32_t mode)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;set_fan_control_mode =3D=3D NULL) {<br>
&gt;&gt;&gt; @@ -587,13 &#43;478,10 @@ static void pp_dpm_set_fan_control_m=
ode(void *handle, uint32_t mode)<br>
&gt;&gt;&gt;&nbsp; static uint32_t pp_dpm_get_fan_control_mode(void *handle=
)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mode =
=3D 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;get_fan_control_mode =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -610,10 &#43;498,8 @@ static int pp_dpm_set_fan_speed_perce=
nt(void *handle, uint32_t percent)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;set_fan_speed_percent =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -630,10 &#43;516,8 @@ static int pp_dpm_get_fan_speed_perce=
nt(void *handle, uint32_t *speed)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;get_fan_speed_percent =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -651,10 &#43;535,8 @@ static int pp_dpm_get_fan_speed_rpm(v=
oid *handle, uint32_t *rpm)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;get_fan_speed_rpm =3D=3D NULL)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; @@ -670,16 &#43;552,10 @@ static int pp_dpm_get_pp_num_states(=
void *handle,<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(data, 0=
, sizeof(*data));<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;ps =3D=3D =
NULL)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en ||!hwmgr-&gt;ps)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; @@ -713,15 &#43;589,9 @@ static int pp_dpm_get_pp_num_states(v=
oid *handle,<br>
&gt;&gt;&gt;&nbsp; static int pp_dpm_get_pp_table(void *handle, char **tabl=
e)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size =3D 0=
;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;soft_pp_t=
able)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en ||!hwmgr-&gt;soft_pp_table)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; @@ -736,10 &#43;606,6 @@ static int amd_powerplay_reset(void *=
handle)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr_=
hw_fini(hwmgr);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; @@ -756,10 &#43;622,8 @@ static int pp_dpm_set_pp_table(void *=
handle, const char *buf, size_t size)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt=
;hardcode_pp_table) {<br>
&gt;&gt;&gt; @@ -796,10 &#43;660,8 @@ static int pp_dpm_force_clock_level(v=
oid *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;force_clock_level =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -820,10 &#43;682,8 @@ static int pp_dpm_print_clock_levels(=
void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;print_clock_levels =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -840,10 &#43;700,8 @@ static int pp_dpm_get_sclk_od(void *h=
andle)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;get_sclk_od =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -860,10 &#43;718,8 @@ static int pp_dpm_set_sclk_od(void *h=
andle, uint32_t value)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;set_sclk_od =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -881,10 &#43;737,8 @@ static int pp_dpm_get_mclk_od(void *h=
andle)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;get_mclk_od =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -901,10 &#43;755,8 @@ static int pp_dpm_set_mclk_od(void *h=
andle, uint32_t value)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;set_mclk_od =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -922,11 &#43;774,7 @@ static int pp_dpm_read_sensor(void *h=
andle, int idx,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (value =3D=3D NULL)<b=
r>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en || !value)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (idx) {=
<br>
&gt;&gt;&gt; @@ -948,14 &#43;796,11 @@ static int pp_dpm_read_sensor(void *=
handle, int idx,<br>
&gt;&gt;&gt;&nbsp; pp_dpm_get_vce_clock_state(void *handle, unsigned idx)<b=
r>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr &amp;&amp; idx=
 &lt; hwmgr-&gt;num_vce_state_tables)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (idx &lt; hwmgr-&=
gt;num_vce_state_tables)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;hwmgr-&gt;vce_states[idx];<br=
>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<b=
r>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt; @@ -964,7 &#43;809,7 @@ static int pp_get_power_profile_mode(v=
oid *handle, char *buf)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!buf || pp_check(hwm=
gr))<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en || !buf)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;get_power_profile_mode =3D=3D NULL) {<br>
&gt;&gt;&gt; @@ -980,12 &#43;825,12 @@ static int pp_set_power_profile_mode=
(void *handle, long *input, uint32_t size)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -E=
INVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_check(hwmgr))<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;set_power_profile_mode =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL)<br>
&gt;&gt;&gt; @@ -998,7 &#43;843,7 @@ static int pp_odn_edit_dpm_table(void =
*handle, uint32_t type, long *input, uint3<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_check(hwmgr))<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;odn_edit_dpm_table =3D=3D NULL) {<br>
&gt;&gt;&gt; @@ -1016,7 &#43;861,7 @@ static int pp_dpm_switch_power_profil=
e(void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long workload;=
<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index=
;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_check(hwmgr))<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;set_power_profile_mode =3D=3D NULL) {<br>
&gt;&gt;&gt; @@ -1058,10 &#43;903,8 @@ static int pp_dpm_notify_smu_memory_=
info(void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;notify_cac_buffer_info =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -1082,12 &#43;925,9 @@ static int pp_dpm_notify_smu_memory_=
info(void *handle,<br>
&gt;&gt;&gt;&nbsp; static int pp_set_power_limit(void *handle, uint32_t lim=
it)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;set_power_limit =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; @@ -1104,20 &#43;944,14 @@ static int pp_set_power_limit(void =
*handle, uint32_t limit)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmg=
r_func-&gt;set_power_limit(hwmgr, limit);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;powe=
r_limit =3D limit;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&=
amp;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; static int pp_get_power_limit(void *handle, uint32_t *li=
mit, bool default_limit)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (limit =3D=3D NULL)<b=
r>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en ||!limit)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; @@ -1129,19 &#43;963,16 @@ static int pp_get_power_limit(void =
*handle, uint32_t *limit, bool default_limit)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&=
amp;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; static int pp_display_configuration_change(void *handle,=
<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct a=
md_pp_display_configuration *display_config)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_store_dal_=
configuration_data(hwmgr, display_config);<br>
&gt;&gt;&gt; @@ -1155,12 &#43;986,7 @@ static int pp_get_display_power_leve=
l(void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (output =3D=3D NULL)<=
br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en ||!output)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; @@ -1177,10 &#43;1003,8 @@ static int pp_get_current_clocks(vo=
id *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; @@ -1225,10 &#43;1049,8 @@ static int pp_get_clock_by_type(voi=
d *handle, enum amd_pp_clock_type type, struc<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clocks =3D=
=3D NULL)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; @@ -1246,11 &#43;1068,7 @@ static int pp_get_clock_by_type_wit=
h_latency(void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!clocks)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en ||!clocks)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; @@ -1266,11 &#43;1084,7 @@ static int pp_get_clock_by_type_wit=
h_voltage(void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!clocks)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en ||!clocks)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; @@ -1287,11 &#43;1101,7 @@ static int pp_set_watermarks_for_cl=
ocks_ranges(void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!wm_with_clock_range=
s)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en ||!wm_with_clock_ranges)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; @@ -1308,11 &#43;1118,7 @@ static int pp_display_clock_voltage=
_request(void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!clock)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en ||!clock)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; @@ -1328,12 &#43;1134,7 @@ static int pp_get_display_mode_vali=
dation_clocks(void *handle,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clocks =3D=3D NULL)<=
br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en ||!clocks)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&am=
p;hwmgr-&gt;smu_lock);<br>
&gt;&gt;&gt; @@ -1348,12 &#43;1149,9 @@ static int pp_get_display_mode_vali=
dation_clocks(void *handle,<br>
&gt;&gt;&gt;&nbsp; static int pp_set_mmhub_powergating_by_smu(void *handle)=
<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmg=
r *hwmgr =3D handle;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pp_check(hwmgr);=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
hwmgr_func-&gt;set_mmhub_powergating_by_smu =3D=3D NULL) {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;%s was not implemented.\n&q=
uot;, __func__);<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/dri=
vers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt;&gt;&gt; index 4298205..96a2d01 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<=
br>
&gt;&gt;&gt; @@ -76,7 &#43;76,7 @@ static void hwmgr_init_workload_prority(=
struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; int hwmgr_early_init(struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL)<b=
r>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;usec=
_timeout =3D AMD_MAX_USEC_TIMEOUT;<br>
&gt;&gt;&gt; @@ -170,17 &#43;170,51 @@ int hwmgr_early_init(struct pp_hwmgr=
 *hwmgr)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &#43;int hwmgr_sw_init(struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr|| !hwmgr-=
&gt;smumgr_funcs || !hwmgr-&gt;smumgr_funcs-&gt;smu_init)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_register_irq_han=
dlers(hwmgr);<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return hwmgr-&gt;smu=
mgr_funcs-&gt;smu_init(hwmgr);<br>
&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;int hwmgr_sw_fini(struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt; &#43;{<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr &amp;&amp;=
 hwmgr-&gt;smumgr_funcs &amp;&amp; hwmgr-&gt;smumgr_funcs-&gt;smu_fini)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;smumgr_funcs-&gt;smu_fini(hwmgr);<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; &#43;}<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp; int hwmgr_hw_init(struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL)<b=
r>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;smumgr_funcs)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;pptable_fu=
nc =3D=3D NULL ||<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hwmgr-&gt;pptable_func-&gt;pptable_init =3D=3D NULL ||<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
hwmgr-&gt;hwmgr_func-&gt;backend_init =3D=3D NULL)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr=
_funcs-&gt;start_smu) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;smumgr_funcs-&gt;start_smu(hw=
mgr);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 pr_err(&quot;smc start failed\n&quot;);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return -EINVAL;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;pm_en=
)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;pptab=
le_func ||<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; !hwmgr-&gt;pptable_func-&gt;pptable_init ||<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; !hwmgr-&gt;hwmgr_func-&gt;backend_init) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pm_en =3D false;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; cgs_notify_dpm_enabled(hwmgr-&gt;device, false)=
;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;dpm not supported \n&quot;);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-=
&gt;pptable_func-&gt;pptable_init(hwmgr);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; @@ -214,14 &#43;248,13 @@ int hwmgr_hw_init(struct pp_hwmgr *h=
wmgr)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;=
pptable_func-&gt;pptable_fini)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;pptable_func-&gt;pptable_fini(h=
wmgr);<br>
&gt;&gt;&gt;&nbsp; err:<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;amdgpu: pow=
erplay initialization failed\n&quot;);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br=
>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; int hwmgr_hw_fini(struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL)<b=
r>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_stop_therm=
al_controller(hwmgr);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psm_set_boot_s=
tates(hwmgr);<br>
&gt;&gt;&gt; @@ -236,12 &#43;269,12 @@ int hwmgr_hw_fini(struct pp_hwmgr *h=
wmgr)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psm_fin=
i_power_state_table(hwmgr);<br>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -int hwmgr_hw_suspend(struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt; &#43;int hwmgr_suspend(struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL)<b=
r>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr=
-&gt;pm_en)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_disable_sm=
c_firmware_ctf(hwmgr);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psm_se=
t_boot_states(hwmgr);<br>
&gt;&gt;&gt; @@ -255,13 &#43;288,23 @@ int hwmgr_hw_suspend(struct pp_hwmgr=
 *hwmgr)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br=
>
&gt;&gt;&gt;&nbsp; }<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -int hwmgr_hw_resume(struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt; &#43;int hwmgr_resume(struct pp_hwmgr *hwmgr)<br>
&gt;&gt;&gt;&nbsp; {<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL)<b=
r>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr=
_funcs &amp;&amp; hwmgr-&gt;smumgr_funcs-&gt;start_smu) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs-&gt;start_smu(hwmgr)=
) {<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 pr_err(&quot;smc start failed\n&quot;);<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 return -EINVAL;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;pm_en=
)<br>
&gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_se=
tup_asic(hwmgr);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; @@ -270,9 &#43;313,6 @@ int hwmgr_hw_resume(struct pp_hwmgr *h=
wmgr)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D phm_st=
art_thermal_controller(hwmgr);<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; -<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret |=3D psm_s=
et_performance_states(hwmgr);<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drive=
rs/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt;&gt;&gt; index 17f811d..d6c9a3b 100644<br>
&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br=
>
&gt;&gt;&gt; @@ -782,10 &#43;782,13 @@ struct pp_hwmgr {<br>
&gt;&gt;&gt;&nbsp; };<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&nbsp; int hwmgr_early_init(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt; &#43;int hwmgr_sw_init(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt; &#43;int hwmgr_sw_fini(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt;&nbsp; int hwmgr_hw_init(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt;&nbsp; int hwmgr_hw_fini(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt; -int hwmgr_hw_suspend(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt; -int hwmgr_hw_resume(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt; &#43;int hwmgr_suspend(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt; &#43;int hwmgr_resume(struct pp_hwmgr *hwmgr);<br>
&gt;&gt;&gt; &#43;<br>
&gt;&gt;&gt;&nbsp; int hwmgr_handle_task(struct pp_hwmgr *hwmgr,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pp_task tas=
k_id,<br>
&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_pm_state_ty=
pe *user_state);<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; 1.9.1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx" id=3D"LPlnk514271" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15217296746250.8377676973900243" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15217296746220.4412012350774459" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15217296746230.3999022866005415" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15217296746230.7515492768466687"></div>
<div id=3D"LPTitle_15217296746230.12004872687650803" style=3D"top: 0px; col=
or: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf=
_segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &q=
uot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-h=
eight: 21px;">
<a id=3D"LPUrlAnchor_15217296746240.5079464424197266" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15217296746240.5706125124067862" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15217296746250.7332168276446271" style=3D"display:=
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
</body>
</html>

--_000_CY4PR12MB1687BB4FAA9E0ED5916B0DB5FBA90CY4PR12MB1687namp_--

--===============0552781723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0552781723==--
