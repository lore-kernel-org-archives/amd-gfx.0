Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ED9EB64DA
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 11:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C57010E05A;
	Mon, 26 Jun 2023 11:47:13 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C045C10E05A
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 11:47:11 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-313f59cd193so430848f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687780029; x=1690372029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pYE+aEXR8xJg+lUzTBHx+lvz6DwwhwdbDsnR/+tqiIg=;
 b=qYYjOoDRdMMpNrUpgyVBtTIegXa8OqnTT15/zUFcV+ahUzVUk+ns8qP7bD3E3O7WYh
 cYrGx19gkV6jUOe5IKPJpznP8HNRszTcWoJwgtJoui7Zk2UlGW/LTTQT8tD2XbVq7Fg+
 j3DM7LrMM7IXbvZqY4FBKNmjca6uw546Rh2Lm76HjsUJpR4B578vW/VX4H4Nd8RwVLug
 xgXzc5qjJXWDu9Rfk7KqZcreZyIwHG5+F3JdmzVfbt7abXYs3mdkzyhIGiJueR1QD82B
 3mgd15NIuifkxixVvot1kkKyaRwtqQjZHWReHNuc8mU0TqafV+qNYec9w/+IxAUmR5Ys
 gtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687780029; x=1690372029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pYE+aEXR8xJg+lUzTBHx+lvz6DwwhwdbDsnR/+tqiIg=;
 b=l2HY/4jhq0KbkDrlvn3iThXFD6WgxqhbnRslj9KmfWWVTkd2HbPTvB2qcMoCpyvTHG
 Lv9MJm+mkQ//U6TR+cL1ieevEeJKKCts+hXldr0fxvhgFpT2wAbI9/ZIdvkVBlSST/iZ
 Za2i3zcbkabaIqLWhM4MGhaTG4Ja7axnhQcuimCQPAieWTBWKbFNGOz5iR0b9Ha37cn6
 +9PX7Xq9pTvoewLSjVrlZ1dSSxIVBwVewr6MkiO6jfAkYM6wFuZfuqNTl3ARjXt7hNQo
 KGRQ6raa8nFuZR1BytODJvv33s6hcUDjmZbMCYBc972k56I4mqriwGXY5TMpn96SGtNK
 GJYA==
X-Gm-Message-State: AC+VfDz4OO30mGizTSYfxc6HzN0d6O6RDtKoaCpHxc0Fx+7OnwQEGBJc
 SkeJ8c3cYvJdM3+eARhnmaZVggBmvhQ=
X-Google-Smtp-Source: ACHHUZ4hOzgwLXLJXr/XOmCPJedS29TdJrLLEIhewPMRmb2Ilt5fkFtDXwJJw05kvZxYAflBk6wqXg==
X-Received: by 2002:a05:6000:105:b0:313:f577:6445 with SMTP id
 o5-20020a056000010500b00313f5776445mr884125wrx.55.1687780029430; 
 Mon, 26 Jun 2023 04:47:09 -0700 (PDT)
Received: from ?IPV6:2a00:e180:158d:7600:d62f:c4fb:6eee:7b87?
 ([2a00:e180:158d:7600:d62f:c4fb:6eee:7b87])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a5d6542000000b00313eee8c080sm3636491wrv.98.2023.06.26.04.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 04:47:08 -0700 (PDT)
Message-ID: <b3424b75-6298-3f97-9de8-d37addb42737@gmail.com>
Date: Mon, 26 Jun 2023 13:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] drm/amdgpu: add new INFO ioctl query for the last GPU
 page fault
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230525165219.544671-1-alexander.deucher@amd.com>
 <20230525165219.544671-4-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230525165219.544671-4-alexander.deucher@amd.com>
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
Cc: samuel.pitoiset@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.05.23 um 18:52 schrieb Alex Deucher:
> Add a interface to query the last GPU page fault for the process.
> Useful for debugging context lost errors.
>
> v2: split vmhub representation between kernel and userspace
>
> Mesa MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
> libdrm MR: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
>
> Cc: samuel.pitoiset@gmail.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 ++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 16 +++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 13 ++++++++++---
>   include/uapi/drm/amdgpu_drm.h           | 16 ++++++++++++++++
>   5 files changed, 59 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7300df2a342c..7e17b285decc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -112,9 +112,10 @@
>    *            gl1c_cache_size, gl2c_cache_size, mall_size, enabled_rb_pipes_mask_hi
>    *   3.53.0 - Support for GFX11 CP GFX shadowing
>    *   3.54.0 - Add AMDGPU_CTX_QUERY2_FLAGS_RESET_IN_PROGRESS support
> + * - 3.55.0 - Add AMDGPU_INFO_GPUVM_FAULT query
>    */
>   #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	54
> +#define KMS_DRIVER_MINOR	55
>   #define KMS_DRIVER_PATCHLEVEL	0
>   
>   unsigned int amdgpu_vram_limit = UINT_MAX;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 41d047e5de69..bca2a56046ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1163,6 +1163,22 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		return copy_to_user(out, max_ibs,
>   				    min((size_t)size, sizeof(max_ibs))) ? -EFAULT : 0;
>   	}
> +	case AMDGPU_INFO_GPUVM_FAULT: {
> +		struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +		struct amdgpu_vm *vm = &fpriv->vm;
> +		struct drm_amdgpu_info_gpuvm_fault gpuvm_fault;
> +
> +		if (!vm)
> +			return -EINVAL;
> +
> +		memset(&gpuvm_fault, 0, sizeof(gpuvm_fault));
> +		gpuvm_fault.addr = vm->fault_info.addr;
> +		gpuvm_fault.status = vm->fault_info.status;
> +		gpuvm_fault.vmhub = vm->fault_info.vmhub;

You need something to provide locking and barrier here. I suggest to 
just grab the xa lock.

> +
> +		return copy_to_user(out, &gpuvm_fault,
> +				    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
> +	}
>   	default:
>   		DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 73e022f3daa4..c1b0c5f3c1f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2657,7 +2657,21 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>   	if (vm) {
>   		vm->fault_info.addr = addr;
>   		vm->fault_info.status = status;
> -		vm->fault_info.vmhub = vmhub;
> +		if (AMDGPU_IS_GFXHUB(vmhub)) {
> +			vm->fault_info.vmhub = AMDGPU_VMHUB_TYPE_GFX;
> +			vm->fault_info.vmhub |=
> +				(vmhub - AMDGPU_GFXHUB_START) << AMDGPU_VMHUB_IDX_SHIFT;
> +		} else if (AMDGPU_IS_MMHUB0(vmhub)) {
> +			vm->fault_info.vmhub = AMDGPU_VMHUB_TYPE_MM0;
> +			vm->fault_info.vmhub |=
> +				(vmhub - AMDGPU_MMHUB0_START) << AMDGPU_VMHUB_IDX_SHIFT;
> +		} else if (AMDGPU_IS_MMHUB1(vmhub)) {
> +			vm->fault_info.vmhub = AMDGPU_VMHUB_TYPE_MM1;
> +			vm->fault_info.vmhub |=
> +				(vmhub - AMDGPU_MMHUB1_START) << AMDGPU_VMHUB_IDX_SHIFT;
> +		} else {
> +			WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
> +		}
>   	}
>   	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index fb66a413110c..1a34fea9acb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -116,9 +116,16 @@ struct amdgpu_mem_stats;
>    * layout: max 8 GFXHUB + 4 MMHUB0 + 1 MMHUB1
>    */
>   #define AMDGPU_MAX_VMHUBS			13
> -#define AMDGPU_GFXHUB(x)			(x)
> -#define AMDGPU_MMHUB0(x)			(8 + x)
> -#define AMDGPU_MMHUB1(x)			(8 + 4 + x)
> +#define AMDGPU_GFXHUB_START			0
> +#define AMDGPU_MMHUB0_START			8
> +#define AMDGPU_MMHUB1_START			12
> +#define AMDGPU_GFXHUB(x)			(AMDGPU_GFXHUB_START + (x))
> +#define AMDGPU_MMHUB0(x)			(AMDGPU_MMHUB0_START + (x))
> +#define AMDGPU_MMHUB1(x)			(AMDGPU_MMHUB1_START + (x))
> +
> +#define AMDGPU_IS_GFXHUB(x) ((x) >= AMDGPU_GFXHUB_START && (x) < AMDGPU_MMHUB0_START)
> +#define AMDGPU_IS_MMHUB0(x) ((x) >= AMDGPU_MMHUB0_START && (x) < AMDGPU_MMHUB1_START)
> +#define AMDGPU_IS_MMHUB1(x) ((x) >= AMDGPU_MMHUB1_START && (x) < AMDGPU_MAX_VMHUBS)
>   
>   /* Reserve 2MB at top/bottom of address space for kernel use */
>   #define AMDGPU_VA_RESERVED_SIZE			(2ULL << 20)
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 79b14828d542..bbe3ae6dc546 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -890,6 +890,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>   	#define AMDGPU_INFO_VIDEO_CAPS_ENCODE		1
>   /* Query the max number of IBs per gang per submission */
>   #define AMDGPU_INFO_MAX_IBS			0x22
> +/* query last page fault info */
> +#define AMDGPU_INFO_GPUVM_FAULT			0x23
>   
>   #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
>   #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
> @@ -1215,6 +1217,20 @@ struct drm_amdgpu_info_video_caps {
>   	struct drm_amdgpu_info_video_codec_info codec_info[AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_COUNT];
>   };
>   
> +#define AMDGPU_VMHUB_TYPE_MASK			0xff
> +#define AMDGPU_VMHUB_TYPE_SHIFT			0
> +#define AMDGPU_VMHUB_TYPE_GFX			0
> +#define AMDGPU_VMHUB_TYPE_MM0			1
> +#define AMDGPU_VMHUB_TYPE_MM1			2
> +#define AMDGPU_VMHUB_IDX_MASK			0xff00
> +#define AMDGPU_VMHUB_IDX_SHIFT			8

IIRC UMR already established the standard to put the hub type in the 
higher bits and the hub number/VMID in the lower ones.

Probably best to sync up with Tom so that both interfaces use the same 
numbering.

Apart from that looks good to me.

Christian.

> +
> +struct drm_amdgpu_info_gpuvm_fault {
> +	__u64 addr;
> +	__u32 status;
> +	__u32 vmhub;
> +};
> +
>   /*
>    * Supported GPU families
>    */

