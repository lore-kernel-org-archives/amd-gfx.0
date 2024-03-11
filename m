Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B16C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 16:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952BD10FF67;
	Mon, 11 Mar 2024 16:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C0/jD6ZA";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A498110E06B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 16:33:15 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-33e959d8bc0so1149033f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710174794; x=1710779594; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=exEAoXQ3m1cZixqptKvKWadXu8fa6DZJ+2Eypgm6vFU=;
 b=C0/jD6ZAm8oVdT+UcshLzoiJAy84+hCPt5fWyVi/MmLAuq33SPheZunVeYMILb4Khd
 XoVHhigA2Tv8uVmqOP4nTfnjpH5pOgGn/Sj08tmKJoKbXSiS3PQh8CUTbZu/sHkg7fbz
 vXAwgeJPY0/s54iNLo1tguOU+EMBaQ66DFUB+m32SvQopYe7mzoCqP/JM4RwBYDLlFih
 9spmBFDzPJRejbZQGiehxhnPD3UW1JM4YZe/NHCNS0+SQ9YYIS055tjKlGqr+U+1wemb
 TvrePBagq1BvSOeHmqO7y0Ba7p9efkef/9Wpni/6m7g5ajEozlb1W65D4RZyOS0Ct75M
 fXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710174794; x=1710779594;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=exEAoXQ3m1cZixqptKvKWadXu8fa6DZJ+2Eypgm6vFU=;
 b=SNaobPhIF+6XDkr98mLamoeK0rzUiE0QHj3d0pWO8/TeuRI1YXnh2gvzlkpDXbB/cB
 LpM+CHjHPirBNWRjLI2P97G5CUAZav42kJRbKABX+XCqaThcGyeDxodsah5if+dgFVDD
 6r/hF2rL9ppbsbRlDNAexgd+kE9xyeUHYVAnM1lm1vDqnckEBV1iKZsqy7FkXIcyUwqO
 bJ9GrNQJdec7A/vKc6xCVodwSAWN5e0+MKjbd7XU6Qqli1wkL7QMBXmmNpT6022GVaBE
 rf84HS6nth0K2jaXCY4/mYoAUJB8ta3vRIlo/ZFym18tTbRnTZOPxptAHpZ7ijGSKDVx
 30wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDw3+nP4F09gIvT69dnj5WOXN2P8uZfkMTLFRYBbNtiXVGHV/9PubEQs27bAEbM0c6svT6kijkWmcOokNG3vYd06am8RlttBASgzI0iQ==
X-Gm-Message-State: AOJu0YwbrSt0K09LcVzEkDZ9eK0hxxzaIAwAYA17sVx4YHtY1yFRRaEJ
 1y4QYriHanbG5RvGuvF369GmbWRF1k19aRS/jBf96cNtpktY4c/2
X-Google-Smtp-Source: AGHT+IEu3ayuvwdgui6MbueSPF96OG7bia8M6kKG2K6VyBPlHlBaZB5AuWqs+FNSgLXG/WLPLU5CHA==
X-Received: by 2002:a05:6000:141:b0:33e:4810:a052 with SMTP id
 r1-20020a056000014100b0033e4810a052mr4020197wrx.70.1710174793612; 
 Mon, 11 Mar 2024 09:33:13 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bt18-20020a056000081200b0033e91509224sm4194654wrb.22.2024.03.11.09.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 09:33:12 -0700 (PDT)
Message-ID: <4cc9a397-fb93-4490-9ae7-3330ac0b4c5e@gmail.com>
Date: Mon, 11 Mar 2024 17:33:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Handle duplicate BOs during process restore
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240308162253.264154-1-mukul.joshi@amd.com>
 <4098f759-dc58-422d-b000-af8126775966@gmail.com>
 <BL3PR12MB6425EFDC27818399BA85C1E2EE242@BL3PR12MB6425.namprd12.prod.outlook.com>
 <08c51a55-a1e9-43e6-82e9-537424c0bfb5@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <08c51a55-a1e9-43e6-82e9-537424c0bfb5@amd.com>
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

Am 11.03.24 um 16:33 schrieb Felix Kuehling:
> On 2024-03-11 11:25, Joshi, Mukul wrote:
>> [AMD Official Use Only - General]
>>
>>> -----Original Message-----
>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Sent: Monday, March 11, 2024 2:50 AM
>>> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: Handle duplicate BOs during process
>>> restore
>>>
>>> Caution: This message originated from an External Source. Use proper 
>>> caution
>>> when opening attachments, clicking links, or responding.
>>>
>>>
>>> Am 08.03.24 um 17:22 schrieb Mukul Joshi:
>>>> In certain situations, some apps can import a BO multiple times
>>>> (through IPC for example). To restore such processes successfully, we
>>>> need to tell drm to ignore duplicate BOs.
>>>> While at it, also add additional logging to prevent silent failures
>>>> when process restore fails.
>>>>
>>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14
>>> ++++++++++----
>>>>    1 file changed, 10 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> index bf8e6653341f..65d808d8b5da 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>> @@ -2869,14 +2869,16 @@ int
>>>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>>>> __rcu *
>>>>
>>>>        mutex_lock(&process_info->lock);
>>>>
>>>> -     drm_exec_init(&exec, 0);
>>>> +     drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES);
>>>>        drm_exec_until_all_locked(&exec) {
>>>>                list_for_each_entry(peer_vm, 
>>>> &process_info->vm_list_head,
>>>>                                    vm_list_node) {
>>>>                        ret = amdgpu_vm_lock_pd(peer_vm, &exec, 2);
>>>> drm_exec_retry_on_contention(&exec);
>>>> -                     if (unlikely(ret))
>>>> +                     if (unlikely(ret)) {
>>>> +                             pr_err("Locking VM PD failed, ret:
>>>> + %d\n", ret);
>>>>                                goto ttm_reserve_fail;
>>>> +                     }
>>> That's a bad idea. Locking can always be interrupted and that would 
>>> print an
>>> error here.
>>>
>> Thanks Christian. Will send out a patch to change it to pr_debug.
>
> We cannot get interrupted here because we're in a worker thread. We 
> should be running in non-interruptible mode.

Ah! Ok in that case this isn't necessary.

But in general I think we should avoid error printing like that. If we 
want to know where something failed there is a function tracker for that.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Mukul
>>
>>> Regards,
>>> Christian.
>>>
>>>>                }
>>>>
>>>>                /* Reserve all BOs and page tables/directory. Add all
>>>> BOs from @@ -2889,8 +2891,10 @@ int
>>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>>> __rcu *
>>>>                        gobj = &mem->bo->tbo.base;
>>>>                        ret = drm_exec_prepare_obj(&exec, gobj, 1);
>>>> drm_exec_retry_on_contention(&exec);
>>>> -                     if (unlikely(ret))
>>>> +                     if (unlikely(ret)) {
>>>> +                             pr_err("drm_exec_prepare_obj failed,
>>>> + ret: %d\n", ret);
>>>>                                goto ttm_reserve_fail;
>>>> +                     }
>>>>                }
>>>>        }
>>>>
>>>> @@ -2950,8 +2954,10 @@ int
>>> amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence
>>> __rcu *
>>>>         * validations above would invalidate DMABuf imports again.
>>>>         */
>>>>        ret = process_validate_vms(process_info, &exec.ticket);
>>>> -     if (ret)
>>>> +     if (ret) {
>>>> +             pr_err("Validating VMs failed, ret: %d\n", ret);
>>>>                goto validate_map_fail;
>>>> +     }
>>>>
>>>>        /* Update mappings not managed by KFD */
>>>>        list_for_each_entry(peer_vm, &process_info->vm_list_head,

