Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA18EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 10:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1DB10E060;
	Wed, 28 Jun 2023 10:46:19 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E1E10E060
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 10:46:18 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51d9890f368so3900926a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 03:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687949176; x=1690541176;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MDb6C/HEHhhgZFQbO1Ebf8CcO+kmKQQRGewsAHUpGNI=;
 b=iWh+XzcqTo6RKsSPviVFIvs4z0GosTsRfSYj95rnXvI/mFnEGJRO2sS6n5zZ7Cuh96
 ywGV8pWSdeD4zVr7b4MBXJbUb1KaKYLnJJwaoBY6Nn74OpPcq3860RDxtjTkI2wqUtBJ
 CpmbnGcVfdXuIKj9bAdmc/Mt8R5esDQ1GTe/mPmuyKOOvhrCNpbGg1A4CRthQKrzWe3H
 rEz+Vw2vHlwrzsyMAkVpFnUsGFMn4o3+KW5QL05ERrW5DSGNc9uzSSDpCdbUo9bT8qXp
 roveLosxquYKtbcBD/dJH84Zzh0ulj7xSMbQz7qv4OwhSuqYd0/Ze/G1/XBYNwJUkWEz
 Prag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687949176; x=1690541176;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MDb6C/HEHhhgZFQbO1Ebf8CcO+kmKQQRGewsAHUpGNI=;
 b=RPnAr15EmTBoPF9wQPstZeyjgvT5QTpZn1jhAohy/vR00WCa2WFa9ETyOFY/i2F9z8
 DN7IiVD6gpwj5M0TgXxCdQ3pXxgG9zhEsrrzPm+ZZhWUtk1SNfQA2P7FdQPne6zMoIK4
 m8rHtDbn5vFPnTuBnaEa55eKNNzjT+ultwSE9uAMHq3I8ijTYKSgZCVVGAHhim//6HqK
 XB/S121boaN/OLbq5p0S5aXhm5EuPe3RUeVcSO4+u/X7/9tXopA5nfuot8tdE8AUje/D
 s+Ws+46WUeEddnxBVX2Z3wjnir4Iehx5xIdnk7G80H/0wDdAWUuWkl8jw+RvxrJCNlhA
 TYCw==
X-Gm-Message-State: AC+VfDx9iidCdissBE3FjlPZ6vHO5lJ1CzIQ+IdQeqe1zQkktrdKh7iG
 4+QIFAk5zJiysPfAZCNXQbw=
X-Google-Smtp-Source: ACHHUZ6rGMhpSjhBIJShzAfWrCU+fhMN2+7kapssqqypqvJxyYLF5PlXLSBdf+/jcOqEk4gmOEZ51w==
X-Received: by 2002:a17:907:84c:b0:987:783f:449a with SMTP id
 ww12-20020a170907084c00b00987783f449amr23705378ejb.11.1687949176347; 
 Wed, 28 Jun 2023 03:46:16 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.89])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a1709060f4d00b0097073f1ed84sm5606205ejj.4.2023.06.28.03.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 03:46:15 -0700 (PDT)
Message-ID: <37748a25-6e7f-4fc8-13d7-29d6c2401a6a@gmail.com>
Date: Wed, 28 Jun 2023 12:46:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: make mcbp a per device setting
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230616211011.31578-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230616211011.31578-1-alexander.deucher@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.06.23 um 23:10 schrieb Alex Deucher:
> So we can selectively enable it on certain devices.  No
> intended functional change.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  3 ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 +-
>   7 files changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f39db4a2c2cf..78c6265fe79b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2551,7 +2551,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   			adev->ip_blocks[i].status.hw = true;
>   
>   			/* right after GMC hw init, we create CSA */
> -			if (amdgpu_mcbp) {
> +			if (adev->gfx.mcbp) {
>   				r = amdgpu_allocate_static_csa(adev, &adev->virt.csa_obj,
>   							       AMDGPU_GEM_DOMAIN_VRAM |
>   							       AMDGPU_GEM_DOMAIN_GTT,
> @@ -3672,6 +3672,18 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>   	NULL
>   };
>   
> +static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_mcbp == 1)
> +		adev->gfx.mcbp = true;
> +
> +	if (amdgpu_sriov_vf(adev))
> +		adev->gfx.mcbp = true;
> +
> +	if (adev->gfx.mcbp)
> +		DRM_INFO("MCBP is enabled\n");
> +}
> +
>   /**
>    * amdgpu_device_init - initialize the driver
>    *
> @@ -3823,9 +3835,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
>   	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
>   
> -	if (amdgpu_mcbp)
> -		DRM_INFO("MCBP is enabled\n");
> -
>   	/*
>   	 * Reset domain needs to be present early, before XGMI hive discovered
>   	 * (if any) and intitialized to use reset sem and in_gpu reset flag
> @@ -3851,6 +3860,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if (r)
>   		return r;
>   
> +	amdgpu_device_set_mcbp(adev);
> +
>   	/* Get rid of things like offb */
>   	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index ce0f7a8ad4b8..a4ff515ce896 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -434,6 +434,7 @@ struct amdgpu_gfx {
>   	uint16_t 			xcc_mask;
>   	uint32_t			num_xcc_per_xcp;
>   	struct mutex			partition_mutex;
> +	bool				mcbp; /* mid command buffer preemption */
>   };
>   
>   struct amdgpu_gfx_ras_reg_entry {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index e3531aa3c8bd..cca5a495611f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -805,7 +805,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		dev_info->ids_flags = 0;
>   		if (adev->flags & AMD_IS_APU)
>   			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
> -		if (amdgpu_mcbp)
> +		if (adev->gfx.mcbp)
>   			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
>   		if (amdgpu_is_tmz(adev))
>   			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
> @@ -1247,7 +1247,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   		goto error_vm;
>   	}
>   
> -	if (amdgpu_mcbp) {
> +	if (adev->gfx.mcbp) {
>   		uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
>   
>   		r = amdgpu_map_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 78ec3420ef85..dacf281d2b21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -72,7 +72,7 @@ uint64_t amdgpu_sdma_get_csa_mc_addr(struct amdgpu_ring *ring,
>   	int r;
>   
>   	/* don't enable OS preemption on SDMA under SRIOV */
> -	if (amdgpu_sriov_vf(adev) || vmid == 0 || !amdgpu_mcbp)
> +	if (amdgpu_sriov_vf(adev) || vmid == 0 || !adev->gfx.mcbp)
>   		return 0;
>   
>   	if (ring->is_mes_queue) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 25b4d7f0bd35..41aa853a07d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -66,9 +66,6 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>   	adev->cg_flags = 0;
>   	adev->pg_flags = 0;
>   
> -	/* enable mcbp for sriov */
> -	amdgpu_mcbp = 1;
> -
>   	/* Reduce kcq number to 2 to reduce latency */
>   	if (amdgpu_num_kcq == -1)
>   		amdgpu_num_kcq = 2;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index be984f8c71c7..44af8022b89f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8307,7 +8307,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   
>   	control |= ib->length_dw | (vmid << 24);
>   
> -	if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +	if (ring->adev->gfx.mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
>   		control |= INDIRECT_BUFFER_PRE_ENB(1);
>   
>   		if (flags & AMDGPU_IB_PREEMPTED)
> @@ -8482,7 +8482,7 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
>   {
>   	uint32_t dw2 = 0;
>   
> -	if (amdgpu_mcbp)
> +	if (ring->adev->gfx.mcbp)
>   		gfx_v10_0_ring_emit_ce_meta(ring,
>   				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 690e121d9dda..3a7af59e83ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5311,7 +5311,7 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   
>   	control |= ib->length_dw | (vmid << 24);
>   
> -	if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +	if (ring->adev->gfx.mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
>   		control |= INDIRECT_BUFFER_PRE_ENB(1);
>   
>   		if (flags & AMDGPU_IB_PREEMPTED)

