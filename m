Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F195C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 08:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DDB6113D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 08:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1DDB6113D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DEE36E4BB;
	Mon,  8 Nov 2021 08:51:06 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F52C6E4BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 08:51:05 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef86.dynamic.kabel-deutschland.de
 [95.90.239.134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id DC9D461E5FE00;
 Mon,  8 Nov 2021 09:51:03 +0100 (CET)
Message-ID: <427ace3e-ba04-bd5c-4eef-d83147ef288e@molgen.mpg.de>
Date: Mon, 8 Nov 2021 09:51:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>
References: <20211108044723.54716-1-evan.quan@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20211108044723.54716-1-evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Borislav Petkov <bp@suse.de>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Evan,


Am 08.11.21 um 05:47 schrieb Evan Quan:
> Just bail out if the target IP block is already in the desired
> powergate/ungate state. This can avoid some duplicate settings
> which sometime may cause unexpected issues.

sometime*s*

Please elaborate the kind of issues.

On what systems did you test this? Also, there is a new debug log message.

> Change-Id: I66346c69f121df0f5ee20182451313ae4fda2d04
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Tested-by: Borislav Petkov <bp@suse.de>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  7 +++++++
>   drivers/gpu/drm/amd/include/amd_shared.h         |  3 ++-
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 13 ++++++++++++-
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  3 +++
>   drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c        |  3 +++
>   drivers/gpu/drm/amd/pm/powerplay/si_dpm.c        |  3 +++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  3 +++
>   7 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b85b67a88a3d..19fa21ad8a44 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -767,9 +767,16 @@ enum amd_hw_ip_block_type {
>   #define HW_ID_MAX		300
>   #define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
>   
> +enum amd_ip_powergate_state {
> +	POWERGATE_STATE_INITIAL,
> +	POWERGATE_STATE_GATE,
> +	POWERGATE_STATE_UNGATE,
> +};
> +
>   struct amd_powerplay {
>   	void *pp_handle;
>   	const struct amd_pm_funcs *pp_funcs;
> +	atomic_t pg_state[AMD_IP_BLOCK_TYPE_NUM];
>   };
>   
>   /* polaris10 kickers */
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index f1a46d16f7ea..4b9e68a79f06 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -98,7 +98,8 @@ enum amd_ip_block_type {
>   	AMD_IP_BLOCK_TYPE_ACP,
>   	AMD_IP_BLOCK_TYPE_VCN,
>   	AMD_IP_BLOCK_TYPE_MES,
> -	AMD_IP_BLOCK_TYPE_JPEG
> +	AMD_IP_BLOCK_TYPE_JPEG,
> +	AMD_IP_BLOCK_TYPE_NUM,
>   };
>   
>   enum amd_clockgating_state {
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 03581d5b1836..a6b337b6f4a9 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -927,6 +927,14 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>   {
>   	int ret = 0;
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	enum amd_ip_powergate_state pg_state =
> +		gate ? POWERGATE_STATE_GATE : POWERGATE_STATE_UNGATE;
> +
> +	if (atomic_read(&adev->powerplay.pg_state[block_type]) == pg_state) {
> +		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
> +				block_type, gate ? "gate" : "ungate");
> +		return 0;
> +	}
>   
>   	switch (block_type) {
>   	case AMD_IP_BLOCK_TYPE_UVD:
> @@ -976,9 +984,12 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
>   		}
>   		break;
>   	default:
> -		break;
> +		return -EINVAL;
>   	}
>   
> +	if (!ret)
> +		atomic_set(&adev->powerplay.pg_state[block_type], pg_state);
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index bba7479f6265..8d8a7cf615eb 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -38,6 +38,7 @@ static const struct amd_pm_funcs pp_dpm_funcs;
>   static int amd_powerplay_create(struct amdgpu_device *adev)
>   {
>   	struct pp_hwmgr *hwmgr;
> +	int i;

I’d use `unsigned int` or `size_t` to make it clear, that they cannot 
get negative.

>   
>   	if (adev == NULL)
>   		return -EINVAL;
> @@ -57,6 +58,8 @@ static int amd_powerplay_create(struct amdgpu_device *adev)
>   	hwmgr->display_config = &adev->pm.pm_display_cfg;
>   	adev->powerplay.pp_handle = hwmgr;
>   	adev->powerplay.pp_funcs = &pp_dpm_funcs;
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> +		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> index bcae42cef374..f84f56552fd0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
> @@ -2965,9 +2965,12 @@ static int kv_dpm_get_temp(void *handle)
>   static int kv_dpm_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	int i;
>   
>   	adev->powerplay.pp_funcs = &kv_dpm_funcs;
>   	adev->powerplay.pp_handle = adev;
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> +		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
>   	kv_dpm_set_irq_funcs(adev);
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> index 81f82aa05ec2..f1eb22c9bb59 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
> @@ -7916,9 +7916,12 @@ static int si_dpm_early_init(void *handle)
>   {
>   
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	int i;
>   
>   	adev->powerplay.pp_funcs = &si_dpm_funcs;
>   	adev->powerplay.pp_handle = adev;
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> +		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
>   	si_dpm_set_irq_funcs(adev);
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 01168b8955bf..fdc25bae8237 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -627,6 +627,7 @@ static int smu_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct smu_context *smu = &adev->smu;
> +	int i;
>   
>   	smu->adev = adev;
>   	smu->pm_enabled = !!amdgpu_dpm;
> @@ -639,6 +640,8 @@ static int smu_early_init(void *handle)
>   
>   	adev->powerplay.pp_handle = smu;
>   	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> +		atomic_set(&adev->powerplay.pg_state[i], POWERGATE_STATE_INITIAL);
>   
>   	return smu_set_funcs(adev);
>   }
> 
