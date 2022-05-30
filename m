Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96024C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 09:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3150410E4EC;
	Mon, 30 May 2022 09:57:19 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C913210E4EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 09:57:17 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id l19so1928175ejr.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 02:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=fgBNeNcmdvsmH/lO6QTRJ77hU9oEojp6fjwtK1y3SMw=;
 b=ZtbN5E/C8/V4s9CO/nv/94g2dCMzQXpGm72c8nu3EsxWEoDMCyOUAajrtKmS3Ve1RL
 jVvo8PnZkm0IvljM/oYg5sD6QUbhk4mK8Fj4bY3Ts5Xr9g1dgT1GrSNn7tPESpj2jUwp
 FxAPfjqfS+Pux7O++cPG6ZDOuEAIPTfzquPxqQ8jwQ3rfcKWiyGtxkq/tSv68eeD7Amp
 SR+J8NBTO5dVVoXoTYBWoxW+p9YDIOwzWR9/e0dbfhw4sZ7ciZYFNpBaEakA4DZP487O
 fMhWV0jPgoqoj6JK3U+E9KTf3TNTp/6MDJrb/A2BiN7KFSO6I4+/A0nlcd28oAAHfLx6
 QwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fgBNeNcmdvsmH/lO6QTRJ77hU9oEojp6fjwtK1y3SMw=;
 b=r7t9tLrtQul5WLl4IlC6Bh0OI1OqOtNekAqGC/K2964mXbaFZTR6sYc3SJNpgTqYmI
 m/obbBgmb2wCxhv6eiulIwE/0Ni181Hxr+QEOcJnLtdWhFzPupzU5VDCAMo4jkXAb0yC
 Ro69LM0mWrK9mwjHNA9RV68EgNDcJTEAj3PpADO8mczTPmieGaKMknj4RmhLHaLKP/Wg
 FXhVJ33eBVQoEZydjBXzNbllC2kw/TTO11+EAWQuPA2Y+vod31W4ByHhngEy+eQFhInN
 71M2BBuKbvjIHkBgWPMMOFEy2m0rD7uyJHnX/tuj1Rj8h9TgWWM1KX2OKjF69k73NCrM
 gcVQ==
X-Gm-Message-State: AOAM530rFRtfHxiHEV2qmnS7zBe8nKSIvY7EZvk5HUs9N27Ua6TsS1Qs
 26dlkrRquxYFEepfdeDpSxg=
X-Google-Smtp-Source: ABdhPJwWKnlW1NnT5IUf3W9d9ofaq4vKgBFRYuf278MdqyNqverNc8FGpa66QmAv901sA8j3h26ykw==
X-Received: by 2002:a17:907:7d8a:b0:6fe:dccb:cf4c with SMTP id
 oz10-20020a1709077d8a00b006fedccbcf4cmr34496189ejc.714.1653904636310; 
 Mon, 30 May 2022 02:57:16 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea17a.dip0.t-ipconnect.de.
 [91.14.161.122]) by smtp.gmail.com with ESMTPSA id
 r27-20020a056402235b00b0042abf2affebsm6181861eda.67.2022.05.30.02.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 02:57:15 -0700 (PDT)
Message-ID: <4dab5c26-367d-3271-e1ff-155927a85fb7@gmail.com>
Date: Mon, 30 May 2022 11:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: don't add DOORBELL and MMIO BOs to validate
 list
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>
References: <20220525084324.1354886-1-Lang.Yu@amd.com>
 <eebb0612-6703-9408-ebf6-2813e13139ef@gmail.com>
 <Yo31/hZQ7qzs2KyO@lang-desktop>
 <77ece2f1-97e6-f44d-0a30-971b28693c3c@gmail.com>
 <e46a9b9f-f8ca-a701-530c-20080f50a3f8@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <e46a9b9f-f8ca-a701-530c-20080f50a3f8@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.05.22 um 00:17 schrieb Felix Kuehling:
>
> On 2022-05-25 06:37, Christian König wrote:
>> Am 25.05.22 um 11:25 schrieb Lang Yu:
>>> On 05/25/ , Christian König wrote:
>>>> Am 25.05.22 um 10:43 schrieb Lang Yu:
>>>>> DOORBELL and MMIO BOs never move once created.
>>>>> No need to validate them after that.
>>>> Yeah, but you still need to make sure their page tables are up to 
>>>> date.
>>>>
>>>> So this here might break horrible.
>>> These BOs(and attachments) are validated when allocated and mapped.
>>> Their page tables should be determined at this time.
>>>
>>> The kfd_bo_list is used to restore BOs after evictions.
>>>
>>> Do you mean their page tabes could be changed? Thanks.
>>
>> Yes, page tables can be destroyed under memory pressure as well.
>
> Is that actually happening today, or is that some future optimization 
> you have in mind? I know page tables can get evicted, but I didn't 
> think they were destroyed unless the memory at that address is 
> unmapped (which never happens for pinned BOs).

We partially already do that, but it is largely for future optimizations.

Currently page tables are moved to system memory and occupy system 
pages. But that's just utterly nonsense because they are re-created 
anyway when they move back in.

>>
>> Not sure how the KFD handles that, but in theory we should have every 
>> BO used by a process on the validation list. Even the ones pinned.
>
> Then we already have some other broken cases for the small number of 
> kmapped BOs that are pinned and currently removed from the validation 
> list (see amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel).

That's indeed broken then and only works by coincidence (the pinned and 
unpinned probably BOs don't overlap an evicted page table).

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>>
>>>> Christian.
>>>>
>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 
>>>>> +++++++++-----
>>>>>    1 file changed, 9 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index 34ba9e776521..45de9cadd771 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -808,6 +808,10 @@ static void add_kgd_mem_to_kfd_bo_list(struct 
>>>>> kgd_mem *mem,
>>>>>        struct ttm_validate_buffer *entry = &mem->validate_list;
>>>>>        struct amdgpu_bo *bo = mem->bo;
>>>>> +    if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>>>>> +                KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
>>>>> +        return;
>>>>> +
>>>>>        INIT_LIST_HEAD(&entry->head);
>>>>>        entry->num_shared = 1;
>>>>>        entry->bo = &bo->tbo;
>>>>> @@ -824,6 +828,10 @@ static void 
>>>>> remove_kgd_mem_from_kfd_bo_list(struct kgd_mem *mem,
>>>>>    {
>>>>>        struct ttm_validate_buffer *bo_list_entry;
>>>>> +    if (mem->alloc_flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
>>>>> +                KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))
>>>>> +        return;
>>>>> +
>>>>>        bo_list_entry = &mem->validate_list;
>>>>>        mutex_lock(&process_info->lock);
>>>>>        list_del(&bo_list_entry->head);
>>>>> @@ -1649,7 +1657,6 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>>        unsigned long bo_size = mem->bo->tbo.base.size;
>>>>>        struct kfd_mem_attachment *entry, *tmp;
>>>>>        struct bo_vm_reservation_context ctx;
>>>>> -    struct ttm_validate_buffer *bo_list_entry;
>>>>>        unsigned int mapped_to_gpu_memory;
>>>>>        int ret;
>>>>>        bool is_imported = false;
>>>>> @@ -1677,10 +1684,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>>>        }
>>>>>        /* Make sure restore workers don't access the BO any more */
>>>>> -    bo_list_entry = &mem->validate_list;
>>>>> -    mutex_lock(&process_info->lock);
>>>>> -    list_del(&bo_list_entry->head);
>>>>> -    mutex_unlock(&process_info->lock);
>>>>> +    remove_kgd_mem_from_kfd_bo_list(mem, process_info);
>>>>>        /* No more MMU notifiers */
>>>>>        amdgpu_mn_unregister(mem->bo);
>>

