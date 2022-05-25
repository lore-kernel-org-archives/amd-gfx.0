Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7655FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 10:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DFA510FB87;
	Wed, 25 May 2022 10:37:14 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0037110FB79
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 10:37:12 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id gh17so27762320ejc.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=DnkMgSxUyCDyvGcQQ9rFPWTMQ48F3Vvelx4B1SQ/GOw=;
 b=Hix+otmA8QYUttXA3Dejqob9pGSapLvHmnzdj81zyxPhe7roDgCho7Unt6mK/QB6XT
 13uGIUQvB8Ungop3tX+sv1feFxPpJ1gkrQMBgE2cCoAvMCoJe2QNjPOELUoI+Ion5Yrl
 HbEit2uj5hqzWS/JQcbjhm/7QgK8supc5AAqvTj9ewQh6/t0t7LIwCPiJ/vt2Neiz7vq
 aAd/B5xLqTaFMLhCHlyy1knZtEGSEfSRyxAEPFqnOgdMWfjK02eLVN4FBc2HBEL2EGb9
 ixZOLNApdPAhXzY357WtStXbd0nW7kYL2sVNMO0TMui7gRK6MgRo6nlvJSkWbLCzYJI9
 qVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=DnkMgSxUyCDyvGcQQ9rFPWTMQ48F3Vvelx4B1SQ/GOw=;
 b=EpCTG6x7t0l6IhmzDm9fPFlN1YNmrl7MS0aScgR1d9Nxa2g3FhZs2uvUTM9yQa9RKC
 +QXLvm0GNGHSrtR8GXHeQu7WoflkJX0lr1mr3xS1sN0GS9pUP5H/NWAUIgqWP5ihqgdN
 704DEwiMJWqmgC+irGGNCTCY0yI04Qux7jUwLLWuTIzARdKlyaSwaGMrXxsob1ohc2ny
 bsk4wMDCKoCh0oui9tgvnoyI6FSEM3XODAzFmUbSjwpjfH77j1x9h6+SBqjfLJWqicZm
 xdOJIFijRsUFzs+wiOOFBdwFuMdDKe1O9U8IT9Vq0B6luSEspH0GK3ciE6huZp1TzQ6X
 fQjQ==
X-Gm-Message-State: AOAM532BuDg9gDwspDBSnQL1GxfrIfOfoPgUEsgxHaAg33cmmVUk4Hxo
 71k1xzlmUzHeekKOavpVO6WL9fR1XS8=
X-Google-Smtp-Source: ABdhPJz40vZvIwG3AIkvUnkmcqol0PYdONREz2/fLVRPkjU2E0Wq4n3AU6INhaIcUAsP7nwAiM8+PQ==
X-Received: by 2002:a17:906:4fc4:b0:6da:b4c6:fadb with SMTP id
 i4-20020a1709064fc400b006dab4c6fadbmr29517412ejw.282.1653475031512; 
 Wed, 25 May 2022 03:37:11 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bdaa.dip0.t-ipconnect.de.
 [87.176.189.170]) by smtp.gmail.com with ESMTPSA id
 n20-20020a509354000000b0042aa23fa93bsm10773958eda.20.2022.05.25.03.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 May 2022 03:37:11 -0700 (PDT)
Message-ID: <77ece2f1-97e6-f44d-0a30-971b28693c3c@gmail.com>
Date: Wed, 25 May 2022 12:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdkfd: don't add DOORBELL and MMIO BOs to validate
 list
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220525084324.1354886-1-Lang.Yu@amd.com>
 <eebb0612-6703-9408-ebf6-2813e13139ef@gmail.com>
 <Yo31/hZQ7qzs2KyO@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <Yo31/hZQ7qzs2KyO@lang-desktop>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.05.22 um 11:25 schrieb Lang Yu:
> On 05/25/ , Christian König wrote:
>> Am 25.05.22 um 10:43 schrieb Lang Yu:
>>> DOORBELL and MMIO BOs never move once created.
>>> No need to validate them after that.
>> Yeah, but you still need to make sure their page tables are up to date.
>>
>> So this here might break horrible.
> These BOs(and attachments) are validated when allocated and mapped.
> Their page tables should be determined at this time.
>
> The kfd_bo_list is used to restore BOs after evictions.
>
> Do you mean their page tabes could be changed? Thanks.

Yes, page tables can be destroyed under memory pressure as well.

Not sure how the KFD handles that, but in theory we should have every BO 
used by a process on the validation list. Even the ones pinned.

Regards,
Christian.

>
>
>> Christian.
>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++++-----
>>>    1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 34ba9e776521..45de9cadd771 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -808,6 +808,10 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
>>>    	struct ttm_validate_buffer *entry = &mem->validate_list;
>>>    	struct amdgpu_bo *bo = mem->bo;
>>> +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>>> +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
>>> +		return;
>>> +
>>>    	INIT_LIST_HEAD(&entry->head);
>>>    	entry->num_shared = 1;
>>>    	entry->bo = &bo->tbo;
>>> @@ -824,6 +828,10 @@ static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
>>>    {
>>>    	struct ttm_validate_buffer *bo_list_entry;
>>> +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>>> +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
>>> +		return;
>>> +
>>>    	bo_list_entry = &mem->validate_list;
>>>    	mutex_lock(&process_info->lock);
>>>    	list_del(&bo_list_entry->head);
>>> @@ -1649,7 +1657,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>    	unsigned long bo_size = mem->bo->tbo.base.size;
>>>    	struct kfd_mem_attachment *entry, *tmp;
>>>    	struct bo_vm_reservation_context ctx;
>>> -	struct ttm_validate_buffer *bo_list_entry;
>>>    	unsigned int mapped_to_gpu_memory;
>>>    	int ret;
>>>    	bool is_imported = false;
>>> @@ -1677,10 +1684,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>    	}
>>>    	/* Make sure restore workers don't access the BO any more */
>>> -	bo_list_entry = &mem->validate_list;
>>> -	mutex_lock(&process_info->lock);
>>> -	list_del(&bo_list_entry->head);
>>> -	mutex_unlock(&process_info->lock);
>>> +	remove_kgd_mem_from_kfd_bo_list(mem, process_info);
>>>    	/* No more MMU notifiers */
>>>    	amdgpu_mn_unregister(mem->bo);

