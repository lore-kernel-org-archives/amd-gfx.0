Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A877C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 15:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D841F10F598;
	Thu,  2 May 2024 15:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HPRvy2Ez";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDDDA10F598
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 15:15:59 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-347e635b1fcso6042970f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 08:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714662958; x=1715267758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iipTQ5YRZNpxZOXjO/mwggee96us26BGlyLRtfPg9XA=;
 b=HPRvy2EzUIk7nfZP8Il8JAWl4XOunaoqeZKNmE7pMKSCsUVJXkkPb/6MYy2E58cqkh
 aaSS1pj+BSwAARJlg4Fwc+Nn8XUyZL6Q18bIDuUnlmJmbJYL5QqOz/BoFTEUvAdK71zP
 mzgdpcZj9q4OHcRwyXyke406QNkOaxs8w2ot5x1qzTomyIXUWcRYr54d4mejxnCqWHTO
 kG+m8xsdflaRTY7fN1RBgClqy1tTsy4TQ7ysRxD0OxeFwhdcWiPfsiwToRw5xR0RYMzE
 VU9PKd3pxe3K3P6h6D5u573WZadQcVbcAwFF8zNCMw+RtrVyBSZaYMUMRqSY2CDuOGC9
 igsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714662958; x=1715267758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iipTQ5YRZNpxZOXjO/mwggee96us26BGlyLRtfPg9XA=;
 b=mhotDIpF32Oecdys5nDUrtN27COfMhzKWnQ6SmuxemjB/8XNuR/H5E60Ysa2bIjPDi
 GH42MBUoBGhs8gKYvsgL3/RXjxUJmCPaUSXD5VyssL7orIayIPm6WsJC3ps+2A1rSYVx
 hDBTh6g+j7jZPTnUblDsq7odSOTxWIoB7KVg4Y/wRhiM7PjjCZWis2vt830h+u5YMq2a
 LXK0nqDmBv2iU9Cz3IKVz29k09x0kKCq6aSw5B/QO3Bvz9ZM/mKDNeEvwnqEMLGwrQXU
 ggW4pYCXveqgPImOKSfKJ25tj0QqtubEcuIiX1Iblq7a2PR8HafW67kII1B2uiuCF9R2
 iduA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIgFB/oDWUp3fQKHDFntAJYupJujz0wpuTzJhL+5pv+r0sH/P2xFkx7q53AAJeTlAs6XN8qoeyWsoiwSfZoVSHLc9B6dPALxVbEQzatA==
X-Gm-Message-State: AOJu0YzCl1Ob8jIWN/i7n60d52lqZ46MwoosYpchKmBianO6K4YkNwIf
 ksQGGYAY6uTNCtvdRBZdVxvj1kguEPIuyS+fHzOxGuQv7Nz6zJd8
X-Google-Smtp-Source: AGHT+IEpunAAoTeT3oph6pZS0RRCYRHDGlYnhqvawfms5AAfUXGQQk0ybpo/loMD0ayCuVkpUssySg==
X-Received: by 2002:adf:fc4f:0:b0:347:6a0:b61d with SMTP id
 e15-20020adffc4f000000b0034706a0b61dmr105816wrs.12.1714662957885; 
 Thu, 02 May 2024 08:15:57 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d400d000000b0034ad657deccsm1501647wrp.71.2024.05.02.08.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 08:15:57 -0700 (PDT)
Message-ID: <4e36e434-21ad-45c9-a022-91a54cff560b@gmail.com>
Date: Thu, 2 May 2024 17:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/14] drm/amdgpu: create context space for usermode
 queue
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-7-shashank.sharma@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240426134810.1250-7-shashank.sharma@amd.com>
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

Am 26.04.24 um 15:48 schrieb Shashank Sharma:
> The FW expects us to allocate at least one page as context
> space to process gang, process, GDS and FW  related work.
> This patch creates a joint object for the same, and calculates
> GPU space offsets of these spaces.
>
> V1: Addressed review comments on RFC patch:
>      Alex: Make this function IP specific
>
> V2: Addressed review comments from Christian
>      - Allocate only one object for total FW space, and calculate
>        offsets for each of these objects.
>
> V3: Integration with doorbell manager
>
> V4: Review comments:
>      - Remove shadow from FW space list from cover letter (Alex)
>      - Alignment of macro (Luben)
>
> V5: Merged patches 5 and 6 into this single patch
>      Addressed review comments:
>      - Use lower_32_bits instead of mask (Christian)
>      - gfx_v11_0 instead of gfx_v11 in function names (Alex)
>      - Shadow and GDS objects are now coming from userspace (Christian,
>        Alex)
>
> V6:
>      - Add a comment to replace amdgpu_bo_create_kernel() with
>        amdgpu_bo_create() during fw_ctx object creation (Christian).
>      - Move proc_ctx_gpu_addr, gang_ctx_gpu_addr and fw_ctx_gpu_addr out
>        of generic queue structure and make it gen11 specific (Alex).
>
> V7:
>     - Using helper function to create/destroy userqueue objects.
>     - Removed FW object space allocation.
>
> V8:
>     - Updating FW object address from user values.
>
> V9:
>     - uppdated function name from gfx_v11_* to mes_v11_*
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 43 +++++++++++++++++++
>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>   2 files changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> index 9e7dee77d344..9f9fdcb9c294 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -27,6 +27,41 @@
>   #include "mes_v11_0.h"
>   #include "amdgpu_userqueue.h"
>   
> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> +
> +static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +					    struct amdgpu_usermode_queue *queue,
> +					    struct drm_amdgpu_userq_mqd *mqd_user)
> +{
> +	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
> +	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
> +	int r, size;
> +
> +	/*
> +	 * The FW expects at least one page space allocated for
> +	 * process ctx and gang ctx each. Create an object
> +	 * for the same.
> +	 */
> +	size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
> +	r = amdgpu_userqueue_create_object(uq_mgr, ctx, size);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
> +		return r;
> +	}
> +
> +	/* Shadow and GDS objects come directly from userspace */
> +	mqd->shadow_base_lo = mqd_user->shadow_va & 0xFFFFFFFC;
> +	mqd->shadow_base_hi = upper_32_bits(mqd_user->shadow_va);
> +
> +	mqd->gds_bkup_base_lo = mqd_user->gds_va & 0xFFFFFFFC;
> +	mqd->gds_bkup_base_hi = upper_32_bits(mqd_user->gds_va);
> +
> +	mqd->fw_work_area_base_lo = mqd_user->csa_va & 0xFFFFFFFC;
> +	mqd->fw_work_area_base_hi = upper_32_bits(mqd_user->csa_va);
> +	return 0;
> +}
> +
>   static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   				      struct drm_amdgpu_userq_in *args_in,
>   				      struct amdgpu_usermode_queue *queue)
> @@ -82,6 +117,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   		goto free_mqd;
>   	}
>   
> +	/* Create BO for FW operations */
> +	r = mes_v11_0_userq_create_ctx_space(uq_mgr, queue, mqd_user);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> +		goto free_mqd;
> +	}
> +
>   	return 0;
>   
>   free_mqd:
> @@ -100,6 +142,7 @@ static void
>   mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>   			    struct amdgpu_usermode_queue *queue)
>   {
> +	amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>   	kfree(queue->userq_prop);
>   	amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>   }
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> index bbd29f68b8d4..643f31474bd8 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
>   	struct amdgpu_userq_mgr *userq_mgr;
>   	struct amdgpu_vm	*vm;
>   	struct amdgpu_userq_obj mqd;
> +	struct amdgpu_userq_obj fw_obj;
>   };
>   
>   struct amdgpu_userq_funcs {

