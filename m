Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4C6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 08:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FE110E008;
	Mon, 13 Jun 2022 08:50:22 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E4210E008
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 08:50:21 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id fu3so9781902ejc.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=9QNlG+hirBrXhXXSJlqkzONAzZwEtZ6g3OCqz3x+o90=;
 b=izPB998eU6OT5AF23lpPSJyzVDEWe6vBF2eqzULfzrcTCWy5TbIA9HrERj6PZr9R4e
 +UaX8ZBbYHRWk9Reb2Bm3qVdTbwR6VFsG6jzSYLdDOCuWIbRxts0e66QtfW9+Ewx/c/R
 wTIrARjFQT8D0vON65pdS5qAC/Zzq5OgSji4vsEqsCzuwcoQTBmPay/672ddAX1L71jK
 OMIrq7D3qEvU9uJ7LzGRE8MnHhIsPIXGGgWl/ByzeuUYDWnosSlZty1LI8fpWZba11Yj
 motin90B/Yvo0z+QdRIx3t3jJhX/UujGhZpU3cg26mzCIb1gQYCM/Aja9rgmLZ2B5MoC
 E6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9QNlG+hirBrXhXXSJlqkzONAzZwEtZ6g3OCqz3x+o90=;
 b=UdGhbp2TKe9JjP2YKai07n1XGKky9bstjthULSD1wKXDG2J94tEPc0OZJoVsQ0/DWS
 iOiaLD+EkoGLImFvr7eVfN4/dVV9PXrFJ33wvMw9jDb8uUPmnItv4vrgloILP4mmZNfh
 LJlLXzVFPbXJ0lT4KWp7X7pVJyh402veMhoHwyubhAOrRk96E7ySfqn217xKQvUlILfe
 9JTYeEt4EydoYRP07CRVpZub+w2cz7rEGraPyABhbUgESP/86ugliXVHgQWK8ZG/9n5L
 ZuPPgxg8uW1/JvI0ULlnBbr0+y58y3NiGo0xhQyGSmzuibPKGOW3Gop9DRN9jCOefsJU
 SKlw==
X-Gm-Message-State: AOAM532dikuNLqQHn5L7uppyEsN2oN2PkfnCw0JOnwVWZYbsSyS9Yvxi
 Ux6QOumjrkcu/1Ls4weCu40=
X-Google-Smtp-Source: ABdhPJxY6tOsE1RghaeLHZm+3etDxFs5BRBU91hzv7fhw/+NIVovaMR7AIxnvuDc1xF5nCKjzzaM2A==
X-Received: by 2002:a17:906:5d0d:b0:711:d49f:e353 with SMTP id
 g13-20020a1709065d0d00b00711d49fe353mr34884920ejt.381.1655110219645; 
 Mon, 13 Jun 2022 01:50:19 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b659.dip0.t-ipconnect.de.
 [87.176.182.89]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056402430800b0042dd792b3e8sm4545876edc.50.2022.06.13.01.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jun 2022 01:50:19 -0700 (PDT)
Message-ID: <4e8aee05-f344-fe77-895d-bce5340bec92@gmail.com>
Date: Mon, 13 Jun 2022 10:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/amdkfd: simplify vm_validate_pt_pd_bos
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220613075956.720375-1-Lang.Yu@amd.com>
 <55d98218-7032-5d29-fea7-afa7ff1e5ea6@amd.com>
 <Yqb0qO2mym1X9ha4@lang-desktop>
 <13337f06-0244-008d-4f9d-672a99206b69@gmail.com>
 <Yqb4MrCTAVcnaGoZ@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <Yqb4MrCTAVcnaGoZ@lang-desktop>
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.06.22 um 10:41 schrieb Lang Yu:
> On 06/13/ , Christian König wrote:
>> Am 13.06.22 um 10:26 schrieb Lang Yu:
>>> On 06/13/ , Christian König wrote:
>>>> Am 13.06.22 um 09:59 schrieb Lang Yu:
>>>>> We don't need to validate and map root PD specially here,
>>>>> it would be validated and mapped by amdgpu_vm_validate_pt_bos
>>>>> if it is evicted.
>>>> I'm not sure if that's correct. Traditionally we have handled the root PD
>>>> differently to the rest in the VM.
>>>>
>>>> It doesn't make much sense any more today, but I need to double check if
>>>> that isn't still the case.
>>>   From my observations, if root PD is evicted. amdgpu_vm_validate_pt_bos
>>> will validate and map it.
>>>
>>> And amdgpu_cs_list_validate always validates root PD after
>>> amdgpu_vm_validate_pt_bos has done that, it is actually unnecessary.
>>> Do you think it's worth skiping root PD validation in
>>> amdgpu_cs_list_validate? Thanks!
>> No, it's just your change is completely irrelevant and just complicates
>> things.
>>
>> Validating a BO twice should have basically no overhead at all.
>>
>> And especially adding the manual call to map_table() in
>> amdgpu_vm_make_compute() is a no-go. We don't want such specific handling
>> for compute contexts.
> That's because when turning a GFX VM to a compute VM, if vm_update_mode changed,
> we need to map the root PD again.

Ah, ok that sounds valid. But please add a comment explaining this.

> If we always validate and map it in vm_validate_pt_pd_bos, that's so confused.

It's indeed not really clean, we shouldn't leak requirements like this 
outside of the VM code.

Regards,
Christian.

>
> Regards,
> Lang
>
>> Regards,
>> Christian.
>>
>>> Regards,
>>> Lang
>>>
>>>
>>>> Christian.
>>>>
>>>>> The special case is when turning a GFX VM to a compute VM,
>>>>> if vm_update_mode changed, we need to map the root PD again.
>>>>> So just move root PD mapping to amdgpu_vm_make_compute.
>>>>>
>>>>> v2:
>>>>>     - Don't rename vm_validate_pt_pd_bos and make it public.
>>>>>
>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 --------------
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  5 +++++
>>>>>     2 files changed, 5 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index 6a3bd8b9a08f..3805eef9ab69 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -425,22 +425,8 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
>>>>>     		return ret;
>>>>>     	}
>>>>> -	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
>>>>> -	if (ret) {
>>>>> -		pr_err("failed to validate PD\n");
>>>>> -		return ret;
>>>>> -	}
>>>>> -
>>>>>     	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>>>>> -	if (vm->use_cpu_for_update) {
>>>>> -		ret = amdgpu_bo_kmap(pd, NULL);
>>>>> -		if (ret) {
>>>>> -			pr_err("failed to kmap PD, ret=%d\n", ret);
>>>>> -			return ret;
>>>>> -		}
>>>>> -	}
>>>>> -
>>>>>     	return 0;
>>>>>     }
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index 703552f9a6d7..08fda57f5aa2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -2225,6 +2225,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>>>     	} else {
>>>>>     		vm->update_funcs = &amdgpu_vm_sdma_funcs;
>>>>>     	}
>>>>> +
>>>>> +	r = vm->update_funcs->map_table(to_amdgpu_bo_vm(vm->root.bo));
>>>>> +	if (r)
>>>>> +		goto unreserve_bo;
>>>>> +
>>>>>     	dma_fence_put(vm->last_update);
>>>>>     	vm->last_update = NULL;
>>>>>     	vm->is_compute_context = true;

