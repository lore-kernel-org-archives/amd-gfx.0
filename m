Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02A3C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 08:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234E310E028;
	Mon, 13 Jun 2022 08:30:17 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B8B10E028
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 08:30:16 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id g25so9670021ejh.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=2XztKXzumhrwGNCbw/AVTqFGGAjHauXllsln3tJ4DRg=;
 b=NEVlBm3tPVpdGH8pLDnO6wa+kLEIGQy5QKkbuRjLRlr0GmFpjpaqtpsSc7+2SMtjdZ
 einuxRE5f86R9zsTv8c3bHfuOr8nhrXUWHZ7ALIOtIQGvGOhCwK1LSQggR6qVJO0kIJb
 piDHAW8HKcWF+vsDqXIU9f+giHc9goq3hwRv6nLer4dIH7R9veOCC/IdHdPynPjXVi5h
 08BuLO6VPQhLLRJlrF1oR+YFexxrCGbUWZ79SFPFCGdBUmbgswvU/cMg2ozc5Bpvb8jA
 0dQEBVOzPNue69l01iTAHrWipimfVtOHOtRuX+L+LjKGuhCrwmy+7vSWlGpu3qGakqdu
 mRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2XztKXzumhrwGNCbw/AVTqFGGAjHauXllsln3tJ4DRg=;
 b=zNGHUn3sQHxk5pvplFzcTZL3m/l/Nlo1xKzlCdqkNNvY9uPj7SpxcnsND6ci852YVo
 pG1GXyF6MRMIms9zBIAQBoVqWurEHRADtNs3sBM/qWNEKi0QKkkYaNswNzVckaS0CgkG
 AM60ZuqbRHrGig/UXWReRRuwhNHQFxFsymT2rB9bQ5oR5a4sm3/92cAuTkIDiI5Sr92W
 CQHwmT1bkyiGwdyLAuQX6NhOEFzkADfek3bJ5cKcQ8svsZpMWi5zYR1BTgWbpajfEEWd
 kwpQjEsLP6iGd4/N2ys9ki3g5gkyp0rPwo3TQAjV633znAzN3hVLrCPZzYoPM4ssICaj
 SznA==
X-Gm-Message-State: AOAM531GCIsv+d/hMu31wdIx6FQhSgeFnv6JpcwxjCafXkGZYbFj5tcO
 Q3d7BqptB/xyGx9t7sp4f3xyZw6T1shQcw==
X-Google-Smtp-Source: ABdhPJxXYAvxgL8WTm0nvfJvxtAVmwL7HljvS6BO4LfA3JDclObdn1BBcOsPrmDrvAD95FrbB9orkw==
X-Received: by 2002:a17:906:180c:b0:6fe:9a3e:3d5b with SMTP id
 v12-20020a170906180c00b006fe9a3e3d5bmr51790990eje.202.1655109014707; 
 Mon, 13 Jun 2022 01:30:14 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b659.dip0.t-ipconnect.de.
 [87.176.182.89]) by smtp.gmail.com with ESMTPSA id
 u4-20020a170906408400b006fee16142b9sm3532156ejj.110.2022.06.13.01.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jun 2022 01:30:14 -0700 (PDT)
Message-ID: <13337f06-0244-008d-4f9d-672a99206b69@gmail.com>
Date: Mon, 13 Jun 2022 10:30:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/amdkfd: simplify vm_validate_pt_pd_bos
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
References: <20220613075956.720375-1-Lang.Yu@amd.com>
 <55d98218-7032-5d29-fea7-afa7ff1e5ea6@amd.com>
 <Yqb0qO2mym1X9ha4@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <Yqb0qO2mym1X9ha4@lang-desktop>
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

Am 13.06.22 um 10:26 schrieb Lang Yu:
> On 06/13/ , Christian König wrote:
>> Am 13.06.22 um 09:59 schrieb Lang Yu:
>>> We don't need to validate and map root PD specially here,
>>> it would be validated and mapped by amdgpu_vm_validate_pt_bos
>>> if it is evicted.
>> I'm not sure if that's correct. Traditionally we have handled the root PD
>> differently to the rest in the VM.
>>
>> It doesn't make much sense any more today, but I need to double check if
>> that isn't still the case.
>  From my observations, if root PD is evicted. amdgpu_vm_validate_pt_bos
> will validate and map it.
>
> And amdgpu_cs_list_validate always validates root PD after
> amdgpu_vm_validate_pt_bos has done that, it is actually unnecessary.
> Do you think it's worth skiping root PD validation in
> amdgpu_cs_list_validate? Thanks!

No, it's just your change is completely irrelevant and just complicates 
things.

Validating a BO twice should have basically no overhead at all.

And especially adding the manual call to map_table() in 
amdgpu_vm_make_compute() is a no-go. We don't want such specific 
handling for compute contexts.

Regards,
Christian.

>
> Regards,
> Lang
>
>
>> Christian.
>>
>>> The special case is when turning a GFX VM to a compute VM,
>>> if vm_update_mode changed, we need to map the root PD again.
>>> So just move root PD mapping to amdgpu_vm_make_compute.
>>>
>>> v2:
>>>    - Don't rename vm_validate_pt_pd_bos and make it public.
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 --------------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           |  5 +++++
>>>    2 files changed, 5 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 6a3bd8b9a08f..3805eef9ab69 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -425,22 +425,8 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm)
>>>    		return ret;
>>>    	}
>>> -	ret = amdgpu_amdkfd_validate_vm_bo(NULL, pd);
>>> -	if (ret) {
>>> -		pr_err("failed to validate PD\n");
>>> -		return ret;
>>> -	}
>>> -
>>>    	vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>>> -	if (vm->use_cpu_for_update) {
>>> -		ret = amdgpu_bo_kmap(pd, NULL);
>>> -		if (ret) {
>>> -			pr_err("failed to kmap PD, ret=%d\n", ret);
>>> -			return ret;
>>> -		}
>>> -	}
>>> -
>>>    	return 0;
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 703552f9a6d7..08fda57f5aa2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -2225,6 +2225,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>>    	} else {
>>>    		vm->update_funcs = &amdgpu_vm_sdma_funcs;
>>>    	}
>>> +
>>> +	r = vm->update_funcs->map_table(to_amdgpu_bo_vm(vm->root.bo));
>>> +	if (r)
>>> +		goto unreserve_bo;
>>> +
>>>    	dma_fence_put(vm->last_update);
>>>    	vm->last_update = NULL;
>>>    	vm->is_compute_context = true;

