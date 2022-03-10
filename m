Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AF4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 10:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4979E10E7F0;
	Thu, 10 Mar 2022 10:04:24 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEF7010E7F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 10:04:22 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id bi12so10943062ejb.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 02:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=fFzhqFfJrML7Pm47ej+K8AzXus/Q1TA7zagWkD7x8JE=;
 b=UfzD8SO79dHVjL2lgAZNFrEMe7BbTSUypIwSFSGh1uXRMc1uaCAFxvVPAmgi83VGZe
 XgEh1fDTAZf6OCEKDIVZI+3LMLj3VA+7fE5IcsSBDNjwLU6ZIhP6B35oSOSu1q9jYkR9
 nafD97DhnZbnhVRrHaRuFXIhvcjeZg+cPsBrQxrkRLXCPOvuKhLjU2YBo4geIKlybSHF
 d6cII+kwhvEz+4oyvUsLDWyEUYx+R/bfMdqjn36DJqxSobZqcJRHQVjBtpcef8kjAbLC
 DSEaXBFTPWm2937umx/A44EOdliXjSMrsOXaOhah3mLs+2vcZkwpe+WzvOuP/oYIC+DQ
 eltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fFzhqFfJrML7Pm47ej+K8AzXus/Q1TA7zagWkD7x8JE=;
 b=bucJzHLGfjroOatX2nVMvsj7+rQECVA+fq4XmIDKGROrQpOOSGABY/QS05YbR6ODzm
 7MJnN0XcjBQNP/WtkOcOv00U8/80zOikDyrBo38Kn7H20CyYGC6xbMl+UPtQjUiCbGaY
 e0YvOuuWLmJUDrieft/IysxiO+Y28H9XCxuxFpvRqo7zXl40qTSiOGN43A8YF1qhDje9
 CdSerAysouqFy/NkRN14aPup9OU3dxrcRneUIYwHpLb5oHMfHmKRho3KdfckM2e7byxt
 N3JPVBnX/rufaNDBZ/GnyAf4UmpsxQGyDcR/gEtgdMIo9eWIj+zRHgCClm1H6A/aoWcH
 NYVw==
X-Gm-Message-State: AOAM532etmbN7oi4fE82tLdLMHBw4ttdU/SVMa6MX7llP9kUHJRDHkXJ
 gXvoGHqJD9MUjy5TdT7eP81AhViuHf4=
X-Google-Smtp-Source: ABdhPJyfo9mXK/VfqiJoIomflmmr6G2nU6gAupLxN8PgGLrhHt1lcyfsb5oZRPCLyKx4Oj96z1W2aA==
X-Received: by 2002:a17:906:2cce:b0:6ce:e203:d207 with SMTP id
 r14-20020a1709062cce00b006cee203d207mr3566125ejr.242.1646906661253; 
 Thu, 10 Mar 2022 02:04:21 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:87b1:f8fa:c08e:8bd0?
 ([2a02:908:1252:fb60:87b1:f8fa:c08e:8bd0])
 by smtp.gmail.com with ESMTPSA id
 r29-20020a50c01d000000b00415fb0dc793sm1790494edb.47.2022.03.10.02.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 02:04:20 -0800 (PST)
Message-ID: <3f45531c-b68c-af30-f3b8-3bc13cddf5e1@gmail.com>
Date: Thu, 10 Mar 2022 11:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] drm/amdgpu: pass job to check soft reset
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220310061155.39292-1-Victor.Zhao@amd.com>
 <20220310061155.39292-3-Victor.Zhao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220310061155.39292-3-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: emily.deng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.03.22 um 07:11 schrieb Victor Zhao:
> In order to get more accurate engine hang detection, pass the hang
> job to check_soft_reset to find the hang engine instead of check
> register status.

NAK, the amdgpu_ring_soft_recovery() function already gets the hardware 
fence as parameter.

That should be sufficient to identify the hanging engine.

Regards,
Christian.

>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 18 +++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c         |  2 +-
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c          |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c          |  2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
>   drivers/gpu/drm/amd/include/amd_shared.h       |  2 +-
>   17 files changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 22b846c359b4..4d6fd69f1bb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1359,7 +1359,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   
>   /* Common functions */
>   bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
> -bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
> +bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev, struct amdgpu_job *job);
>   int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			      struct amdgpu_job* job);
>   void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 7a513e5f7156..4819aedbfe62 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -238,7 +238,7 @@ void amdgpu_amdkfd_gpu_reset(struct kgd_dev *kgd)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
>   
> -	if (amdgpu_device_should_recover_gpu(adev))
> +	if (amdgpu_device_should_recover_gpu(adev, NULL))
>   		amdgpu_device_gpu_recover(adev, NULL);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a78a39e3d6e7..c82dc3621781 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4162,7 +4162,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>    * if the asic is still hung or not.
>    * Returns true if any of the IPs are still in a hung state, false if not.
>    */
> -static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
> +static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev, struct amdgpu_job *job)
>   {
>   	int i;
>   	bool asic_hang = false;
> @@ -4178,7 +4178,7 @@ static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
>   			continue;
>   		if (adev->ip_blocks[i].version->funcs->check_soft_reset)
>   			adev->ip_blocks[i].status.hang =
> -				adev->ip_blocks[i].version->funcs->check_soft_reset(adev);
> +				adev->ip_blocks[i].version->funcs->check_soft_reset(adev, job);
>   		if (adev->ip_blocks[i].status.hang) {
>   			dev_info(adev->dev, "IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
>   			asic_hang = true;
> @@ -4466,11 +4466,15 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>    * Check amdgpu_gpu_recovery and SRIOV status to see if we should try to recover
>    * a hung GPU.
>    */
> -bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
> +bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev, struct amdgpu_job *job)
>   {
> -	if (!amdgpu_device_ip_check_soft_reset(adev)) {
> -		dev_info(adev->dev, "Timeout, but no hardware hang detected.\n");
> -		return false;
> +	if (!amdgpu_device_ip_check_soft_reset(adev, job)) {
> +		if (job) {
> +			dev_info(adev->dev, "No matching soft reset found, do whole gpu recovery\n");
> +		} else {
> +			dev_info(adev->dev, "Timeout, but no hardware hang detected.\n");
> +			return false;
> +		}
>   	}
>   
>   	if (amdgpu_gpu_recovery == 0)
> @@ -4616,7 +4620,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   			amdgpu_device_ip_pre_soft_reset(adev);
>   			r = amdgpu_device_ip_soft_reset(adev);
>   			amdgpu_device_ip_post_soft_reset(adev);
> -			if (r || amdgpu_device_ip_check_soft_reset(adev)) {
> +			if (r || amdgpu_device_ip_check_soft_reset(adev, NULL)) {
>   				dev_info(adev->dev, "soft reset failed, will fallback to full reset!\n");
>   				need_full_reset = true;
>   			}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e0730ea56a8c..dc9a2390cf39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -62,7 +62,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
>   		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
>   
> -	if (amdgpu_device_should_recover_gpu(ring->adev)) {
> +	if (amdgpu_device_should_recover_gpu(ring->adev, job)) {
>   		amdgpu_device_gpu_recover(ring->adev, job);
>   	} else {
>   		drm_sched_suspend_timeout(&ring->sched);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index b642dde8833b..f2aa65016d1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1871,7 +1871,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   		amdgpu_put_xgmi_hive(hive);
>   	}
>   
> -	if (amdgpu_device_should_recover_gpu(ras->adev))
> +	if (amdgpu_device_should_recover_gpu(ras->adev, NULL))
>   		amdgpu_device_gpu_recover(ras->adev, NULL);
>   	atomic_set(&ras->in_recovery, 0);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index 22f9fedadbb8..cc042db4c823 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -3033,7 +3033,7 @@ static int dce_v10_0_wait_for_idle(void *handle)
>   	return 0;
>   }
>   
> -static bool dce_v10_0_check_soft_reset(void *handle)
> +static bool dce_v10_0_check_soft_reset(void *handle, struct amdgpu_job *job)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 1a476de20d08..a55d4a7914bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -4974,7 +4974,7 @@ static int gfx_v8_0_resume(void *handle)
>   	return gfx_v8_0_hw_init(handle);
>   }
>   
> -static bool gfx_v8_0_check_soft_reset(void *handle)
> +static bool gfx_v8_0_check_soft_reset(void *handle, struct amdgpu_job *job)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 9a3fc0926903..a3cbdb5703b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1311,7 +1311,7 @@ static int gmc_v8_0_wait_for_idle(void *handle)
>   
>   }
>   
> -static bool gmc_v8_0_check_soft_reset(void *handle)
> +static bool gmc_v8_0_check_soft_reset(void *handle, struct amdgpu_job *job)
>   {
>   	u32 srbm_soft_reset = 0;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index f8a9b5e4f5e4..a3d5529b3642 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -274,7 +274,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   	up_write(&adev->reset_sem);
>   
>   	/* Trigger recovery for world switch failure if no TDR */
> -	if (amdgpu_device_should_recover_gpu(adev)
> +	if (amdgpu_device_should_recover_gpu(adev, NULL)
>   		&& (!amdgpu_device_has_job_running(adev) ||
>   		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
>   		amdgpu_device_gpu_recover(adev, NULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 1b0a1550a352..708f9aa3ab23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -303,7 +303,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   	up_write(&adev->reset_sem);
>   
>   	/* Trigger recovery for world switch failure if no TDR */
> -	if (amdgpu_device_should_recover_gpu(adev)
> +	if (amdgpu_device_should_recover_gpu(adev, NULL)
>   		&& (!amdgpu_device_has_job_running(adev) ||
>   		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
>   		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index aef9d059ae52..1321c70bbccc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -520,7 +520,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>   	}
>   
>   	/* Trigger recovery due to world switch failure */
> -	if (amdgpu_device_should_recover_gpu(adev))
> +	if (amdgpu_device_should_recover_gpu(adev, NULL))
>   		amdgpu_device_gpu_recover(adev, NULL);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index 135727b59c41..223f7411ea71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1250,7 +1250,7 @@ static int sdma_v3_0_wait_for_idle(void *handle)
>   	return -ETIMEDOUT;
>   }
>   
> -static bool sdma_v3_0_check_soft_reset(void *handle)
> +static bool sdma_v3_0_check_soft_reset(void *handle, struct amdgpu_job *job)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	u32 srbm_soft_reset = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index b08905d1c00f..b222a003a9b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -380,7 +380,7 @@ static int tonga_ih_wait_for_idle(void *handle)
>   	return -ETIMEDOUT;
>   }
>   
> -static bool tonga_ih_check_soft_reset(void *handle)
> +static bool tonga_ih_check_soft_reset(void *handle, struct amdgpu_job *job)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	u32 srbm_soft_reset = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 2d558c2f417d..b2f5f15ea575 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -1159,7 +1159,7 @@ static int uvd_v6_0_wait_for_idle(void *handle)
>   }
>   
>   #define AMDGPU_UVD_STATUS_BUSY_MASK    0xfd
> -static bool uvd_v6_0_check_soft_reset(void *handle)
> +static bool uvd_v6_0_check_soft_reset(void *handle, struct amdgpu_job *job)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	u32 srbm_soft_reset = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 142e291983b4..2e69ba269e5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -629,7 +629,7 @@ static int vce_v3_0_wait_for_idle(void *handle)
>   #define  AMDGPU_VCE_STATUS_BUSY_MASK (VCE_STATUS_VCPU_REPORT_AUTO_BUSY_MASK | \
>   				      VCE_STATUS_VCPU_REPORT_RB0_BUSY_MASK)
>   
> -static bool vce_v3_0_check_soft_reset(void *handle)
> +static bool vce_v3_0_check_soft_reset(void *handle, struct amdgpu_job *job)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	u32 srbm_soft_reset = 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4a5523c3e75b..732d0d660c0f 100755
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -317,7 +317,7 @@ static int dm_wait_for_idle(void *handle)
>   	return 0;
>   }
>   
> -static bool dm_check_soft_reset(void *handle)
> +static bool dm_check_soft_reset(void *handle, struct amdgpu_job *job)
>   {
>   	return false;
>   }
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index f1a46d16f7ea..c202ebc2b231 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -287,7 +287,7 @@ struct amd_ip_funcs {
>   	int (*resume)(void *handle);
>   	bool (*is_idle)(void *handle);
>   	int (*wait_for_idle)(void *handle);
> -	bool (*check_soft_reset)(void *handle);
> +	bool (*check_soft_reset)(void *handle, struct amdgpu_job *job);
>   	int (*pre_soft_reset)(void *handle);
>   	int (*soft_reset)(void *handle);
>   	int (*post_soft_reset)(void *handle);

