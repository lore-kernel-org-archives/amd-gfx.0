Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BE4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA09210E8C2;
	Fri,  4 Feb 2022 18:50:37 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B382310E5AE
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:50:36 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 bg21-20020a05600c3c9500b0035283e7a012so4349727wmb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Feb 2022 10:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=XXcPyMpa88XmlejJPc+xr5UW3dsLcs3tIpqG0H6cdGI=;
 b=iiQI/OgDDq0YdlB7ayrG1XcldgVNXEcEcv1myt9Fgt1VmlWtwwUBmnjVpziWHYSbfd
 xBPyS3TOefCwmRV2Ob7NB1vJL6HsRzHrUB5AuB6DxqhcjdORqECQn0ieVpnghS7U/7R3
 eDNp9lFpN+AWV103B4z2pL67zN+oYc883Jfulx2aABSQ543bINKtFy3F67ez8cHwVt01
 U4WxQGC0yOWzIWrbGic/8ZNVnaZaccDI1znF+JIfb+DeCfhFHinq6TDSnb4A6XylKLTf
 jR4QZY8Z5Upuh6U8/pGlOelfo9OZ3dvek3MAtky7KRDb6WhqHvgHp32WCRoCb+v20zhq
 Ll/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=XXcPyMpa88XmlejJPc+xr5UW3dsLcs3tIpqG0H6cdGI=;
 b=WHfY5PNDYd8iJQT/U0u8Oqa/NMF2Wra7hdwlHeOwK0gupzVUGyQeNy7xZ4y8GD+T+J
 BI05AYRrE2blTKdB+FrajZUWGNm06+vYoZQ5vdE3ztna1fGG1fEXEfQs6vPYHZVBVpm2
 NiZquFXQwToyRw6WkYmNecMnQNECDgeLtkddBkuEujW2mwORNkBdHNnVFdk0so9ikg6B
 /snzXBIlj7zFh7dFcRf2FznYvQM57G5H8BzR7VTsbdUqxfhWk1fOBUIOrun+ssGG2sSt
 yuodI5VscWRDYORcpHOXWm7fJ3K2gkzva18rt78pQigUPdI1oSeT3hXkWmHt84zUlJ/+
 RUZA==
X-Gm-Message-State: AOAM533j4bKnN1H5/1E5XGSRzAL0qbL9/peYpwFyOcXsRa2zHi0qqsJX
 I1E9IY3ACrYIsi2akmYyQH7Ya62hYzI=
X-Google-Smtp-Source: ABdhPJy3kkgJzICVIjTt2ogTSxTZ9XnlVg6EFPIperLjWNmLmKjlnqnVTRsolgtqpLNciY75eIFPBQ==
X-Received: by 2002:a05:600c:a45:: with SMTP id
 c5mr3267725wmq.127.1644000635268; 
 Fri, 04 Feb 2022 10:50:35 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:effb:7934:c2dc:ea53?
 ([2a02:908:1252:fb60:effb:7934:c2dc:ea53])
 by smtp.gmail.com with ESMTPSA id n11sm5799128wms.3.2022.02.04.10.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Feb 2022 10:50:34 -0800 (PST)
Message-ID: <cc241e74-40a6-7b87-d80d-a338361abd01@gmail.com>
Date: Fri, 4 Feb 2022 19:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: move lockdep assert to the right place.
Content-Language: en-US
To: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20220204085201.30615-1-christian.koenig@amd.com>
 <32b9cdf2-3d71-4228-3471-38584575f41b@amd.com>
 <668b5be7-de6c-4c47-9756-6452f316cd7e@amd.com>
 <108a3c26-df8c-c7ea-2228-25ec69afe50a@gmail.com>
 <df73c8a3-0c85-0402-01e4-38e6bec5af17@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <df73c8a3-0c85-0402-01e4-38e6bec5af17@amd.com>
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

Am 04.02.22 um 19:47 schrieb Bhardwaj, Rajneesh:
>
> On 2/4/2022 1:32 PM, Christian König wrote:
>> Am 04.02.22 um 19:12 schrieb Bhardwaj, Rajneesh:
>>> [Sorry for top posting]
>>>
>>> Hi Christian
>>>
>>> I think you forgot the below hunk, without which the issue is not 
>>> fixed completely on a multi GPU system.
>>
>> No, that is perfectly intentional. While removing a bo_va structure 
>> it can happen that there are still mappings attached to it (for 
>> example because the application crashed).
>
>
> OK. but for me, at boot time, I see flood of warning messages coming 
> from  amdgpu_vm_bo_del so the previous patch doesn't help.

Do you have a backtrace? That should not happen.

Could be that we have this buggy at a couple of different places.

Regards,
Christian.

>
>
>>
>> Because of this locking the VM before the remove is mandatory. Only 
>> while adding a bo_va structure we can avoid that.
>>
>> Regards,
>> Christian.
>>
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index dcc80d6e099e..6f68fc9da56a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2670,8 +2670,6 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>>>         struct amdgpu_vm *vm = bo_va->base.vm;
>>>         struct amdgpu_vm_bo_base **base;
>>>
>>> - dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>> -
>>>         if (bo) {
>>>                 dma_resv_assert_held(bo->tbo.base.resv);
>>>                 if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>>>
>>>
>>> If you chose to include the above hunk, please feel free to add
>>>
>>> Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>>
>>> On 2/4/2022 11:27 AM, Felix Kuehling wrote:
>>>>
>>>> Am 2022-02-04 um 03:52 schrieb Christian König:
>>>>> Since newly added BOs don't have any mappings it's ok to add them
>>>>> without holding the VM lock. Only when we add per VM BOs the lock is
>>>>> mandatory.
>>>>>
>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>> Reported-by: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
>>>>
>>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>
>>>>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index fdc6a1fd74af..dcc80d6e099e 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -375,6 +375,8 @@ static void amdgpu_vm_bo_base_init(struct 
>>>>> amdgpu_vm_bo_base *base,
>>>>>       if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>>>>           return;
>>>>>   + dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>> +
>>>>>       vm->bulk_moveable = false;
>>>>>       if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
>>>>>           amdgpu_vm_bo_relocated(base);
>>>>> @@ -2260,8 +2262,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct 
>>>>> amdgpu_device *adev,
>>>>>   {
>>>>>       struct amdgpu_bo_va *bo_va;
>>>>>   - dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>>>> -
>>>>>       bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
>>>>>       if (bo_va == NULL) {
>>>>>           return NULL;
>>

