Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032AFEE6454
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 10:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905AB10E612;
	Fri, 15 Sep 2023 10:19:21 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A7E10E61A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 10:19:19 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31f6ddb3047so1808736f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 03:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694773157; x=1695377957; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sK9Eyjty3WcSPQgzQfhXSPOXZAdD5UkhlLQAAi98pcA=;
 b=Kr5+QmCuGZx9cN24MzOKYZ8NBXh43+H8mHl5l4eLod5AThvxzh0MtXQySv1Xmx8tK5
 FD9KndpPdV8/JApk4EcwWqLMFP+SsZxXBgvuMfyUc0nHGLcbb3OkDJpMLcuy9xN8Zim8
 ZQj+MvU5/8RFyWSae0d9CMH4rp4yDuTnBOSxTaJZR70U3x2Lf8ymUlWmVaZ59NTqghCu
 z9BfHxbKmWZg7JXfroxorxMl5eUcgpNbKiQY0FSnc7Ov09uPP+83BneCi5A197ibGLF0
 gk6jhvPKxupfzKHgEUxDfVbm0ScqR2SWqM1tQaaFVWNbm2/6s00x20yyRm2ARoJXFpWZ
 WyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694773157; x=1695377957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sK9Eyjty3WcSPQgzQfhXSPOXZAdD5UkhlLQAAi98pcA=;
 b=c5phKAPAsdW9igAkwJjultVIVpcgMrSNQqbSeXfMCuWChiA+mEdpy7Z+bYIhnFEhn7
 /tZ8MuoQVi31eDSuELubTflZzT3+c+2yYDLtpu1KCqXiiY4AA6lAuPg1zz5HOyTREBq1
 F9sBplk8C2pr7/oivOsZsFILdVZPAvD4vvMtB8R077OYOxK2vsuFOY150V5BOrr5wWV/
 /Q+z6NmutRaC8aPgDs2B8LV3KDELcKaupIaevqbXQ+UX44QBmpouMkRFQpdqcrSu384F
 ejRJDtZxHo12/+ZjSEOpMD23Z2hu9lgKqbdp7c9fzlJqi3dl+ULikqhyHxURn/UBflUi
 UCxQ==
X-Gm-Message-State: AOJu0YwT04hzcXHJBsZAa1gVoZIdg1Dle1PcakLV0BeFX1kFwhCWjKS9
 l+TbUtwkxRhAnCCAVuRFSqw=
X-Google-Smtp-Source: AGHT+IHB2R8E1JJhdEyHIDzJJv9xzmQEjZsoALFdszxJJyova8my7tMp6WkYUw4nrIO1rC9lZYwwlg==
X-Received: by 2002:a5d:6309:0:b0:315:9e1b:4ea6 with SMTP id
 i9-20020a5d6309000000b003159e1b4ea6mr846507wru.58.1694773157085; 
 Fri, 15 Sep 2023 03:19:17 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a5d6585000000b0031accc7228asm4101670wru.34.2023.09.15.03.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 03:19:16 -0700 (PDT)
Message-ID: <39f0c4d9-0959-73ed-9bca-43a342fb906a@gmail.com>
Date: Fri, 15 Sep 2023 12:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] drm/amdgpu: always use legacy tlb flush on
 cyan_skilfish
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
References: <20230914092350.3512016-1-Lang.Yu@amd.com>
 <40c096af-6c59-ce6d-af26-5cce7bceab83@amd.com>
 <1317e1a5-b1c0-2c3d-6082-b628fde5ab4d@amd.com>
 <745145aa-76fb-bb17-6065-c5e29c37f3c6@amd.com>
 <e7913001-ff45-169d-7110-3f2bef86208a@amd.com>
 <ZQQbmfuivo/F+b9o@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ZQQbmfuivo/F+b9o@lang-desktop>
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
 Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.09.23 um 10:53 schrieb Lang Yu:
> On 09/14/ , Felix Kuehling wrote:
>> On 2023-09-14 10:02, Christian König wrote:
> Do we still need to use legacy flush to emulate heavyweight flush
> if we don't use SVM? And can I push this now?

Felix needs to decide that. From what I understand the KFD needs 
heavyweight flushes for secure SVM operation.

If heavyweight flushes are buggy papering over that by using legacy 
flushes is only a mediocre workaround.

Regards,
Christian.

>
> Regards,
> Lang
>
>
>>> Am 14.09.23 um 15:59 schrieb Felix Kuehling:
>>>> On 2023-09-14 9:39, Christian König wrote:
>>>>> Is a single legacy flush sufficient to emulate an heavyweight
>>>>> flush as well?
>>>>>
>>>>> On previous generations we needed to issue at least two legacy
>>>>> flushes for this.
>>>> I assume you are referring to the Vega20 XGMI workaround. That is a
>>>> very different issue. Because PTEs would be cached in L2, we had to
>>>> always use a heavy-weight flush that would also flush the L2 cache
>>>> as well, and follow that with another legacy flush to deal with race
>>>> conditions where stale PTEs could be re-fetched from L2 before the
>>>> L2 flush was complete.
>>> No, we also have another (badly documented) workaround which issues a
>>> legacy flush before each heavy weight on some hw generations. See the my
>>> TLB flush cleanup patches.
>>>
>>>> A heavy-weight flush guarantees that there are no more possible
>>>> memory accesses using the old PTEs. With physically addressed caches
>>>> on GFXv9 that includes a cache flush because the address translation
>>>> happened before putting data into the cache. I think the address
>>>> translation and cache architecture works differently on GFXv10. So
>>>> maybe the cache-flush is not required here.
>>>>
>>>> But even then a legacy flush probably allows for in-flight memory
>>>> accesses with old physical addresses to complete after the TLB
>>>> flush. So there is a small risk of memory corruption that was
>>>> assumed to not be accessed by the GPU any more. Or when using IOMMU
>>>> device isolation it would result in IOMMU faults if the DMA mappings
>>>> are invalidated slightly too early.
>>> Mhm, that's quite bad. Any idea how to avoid that?
>> A few ideas
>>
>>   * Add an arbitrary delay and hope that it is longer than the FIFOs in
>>     the HW
>>   * Execute an atomic operation to memory on some GPU engine that could
>>     act as a fence, maybe just a RELEASE_MEM on the CP to some writeback
>>     location would do the job
>>   * If needed, RELEASE_MEM could also perform a cache flush
>>
>> Regards,
>>    Felix
>>
>>
>>> Regards,
>>> Christian.
>>>
>>>> Regards,
>>>>    Felix
>>>>
>>>>
>>>>> And please don't push before getting an rb from Felix as well.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>
>>>>> Am 14.09.23 um 11:23 schrieb Lang Yu:
>>>>>> cyan_skilfish has problems with other flush types.
>>>>>>
>>>>>> v2: fix incorrect ternary conditional operator usage.(Yifan)
>>>>>>
>>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>>> Cc: <stable@vger.kernel.org> # v5.15+
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 ++++++-
>>>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> index d3da13f4c80e..c6d11047169a 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>> @@ -236,7 +236,8 @@ static void
>>>>>> gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t
>>>>>> vmid,
>>>>>>    {
>>>>>>        bool use_semaphore =
>>>>>> gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
>>>>>>        struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>>>>> -    u32 inv_req =
>>>>>> hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
>>>>>> +    u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid,
>>>>>> +              (adev->asic_type != CHIP_CYAN_SKILLFISH) ?
>>>>>> flush_type : 0);
>>>>>>        u32 tmp;
>>>>>>        /* Use register 17 for GART */
>>>>>>        const unsigned int eng = 17;
>>>>>> @@ -331,6 +332,8 @@ static void
>>>>>> gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t
>>>>>> vmid,
>>>>>>          int r;
>>>>>>    +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH)
>>>>>> ? flush_type : 0;
>>>>>> +
>>>>>>        /* flush hdp cache */
>>>>>>        adev->hdp.funcs->flush_hdp(adev, NULL);
>>>>>>    @@ -426,6 +429,8 @@ static int
>>>>>> gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>>>>>        struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
>>>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>>>>    +    flush_type = (adev->asic_type != CHIP_CYAN_SKILLFISH)
>>>>>> ? flush_type : 0;
>>>>>> +
>>>>>>        if (amdgpu_emu_mode == 0 && ring->sched.ready) {
>>>>>>            spin_lock(&adev->gfx.kiq[0].ring_lock);
>>>>>>            /* 2 dwords flush + 8 dwords fence */

