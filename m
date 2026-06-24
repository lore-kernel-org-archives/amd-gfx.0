Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6B5CDB479
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 14:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5FD410E0BD;
	Wed, 24 Jun 2026 14:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="l43ulMEB";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9A2010E0B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 14:31:24 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso11258185e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1782311483; x=1782916283; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S3N5ziAax0EuTJ7RdIkG97OXnrHVRSVVAWCOteuigsM=;
 b=l43ulMEBFZB8yT4rhb4l1eb/Y8trhhmjNNn1PJSpmrbhav6jCIki/3d0rgOdbSxKCW
 k7NcyCp2lghBWf0lKpKGK6/3dFvAQfSXOnJvbV1VuflgrnYiYBqnqzaQJWWpCPySBK1H
 9BSqTqP0aZIpXq5qxwaWAybpVxEeoigOK5IzfxTXi6SXQzXV9utUt7DtZhARIdt8akYH
 lJbE1mE4U0HmuYNlURuMuuNaHTF3JtfFTSzgz4EAAKh1HFIIqmHOQDE3GTcXXjvrj+cS
 mj41VQ5/Atg4iCh79WKbHr235XVHb8/Ap6y10qjxl1FQ1pdqCyf94XWFiY3Ap+dg6Int
 ByDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782311483; x=1782916283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S3N5ziAax0EuTJ7RdIkG97OXnrHVRSVVAWCOteuigsM=;
 b=Azm2Ka6KfwwgS6ebDAd657wKG9j3DuETsuuq0ljNKGnfGoq78PgAEjUHfc34hffQ6v
 otpAVWnWU/h/HYDsDdBmXhQxw4YRO2fhcCGn5TIdllD4Je5r2vwIXYFAq0kIHRupjRHQ
 wRM8G2LNbCwMUR5Vbkd3hAHn+4MHe1M/ubXGXXjpWqhX3gPnhJIgrA/yWh/9o1AxbrZl
 LvuAqRUhyiumQ9DtlO/BBUqvOlf4yTUMapMAbnRdLXgA6BBWHLhjx7ss5nSuH7VNV0lf
 hMGXqYvfRYru8Ff7Q4NIR66hV3e6gmPmBGDeJjlmtKs9UPm6Kq6NGJsL52zo5E3hlZHy
 /Xuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FGGZBRMef3nkJKeeYt9d6/6fdznN84BitTkHCwkgE2xhWziF1ZprHnPxtZSCVHk42XxkkS5Wx@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxgp5NtIHFEV5ZHZJ8nPdqJzO+iZ8aZstGLGkYD0jTpTNMQFfG3
 bwUkwzhMhQ/9yMydsslT9dNjY4iAFFOg1O4jHjNkFnecw4+k7BXUAJTXkc7Vnb2NsTA=
X-Gm-Gg: AfdE7cmlzdkpBNjWHtqbnSf/gNg0gzpb2cK6YFsoOiG5p0QNuR1TvPwGpYeKPsknzWU
 lvF93p/3nqh4hlFwnbjEhutwRmGSMk0AjZclx5fTpob6r+0rS26qR0tTXFQmZNs4wfmCQg+b2DI
 4nlWbqEEhRlewL4N+PIMAsnnc6jCMWL4y+4Pr2PpPKzEamiX2y/PJWaOUBUtqDR4Js6UIlCxneL
 qqxuLeTi/mQFl8sEinibVoDOQrEgZkLWfLzJX6O+fJfIfsH+EYmSzNKh5CJRyWFYfDDVZkp3mDw
 8bAtIXjUFLz1/BRsXwMZfJWMTBBEcBYkqhig5TmJGc1cmrdo+2I5nNpPEgF9G7iN7VgzpdBrf9q
 YIMFT44dSnRYLkkz0vXC4jtdXHglhpedtTCyxaId0bwyx0Qi87YcmWnix6Tlz4ajl/3ad8D8JRP
 99ETFsRgo05OiwNQHwvOnGHGjzVkCg8913Gw==
X-Received: by 2002:a05:600c:a07:b0:492:59e4:f3fb with SMTP id
 5b1f17b1804b1-4926084a269mr52685855e9.3.1782311483141; 
 Wed, 24 Jun 2026 07:31:23 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494497ffsm393604635e9.11.2026.06.24.07.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 07:31:21 -0700 (PDT)
Message-ID: <55bb616f-343f-4189-8ef8-e9f20429cdbb@ursulin.net>
Date: Wed, 24 Jun 2026 15:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu: ACK the retry CAM after VM update finishes
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260529103059.21470-1-timur.kristof@gmail.com>
 <20260529103059.21470-3-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260529103059.21470-3-timur.kristof@gmail.com>
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


On 29/05/2026 11:30, Timur Kristóf wrote:
> Add a fence callback to the VM update and ACK the retry CAM
> after the VM update is finished. Previously, we would ACK it
> immediately after calling amdgpu_vm_handle_fault() which
> caused a race condition that was likely to trigger the same
> interrupt again, causing the same fault to be handled
> multiple times.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     | 28 +++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h     |  8 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
>   4 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 26aea960e2759..21c8d87477448 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -545,6 +545,16 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
>   	} while (fault->timestamp < tmp);
>   }
>   
> +static void amdgpu_gmc_retry_fault_handled(struct dma_fence *fence,
> +					   struct dma_fence_cb *cb)
> +{
> +	struct amdgpu_fence_cb *afc = container_of(cb, struct amdgpu_fence_cb, cb);
> +	struct amdgpu_device *adev = afc->adev;
> +
> +	/* CAM index is the array index of the current callback struct */
> +	adev->irq.ih_funcs->retry_cam_ack(adev, afc - &adev->gmc.retry_cb[0]);

Is the "afc - &adev->gmc.retry_cb[0]" part correct? It will be the index 
of the array element, while ->retry_cam_ack() expects the content of 
that element, no?

> +}
> +
>   int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
>   				  struct amdgpu_iv_entry *entry,
>   				  u64 addr,
> @@ -552,6 +562,7 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
>   				  u32 node_id,
>   				  bool write_fault)
>   {
> +	struct dma_fence *fence = NULL;
>   	int ret;
>   
>   	if (adev->irq.retry_cam_enabled) {
> @@ -564,8 +575,21 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
>   		}
>   
>   		ret = amdgpu_vm_handle_fault(adev, entry->pasid, entry->vmid, node_id,
> -					     addr, entry->timestamp, write_fault, NULL);
> -		adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
> +					     addr, entry->timestamp, write_fault, &fence);
> +
> +		/* If the update is already done, ACK now, otherwise when it's done. */
> +		if (fence) {
> +			adev->gmc.retry_cb[cam_index].adev = adev;

Why is 16 retry_cb elements enough? I see in the code cam_index extraced 
from the IV entry with a mask such as 0x3ff.
> +
> +			if (dma_fence_add_callback(fence, &adev->gmc.retry_cb[cam_index].cb,
> +						   amdgpu_gmc_retry_fault_handled))
> +				adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
> +
> +			dma_fence_put(fence);
> +		} else {
> +			adev->irq.ih_funcs->retry_cam_ack(adev, cam_index);
> +		}
> +
>   		if (ret)
>   			return 1;
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 77eb153802845..3bfb06e011a86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -27,6 +27,7 @@
>   #define __AMDGPU_GMC_H__
>   
>   #include <linux/types.h>
> +#include <linux/dma-fence.h>
>   
>   #include "amdgpu_irq.h"
>   #include "amdgpu_xgmi.h"
> @@ -214,6 +215,11 @@ struct amdgpu_gmc_memrange {
>   	int nid_mask;
>   };
>   
> +struct amdgpu_fence_cb {
> +	struct amdgpu_device *adev;
> +	struct dma_fence_cb cb;
> +};
> +
>   enum amdgpu_gart_placement {
>   	AMDGPU_GART_PLACEMENT_BEST_FIT = 0,
>   	AMDGPU_GART_PLACEMENT_HIGH,
> @@ -305,6 +311,8 @@ struct amdgpu_gmc {
>   	} fault_hash[AMDGPU_GMC_FAULT_HASH_SIZE];
>   	uint64_t		last_fault:AMDGPU_GMC_FAULT_RING_ORDER;
>   
> +	struct amdgpu_fence_cb retry_cb[16];
> +
>   	bool tmz_enabled;
>   	bool is_app_apu;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 8c3ba7213eb22..f5e9b97e92a8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3035,7 +3035,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   
>   	r = amdgpu_vm_update_pdes(adev, vm, true);
>   
> -	*fence = vm->last_update;
> +	*fence = dma_fence_get(vm->last_update);

Ah! But passing over since you said you are dropping that patch anyway.

>   error_unlock:
>   	amdgpu_bo_unreserve(root);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index 2eb64df6daa94..6e28f0e435bf5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -132,7 +132,7 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>   				   DMA_RESV_USAGE_BOOKKEEP);
>   	}
>   
> -	if (fence && !p->immediate) {
> +	if (fence) {

Is this deliberate and if so what it is about? Commit message should 
explain it as well.

Regards,

Tvrtko

>   		/*
>   		 * Most hw generations now have a separate queue for page table
>   		 * updates, but when the queue is shared with userspace we need

