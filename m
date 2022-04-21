Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BB7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 13:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B4A410E351;
	Thu, 21 Apr 2022 13:06:24 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAFB10F80A
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 08:29:16 +0000 (UTC)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1nhSBa-0002bh-Cn; Thu, 21 Apr 2022 10:29:10 +0200
Message-ID: <44570dcb-edae-9a92-b5a8-cfe9da4e9b29@leemhuis.info>
Date: Thu, 21 Apr 2022 10:29:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2] drm/amd/pm: fix the deadlock issue observed on SI
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220411085453.38063-1-evan.quan@amd.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220411085453.38063-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1650529756;
 c613129c; 
X-HE-SMSGID: 1nhSBa-0002bh-Cn
X-Mailman-Approved-At: Thu, 21 Apr 2022 13:06:23 +0000
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
Cc: Alexander.Deucher@amd.com, pmenzel@molgen.mpg.de,
 arthur.marsh@internode.on.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11.04.22 10:54, Evan Quan wrote:
> The adev->pm.mutx is already held at the beginning of
> amdgpu_dpm_compute_clocks/amdgpu_dpm_enable_uvd/amdgpu_dpm_enable_vce.
> But on their calling path, amdgpu_display_bandwidth_update will be
> called and thus its sub functions amdgpu_dpm_get_sclk/mclk. They
> will then try to acquire the same adev->pm.mutex and deadlock will
> occur.
> 
> By placing amdgpu_display_bandwidth_update outside of adev->pm.mutex
> protection(considering logically they do not need such protection) and
> restructuring the call flow accordingly, we can eliminate the deadlock
> issue. This comes with no real logics change.
> 
> Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
> Link: https: //lore.kernel.org/all/9e689fea-6c69-f4b0-8dee-32c4cf7d8f9c@molgen.mpg.de/
> BugLink: https: //gitlab.freedesktop.org/drm/amd/-/issues/1957

Side note: two spaces sneaked in there. But that's not why I write this
mail.

This patch is fixing a regression in 5.18-rc, but it looks like things
are stuck for more than a week now. What's up there? Or was progress
made somewhere and I just couldn't find it? Was the review comment from
Lijo addressed?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot ignore-activity
#regzbot ^backmonitor:
https://lore.kernel.org/all/9e689fea-6c69-f4b0-8dee-32c4cf7d8f9c@molgen.mpg.de/

> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v1->v2:
>   - rich the commit messages(Paul)
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39 +++++++++++++++++++
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 10 -----
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 35 -----------------
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 10 -----
>  4 files changed, 39 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 5504d81c77b7..72e7b5d40af6 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -427,6 +427,7 @@ int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors senso
>  void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>  {
>  	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	int i;
>  
>  	if (!adev->pm.dpm_enabled)
>  		return;
> @@ -434,6 +435,15 @@ void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>  	if (!pp_funcs->pm_compute_clocks)
>  		return;
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
>  	mutex_lock(&adev->pm.mutex);
>  	pp_funcs->pm_compute_clocks(adev->powerplay.pp_handle);
>  	mutex_unlock(&adev->pm.mutex);
> @@ -443,6 +453,20 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
>  {
>  	int ret = 0;
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
>  	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
>  	if (ret)
>  		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
> @@ -453,6 +477,21 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>  {
>  	int ret = 0;
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
>  	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
>  	if (ret)
>  		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index 9613c6181c17..d3fe149d8476 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -1028,16 +1028,6 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
>  void amdgpu_legacy_dpm_compute_clocks(void *handle)
>  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
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
>  	amdgpu_dpm_get_active_displays(adev);
>  
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index caae54487f9c..633dab14f51c 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3892,40 +3892,6 @@ static int si_set_boot_state(struct amdgpu_device *adev)
>  }
>  #endif
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
>  static int si_set_sw_state(struct amdgpu_device *adev)
>  {
>  	return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_SwitchToSwState) == PPSMC_Result_OK) ?
> @@ -8125,7 +8091,6 @@ static const struct amd_pm_funcs si_dpm_funcs = {
>  	.print_power_state = &si_dpm_print_power_state,
>  	.debugfs_print_current_performance_level = &si_dpm_debugfs_print_current_performance_level,
>  	.force_performance_level = &si_dpm_force_performance_level,
> -	.set_powergating_by_smu = &si_set_powergating_by_smu,
>  	.vblank_too_short = &si_dpm_vblank_too_short,
>  	.set_fan_control_mode = &si_dpm_set_fan_control_mode,
>  	.get_fan_control_mode = &si_dpm_get_fan_control_mode,
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index dbed72c1e0c6..1eb4e613b27a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1503,16 +1503,6 @@ static void pp_pm_compute_clocks(void *handle)
>  {
>  	struct pp_hwmgr *hwmgr = handle;
>  	struct amdgpu_device *adev = hwmgr->adev;
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
>  	if (!amdgpu_device_has_dc_support(adev)) {
>  		amdgpu_dpm_get_active_displays(adev);

