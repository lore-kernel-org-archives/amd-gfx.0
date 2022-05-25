Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4391CC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 08:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6C410E554;
	Wed, 25 May 2022 08:45:46 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D52AD10E531
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 08:45:44 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id gi33so31740019ejc.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=J7DIrUYXCe4vuk1svLjBT3pk+Ohtrxy2o0xAJeegDmk=;
 b=R/NrQRy+rrTvKGaufjI66KvpVqT6UknWASbHw0BP0ABcxb7P4K5t4OYVY5d8WtqFSx
 Z6UELJ+5xJc9ulOILZeW/3h+Vec2sgi9eofAA20c68iLT0TjOHl6NfHpsq70E51yO+HC
 zRR9/zgR3OpYk6H51d3BWi8h8Clyv54UA6fwAnAGNV4ye7Mk9CLAjqb0odcBdoYutz52
 65tswJZusvvXPngh3w3Kg1V1/+a/00KO+WQlkfRLqx9uiH/MxVY8iSDvYF0I9ZIZDa0z
 Cedql2QY8K4KyehNQfT4+D1ML0YyJjzXKau0Qa1Cfas0AFoxEOqi0FWOZTOdWSNQymOJ
 ziGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=J7DIrUYXCe4vuk1svLjBT3pk+Ohtrxy2o0xAJeegDmk=;
 b=wNB4+lJl7HuWjziNhvXGQcDI8gYg95zN7Ddma+gF09wV23qNODhnKU3QjueqbUQWC7
 4Ha09AsSuzWMirkjndcBQ8ABVikLGv/UCju30IG8INIl0fSEfcqzwWR7uOBax7nUxZy+
 PM+4E5UpxTselQXUrCq/6lBjtlCPfyktetgErPtiibtjkag158vriWqwBsKU29WKwZW9
 AiKw/uyaFvIHOj1bR3hbepTU3xT4WvnaD1g9uzmuLTgxsbn7099YJpr5WJ+awNhj6Vws
 RFAf/o5e+arB1bQFhG61rnmS9Xa61ysCMFsff9Z5TngSvFc+O96B8AebZ2jxx8JljgqC
 vdcg==
X-Gm-Message-State: AOAM531KHKo3br2/LtJMwmUmjgjoIW4KX5IyQ+I0rA2NiEsTm9O/ltaa
 UTAYPWHU+rmz5vaAde+rmV0=
X-Google-Smtp-Source: ABdhPJxWdZ3HhCCkxK2yhId5gVDZxCn3adDFK7KQGms/AXmH6vERZxCVVelYF0Gx1Y9XUrI2YTUQeA==
X-Received: by 2002:a17:907:6d9f:b0:6fe:af28:5fbf with SMTP id
 sb31-20020a1709076d9f00b006feaf285fbfmr21951389ejc.737.1653468343341; 
 Wed, 25 May 2022 01:45:43 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bdaa.dip0.t-ipconnect.de.
 [87.176.189.170]) by smtp.gmail.com with ESMTPSA id
 28-20020a170906015c00b006f3ef214da8sm8041902ejh.14.2022.05.25.01.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 May 2022 01:45:41 -0700 (PDT)
Message-ID: <eebb0612-6703-9408-ebf6-2813e13139ef@gmail.com>
Date: Wed, 25 May 2022 10:45:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdkfd: don't add DOORBELL and MMIO BOs to validate
 list
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220525084324.1354886-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220525084324.1354886-1-Lang.Yu@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.05.22 um 10:43 schrieb Lang Yu:
> DOORBELL and MMIO BOs never move once created.
> No need to validate them after that.

Yeah, but you still need to make sure their page tables are up to date.

So this here might break horrible.

Christian.

>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 34ba9e776521..45de9cadd771 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -808,6 +808,10 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
>   	struct ttm_validate_buffer *entry = &mem->validate_list;
>   	struct amdgpu_bo *bo = mem->bo;
>   
> +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> +		return;
> +
>   	INIT_LIST_HEAD(&entry->head);
>   	entry->num_shared = 1;
>   	entry->bo = &bo->tbo;
> @@ -824,6 +828,10 @@ static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
>   {
>   	struct ttm_validate_buffer *bo_list_entry;
>   
> +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
> +		return;
> +
>   	bo_list_entry = &mem->validate_list;
>   	mutex_lock(&process_info->lock);
>   	list_del(&bo_list_entry->head);
> @@ -1649,7 +1657,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	unsigned long bo_size = mem->bo->tbo.base.size;
>   	struct kfd_mem_attachment *entry, *tmp;
>   	struct bo_vm_reservation_context ctx;
> -	struct ttm_validate_buffer *bo_list_entry;
>   	unsigned int mapped_to_gpu_memory;
>   	int ret;
>   	bool is_imported = false;
> @@ -1677,10 +1684,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	}
>   
>   	/* Make sure restore workers don't access the BO any more */
> -	bo_list_entry = &mem->validate_list;
> -	mutex_lock(&process_info->lock);
> -	list_del(&bo_list_entry->head);
> -	mutex_unlock(&process_info->lock);
> +	remove_kgd_mem_from_kfd_bo_list(mem, process_info);
>   
>   	/* No more MMU notifiers */
>   	amdgpu_mn_unregister(mem->bo);

