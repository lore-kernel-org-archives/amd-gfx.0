Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9357C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 07:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56D7710F040;
	Mon, 11 Apr 2022 07:59:12 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79BE910F07D
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 07:59:10 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae91f.dynamic.kabel-deutschland.de
 [95.90.233.31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D07BF61EA1923;
 Mon, 11 Apr 2022 09:59:08 +0200 (CEST)
Message-ID: <78cdd8a2-4482-7b1b-2df4-a2983c1b2887@molgen.mpg.de>
Date: Mon, 11 Apr 2022 09:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amd/pm: fix the deadlock issue observed on SI
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>
References: <20220411074732.36486-1-evan.quan@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220411074732.36486-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Alexander.Deucher@amd.com, arthur.marsh@internode.on.net,
 regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Evan,


It would have been nice, if you put me in Cc as I also reported the 
regression.

Am 11.04.22 um 09:47 schrieb Evan Quan:
> By placing those unrelated code outside of adev->pm.mutex
> protections or restructuring the call flow, we can eliminate
> the deadlock issue. This comes with no real logics change.

Please describe the deadlock issue and the fix in more detail. What code 
is unrelated, and why was it put into the mutex protections in the first 
place?

> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")

No blank line needed.

> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I75de4350d9c2517aba0d6adc12e1bc69430fd800

Without the Gerrit instance URL, the Change-Id is useless.

As it’s a regression, please follow the documentation, and add the 
related tags.

Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
Link: 
https://lore.kernel.org/r/9e689fea-6c69-f4b0-8dee-32c4cf7d8f9c@molgen.mpg.de
BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1957

Also add the link from Arthur.


Kind regards,

Paul


[1]: https://linux-regtracking.leemhuis.info/regzbot/mainline/

> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39 +++++++++++++++++++
>   .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 10 -----
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 35 -----------------
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 -----
>   4 files changed, 39 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 5504d81c77b7..72e7b5d40af6 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -427,6 +427,7 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
>   void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int i;

You could make it unsigned, as the variable never should be assigned 
negaitve values.

>   
>   	if (!adev->pm.dpm_enabled)
>   		return;
> @@ -434,6 +435,15 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>   	if (!pp_funcs->pm_compute_clocks)
>   		return;
>   
> +	if (adev->mode_info.num_crtc)
> +		amdgpu_display_bandwidth_update(adev);
> +
> +	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> +		struct amdgpu_ring *ring = adev->rings[i];
> +		if (ring && ring->sched.ready)
> +			amdgpu_fence_wait_empty(ring);
> +	}
> +
>   	mutex_lock(&adev->pm.mutex);
>   	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
>   	mutex_unlock(&adev->pm.mutex);
> @@ -443,6 +453,20 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>   {
>   	int ret = 0;
>   
> +	if (adev->family == AMDGPU_FAMILY_SI) {
> +		mutex_lock(&adev->pm.mutex);
> +		if (enable) {
> +			adev->pm.dpm.uvd_active = true;
> +			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> +		} else {
> +			adev->pm.dpm.uvd_active = false;
> +		}
> +		mutex_unlock(&adev->pm.mutex);
> +
> +		amdgpu_dpm_compute_clocks(adev);
> +		return;
> +	}
> +
>   	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
>   	if (ret)
>   		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> @@ -453,6 +477,21 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>   {
>   	int ret = 0;
>   
> +	if (adev->family == AMDGPU_FAMILY_SI) {
> +		mutex_lock(&adev->pm.mutex);
> +		if (enable) {
> +			adev->pm.dpm.vce_active = true;
> +			/* XXX select vce level based on ring/task */
> +			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> +		} else {
> +			adev->pm.dpm.vce_active = false;
> +		}
> +		mutex_unlock(&adev->pm.mutex);
> +
> +		amdgpu_dpm_compute_clocks(adev);
> +		return;
> +	}
> +
>   	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
>   	if (ret)
>   		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index 9613c6181c17..d3fe149d8476 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -1028,16 +1028,6 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>   void amdgpu_legacy_dpm_compute_clocks(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	int i = 0;
> -
> -	if (adev->mode_info.num_crtc)
> -		amdgpu_display_bandwidth_update(adev);
> -
> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> -		struct amdgpu_ring *ring = adev->rings[i];
> -		if (ring && ring->sched.ready)
> -			amdgpu_fence_wait_empty(ring);
> -	}
>   
>   	amdgpu_dpm_get_active_displays(adev);
>   
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index caae54487f9c..633dab14f51c 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3892,40 +3892,6 @@ static int si_set_boot_state(struct amdgpu_device *adev)
>   }
>   #endif
>   
> -static int si_set_powergating_by_smu(void *handle,
> -				     uint32_t block_type,
> -				     bool gate)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	switch (block_type) {
> -	case AMD_IP_BLOCK_TYPE_UVD:
> -		if (!gate) {
> -			adev->pm.dpm.uvd_active = true;
> -			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
> -		} else {
> -			adev->pm.dpm.uvd_active = false;
> -		}
> -
> -		amdgpu_legacy_dpm_compute_clocks(handle);
> -		break;
> -	case AMD_IP_BLOCK_TYPE_VCE:
> -		if (!gate) {
> -			adev->pm.dpm.vce_active = true;
> -			/* XXX select vce level based on ring/task */
> -			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
> -		} else {
> -			adev->pm.dpm.vce_active = false;
> -		}
> -
> -		amdgpu_legacy_dpm_compute_clocks(handle);
> -		break;
> -	default:
> -		break;
> -	}
> -	return 0;
> -}
> -
>   static int si_set_sw_state(struct amdgpu_device *adev)
>   {
>   	return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
> @@ -8125,7 +8091,6 @@ static const struct amd_pm_funcs si_dpm_funcs = {
>   	.print_power_state = &si_dpm_print_power_state,
>   	.debugfs_print_current_performance_level = &si_dpm_debugfs_print_current_performance_level,
>   	.force_performance_level = &si_dpm_force_performance_level,
> -	.set_powergating_by_smu = &si_set_powergating_by_smu,
>   	.vblank_too_short = &si_dpm_vblank_too_short,
>   	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
>   	.get_fan_control_mode = &si_dpm_get_fan_control_mode,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index dbed72c1e0c6..1eb4e613b27a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1503,16 +1503,6 @@ static void pp_pm_compute_clocks(void *handle)
>   {
>   	struct pp_hwmgr *hwmgr = handle;
>   	struct amdgpu_device *adev = hwmgr->adev;
> -	int i = 0;
> -
> -	if (adev->mode_info.num_crtc)
> -		amdgpu_display_bandwidth_update(adev);
> -
> -	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
> -		struct amdgpu_ring *ring = adev->rings[i];
> -		if (ring && ring->sched.ready)
> -			amdgpu_fence_wait_empty(ring);
> -	}
>   
>   	if (!amdgpu_device_has_dc_support(adev)) {
>   		amdgpu_dpm_get_active_displays(adev);
