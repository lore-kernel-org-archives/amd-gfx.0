Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13310C6FD1D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Mar 2023 15:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9728F10E2F8;
	Mon, 20 Mar 2023 15:49:23 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 926AB10E2F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 15:49:21 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id w11so6784185wmo.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Mar 2023 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679327360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oBdkRC0zzCOKHZM1daphlCh8WbKx5GrvjxylnGsRZ9E=;
 b=MtaEbD5gChgPvCCGwP2EgRHx2Yq/oVZfRlUjcsidm26ybVPKBtCCdt9bWb78SKKT7a
 fV2nxsL/+wL/mwyy0xt+Aq74b80x5Bt582WtdY6oI2o43BMsvwUV095NTkt6sxYRjYmK
 y5hpQyubm+r2JL0fj2C6DcMSSdsTSUj44r+UOkKnpIYIftjUzh8rf473b+ap/pPmSzN5
 Vpl/5tF1Xp+0IQC7qMvCEquYKNbf7YQyOmoLeMbwqdy3/O6TJoOszZCVba+5JAhbaow0
 CugcTHalSB1SPOu4y4ST3enKIWRc8RPLa4dL+gttGfEzZdzMgJwo5NCpksg7sytmDsJI
 pjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679327360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oBdkRC0zzCOKHZM1daphlCh8WbKx5GrvjxylnGsRZ9E=;
 b=hEPUVEaE4MV32h2OzBMH2+VPRhUBl6En6fEhlArvXO7pOugFvtHkB0BrYYL2GPG8Er
 gza3SvWeIc6vhHrUpWUXeJ3WtnZt/yXSmCEIOW4hzE48l8W/xyG1JS9epZUc0Sj8deA6
 u6gJEwcWTbTFJoLZxJtVKymn+hkFIt92lT7RD5x1Gc1pSYGwkKStufiHAcWSJ0olxJNI
 ibkfv+tzMgAVZ7CHnQKhKUs8X06UrXk9H1ZTs+27EQYg9UABNEtlOic6riJP/yJHtBFd
 G2MbtLasFC9womiLCXGkGhbUJwfL212OYmgaD28559SelSIdfkFpBSMa+KXMNhWE0hbF
 MZig==
X-Gm-Message-State: AO0yUKU260G9FEtbswGZlHUJCqTLrtRINbr0hO4TAyxOEUYlwT8+TaMt
 7HNpo5JABoEXVdaD7Q9UykiOeQy7NpE=
X-Google-Smtp-Source: AK7set/6vuT/T5cK0Mj5YT28NBXE4xLlrSkgPt1DP3fi2TAfEPcwWODC/vWor8GvJ6TFvQyspd12Zw==
X-Received: by 2002:a05:600c:3649:b0:3ea:f6c4:5f3d with SMTP id
 y9-20020a05600c364900b003eaf6c45f3dmr50580wmq.2.1679327359856; 
 Mon, 20 Mar 2023 08:49:19 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fae3:596:f1a7:6853?
 ([2a02:908:1256:79a0:fae3:596:f1a7:6853])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a1cc90c000000b003e20cf0408esm10861114wmb.40.2023.03.20.08.49.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Mar 2023 08:49:19 -0700 (PDT)
Message-ID: <e1f5b9a0-556c-7c6e-507a-55833937020c@gmail.com>
Date: Mon, 20 Mar 2023 16:49:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/10] drm/amdgpu: add gfx11 emit shadow callback
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230317171748.682691-1-alexander.deucher@amd.com>
 <20230317171748.682691-5-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230317171748.682691-5-alexander.deucher@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.03.23 um 18:17 schrieb Alex Deucher:
> From: Christian König <christian.koenig@amd.com>
>
> Add ring callback for gfx to update the CP firmware
> with the new shadow information before we process the
> IB.
>
> v2: add implementation for new packet (Alex)
> v3: add current FW version checks (Alex)
> v4: only initialize shadow on first use
>      Only set IB_VMID when a valid shadow buffer is present
>      (Alex)
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 46 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/nvd.h        |  5 ++-
>   3 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index de9e7a00bb15..4ad9e225d6e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -364,6 +364,8 @@ struct amdgpu_gfx {
>   
>   	struct amdgpu_ring		sw_gfx_ring[AMDGPU_MAX_SW_GFX_RINGS];
>   	struct amdgpu_ring_mux          muxer;
> +
> +	bool				cp_gfx_shadow; /* for gfx11 */
>   };
>   
>   #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 3bf697a80cf2..166a3f640042 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -463,6 +463,27 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
>   	return err;
>   }
>   
> +static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
> +{
> +	switch (adev->ip_versions[GC_HWIP][0]) {
> +	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 2):
> +	case IP_VERSION(11, 0, 3):
> +		/* XXX fix me! */
> +		if ((adev->gfx.me_fw_version >= 1498) &&
> +		    (adev->gfx.me_feature_version >= 29) &&
> +		    (adev->gfx.pfp_fw_version >= 1541) &&
> +		    (adev->gfx.pfp_feature_version >= 29) &&
> +		    (adev->gfx.mec_fw_version >= 507) &&
> +		    (adev->gfx.mec_feature_version >= 29))
> +			adev->gfx.cp_gfx_shadow = true;
> +		break;
> +	default:
> +		adev->gfx.cp_gfx_shadow = false;
> +		break;
> +	}
> +}
> +
>   static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>   {
>   	char fw_name[40];
> @@ -539,6 +560,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
>   	/* only one MEC for gfx 11.0.0. */
>   	adev->gfx.mec2_fw = NULL;
>   
> +	gfx_v11_0_check_fw_cp_gfx_shadow(adev);
>   out:
>   	if (err) {
>   		amdgpu_ucode_release(&adev->gfx.pfp_fw);
> @@ -5563,6 +5585,28 @@ static void gfx_v11_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
>   	amdgpu_ring_write(ring, 0);
>   }
>   
> +static void gfx_v11_0_ring_emit_gfx_shadow(struct amdgpu_ring *ring,
> +					   struct amdgpu_job *job)

Better give the values to use here instead of the job structure.

Regards,
Christian.

> +{
> +	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (!adev->gfx.cp_gfx_shadow)
> +		return;
> +
> +	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_Q_PREEMPTION_MODE, 7));
> +	amdgpu_ring_write(ring, lower_32_bits(job->shadow_va));
> +	amdgpu_ring_write(ring, upper_32_bits(job->shadow_va));
> +	amdgpu_ring_write(ring, lower_32_bits(job->gds_va));
> +	amdgpu_ring_write(ring, upper_32_bits(job->gds_va));
> +	amdgpu_ring_write(ring, lower_32_bits(job->csa_va));
> +	amdgpu_ring_write(ring, upper_32_bits(job->csa_va));
> +	amdgpu_ring_write(ring, job->shadow_va ?
> +			  PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(vmid) : 0);
> +	amdgpu_ring_write(ring, job->init_shadow ?
> +			  PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM : 0);
> +}
> +
>   static unsigned gfx_v11_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring)
>   {
>   	unsigned ret;
> @@ -6183,6 +6227,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
>   	.set_wptr = gfx_v11_0_ring_set_wptr_gfx,
>   	.emit_frame_size = /* totally 242 maximum if 16 IBs */
>   		5 + /* COND_EXEC */
> +		9 + /* SET_Q_PREEMPTION_MODE */
>   		7 + /* PIPELINE_SYNC */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> @@ -6209,6 +6254,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
>   	.insert_nop = amdgpu_ring_insert_nop,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.emit_cntxcntl = gfx_v11_0_ring_emit_cntxcntl,
> +	.emit_gfx_shadow = gfx_v11_0_ring_emit_gfx_shadow,
>   	.init_cond_exec = gfx_v11_0_ring_emit_init_cond_exec,
>   	.patch_cond_exec = gfx_v11_0_ring_emit_patch_cond_exec,
>   	.preempt_ib = gfx_v11_0_ring_preempt_ib,
> diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
> index fd6b58243b03..631dafb92299 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nvd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
> @@ -462,6 +462,9 @@
>   #              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
>   #define	PACKET3_RUN_LIST				0xA5
>   #define	PACKET3_MAP_PROCESS_VM				0xA6
> -
> +/* GFX11 */
> +#define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
> +#              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) << 0)
> +#              define PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM    (1 << 0)
>   
>   #endif

