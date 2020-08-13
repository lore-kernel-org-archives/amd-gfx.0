Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49824C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 13:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162FD20774
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 13:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRyqBFD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162FD20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5CB6E9F1;
	Thu, 13 Aug 2020 13:53:49 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474486E9F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 13:53:48 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id 9so4759070wmj.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SbLabdSl+OMTISjR/Kpmfpe/iR7NFq73gorTS5++2R8=;
 b=HRyqBFD/tWlT2+lom/LiRR348+VflMReO6ehhsMWYfKuktMhDuoSRV3BaDPIrJKXwq
 dC8wEpJGBBiFnMmFBHRqzujkbmPUMJh4uFfsc7LTqx43gPCbYR1jdzT3BRbRb3ZSL8fc
 /5nNwSamUbdFMv9ptYEU7LsH/drCvAjza+kynryW1tAUGCYZjPVyiSTPU1HYgWcdPS45
 poibkfneLVSH2II3/vnCWv0AW1xlA1x7KEghcqZY6NHNSpOFWtJOMH48E5iLu36J/K/U
 YWjliZje1XRr3bDrdZIh/KdhrdIISj2ags4F8NqaLLZMCVTxZKCUNfJaJWjKKMeGcOt8
 z86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SbLabdSl+OMTISjR/Kpmfpe/iR7NFq73gorTS5++2R8=;
 b=U7ORf1sD6Eq1ZD63T5IyIrv2UAbQKY7tvzmP0DIPrCTQS1mKm5ysf6kA4ozpmD3chF
 nk4MqULDoJaGebjLlifJlGj9c/CLfWEf+k+iyratJrhy8nE/VagZ8haKCfwVI0aBnUtE
 BunFUA2pk3cA3GieWBtAeMhnkgC54kMaNNbG5Nkk1nYf/36sWJdKmE36js5j+o++Z/PC
 zp3X04AYn+aXSt5W9qmPsJVblrW1bv6zLRydgSa7LD2Xe8XEMoal5eNnrfBTFxzUrOe/
 JrtN5WvoTayb3ek5N6SX5YsKewvX7tBsp9f7EmhVujmAg45nLA5a+FZ3G0z/BBWwRXqs
 qG3A==
X-Gm-Message-State: AOAM5300voHE41eXyBTecJ/0MPLdJJLr+2j9Bfn9kaN0qIikmc/F++1r
 Yw4MEPqWJF5NGG6fkqFT2M+P5mAWgWJ+VoYpiEk=
X-Google-Smtp-Source: ABdhPJzWdmoNQoh8w9D0StlumsgzOPmChwpVgBeQmF9bCidpl4eUjdiJYB3MsSR1vJA057wa38aBotd+SBz9vKZbHuE=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr4440312wml.73.1597326826654;
 Thu, 13 Aug 2020 06:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200813090819.32115-1-evan.quan@amd.com>
 <20200813090819.32115-4-evan.quan@amd.com>
 <90cf2433-2c27-5a76-d08b-6838a6aa8c88@amd.com>
In-Reply-To: <90cf2433-2c27-5a76-d08b-6838a6aa8c88@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2020 09:53:35 -0400
Message-ID: <CADnq5_PyXxBssM7kY8Z=5YDSV18OOb5kP_ammSt4sO+R-dmjxg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: put those exposed power interfaces
 in amdgpu_dpm.c
To: Nirmoy <nirmodas@amd.com>
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Nirmoy makes some good points below, but I think those should be a
follow up patch as this patch is just moving code around; no actual
changes.

Alex

On Thu, Aug 13, 2020 at 6:52 AM Nirmoy <nirmodas@amd.com> wrote:
>
> Acked-by: Nirmoy Das <nirmoy.das@amd.com> for 1st 3 patches. Check for
> below for
>
> more comments.
>
> On 8/13/20 11:08 AM, Evan Quan wrote:
> > As other power interfaces.
> >
> > Change-Id: I5e3b85ae21c4b1d0239f54fa75247b33cfdb7ddc
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 425 ++++++++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h |  14 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c  | 423 -----------------------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h  |   8 -
> >   4 files changed, 439 insertions(+), 431 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> > index 2198148319e2..e114b5cbd8b0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
> > @@ -28,6 +28,11 @@
> >   #include "amdgpu_dpm.h"
> >   #include "atom.h"
> >   #include "amd_pcie.h"
> > +#include "amdgpu_display.h"
> > +#include "hwmgr.h"
> > +#include <linux/power_supply.h>
> > +
> > +#define WIDTH_4K 3840
> >
> >   void amdgpu_dpm_print_class_info(u32 class, u32 class2)
> >   {
> > @@ -1262,3 +1267,423 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
> >
> >       return ret;
> >   }
> > +
> > +void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
> > +{
> > +     if (adev->pm.dpm_enabled) {
> > +             mutex_lock(&adev->pm.mutex);
> > +             if (power_supply_is_system_supplied() > 0)
> > +                     adev->pm.ac_power = true;
> > +             else
> > +                     adev->pm.ac_power = false;
> > +             if (adev->powerplay.pp_funcs &&
> > +                 adev->powerplay.pp_funcs->enable_bapm)
> > +                     amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
> > +             mutex_unlock(&adev->pm.mutex);
> > +
> > +             if (is_support_sw_smu(adev))
> > +                     smu_set_ac_dc(&adev->smu);
> > +     }
> > +}
> > +
> > +int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
> > +                        void *data, uint32_t *size)
> > +{
> > +     int ret = 0;
> > +
> > +     if (!data || !size)
> > +             return -EINVAL;
> > +
> > +     if (is_support_sw_smu(adev))
> > +             ret = smu_read_sensor(&adev->smu, sensor, data, size);
> > +     else {
> > +             if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->read_sensor)
> > +                     ret = adev->powerplay.pp_funcs->read_sensor((adev)->powerplay.pp_handle,
> > +                                                                 sensor, data, size);
> > +             else
> > +                     ret = -EINVAL;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
> > +{
> > +     struct amdgpu_device *adev =
> > +             container_of(work, struct amdgpu_device,
> > +                          pm.dpm.thermal.work);
> > +     /* switch to the thermal state */
> > +     enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
> > +     int temp, size = sizeof(temp);
> > +
> > +     if (!adev->pm.dpm_enabled)
> > +             return;
> > +
> > +     if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_TEMP,
> > +                                 (void *)&temp, &size)) {
> > +             if (temp < adev->pm.dpm.thermal.min_temp)
> > +                     /* switch back the user state */
> > +                     dpm_state = adev->pm.dpm.user_state;
> > +     } else {
> > +             if (adev->pm.dpm.thermal.high_to_low)
> > +                     /* switch back the user state */
> > +                     dpm_state = adev->pm.dpm.user_state;
> > +     }
> > +     mutex_lock(&adev->pm.mutex);
> > +     if (dpm_state == POWER_STATE_TYPE_INTERNAL_THERMAL)
> > +             adev->pm.dpm.thermal_active = true;
> > +     else
> > +             adev->pm.dpm.thermal_active = false;
> > +     adev->pm.dpm.state = dpm_state;
> > +     mutex_unlock(&adev->pm.mutex);
> > +
> > +     amdgpu_pm_compute_clocks(adev);
> > +}
> > +
> > +static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
> > +                                                  enum amd_pm_state_type dpm_state)
> > +{
> > +     int i;
> > +     struct amdgpu_ps *ps;
> > +     u32 ui_class;
> > +     bool single_display = (adev->pm.dpm.new_active_crtc_count < 2) ?
> > +             true : false;
> > +
> > +     /* check if the vblank period is too short to adjust the mclk */
> > +     if (single_display && adev->powerplay.pp_funcs->vblank_too_short) {
> > +             if (amdgpu_dpm_vblank_too_short(adev))
> > +                     single_display = false;
> > +     }
> > +
> > +     /* certain older asics have a separare 3D performance state,
> > +      * so try that first if the user selected performance
> > +      */
> > +     if (dpm_state == POWER_STATE_TYPE_PERFORMANCE)
> > +             dpm_state = POWER_STATE_TYPE_INTERNAL_3DPERF;
> > +     /* balanced states don't exist at the moment */
> > +     if (dpm_state == POWER_STATE_TYPE_BALANCED)
> > +             dpm_state = POWER_STATE_TYPE_PERFORMANCE;
> > +
> > +restart_search:
> > +     /* Pick the best power state based on current conditions */
> > +     for (i = 0; i < adev->pm.dpm.num_ps; i++) {
> > +             ps = &adev->pm.dpm.ps[i];
> > +             ui_class = ps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK;
> > +             switch (dpm_state) {
> > +             /* user states */
> > +             case POWER_STATE_TYPE_BATTERY:
> > +                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_BATTERY) {
> > +                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
> > +                                     if (single_display)
> > +                                             return ps;
> > +                             } else
> > +                                     return ps;
> > +                     }
> > +                     break;
> > +             case POWER_STATE_TYPE_BALANCED:
> > +                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_BALANCED) {
> > +                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
> > +                                     if (single_display)
> > +                                             return ps;
> > +                             } else
> > +                                     return ps;
> > +                     }
> > +                     break;
> > +             case POWER_STATE_TYPE_PERFORMANCE:
> > +                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE) {
> > +                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
> > +                                     if (single_display)
> > +                                             return ps;
> > +                             } else
> > +                                     return ps;
> > +                     }
> > +                     break;
> > +             /* internal states */
> > +             case POWER_STATE_TYPE_INTERNAL_UVD:
> > +                     if (adev->pm.dpm.uvd_ps)
> > +                             return adev->pm.dpm.uvd_ps;
> > +                     else
>
>
> We don't need the "else" here.
>
>
> > +                             break;
> > +             case POWER_STATE_TYPE_INTERNAL_UVD_SD:
> > +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_SDSTATE)
> > +                             return ps;
> > +                     break;
> > +             case POWER_STATE_TYPE_INTERNAL_UVD_HD:
> > +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_HDSTATE)
> > +                             return ps;
> > +                     break;
> > +             case POWER_STATE_TYPE_INTERNAL_UVD_HD2:
> > +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_HD2STATE)
> > +                             return ps;
> > +                     break;
> > +             case POWER_STATE_TYPE_INTERNAL_UVD_MVC:
> > +                     if (ps->class2 & ATOM_PPLIB_CLASSIFICATION2_MVC)
> > +                             return ps;
> > +                     break;
> > +             case POWER_STATE_TYPE_INTERNAL_BOOT:
> > +                     return adev->pm.dpm.boot_ps;
> > +             case POWER_STATE_TYPE_INTERNAL_THERMAL:
> > +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_THERMAL)
> > +                             return ps;
> > +                     break;
> > +             case POWER_STATE_TYPE_INTERNAL_ACPI:
> > +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_ACPI)
> > +                             return ps;
> > +                     break;
> > +             case POWER_STATE_TYPE_INTERNAL_ULV:
> > +                     if (ps->class2 & ATOM_PPLIB_CLASSIFICATION2_ULV)
> > +                             return ps;
> > +                     break;
> > +             case POWER_STATE_TYPE_INTERNAL_3DPERF:
> > +                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_3DPERFORMANCE)
> > +                             return ps;
> > +                     break;
> > +             default:
> > +                     break;
> > +             }
> > +     }
> > +     /* use a fallback state if we didn't match */
> > +     switch (dpm_state) {
> > +     case POWER_STATE_TYPE_INTERNAL_UVD_SD:
> > +             dpm_state = POWER_STATE_TYPE_INTERNAL_UVD_HD;
> > +             goto restart_search;
> > +     case POWER_STATE_TYPE_INTERNAL_UVD_HD:
> > +     case POWER_STATE_TYPE_INTERNAL_UVD_HD2:
> > +     case POWER_STATE_TYPE_INTERNAL_UVD_MVC:
> > +             if (adev->pm.dpm.uvd_ps) {
> > +                     return adev->pm.dpm.uvd_ps;
> > +             } else {
> > +                     dpm_state = POWER_STATE_TYPE_PERFORMANCE;
> > +                     goto restart_search;
> > +             }
> > +     case POWER_STATE_TYPE_INTERNAL_THERMAL:
> > +             dpm_state = POWER_STATE_TYPE_INTERNAL_ACPI;
> > +             goto restart_search;
> > +     case POWER_STATE_TYPE_INTERNAL_ACPI:
> > +             dpm_state = POWER_STATE_TYPE_BATTERY;
> > +             goto restart_search;
> > +     case POWER_STATE_TYPE_BATTERY:
> > +     case POWER_STATE_TYPE_BALANCED:
> > +     case POWER_STATE_TYPE_INTERNAL_3DPERF:
> > +             dpm_state = POWER_STATE_TYPE_PERFORMANCE;
> > +             goto restart_search;
>
>
> I think it will be a good idea to move restart_search block to a
> function so we can easily
>
> rule out any infinite loops with "goto restart_search" usages.
>
>
>
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +static void amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
> > +{
> > +     struct amdgpu_ps *ps;
> > +     enum amd_pm_state_type dpm_state;
> > +     int ret;
> > +     bool equal = false;
> > +
> > +     /* if dpm init failed */
> > +     if (!adev->pm.dpm_enabled)
> > +             return;
> > +
> > +     if (adev->pm.dpm.user_state != adev->pm.dpm.state) {
> > +             /* add other state override checks here */
> > +             if ((!adev->pm.dpm.thermal_active) &&
> > +                 (!adev->pm.dpm.uvd_active))
> > +                     adev->pm.dpm.state = adev->pm.dpm.user_state;
> > +     }
> > +     dpm_state = adev->pm.dpm.state;
> > +
> > +     ps = amdgpu_dpm_pick_power_state(adev, dpm_state);
> > +     if (ps)
> > +             adev->pm.dpm.requested_ps = ps;
> > +     else
> > +             return;
>
>
> nitpick:
>
> if(!ns)
>
>      return;
>
> adev->pm.dpm.requested_ps = ps;
>
>
> > +
> > +     if (amdgpu_dpm == 1 && adev->powerplay.pp_funcs->print_power_state) {
> > +             printk("switching from power state:\n");
> > +             amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
> > +             printk("switching to power state:\n");
> > +             amdgpu_dpm_print_power_state(adev, adev->pm.dpm.requested_ps);
> > +     }
> > +
> > +     /* update whether vce is active */
> > +     ps->vce_active = adev->pm.dpm.vce_active;
> > +     if (adev->powerplay.pp_funcs->display_configuration_changed)
> > +             amdgpu_dpm_display_configuration_changed(adev);
> > +
> > +     ret = amdgpu_dpm_pre_set_power_state(adev);
> > +     if (ret)
> > +             return;
> > +
> > +     if (adev->powerplay.pp_funcs->check_state_equal) {
> > +             if (0 != amdgpu_dpm_check_state_equal(adev, adev->pm.dpm.current_ps, adev->pm.dpm.requested_ps, &equal))
>
>
> We don't need that check as amdgpu_dpm_check_state_equal() should not
> modify (default)value of
>
> "equal" on error.
>
>
> Nirmoy
>
> > +                     equal = false;
> > +     }
> > +
> > +     if (equal)
> > +             return;
> > +
> > +     amdgpu_dpm_set_power_state(adev);
> > +     amdgpu_dpm_post_set_power_state(adev);
> > +
> > +     adev->pm.dpm.current_active_crtcs = adev->pm.dpm.new_active_crtcs;
> > +     adev->pm.dpm.current_active_crtc_count = adev->pm.dpm.new_active_crtc_count;
> > +
> > +     if (adev->powerplay.pp_funcs->force_performance_level) {
> > +             if (adev->pm.dpm.thermal_active) {
> > +                     enum amd_dpm_forced_level level = adev->pm.dpm.forced_level;
> > +                     /* force low perf level for thermal */
> > +                     amdgpu_dpm_force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
> > +                     /* save the user's level */
> > +                     adev->pm.dpm.forced_level = level;
> > +             } else {
> > +                     /* otherwise, user selected level */
> > +                     amdgpu_dpm_force_performance_level(adev, adev->pm.dpm.forced_level);
> > +             }
> > +     }
> > +}
> > +
> > +void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
> > +{
> > +     int i = 0;
> > +
> > +     if (!adev->pm.dpm_enabled)
> > +             return;
> > +
> > +     if (adev->mode_info.num_crtc)
> > +             amdgpu_display_bandwidth_update(adev);
> > +
> > +     for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> > +             struct amdgpu_ring *ring = adev->rings[i];
> > +             if (ring && ring->sched.ready)
> > +                     amdgpu_fence_wait_empty(ring);
> > +     }
> > +
> > +     if (is_support_sw_smu(adev)) {
> > +             struct smu_dpm_context *smu_dpm = &adev->smu.smu_dpm;
> > +             smu_handle_task(&adev->smu,
> > +                             smu_dpm->dpm_level,
> > +                             AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
> > +                             true);
> > +     } else {
> > +             if (adev->powerplay.pp_funcs->dispatch_tasks) {
> > +                     if (!amdgpu_device_has_dc_support(adev)) {
> > +                             mutex_lock(&adev->pm.mutex);
> > +                             amdgpu_dpm_get_active_displays(adev);
> > +                             adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
> > +                             adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
> > +                             adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
> > +                             /* we have issues with mclk switching with refresh rates over 120 hz on the non-DC code. */
> > +                             if (adev->pm.pm_display_cfg.vrefresh > 120)
> > +                                     adev->pm.pm_display_cfg.min_vblank_time = 0;
> > +                             if (adev->powerplay.pp_funcs->display_configuration_change)
> > +                                     adev->powerplay.pp_funcs->display_configuration_change(
> > +                                                                     adev->powerplay.pp_handle,
> > +                                                                     &adev->pm.pm_display_cfg);
> > +                             mutex_unlock(&adev->pm.mutex);
> > +                     }
> > +                     amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
> > +             } else {
> > +                     mutex_lock(&adev->pm.mutex);
> > +                     amdgpu_dpm_get_active_displays(adev);
> > +                     amdgpu_dpm_change_power_state_locked(adev);
> > +                     mutex_unlock(&adev->pm.mutex);
> > +             }
> > +     }
> > +}
> > +
> > +void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
> > +{
> > +     int ret = 0;
> > +
> > +     if (adev->family == AMDGPU_FAMILY_SI) {
> > +             mutex_lock(&adev->pm.mutex);
> > +             if (enable) {
> > +                     adev->pm.dpm.uvd_active = true;
> > +                     adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> > +             } else {
> > +                     adev->pm.dpm.uvd_active = false;
> > +             }
> > +             mutex_unlock(&adev->pm.mutex);
> > +
> > +             amdgpu_pm_compute_clocks(adev);
> > +     } else {
> > +             ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> > +             if (ret)
> > +                     DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> > +                               enable ? "enable" : "disable", ret);
> > +
> > +             /* enable/disable Low Memory PState for UVD (4k videos) */
> > +             if (adev->asic_type == CHIP_STONEY &&
> > +                     adev->uvd.decode_image_width >= WIDTH_4K) {
> > +                     struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> > +
> > +                     if (hwmgr && hwmgr->hwmgr_func &&
> > +                         hwmgr->hwmgr_func->update_nbdpm_pstate)
> > +                             hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
> > +                                                                    !enable,
> > +                                                                    true);
> > +             }
> > +     }
> > +}
> > +
> > +void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
> > +{
> > +     int ret = 0;
> > +
> > +     if (adev->family == AMDGPU_FAMILY_SI) {
> > +             mutex_lock(&adev->pm.mutex);
> > +             if (enable) {
> > +                     adev->pm.dpm.vce_active = true;
> > +                     /* XXX select vce level based on ring/task */
> > +                     adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> > +             } else {
> > +                     adev->pm.dpm.vce_active = false;
> > +             }
> > +             mutex_unlock(&adev->pm.mutex);
> > +
> > +             amdgpu_pm_compute_clocks(adev);
> > +     } else {
> > +             ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> > +             if (ret)
> > +                     DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> > +                               enable ? "enable" : "disable", ret);
> > +     }
> > +}
> > +
> > +void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
> > +{
> > +     int i;
> > +
> > +     if (adev->powerplay.pp_funcs->print_power_state == NULL)
> > +             return;
> > +
> > +     for (i = 0; i < adev->pm.dpm.num_ps; i++)
> > +             amdgpu_dpm_print_power_state(adev, &adev->pm.dpm.ps[i]);
> > +
> > +}
> > +
> > +void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
> > +{
> > +     int ret = 0;
> > +
> > +     ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable);
> > +     if (ret)
> > +             DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
> > +                       enable ? "enable" : "disable", ret);
> > +}
> > +
> > +int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version)
> > +{
> > +     int r;
> > +
> > +     if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->load_firmware) {
> > +             r = adev->powerplay.pp_funcs->load_firmware(adev->powerplay.pp_handle);
> > +             if (r) {
> > +                     pr_err("smu firmware loading failed\n");
> > +                     return r;
> > +             }
> > +             *smu_version = adev->pm.fw_version;
> > +     }
> > +     return 0;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > index 5a2344f839f2..dff4a5f99bb0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> > @@ -548,4 +548,18 @@ int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
> >   int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_device *adev,
> >                                 bool acquire);
> >
> > +void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
> > +
> > +int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
> > +                        void *data, uint32_t *size);
> > +
> > +void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
> > +
> > +void amdgpu_pm_compute_clocks(struct amdgpu_device *adev);
> > +void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
> > +void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
> > +void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
> > +void amdgpu_pm_print_power_states(struct amdgpu_device *adev);
> > +int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version);
> > +
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > index 1705e328c6fc..9874f947e2ad 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > @@ -29,17 +29,14 @@
> >   #include "amdgpu_drv.h"
> >   #include "amdgpu_pm.h"
> >   #include "amdgpu_dpm.h"
> > -#include "amdgpu_display.h"
> >   #include "amdgpu_smu.h"
> >   #include "atom.h"
> > -#include <linux/power_supply.h>
> >   #include <linux/pci.h>
> >   #include <linux/hwmon.h>
> >   #include <linux/hwmon-sysfs.h>
> >   #include <linux/nospec.h>
> >   #include <linux/pm_runtime.h>
> >   #include "hwmgr.h"
> > -#define WIDTH_4K 3840
> >
> >   static const struct cg_flag_name clocks[] = {
> >       {AMD_CG_SUPPORT_GFX_MGCG, "Graphics Medium Grain Clock Gating"},
> > @@ -81,45 +78,6 @@ static const struct hwmon_temp_label {
> >       {PP_TEMP_MEM, "mem"},
> >   };
> >
> > -void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
> > -{
> > -     if (adev->pm.dpm_enabled) {
> > -             mutex_lock(&adev->pm.mutex);
> > -             if (power_supply_is_system_supplied() > 0)
> > -                     adev->pm.ac_power = true;
> > -             else
> > -                     adev->pm.ac_power = false;
> > -             if (adev->powerplay.pp_funcs &&
> > -                 adev->powerplay.pp_funcs->enable_bapm)
> > -                     amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
> > -             mutex_unlock(&adev->pm.mutex);
> > -
> > -             if (is_support_sw_smu(adev))
> > -                     smu_set_ac_dc(&adev->smu);
> > -     }
> > -}
> > -
> > -int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
> > -                        void *data, uint32_t *size)
> > -{
> > -     int ret = 0;
> > -
> > -     if (!data || !size)
> > -             return -EINVAL;
> > -
> > -     if (is_support_sw_smu(adev))
> > -             ret = smu_read_sensor(&adev->smu, sensor, data, size);
> > -     else {
> > -             if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->read_sensor)
> > -                     ret = adev->powerplay.pp_funcs->read_sensor((adev)->powerplay.pp_handle,
> > -                                                                 sensor, data, size);
> > -             else
> > -                     ret = -EINVAL;
> > -     }
> > -
> > -     return ret;
> > -}
> > -
> >   /**
> >    * DOC: power_dpm_state
> >    *
> > @@ -3636,338 +3594,6 @@ static const struct attribute_group *hwmon_groups[] = {
> >       NULL
> >   };
> >
> > -void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
> > -{
> > -     struct amdgpu_device *adev =
> > -             container_of(work, struct amdgpu_device,
> > -                          pm.dpm.thermal.work);
> > -     /* switch to the thermal state */
> > -     enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
> > -     int temp, size = sizeof(temp);
> > -
> > -     if (!adev->pm.dpm_enabled)
> > -             return;
> > -
> > -     if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_TEMP,
> > -                                 (void *)&temp, &size)) {
> > -             if (temp < adev->pm.dpm.thermal.min_temp)
> > -                     /* switch back the user state */
> > -                     dpm_state = adev->pm.dpm.user_state;
> > -     } else {
> > -             if (adev->pm.dpm.thermal.high_to_low)
> > -                     /* switch back the user state */
> > -                     dpm_state = adev->pm.dpm.user_state;
> > -     }
> > -     mutex_lock(&adev->pm.mutex);
> > -     if (dpm_state == POWER_STATE_TYPE_INTERNAL_THERMAL)
> > -             adev->pm.dpm.thermal_active = true;
> > -     else
> > -             adev->pm.dpm.thermal_active = false;
> > -     adev->pm.dpm.state = dpm_state;
> > -     mutex_unlock(&adev->pm.mutex);
> > -
> > -     amdgpu_pm_compute_clocks(adev);
> > -}
> > -
> > -static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
> > -                                                  enum amd_pm_state_type dpm_state)
> > -{
> > -     int i;
> > -     struct amdgpu_ps *ps;
> > -     u32 ui_class;
> > -     bool single_display = (adev->pm.dpm.new_active_crtc_count < 2) ?
> > -             true : false;
> > -
> > -     /* check if the vblank period is too short to adjust the mclk */
> > -     if (single_display && adev->powerplay.pp_funcs->vblank_too_short) {
> > -             if (amdgpu_dpm_vblank_too_short(adev))
> > -                     single_display = false;
> > -     }
> > -
> > -     /* certain older asics have a separare 3D performance state,
> > -      * so try that first if the user selected performance
> > -      */
> > -     if (dpm_state == POWER_STATE_TYPE_PERFORMANCE)
> > -             dpm_state = POWER_STATE_TYPE_INTERNAL_3DPERF;
> > -     /* balanced states don't exist at the moment */
> > -     if (dpm_state == POWER_STATE_TYPE_BALANCED)
> > -             dpm_state = POWER_STATE_TYPE_PERFORMANCE;
> > -
> > -restart_search:
> > -     /* Pick the best power state based on current conditions */
> > -     for (i = 0; i < adev->pm.dpm.num_ps; i++) {
> > -             ps = &adev->pm.dpm.ps[i];
> > -             ui_class = ps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK;
> > -             switch (dpm_state) {
> > -             /* user states */
> > -             case POWER_STATE_TYPE_BATTERY:
> > -                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_BATTERY) {
> > -                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
> > -                                     if (single_display)
> > -                                             return ps;
> > -                             } else
> > -                                     return ps;
> > -                     }
> > -                     break;
> > -             case POWER_STATE_TYPE_BALANCED:
> > -                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_BALANCED) {
> > -                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
> > -                                     if (single_display)
> > -                                             return ps;
> > -                             } else
> > -                                     return ps;
> > -                     }
> > -                     break;
> > -             case POWER_STATE_TYPE_PERFORMANCE:
> > -                     if (ui_class == ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE) {
> > -                             if (ps->caps & ATOM_PPLIB_SINGLE_DISPLAY_ONLY) {
> > -                                     if (single_display)
> > -                                             return ps;
> > -                             } else
> > -                                     return ps;
> > -                     }
> > -                     break;
> > -             /* internal states */
> > -             case POWER_STATE_TYPE_INTERNAL_UVD:
> > -                     if (adev->pm.dpm.uvd_ps)
> > -                             return adev->pm.dpm.uvd_ps;
> > -                     else
> > -                             break;
> > -             case POWER_STATE_TYPE_INTERNAL_UVD_SD:
> > -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_SDSTATE)
> > -                             return ps;
> > -                     break;
> > -             case POWER_STATE_TYPE_INTERNAL_UVD_HD:
> > -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_HDSTATE)
> > -                             return ps;
> > -                     break;
> > -             case POWER_STATE_TYPE_INTERNAL_UVD_HD2:
> > -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_HD2STATE)
> > -                             return ps;
> > -                     break;
> > -             case POWER_STATE_TYPE_INTERNAL_UVD_MVC:
> > -                     if (ps->class2 & ATOM_PPLIB_CLASSIFICATION2_MVC)
> > -                             return ps;
> > -                     break;
> > -             case POWER_STATE_TYPE_INTERNAL_BOOT:
> > -                     return adev->pm.dpm.boot_ps;
> > -             case POWER_STATE_TYPE_INTERNAL_THERMAL:
> > -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_THERMAL)
> > -                             return ps;
> > -                     break;
> > -             case POWER_STATE_TYPE_INTERNAL_ACPI:
> > -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_ACPI)
> > -                             return ps;
> > -                     break;
> > -             case POWER_STATE_TYPE_INTERNAL_ULV:
> > -                     if (ps->class2 & ATOM_PPLIB_CLASSIFICATION2_ULV)
> > -                             return ps;
> > -                     break;
> > -             case POWER_STATE_TYPE_INTERNAL_3DPERF:
> > -                     if (ps->class & ATOM_PPLIB_CLASSIFICATION_3DPERFORMANCE)
> > -                             return ps;
> > -                     break;
> > -             default:
> > -                     break;
> > -             }
> > -     }
> > -     /* use a fallback state if we didn't match */
> > -     switch (dpm_state) {
> > -     case POWER_STATE_TYPE_INTERNAL_UVD_SD:
> > -             dpm_state = POWER_STATE_TYPE_INTERNAL_UVD_HD;
> > -             goto restart_search;
> > -     case POWER_STATE_TYPE_INTERNAL_UVD_HD:
> > -     case POWER_STATE_TYPE_INTERNAL_UVD_HD2:
> > -     case POWER_STATE_TYPE_INTERNAL_UVD_MVC:
> > -             if (adev->pm.dpm.uvd_ps) {
> > -                     return adev->pm.dpm.uvd_ps;
> > -             } else {
> > -                     dpm_state = POWER_STATE_TYPE_PERFORMANCE;
> > -                     goto restart_search;
> > -             }
> > -     case POWER_STATE_TYPE_INTERNAL_THERMAL:
> > -             dpm_state = POWER_STATE_TYPE_INTERNAL_ACPI;
> > -             goto restart_search;
> > -     case POWER_STATE_TYPE_INTERNAL_ACPI:
> > -             dpm_state = POWER_STATE_TYPE_BATTERY;
> > -             goto restart_search;
> > -     case POWER_STATE_TYPE_BATTERY:
> > -     case POWER_STATE_TYPE_BALANCED:
> > -     case POWER_STATE_TYPE_INTERNAL_3DPERF:
> > -             dpm_state = POWER_STATE_TYPE_PERFORMANCE;
> > -             goto restart_search;
> > -     default:
> > -             break;
> > -     }
> > -
> > -     return NULL;
> > -}
> > -
> > -static void amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
> > -{
> > -     struct amdgpu_ps *ps;
> > -     enum amd_pm_state_type dpm_state;
> > -     int ret;
> > -     bool equal = false;
> > -
> > -     /* if dpm init failed */
> > -     if (!adev->pm.dpm_enabled)
> > -             return;
> > -
> > -     if (adev->pm.dpm.user_state != adev->pm.dpm.state) {
> > -             /* add other state override checks here */
> > -             if ((!adev->pm.dpm.thermal_active) &&
> > -                 (!adev->pm.dpm.uvd_active))
> > -                     adev->pm.dpm.state = adev->pm.dpm.user_state;
> > -     }
> > -     dpm_state = adev->pm.dpm.state;
> > -
> > -     ps = amdgpu_dpm_pick_power_state(adev, dpm_state);
> > -     if (ps)
> > -             adev->pm.dpm.requested_ps = ps;
> > -     else
> > -             return;
> > -
> > -     if (amdgpu_dpm == 1 && adev->powerplay.pp_funcs->print_power_state) {
> > -             printk("switching from power state:\n");
> > -             amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
> > -             printk("switching to power state:\n");
> > -             amdgpu_dpm_print_power_state(adev, adev->pm.dpm.requested_ps);
> > -     }
> > -
> > -     /* update whether vce is active */
> > -     ps->vce_active = adev->pm.dpm.vce_active;
> > -     if (adev->powerplay.pp_funcs->display_configuration_changed)
> > -             amdgpu_dpm_display_configuration_changed(adev);
> > -
> > -     ret = amdgpu_dpm_pre_set_power_state(adev);
> > -     if (ret)
> > -             return;
> > -
> > -     if (adev->powerplay.pp_funcs->check_state_equal) {
> > -             if (0 != amdgpu_dpm_check_state_equal(adev, adev->pm.dpm.current_ps, adev->pm.dpm.requested_ps, &equal))
> > -                     equal = false;
> > -     }
> > -
> > -     if (equal)
> > -             return;
> > -
> > -     amdgpu_dpm_set_power_state(adev);
> > -     amdgpu_dpm_post_set_power_state(adev);
> > -
> > -     adev->pm.dpm.current_active_crtcs = adev->pm.dpm.new_active_crtcs;
> > -     adev->pm.dpm.current_active_crtc_count = adev->pm.dpm.new_active_crtc_count;
> > -
> > -     if (adev->powerplay.pp_funcs->force_performance_level) {
> > -             if (adev->pm.dpm.thermal_active) {
> > -                     enum amd_dpm_forced_level level = adev->pm.dpm.forced_level;
> > -                     /* force low perf level for thermal */
> > -                     amdgpu_dpm_force_performance_level(adev, AMD_DPM_FORCED_LEVEL_LOW);
> > -                     /* save the user's level */
> > -                     adev->pm.dpm.forced_level = level;
> > -             } else {
> > -                     /* otherwise, user selected level */
> > -                     amdgpu_dpm_force_performance_level(adev, adev->pm.dpm.forced_level);
> > -             }
> > -     }
> > -}
> > -
> > -void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
> > -{
> > -     int ret = 0;
> > -
> > -     if (adev->family == AMDGPU_FAMILY_SI) {
> > -             mutex_lock(&adev->pm.mutex);
> > -             if (enable) {
> > -                     adev->pm.dpm.uvd_active = true;
> > -                     adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> > -             } else {
> > -                     adev->pm.dpm.uvd_active = false;
> > -             }
> > -             mutex_unlock(&adev->pm.mutex);
> > -
> > -             amdgpu_pm_compute_clocks(adev);
> > -     } else {
> > -             ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
> > -             if (ret)
> > -                     DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> > -                               enable ? "enable" : "disable", ret);
> > -
> > -             /* enable/disable Low Memory PState for UVD (4k videos) */
> > -             if (adev->asic_type == CHIP_STONEY &&
> > -                     adev->uvd.decode_image_width >= WIDTH_4K) {
> > -                     struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
> > -
> > -                     if (hwmgr && hwmgr->hwmgr_func &&
> > -                         hwmgr->hwmgr_func->update_nbdpm_pstate)
> > -                             hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
> > -                                                                    !enable,
> > -                                                                    true);
> > -             }
> > -     }
> > -}
> > -
> > -void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
> > -{
> > -     int ret = 0;
> > -
> > -     if (adev->family == AMDGPU_FAMILY_SI) {
> > -             mutex_lock(&adev->pm.mutex);
> > -             if (enable) {
> > -                     adev->pm.dpm.vce_active = true;
> > -                     /* XXX select vce level based on ring/task */
> > -                     adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> > -             } else {
> > -                     adev->pm.dpm.vce_active = false;
> > -             }
> > -             mutex_unlock(&adev->pm.mutex);
> > -
> > -             amdgpu_pm_compute_clocks(adev);
> > -     } else {
> > -             ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
> > -             if (ret)
> > -                     DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> > -                               enable ? "enable" : "disable", ret);
> > -     }
> > -}
> > -
> > -void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
> > -{
> > -     int i;
> > -
> > -     if (adev->powerplay.pp_funcs->print_power_state == NULL)
> > -             return;
> > -
> > -     for (i = 0; i < adev->pm.dpm.num_ps; i++)
> > -             amdgpu_dpm_print_power_state(adev, &adev->pm.dpm.ps[i]);
> > -
> > -}
> > -
> > -void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
> > -{
> > -     int ret = 0;
> > -
> > -     ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable);
> > -     if (ret)
> > -             DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
> > -                       enable ? "enable" : "disable", ret);
> > -}
> > -
> > -int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version)
> > -{
> > -     int r;
> > -
> > -     if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->load_firmware) {
> > -             r = adev->powerplay.pp_funcs->load_firmware(adev->powerplay.pp_handle);
> > -             if (r) {
> > -                     pr_err("smu firmware loading failed\n");
> > -                     return r;
> > -             }
> > -             *smu_version = adev->pm.fw_version;
> > -     }
> > -     return 0;
> > -}
> > -
> >   int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
> >   {
> >       int ret;
> > @@ -4028,55 +3654,6 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
> >       amdgpu_device_attr_remove_groups(adev, &adev->pm.pm_attr_list);
> >   }
> >
> > -void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
> > -{
> > -     int i = 0;
> > -
> > -     if (!adev->pm.dpm_enabled)
> > -             return;
> > -
> > -     if (adev->mode_info.num_crtc)
> > -             amdgpu_display_bandwidth_update(adev);
> > -
> > -     for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> > -             struct amdgpu_ring *ring = adev->rings[i];
> > -             if (ring && ring->sched.ready)
> > -                     amdgpu_fence_wait_empty(ring);
> > -     }
> > -
> > -     if (is_support_sw_smu(adev)) {
> > -             struct smu_dpm_context *smu_dpm = &adev->smu.smu_dpm;
> > -             smu_handle_task(&adev->smu,
> > -                             smu_dpm->dpm_level,
> > -                             AMD_PP_TASK_DISPLAY_CONFIG_CHANGE,
> > -                             true);
> > -     } else {
> > -             if (adev->powerplay.pp_funcs->dispatch_tasks) {
> > -                     if (!amdgpu_device_has_dc_support(adev)) {
> > -                             mutex_lock(&adev->pm.mutex);
> > -                             amdgpu_dpm_get_active_displays(adev);
> > -                             adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
> > -                             adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
> > -                             adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
> > -                             /* we have issues with mclk switching with refresh rates over 120 hz on the non-DC code. */
> > -                             if (adev->pm.pm_display_cfg.vrefresh > 120)
> > -                                     adev->pm.pm_display_cfg.min_vblank_time = 0;
> > -                             if (adev->powerplay.pp_funcs->display_configuration_change)
> > -                                     adev->powerplay.pp_funcs->display_configuration_change(
> > -                                                                     adev->powerplay.pp_handle,
> > -                                                                     &adev->pm.pm_display_cfg);
> > -                             mutex_unlock(&adev->pm.mutex);
> > -                     }
> > -                     amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_DISPLAY_CONFIG_CHANGE, NULL);
> > -             } else {
> > -                     mutex_lock(&adev->pm.mutex);
> > -                     amdgpu_dpm_get_active_displays(adev);
> > -                     amdgpu_dpm_change_power_state_locked(adev);
> > -                     mutex_unlock(&adev->pm.mutex);
> > -             }
> > -     }
> > -}
> > -
> >   /*
> >    * Debugfs info
> >    */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
> > index d9ae2b49a402..45a22e101d15 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
> > @@ -79,18 +79,10 @@ struct amdgpu_device_attr_entry {
> >                            amdgpu_get_##_name, NULL,                  \
> >                            _flags, ##__VA_ARGS__)
> >
> > -void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
> >   int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
> >   int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
> >   void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
> >   void amdgpu_pm_virt_sysfs_fini(struct amdgpu_device *adev);
> > -void amdgpu_pm_print_power_states(struct amdgpu_device *adev);
> > -int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version);
> > -void amdgpu_pm_compute_clocks(struct amdgpu_device *adev);
> > -void amdgpu_dpm_thermal_work_handler(struct work_struct *work);
> > -void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
> > -void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
> > -void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
> >
> >   int amdgpu_debugfs_pm_init(struct amdgpu_device *adev);
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
