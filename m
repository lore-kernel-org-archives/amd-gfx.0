Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8E7C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 12:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41FC910E283;
	Tue,  4 Apr 2023 12:47:27 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816F610E283
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 12:47:25 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id r11so32655250wrr.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Apr 2023 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680612443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hvNLg7hq8s4BwIul17R1HQG9uj18d+Iir0cRzgmywlU=;
 b=WN32N6MZmP9jHfXPGPQCG5qR0eZsLO1N5nQ3NP+Y8mLSm4lOyC8xHZtdkhSj6cJ1FF
 kdulSDdZAkauuhzdwMgdzl4txfnaBA6fxCz2P6x4FpXabkuvzj5jCeKunPVu0OPQB4rL
 Z486nPO1gbP5Jt0nDAAqIywFnagXtctCyT2Z4eygQU43vTev6ijWgK4TpC8wWzW9OWSp
 XTGSZNCiqqzsMn+30tA43JssHcIS4k+TOwQtDD2jvrZPmfSQ52UebEIZpA/FKVepNDfw
 d9ipwWPYCghOKj2bPCleVTfI3a1na6wFCEBDc5SbPpcsalw1sbCi2x7wHXxxCWRQgvTe
 Eu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680612443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hvNLg7hq8s4BwIul17R1HQG9uj18d+Iir0cRzgmywlU=;
 b=g4rRmdnL6dEjyTawLl92Z7QeiwJnIgTZgE5ZkxE+Ay8OvzWuK9QfhtQhM+4h4kBJbu
 KnRnqgo8js7s/00tmMbKT3eLzCuJPD5MPL7Ym5hp475Zz8TfZ0akPl32y6TkCVD4190/
 PRi6dgou3BG5O3jjbbCFCN9trBJV9eV9pUCELkcKtdEhB3a71BCHFzRNZM5HatJsSrZ/
 RTfa6orh+uhsKs9Bg+ucss8wQxG45/1DCgweV+5JBthgWXchzQnwUeznH7u3GreHszgT
 iK2FtAHm7k9uY5lkA62So0AnV8xnjE1NISpxKWzqA+bvYprv/Ko6v9cFQiuZmoJ1zaET
 fgfQ==
X-Gm-Message-State: AAQBX9dgq0kNd4qZx+HsSXPu8Kf1oO6jsn4inDlvUrBTMLtaUksEH6W5
 eHgdJ3BtV1VtUWj9vh/v7pE=
X-Google-Smtp-Source: AKy350YQ4LP8ySWs2gQ/ndeHb0WKxgZAHBqEkPLID0mycev5brYUY7ZPCp7OaLlIYfLdY8Q6ntUFHA==
X-Received: by 2002:adf:eb46:0:b0:2cf:f2f9:df7a with SMTP id
 u6-20020adfeb46000000b002cff2f9df7amr1491632wrn.38.1680612443447; 
 Tue, 04 Apr 2023 05:47:23 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c161500b003ef4cd057f5sm21565191wmn.4.2023.04.04.05.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Apr 2023 05:47:22 -0700 (PDT)
Message-ID: <c5bd045a-a5ff-36ea-ed9b-bc4732b50b16@gmail.com>
Date: Tue, 4 Apr 2023 14:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs when
 iommu is on
Content-Language: en-US
To: "Xiao, Shane" <shane.xiao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20230404095640.3277840-1-shane.xiao@amd.com>
 <cd5efdb0-d6f6-8e91-353f-35906a1fe62f@amd.com>
 <DM4PR12MB5261B08BE4730541920230F89D939@DM4PR12MB5261.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB5261B08BE4730541920230F89D939@DM4PR12MB5261.namprd12.prod.outlook.com>
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
Cc: "Liu, Aaron" <Aaron.Liu@amd.com>, "Guo, Shikai" <Shikai.Guo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.04.23 um 12:56 schrieb Xiao, Shane:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, April 4, 2023 6:27 PM
>> To: Xiao, Shane <shane.xiao@amd.com>; amd-gfx@lists.freedesktop.org;
>> Kuehling, Felix <Felix.Kuehling@amd.com>
>> Cc: Liu, Aaron <Aaron.Liu@amd.com>; Guo, Shikai <Shikai.Guo@amd.com>
>> Subject: Re: [PATCH 1/3] drm/amdgpu: Add userptr bo support for mGPUs
>> when iommu is on
>>
>> Am 04.04.23 um 11:56 schrieb Shane Xiao:
>>> For userptr bo with iommu on, multiple GPUs use same system memory dma
>>> mapping address when both bo_adev and adev in identity mode or in the
>>> same iommu group.
> Hi Christian,
>
>> WTF? Userptr BOs are not allowed to be exported/imported between different
>> GPUs.
>>
>> So how can the same userptr BO be used on different GPUs?
> If GPUs are all in iommu identity mode which means dma address are the same as physical address,  all of the GPUs can see the system memory directly.
>
> In such case, should we export/import the BO,  then create a new SG BO for another GPU?

Yes, absolutely. Each userptr BO is only meant to be used on one GPU.

Even if you could use the same BO for multiple GPUs it's not necessary a 
good idea since you then have live time problems for example.

E.g. what happens when one GPU is hot removed while the other one who 
imported the BO is still in use?

Felix can you comment on that? My recollection was that we rather 
improve the storage of DMA addresses instead of duplicating the BOs over 
different GPUs.

Regards,
Christian.

>
>
> Best Regards,
> Shane
>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index e7403f8e4eba..33cda358cb9e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -804,11 +804,11 @@ static int kfd_mem_attach(struct amdgpu_device
>> *adev, struct kgd_mem *mem,
>>>    			 va + bo_size, vm);
>>>
>>>    		if ((adev == bo_adev && !(mem->alloc_flags &
>> KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) ||
>>> -		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) &&
>> adev->ram_is_direct_mapped) ||
>>> -		    same_hive) {
>>> +		    (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm) &&
>> ((adev->ram_is_direct_mapped && bo_adev->ram_is_direct_mapped) ||
>>> +			adev->dev->iommu_group == bo_adev->dev-
>>> iommu_group)) ||
>>> +same_hive){
>>>    			/* Mappings on the local GPU, or VRAM mappings in
>> the
>>> -			 * local hive, or userptr mapping IOMMU direct map
>> mode
>>> -			 * share the original BO
>>> +			 * local hive, or userptr mapping in the same dma
>>> +			 * address space share the original BO
>>>    			 */
>>>    			attachment[i]->type = KFD_MEM_ATT_SHARED;
>>>    			bo[i] = mem->bo;

