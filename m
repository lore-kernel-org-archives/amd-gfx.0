Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D67C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2DC10E465;
	Fri,  4 Feb 2022 18:33:00 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 274E110E465
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:32:59 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 l12-20020a7bc34c000000b003467c58cbdfso9998015wmj.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Feb 2022 10:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=FwWOtQmOHjR71J+Y/VfWoOqBPni6ylJmMBW2NU1EHX0=;
 b=aPSkaLP4efpv0Hn0/uIZxBsiJmF52QAvUC6nTw8AtN6dvxjBzM6TIvIux9eu45bRvx
 VjgOkYTJ9rnqQfvVSM1WcvOZQ0nVR6oS6sZ/j4bLbE1PnJ+wv48n+ws1JCuAth9tw92R
 /ihr4rBj/Lhe6xzdVdKsx7fvri8fwNDJrei565fkphpfuUK783HoZop0D9wAlyh1elF/
 FraRiar/I/ydUYrDSmmjCuaUBxTMeLq7cePA0TovYEqhyAEEDWOQwbUFqv64gU0MUDhq
 O5f8pf8WwfntoMBIU1YZOwxNtdbXk5QLIHvnWPSQVZZKtngkr9edp0XgqFIBvQe5Fr94
 Y6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=FwWOtQmOHjR71J+Y/VfWoOqBPni6ylJmMBW2NU1EHX0=;
 b=Z3NIHtMlZ+jhS8cqYIsYzfkdFlc6RlevyjTTQgWDZ8Fi1PmAu3kl5l0IY741hVPash
 /Z8LMEuc1f2Vx6GqN0V07hLRxsTldzx4GeK81/XORux7jfm9MCxskZNmXwEg1nWrfOz9
 iPmtdPW/usyJsctwmjqlAmr5QV/E1HULoAyLL1Nyj9m86fAzA1xSuvrzq9ehwZp5TgU1
 F6eZUk5BGi4SnIDvJjUzs60UUoP9rNyxGJPgyF72V0TFBSA5LFJKngC/0J9As1r2sPU/
 fZBNODJJh7fSbPO36MTxUz7EArvKQE/nuqujpHtEGnplYwx2tKJn+tISb+Y8v6QtRism
 51OQ==
X-Gm-Message-State: AOAM532be57Mw0LzpFydMj1FI1pPCXDGDsXiSF7GIFKy2+LjoSWqB6cJ
 knWVVXXUbw/DXVqFJcbOF0w=
X-Google-Smtp-Source: ABdhPJzVvXfk1mL/CnvAmQ+XAO/xnMSInvIDjY4qQPZgEoRRUfsXaz8T0+Dxq2yzPZ/r2EDWRhyZMg==
X-Received: by 2002:a7b:cb94:: with SMTP id m20mr2524772wmi.46.1643999577544; 
 Fri, 04 Feb 2022 10:32:57 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:2e1a:9955:6a7:3f7d?
 ([2a02:908:1252:fb60:2e1a:9955:6a7:3f7d])
 by smtp.gmail.com with ESMTPSA id bi18sm9397603wmb.20.2022.02.04.10.32.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Feb 2022 10:32:57 -0800 (PST)
Message-ID: <108a3c26-df8c-c7ea-2228-25ec69afe50a@gmail.com>
Date: Fri, 4 Feb 2022 19:32:55 +0100
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <668b5be7-de6c-4c47-9756-6452f316cd7e@amd.com>
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

Am 04.02.22 um 19:12 schrieb Bhardwaj, Rajneesh:
> [Sorry for top posting]
>
> Hi Christian
>
> I think you forgot the below hunk, without which the issue is not 
> fixed completely on a multi GPU system.

No, that is perfectly intentional. While removing a bo_va structure it 
can happen that there are still mappings attached to it (for example 
because the application crashed).

Because of this locking the VM before the remove is mandatory. Only 
while adding a bo_va structure we can avoid that.

Regards,
Christian.

>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index dcc80d6e099e..6f68fc9da56a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2670,8 +2670,6 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>         struct amdgpu_vm *vm = bo_va->base.vm;
>         struct amdgpu_vm_bo_base **base;
>
> -       dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> -
>         if (bo) {
>                 dma_resv_assert_held(bo->tbo.base.resv);
>                 if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
>
>
> If you chose to include the above hunk, please feel free to add
>
> Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>
> On 2/4/2022 11:27 AM, Felix Kuehling wrote:
>>
>> Am 2022-02-04 um 03:52 schrieb Christian König:
>>> Since newly added BOs don't have any mappings it's ok to add them
>>> without holding the VM lock. Only when we add per VM BOs the lock is
>>> mandatory.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> Reported-by: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index fdc6a1fd74af..dcc80d6e099e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -375,6 +375,8 @@ static void amdgpu_vm_bo_base_init(struct 
>>> amdgpu_vm_bo_base *base,
>>>       if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>>>           return;
>>>   +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>> +
>>>       vm->bulk_moveable = false;
>>>       if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
>>>           amdgpu_vm_bo_relocated(base);
>>> @@ -2260,8 +2262,6 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct 
>>> amdgpu_device *adev,
>>>   {
>>>       struct amdgpu_bo_va *bo_va;
>>>   -    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>>> -
>>>       bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
>>>       if (bo_va == NULL) {
>>>           return NULL;

