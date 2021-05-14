Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A00C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A048961446
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A048961446
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6F96EE18;
	Fri, 14 May 2021 07:24:44 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B055F6EE18
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:24:42 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id k10so12090766ejj.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 00:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=QRPxqsHF4BhWheynegxhR7f26uA525kDEAKCnlexQDQ=;
 b=lRlY7Nde9JgH4pos5lt1bYhxJvUVq/oyXuex2raBSLvk3WuXAFfMD1t6+a58gRoP2e
 0kY0ebN5MJvgbC9wzeoft729P4DbiIrDy6UcOkqcXnjzDFFuGWTxzSAkB6J23lEKp2gG
 ZLD59jII076j+lj5WhI/3L7XarxMWdPHZVMDirwqXnO4zcFP7We/2UP8md16GlQwLqJq
 dUusRADRGrhual0ghnQdrBEpIfXbvRnOpS/0ol1X3Y3izVb7oR18H7bp15WO+1o3zilT
 uyYC7MKe+IMCmeKt9Q8X9AK4PxK3AmA6DA4+wwr5fsysfWALjGv2AqGWHdA4szcyato0
 jVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QRPxqsHF4BhWheynegxhR7f26uA525kDEAKCnlexQDQ=;
 b=jzr2mJdeQ3Zc+mDQBWRowouVgZwdN3Tb1GG9FpZaGzs+drZ3P3X4cfDI3MzA7nHLfc
 t6EmgZoTGIIKR5s9UgfvvcL+gerJ0a7IU/OYmJeLUc8S0xo7R3LpM2RFxttZaAMOtWxa
 oNXMidn16DA5AwUcPECeulMt+8lk3S4+Wh0OljATnAyjzwsuMHlShHFKxctNz1b7IxLE
 aSZ+iOblsPisGIwiwnp7O3fVoriIaBucZtfVZRWkoJ0+fiiKderS3iIdpJoayKUkE3OM
 RmUb14ZomWi2LiA5Jj/xpHTUMp20H73pV2Uj8I5DTWxee2eoRSATWwGHXbNCXr767HHO
 9yJw==
X-Gm-Message-State: AOAM530YGjWkOhs9oRk3f+UOoqWMB+1vTgWJPADOLMMzOrqe+PfNIJOX
 TBHNGhDc9kydUhw2WPgeYJgSCW5oN2o=
X-Google-Smtp-Source: ABdhPJzCf3MkzlyI0jIWIPARiAH4sR9W8+HxmnDzjV9gQBp6FE2qQWSHZbZ8ZIEr/Ic+ZLhPnd968w==
X-Received: by 2002:a17:907:76d9:: with SMTP id
 kf25mr2221667ejc.340.1620977081317; 
 Fri, 14 May 2021 00:24:41 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:cf70:a0fd:8c48:efd4?
 ([2a02:908:1252:fb60:cf70:a0fd:8c48:efd4])
 by smtp.gmail.com with ESMTPSA id rn2sm721686ejb.45.2021.05.14.00.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 May 2021 00:24:40 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdkfd: heavy-weight flush TLB after unmap
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210513165855.16395-1-Philip.Yang@amd.com>
 <20210513165855.16395-2-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3e6be93f-62c0-ce9f-8137-520424438056@gmail.com>
Date: Fri, 14 May 2021 09:24:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513165855.16395-2-Philip.Yang@amd.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.05.21 um 18:58 schrieb Philip Yang:
> Need do a heavy-weight TLB flush to make sure we have no more dirty data
> in the cache for the unmapped pages.
>
> Add flush_type parameter to amdgpu_amdkfd_flush_gpu_tlb_pasid.

Using a define for the flush type instead of magic numbers would be 
really nice to have here.

Apart from that I'm fine with the patch.

Christian.

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c       | 4 ++--
>   4 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 5f6696a3c778..0be9a6695b2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -670,10 +670,10 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
>   	return 0;
>   }
>   
> -int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid)
> +int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
> +				      uint32_t flush_type)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -	const uint32_t flush_type = 0;
>   	bool all_hub = false;
>   
>   	if (adev->family == AMDGPU_FAMILY_AI)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 313ee49b9f17..e8ce851c6f29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -135,7 +135,8 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>   void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle);
>   bool amdgpu_amdkfd_have_atomics_support(struct kgd_dev *kgd);
>   int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid);
> -int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid);
> +int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid,
> +				      uint32_t flush_type);
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 9d4f527bda7c..1d8a593edd3f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1853,7 +1853,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
>   							pdd->qpd.vmid);
>   	} else {
>   		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
> -						pdd->process->pasid);
> +						pdd->process->pasid, 0);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 50da0d1fb9c1..e57a8e405efd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1125,7 +1125,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   				break;
>   		}
>   		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
> -						  p->pasid);
> +						  p->pasid, 2);
>   	}
>   
>   	return r;
> @@ -1182,7 +1182,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   		p = container_of(prange->svms, struct kfd_process, svms);
>   		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
> -						  p->pasid);
> +						  p->pasid, 0);
>   	}
>   out:
>   	prange->mapping.bo_va = NULL;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
