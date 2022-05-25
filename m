Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69498C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 11:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD54510E6D9;
	Wed, 25 May 2022 11:43:20 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE0F10E6D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 11:43:19 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id gi33so32616099ejc.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=vDaJTz0SmcT/KXg865yQ2gmtUxNB0ROCVSCmmwNMwCY=;
 b=dCMUKtWAjEwvvWeUk0SU0dwpYJ+CdyFnQQEFCxH5C4PLTDQcn8ndMcFi6m/A2nkQ1i
 IpjdIN8c5HKnW2k2fsRlngebYyNhnlwKjPpkLeMK30SnlPacUhEDr9tTmGrOVcThE8C9
 vgPkIk//Anz7heXnMv1gmNn+xrPBDqR34VJLV9S40/Er9KE539OaWO9mfcTDitf+anfc
 riE1c3xHB2NYaG9kslAMbMQcEiaeR6q7AHxkRli5DJdUDnRFjBPJx3L9ElnA+OUmDKuZ
 PuBiPz7b+Ow9jHwaWHLvSV/8UbLI4/7CSjse1GBD9cTFwM1HvRLOQ1jj+GrqM5GtxqU2
 zJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=vDaJTz0SmcT/KXg865yQ2gmtUxNB0ROCVSCmmwNMwCY=;
 b=W4Z+lemZhM6FLBISojsYa6a6gM1iQrHyRA59ymAV1g+D91aZyl9TCYTJLVty/PQZYh
 dfDJpNFn2MNwhWllas/oSOBY0CTrU8yqgNU4XnSnvZJNEWjTenLSV+T5ulGJqTi8P8K4
 wUcix23c49zZyiZWp/x2ik822lIW2DDYhH4qliCigUJgSuJhF0dC/p84LUL2FC6rxUry
 OBLnfL4U8bhsDgtO54y7c78tQrY8r76UmU6N1kGMTRd9KJP1mVlsdbPaBrDS8JSZ0+AI
 dT7NfDtrtitdYXPLfGq80HI49Z9eREph3iD/HLU8Id0Pci8nA1LzV4gHJeiNIc4d/8RW
 WmPQ==
X-Gm-Message-State: AOAM530BKz3LucudkSI9mSVsLoreZIbIz+PKYSWYLiKsgrIglbSL78EJ
 RJWrHMDKw4POEVppHuZv5y0f6/Z8QeI=
X-Google-Smtp-Source: ABdhPJyDS4lWqFhn5hKAEYkFjSosnZDw23NHLq3zrCzmt9TrdVH6A0BXOVv7rEHOggs3pNJYxr+pZA==
X-Received: by 2002:a17:907:d06:b0:6f4:13cc:80c2 with SMTP id
 gn6-20020a1709070d0600b006f413cc80c2mr28562863ejc.500.1653478997777; 
 Wed, 25 May 2022 04:43:17 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bdaa.dip0.t-ipconnect.de.
 [87.176.189.170]) by smtp.gmail.com with ESMTPSA id
 cq3-20020a056402220300b0042617ba63c2sm10712988edb.76.2022.05.25.04.43.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 May 2022 04:43:17 -0700 (PDT)
Message-ID: <d8586e11-8d65-93ea-8226-36cfd5ab978d@gmail.com>
Date: Wed, 25 May 2022 13:43:15 +0200
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
 <77ece2f1-97e6-f44d-0a30-971b28693c3c@gmail.com>
 <Yo4U+BrDV8bgALkJ@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <Yo4U+BrDV8bgALkJ@lang-desktop>
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

Am 25.05.22 um 13:37 schrieb Lang Yu:
> On 05/25/ , Christian König wrote:
>> Am 25.05.22 um 11:25 schrieb Lang Yu:
>>> On 05/25/ , Christian König wrote:
>>>> Am 25.05.22 um 10:43 schrieb Lang Yu:
>>>>> DOORBELL and MMIO BOs never move once created.
>>>>> No need to validate them after that.
>>>> Yeah, but you still need to make sure their page tables are up to date.
>>>>
>>>> So this here might break horrible.
>>> These BOs(and attachments) are validated when allocated and mapped.
>>> Their page tables should be determined at this time.
>>>
>>> The kfd_bo_list is used to restore BOs after evictions.
>>>
>>> Do you mean their page tabes could be changed? Thanks.
>> Yes, page tables can be destroyed under memory pressure as well.
> Destroyed? You mean the contents of page table BOs are disappeared.

Currently we try to just free up the backing store of them, but the idea 
is to really get rid of the whole BO under memory pressure.

See page tables are managed in a hierarchy and their content can be 
fully restored from the metadata.

So except for the root PD all page tables in a VM can (in theory) be 
destroyed and re-created when they are not used.

> If so, could other BOs be destroyed under memory pressure? Thanks!

I don't think so, everything else is just referenced somewhere.

Regards,
Christian.

>
> Regards,
> Lang
>
>> Not sure how the KFD handles that, but in theory we should have every BO
>> used by a process on the validation list. Even the ones pinned.
>>
>> Regards,
>> Christian.
>>
>>>
>>>> Christian.
>>>>
>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++++-----
>>>>>     1 file changed, 9 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index 34ba9e776521..45de9cadd771 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -808,6 +808,10 @@ static void add_kgd_mem_to_kfd_bo_list(struct kgd_mem *mem,
>>>>>     	struct ttm_validate_buffer *entry = &mem->validate_list;
>>>>>     	struct amdgpu_bo *bo = mem->bo;
>>>>> +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>>>>> +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
>>>>> +		return;
>>>>> +
>>>>>     	INIT_LIST_HEAD(&entry->head);
>>>>>     	entry->num_shared = 1;
>>>>>     	entry->bo = &bo->tbo;
>>>>> @@ -824,6 +828,10 @@ static void remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
>>>>>     {
>>>>>     	struct ttm_validate_buffer *bo_list_entry;
>>>>> +	if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>>>>> +				KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
>>>>> +		return;
>>>>> +
>>>>>     	bo_list_entry = &mem->validate_list;
>>>>>     	mutex_lock(&process_info->lock);
>>>>>     	list_del(&bo_list_entry->head);
>>>>> @@ -1649,7 +1657,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>>     	unsigned long bo_size = mem->bo->tbo.base.size;
>>>>>     	struct kfd_mem_attachment *entry, *tmp;
>>>>>     	struct bo_vm_reservation_context ctx;
>>>>> -	struct ttm_validate_buffer *bo_list_entry;
>>>>>     	unsigned int mapped_to_gpu_memory;
>>>>>     	int ret;
>>>>>     	bool is_imported = false;
>>>>> @@ -1677,10 +1684,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>>     	}
>>>>>     	/* Make sure restore workers don't access the BO any more */
>>>>> -	bo_list_entry = &mem->validate_list;
>>>>> -	mutex_lock(&process_info->lock);
>>>>> -	list_del(&bo_list_entry->head);
>>>>> -	mutex_unlock(&process_info->lock);
>>>>> +	remove_kgd_mem_from_kfd_bo_list(mem, process_info);
>>>>>     	/* No more MMU notifiers */
>>>>>     	amdgpu_mn_unregister(mem->bo);

