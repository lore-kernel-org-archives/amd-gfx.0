Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D121C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 09:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EBD11300F;
	Fri,  8 Jul 2022 09:05:02 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445D911301D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 09:05:02 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id r18so26088885edb.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jul 2022 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=J/Q/jtHQaIysFj7zcuaijLFhSwVdL7GPOOGT+9abNQ4=;
 b=kYQqOO06sE4/LMBv2gdXyr8XjCkTY7HSMIscmySyDmYPvFWTu7blMuzq953PnOPaTd
 dsf4zy/yHH2cLkvcEXFBxEygLSY52yxW99ydf7yvyzkvVLHYXs1P6Evbyz4pDcvd/uMO
 RVgSNedpI2CYOY5zHIaklIVfV3ewJn9T75aLGRbyoPHqn2j8Cgt+FS+UvCYee2pVLMNg
 oI9CQnvjfztWD24x1dDLR8EFf/EKpnMIpRk+rdxn/000XXJNKSnFquNM/nZowKsCQ+/Q
 6Niesv2nbPj9cl15EqOw2thzQ3ijUbbY0+TN9fNKylHAqUTCZvuCKaTfV3Rs4Gw15mY7
 W4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=J/Q/jtHQaIysFj7zcuaijLFhSwVdL7GPOOGT+9abNQ4=;
 b=Wi25GsXLIejLj9LfaP9yLof/2+cuM0vxJQQe09VxZl/5I6H8vb2VhB3L/lFw+NrAnc
 hvUBNUdLlSZj+/DpQ5tzIVLjok48JeEG5RgVKVIzN25w66GX0u53qNoxIZyljWpRU9Q6
 VA97OCqWSlCNhqLSpZMJ74wAD0dDma6POfVgyhYNT5cEdjNxaNsxqn1hPj3obM91IxH3
 AaC/XvxnTuw4YhZJx1BZ3Cg5XgxdCNbX0FbRJwlf7ZkqJBGNaXaQR6kZn4WdDEoGAvXh
 MqApYFRhlngNHgivzfiqJ4wnyNumCdy6KDKico9yDNEGcQbmcZ1P6ixxVcuupsb/H86e
 dRUQ==
X-Gm-Message-State: AJIora/BOW1Q1ZMR6A+MaNALtkJyPlSZ4JK87PKrb2Ov7VeqMmd4hdVF
 q6zdzjX+rD14Dyaf5x5Qal8=
X-Google-Smtp-Source: AGRyM1s/CRlSw6SVjZ8i4RJK40FwQfSNpIgzk5PTKfShaLuiq+ME4QVUItEfzVqILf/uNqDh3bw79g==
X-Received: by 2002:a50:eb89:0:b0:43a:1212:db8c with SMTP id
 y9-20020a50eb89000000b0043a1212db8cmr3183341edr.391.1657271040888; 
 Fri, 08 Jul 2022 02:04:00 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:95df:c673:e23c:7b70?
 ([2a02:908:1256:79a0:95df:c673:e23c:7b70])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a170906d20d00b00726298147b1sm19939156ejz.161.2022.07.08.02.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jul 2022 02:04:00 -0700 (PDT)
Message-ID: <1766b5b0-05f1-b88e-3147-c5ac1749f0d1@gmail.com>
Date: Fri, 8 Jul 2022 11:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
Content-Language: en-US
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220707095053.6755-1-xinhui.pan@amd.com>
 <92f468dc-2fad-5135-4aeb-c8ce2a680c69@gmail.com>
 <4b60ece6-afa5-62ca-afa6-bb800cdba982@amd.com>
 <DM4PR12MB5165724D36AB92CF9D40728487829@DM4PR12MB5165.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB5165724D36AB92CF9D40728487829@DM4PR12MB5165.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi guys,

well the practice to remove all fences by adding a NULL exclusive fence 
was pretty much illegal in the first place because this also removes 
kernel internal fences which can lead to freeing up memory which is 
still accessed.

I've just didn't noticed that this was used by the KFD code as well 
otherwise I would have pushed to clean that up much earlier.

Regards,
Christian.

Am 08.07.22 um 03:08 schrieb Pan, Xinhui:
> [AMD Official Use Only - General]
>
> Felix,
> Shared fences depend on exclusive fence, so add a new exclusive fence, say NULL would also remove all shared fences. That works before 5.18 . 😉
>  From 5.18, adding a new exclusive fence(the write usage fence) did not remove any shared fences(the read usage fence). So that is broken.
>
> And I also try the debug_evictions parameter. No unexpected eviction shows anyway.
> I did a quick check and found amdgpu implement BO release notify and it will remove kfd ef on pt/pd BO. So we don’t need this duplicated ef removal. The interesting thing is that is done by patch f4a3c42b5c52("drm/amdgpu: Remove kfd eviction fence before release bo (v2)") which is from me 😉 I totally forgot it.
>
> So I would make a new patch to remove this duplicated ef removal.
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Thursday, July 7, 2022 11:47 PM
> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Fix a NULL pointer of fence
>
> Am 2022-07-07 um 05:54 schrieb Christian König:
>> Am 07.07.22 um 11:50 schrieb xinhui pan:
>>> Fence is accessed by dma_resv_add_fence() now.
>>> Use amdgpu_amdkfd_remove_eviction_fence instead.
>>>
>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 0036c9e405af..1e25c400ce4f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1558,10 +1558,10 @@ void amdgpu_amdkfd_gpuvm_destroy_cb(struct
>>> amdgpu_device *adev,
>>>          if (!process_info)
>>>            return;
>>> -
>>>        /* Release eviction fence from PD */
>>>        amdgpu_bo_reserve(pd, false);
>>> -    amdgpu_bo_fence(pd, NULL, false);
>>> +    amdgpu_amdkfd_remove_eviction_fence(pd,
>>> +                    process_info->eviction_fence);
>> Good catch as well, but Felix needs to take a look at this.
> This is weird. We used amdgpu_bo_fence(pd, NULL, false) here, which would have removed an exclusive fence. But as far as I can tell we added the fence as a shared fence in init_kfd_vm and amdgpu_amdkfd_gpuvm_restore_process_bos. So this probably never worked as intended.
>
> You could try if this is really needed. Just remove the eviction fence removal. Then enable eviction debugging with
>
>       echo Y > /sys/module/amdgpu/parameters/debug_evictions
>
> Run some simple tests and check the kernel log to see if process termination is causing any unexpected evictions.
>
> Regards,
>     Felix
>
>
>> Regards,
>> Christian.
>>
>>>        amdgpu_bo_unreserve(pd);
>>>          /* Update process info */

