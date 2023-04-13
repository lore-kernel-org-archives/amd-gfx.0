Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8AAC77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Apr 2023 11:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB8410E088;
	Thu, 13 Apr 2023 11:19:44 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC76A10E088
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 11:19:41 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id si1so6345238ejb.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Apr 2023 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681384778; x=1683976778;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6hUIiQ8kKRCKnpJBWImSrFEs8LuDZIT/g0nxDwkXqc0=;
 b=XVRDJIvQH4SWa6RNc2CCNlsa5dTklqCdm4K9zKeh+Bs7W0B4GkEdVmDVC7HkXW26OD
 80TMZBO3jcI7dkiedVy+N0oSZycpLRQw9hlpPec7FYii+pOau6XD6iyJut8LHxTvU7IV
 dikmSV6lOd8LFR9wLNtrrmEsIB8jUobyBNBDGRLtmi5U4Wy/INF3Xn4RI/cUhgDa4Ayj
 D+wkFNE6LvkyTusan1kzHp6qp4oVFIcHjXyOt1UV9ERZoffu+8uKbXVpU2Dx58//GbmE
 W9XGS9e+vqMbjnyqvaIl0PoJ081MzwUoTh5v3RDIaPzY9FpDmrblsJMe77EVuQhLglcd
 MYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681384778; x=1683976778;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6hUIiQ8kKRCKnpJBWImSrFEs8LuDZIT/g0nxDwkXqc0=;
 b=ZhvyqU/TStFqHh3GXRrmVZtwa/nyTUaOQlPQggK8OKhSL6sU9Uf1ZYJfdzRrgv9EE4
 ZENlVJJTIp0LiQ3EMRIpkAwBZBzDne0SsUSeMIE/Drn26BqsW8YJmyPjKwcn+D1PP43F
 ZSUGEXAr5P183XRQ8uF0EZUFspn5/6um9tPLmX+wqkFxh+tFTE5l2iNd4ets/1oz1Fc0
 rePNuLJJPhAsz3jBkygEKfJnCcZT6v0wk5f81/PN18TeQTvI/jHTAFWItt7LrEG5gzHb
 5qNMxHUEFhgRXjJFvhFjr/A3l6dFJhBrcguINlYWYz4RPYy1/JHJ/tM3yYbZsT/PeACE
 pRJw==
X-Gm-Message-State: AAQBX9fCXiQf8lWQRsKgIlhkbuSY+HaTKy/h39+iWz3VA6aDDtXCAA9R
 BplsS18yiVv//I4mqP1CZAc=
X-Google-Smtp-Source: AKy350bx7uLzZkTUNqn03rKkP1PilXsMHHRffNJ4JccAgI+dmCXiemhUYGj/oR0NgRZg95NyEl+5tA==
X-Received: by 2002:a17:906:1857:b0:94a:4e86:31bc with SMTP id
 w23-20020a170906185700b0094a4e8631bcmr6163055eje.13.1681384777840; 
 Thu, 13 Apr 2023 04:19:37 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 lv25-20020a170906bc9900b0094a77168584sm830300ejb.125.2023.04.13.04.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Apr 2023 04:19:37 -0700 (PDT)
Message-ID: <a6f856f2-60fa-7a54-4579-ab7d31ca70e4@gmail.com>
Date: Thu, 13 Apr 2023 13:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 12/12] drm/amdgpu: cleanup MES process level doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-13-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230412162537.1357-13-shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.23 um 18:25 schrieb Shashank Sharma:
> MES allocates process level doorbells, but there is no userspace
> client to consume it. It was only being used for the MES ring
> tests (in kernel), and was written by kernel doorbell write.
>
> The previous patch of this series has changed the MES ring test code to
> use kernel level MES doorbells. This patch now cleans up the process level
> doorbell allocation code which is not required.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 54 +------------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 10 -----
>   2 files changed, 1 insertion(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index cd3ee851f0a4..2180e8e2c82e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -36,35 +36,6 @@ int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
>   		       PAGE_SIZE);
>   }
>   
> -int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
> -				      unsigned int *doorbell_index)
> -{
> -	int r = ida_simple_get(&adev->mes.doorbell_ida, 2,
> -			       adev->mes.max_doorbell_slices,
> -			       GFP_KERNEL);
> -	if (r > 0)
> -		*doorbell_index = r;
> -
> -	return r;
> -}
> -
> -void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
> -				      unsigned int doorbell_index)
> -{
> -	if (doorbell_index)
> -		ida_simple_remove(&adev->mes.doorbell_ida, doorbell_index);
> -}
> -
> -unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
> -					struct amdgpu_device *adev,
> -					uint32_t doorbell_index,
> -					unsigned int doorbell_id)
> -{
> -	return ((doorbell_index *
> -		amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32) +
> -		doorbell_id * 2);
> -}
> -
>   static int amdgpu_mes_kernel_doorbell_get(struct amdgpu_device *adev,
>   					 struct amdgpu_mes_process *process,
>   					 int ip_type, uint64_t *doorbell_index)
> @@ -256,15 +227,6 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
>   		return -ENOMEM;
>   	}
>   
> -	process->doorbell_bitmap =
> -		kzalloc(DIV_ROUND_UP(AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
> -				     BITS_PER_BYTE), GFP_KERNEL);
> -	if (!process->doorbell_bitmap) {
> -		DRM_ERROR("failed to allocate doorbell bitmap\n");
> -		kfree(process);
> -		return -ENOMEM;
> -	}
> -
>   	/* allocate the process context bo and map it */
>   	r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_PROC_CTX_SIZE, PAGE_SIZE,
>   				    AMDGPU_GEM_DOMAIN_GTT,
> @@ -291,15 +253,6 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
>   		goto clean_up_ctx;
>   	}
>   
> -	/* allocate the starting doorbell index of the process */
> -	r = amdgpu_mes_alloc_process_doorbells(adev, &process->doorbell_index);
> -	if (r < 0) {
> -		DRM_ERROR("failed to allocate doorbell for process\n");
> -		goto clean_up_pasid;
> -	}
> -
> -	DRM_DEBUG("process doorbell index = %d\n", process->doorbell_index);
> -
>   	INIT_LIST_HEAD(&process->gang_list);
>   	process->vm = vm;
>   	process->pasid = pasid;
> @@ -309,15 +262,12 @@ int amdgpu_mes_create_process(struct amdgpu_device *adev, int pasid,
>   	amdgpu_mes_unlock(&adev->mes);
>   	return 0;
>   
> -clean_up_pasid:
> -	idr_remove(&adev->mes.pasid_idr, pasid);
> -	amdgpu_mes_unlock(&adev->mes);
>   clean_up_ctx:
> +	amdgpu_mes_unlock(&adev->mes);
>   	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
>   			      &process->proc_ctx_gpu_addr,
>   			      &process->proc_ctx_cpu_ptr);
>   clean_up_memory:
> -	kfree(process->doorbell_bitmap);
>   	kfree(process);
>   	return r;
>   }
> @@ -363,7 +313,6 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
>   		idr_remove(&adev->mes.gang_id_idr, gang->gang_id);
>   	}
>   
> -	amdgpu_mes_free_process_doorbells(adev, process->doorbell_index);
>   	idr_remove(&adev->mes.pasid_idr, pasid);
>   	amdgpu_mes_unlock(&adev->mes);
>   
> @@ -385,7 +334,6 @@ void amdgpu_mes_destroy_process(struct amdgpu_device *adev, int pasid)
>   	amdgpu_bo_free_kernel(&process->proc_ctx_bo,
>   			      &process->proc_ctx_gpu_addr,
>   			      &process->proc_ctx_cpu_ptr);
> -	kfree(process->doorbell_bitmap);
>   	kfree(process);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index b04225585757..f96010dbd12a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -77,7 +77,6 @@ struct amdgpu_mes {
>   	uint32_t			kiq_version;
>   
>   	uint32_t                        total_max_queue;
> -	uint32_t                        doorbell_id_offset;
>   	uint32_t                        max_doorbell_slices;
>   
>   	uint64_t                        default_process_quantum;
> @@ -148,7 +147,6 @@ struct amdgpu_mes_process {
>   	uint64_t 		process_quantum;
>   	struct 			list_head gang_list;
>   	uint32_t 		doorbell_index;
> -	unsigned long 		*doorbell_bitmap;
>   	struct mutex		doorbell_lock;
>   };
>   
> @@ -367,14 +365,6 @@ int amdgpu_mes_ctx_unmap_meta_data(struct amdgpu_device *adev,
>   
>   int amdgpu_mes_self_test(struct amdgpu_device *adev);
>   
> -int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
> -					unsigned int *doorbell_index);
> -void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
> -					unsigned int doorbell_index);
> -unsigned int amdgpu_mes_get_doorbell_dw_offset_in_bar(
> -					struct amdgpu_device *adev,
> -					uint32_t doorbell_index,
> -					unsigned int doorbell_id);
>   int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev);
>   
>   /*

