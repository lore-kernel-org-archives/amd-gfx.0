Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08B2C369C2
	for <amd-gfx@archiver.kernel.org>; Sat,  3 May 2025 20:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CDB10E21D;
	Sat,  3 May 2025 20:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hSyFqukW";
	dkim-atps=neutral
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA02310E21D
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 May 2025 20:31:55 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4811fca8658so39414931cf.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 03 May 2025 13:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746304314; x=1746909114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3sZ/NwHBlIDBdTnDlTGRHEqv3DqBT/6e5nIOCUdwvDo=;
 b=hSyFqukWQrLoPH5NFjJvp7xhYR1FiHLONyaDlMecanEM7D4zc8Qn+KL2RExsfq31sf
 1aiNon2A0r6h+W53tH7tiXx3j1lnINcEkr8H8HEvvtADp3vzsWCCXA5R82OclPWjHxJj
 UPzpnjasfNt5sjVfMwkNgrJQ8N7RQZe401kTwbfXHfNZI3ylOuCGkgVC3QmuRGlsLLs8
 QesKvyrj5qNaNhfGyblf6fB4Vyv+ImrrEfqREu64PHKcOiitbj/3za464ygXP4kIg/4x
 U4Y6fJiprpRTY32xXoVGgKVAFQ0mdbLNJuaQj9y/YR8NjoWI3PNitbnCLo+ff8xQGsm+
 SEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746304314; x=1746909114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3sZ/NwHBlIDBdTnDlTGRHEqv3DqBT/6e5nIOCUdwvDo=;
 b=lci8oP0fzzohBPZ3tO6fQ/cy281eyeQhGw6p/oVsxX12zYv9BcIbHpbr3qpUQQ1zK3
 0zkAOXkhM54lcKZ4lA+QKSchCHp/69guVmGSGOZQrDUCtRN8sv+686XXvgk7TrV5ahkp
 9sJ9E8hifXhYAmmVwXOy8+GlRBuSwyrRVjivrFdZPUW/tAEfGRtt0yybMm++EBJv0tW2
 wo+T4zf5lEv6F25mYOZ1RmevoLgKt1JuyxF877wddvQ2I6EyL+QHIkegFWqFxym+MWXc
 XKe87ExuhQQJKQsYaJkObTzLaPXqtCMw0EwrOxNAiYJ1EW1lmDpbCXOyV7SXiEsj/Tzg
 +now==
X-Gm-Message-State: AOJu0YySO1zitbcIghEJ7QHsOe7pFjTXBPjSHIdDJS/uAftkVqTYJEJ/
 yvxfBVwxlbhakyFkC7cqAR8/XJ+6furz5PWn3uGyrrDbqsy4k5pZ
X-Gm-Gg: ASbGncsXzZvzffRUgaJtVIxGqtXDw6NgAixxqS3UBMqtoz8bTeSX/KmXLZ6+S/DFXqe
 vzKqK53kagy4/Mo9IpeY6eZPrL6uSijb8zPaF38Bqpl+OEqoeRdZa+wGhXyGaHnM5CU5ET6RyWw
 8BI9yD6LHlfme3aaWcXQckwwwXugiUyYQLOzrWulC1FEH2eAb3ke1U5IseoqwqwJB1+Qap/ONdw
 l6NyP+VHsEAQjdpm6t5Drwys/2HMrNkJjY71Lknd0JF/LoeuZ1U0F6tTYcRrFwNQdecrW6sWEOs
 nTZEBRMkaGzhaNbIG39eGGkKBtQjzpVWfZxoqcCAza4U1lZAag==
X-Google-Smtp-Source: AGHT+IE2Tph6gR4vq2IjRY1jpW4sIHQhrHm6OnPPRVC5gNVTueuHjJ87wK7nboa2xqFqmpt8xQM/cQ==
X-Received: by 2002:a05:6214:5086:b0:6f4:c9a6:b53a with SMTP id
 6a1803df08f44-6f523778215mr51954186d6.26.1746304313945; 
 Sat, 03 May 2025 13:31:53 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6f50f3d2816sm35504196d6.57.2025.05.03.13.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 13:31:53 -0700 (PDT)
Message-ID: <7efe97e3-adac-417b-8f0d-50ec4b2589e0@gmail.com>
Date: Sat, 3 May 2025 16:31:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 5/2/25 4:36 AM, Christian König wrote:
> On 4/30/25 23:39, Alex Deucher wrote:
>> + Christian
>>
>> On Tue, Apr 29, 2025 at 7:25 AM John Olender <john.olender@gmail.com> wrote:
>>>
>>> If the vcpu bos are allocated outside the uvd segment,
>>> amdgpu_uvd_ring_test_ib() times out waiting on the ring's fence.
> 
> That's incorrect, but pointing to the correct solution.
> 
>>>
>>> See amdgpu_fence_driver_start_ring() for more context.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3851
>>> Signed-off-by: John Olender <john.olender@gmail.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 36 ++++++++++++++-----------
>>>  1 file changed, 21 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> index 74758b5ffc6c..a6b3e75ffa2d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>> @@ -139,15 +139,20 @@ static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo);
>>>
>>>  static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
>>>                                            uint32_t size,
>>> -                                          struct amdgpu_bo **bo_ptr)
>>> +                                          struct amdgpu_bo **bo_ptr,
>>> +                                          bool interruptible)
>>>  {
>>> -       struct ttm_operation_ctx ctx = { true, false };
>>> +       struct ttm_operation_ctx ctx = { interruptible, false };
>>>         struct amdgpu_bo *bo = NULL;
>>> +       u32 initial_domain = AMDGPU_GEM_DOMAIN_GTT;
>>>         void *addr;
>>>         int r;
>>>
>>> +       if (!interruptible && adev->uvd.address_64_bit)
>>> +               initial_domain |= AMDGPU_GEM_DOMAIN_VRAM;
>>> +
>>>         r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
>>> -                                     AMDGPU_GEM_DOMAIN_GTT,
>>> +                                     initial_domain,
>>>                                       &bo, NULL, &addr);
>>>         if (r)
>>>                 return r;
>>> @@ -319,19 +324,23 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>         if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
>>>                 bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
>>>
>>> +       /* from uvd v5.0 HW addressing capacity increased to 64 bits */
>>> +       if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>>> +               adev->uvd.address_64_bit = true;
>>> +
>>>         for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
>>>                 if (adev->uvd.harvest_config & (1 << j))
>>>                         continue;
>>> -               r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
>>> -                                           AMDGPU_GEM_DOMAIN_VRAM |
>>> -                                           AMDGPU_GEM_DOMAIN_GTT,
>>
>> I think we can just make this VRAM only.  Or something like:
>> adev->uvd.address_64_bit ? AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM
> 
> Yeah completely agree. It's a good catch, but the solution is incorrect.
> 
> On the older UVD MC interface the FW needs to be in VRAM or the validation fails. If it's inside the window for the message and fence is actually irrelevant.
> 
> So something like AMDGPU_GEM_DOMAIN_VRAM | (adev->uvd.address_64_bit ? AMDGPU_GEM_DOMAIN_GTT : 0) would be correct I think.
> 
>>
>> If that fixes it, this should be tagged with:
>> Fixes: 58ab2c08d708 ("drm/amdgpu: use VRAM|GTT for a bunch of kernel
>> allocations")
> 
> And CC stable I think.
> 
> Regards,
> Christian.
> 
>>
>> Alex
>>

Simply changing the uvd vcpu bo (and therefore the firmware) to always
be allocated in vram does *not* solve #3851.

Let me go into a bit of depth about how I arrived at this patch.

First, what sort of system configuration changes result in the uvd init
failure?  It looks like having a display connected and changing the BAR
size have an impact.  Next, which kernel change reliably triggers the
issue?  The change is the switch to the buddy allocator.

Now that the issue can be reliably triggered, where does the error code,
-110 / -ETIMEDOUT, come from?  It turns out it's in
amdgpu_uvd_ring_test_ib(), specifically a timeout while waiting on the
ring's fence.

With that out of the way, what allocator-related change happens when a
display is connected at startup?  The 'stolen_vga_memory' and related
bos are created.  Adding a one page dummy bo to the same place in the
driver can allow a headless configuration to now pass the uvd ring ib test.

Why does having these extra objects allocated result in a change in
behavior?  Well, the switch to the buddy allocator drastically changes
*where* in vram various objects end up being placed.  What about the BAR
size change?  That ends up influencing where the objects are placed too.

Which objects related to uvd end up being moved around?  The uvd code
has a function to force its objects into a specific segment after all.
Well, it turns out the vcpu bo doesn't go through this function and is
therefore being moved around.

When the system configuration results in a ring ib timeout, the uvd vcpu
bo is pinned *outside* the uvd segment.  When uvd init succeeds, the uvd
vcpu bo is pinned *inside* the uvd segment.

So, it appears there's a relationship between *where* the vcpu bo ends
up and the fence timeout.  But why does the issue manifest as a ring
fence timeout while testing the ib?  Unfortunately, I'm unable to find
something like a datasheet or developer's guide containing the finer
details of uvd.

Well, what seems related in the code?  Where is the ring fence located?
It's placed inside the vcpu bo by amdgpu_fence_driver_start_ring().

So, does this patch provide the correct solution to the problem?  Maybe
not.  But the solution seems plausible enough to at least send in the
patch for review.

Thanks,
John

>>> -                                           &adev->uvd.inst[j].vcpu_bo,
>>> -                                           &adev->uvd.inst[j].gpu_addr,
>>> -                                           &adev->uvd.inst[j].cpu_addr);
>>> +               r = amdgpu_uvd_create_msg_bo_helper(adev, bo_size,
>>> +                               &adev->uvd.inst[j].vcpu_bo, false);
>>>                 if (r) {
>>>                         dev_err(adev->dev, "(%d) failed to allocate UVD bo\n", r);
>>>                         return r;
>>>                 }
>>> +               adev->uvd.inst[j].gpu_addr =
>>> +                               amdgpu_bo_gpu_offset(adev->uvd.inst[j].vcpu_bo);
>>> +               adev->uvd.inst[j].cpu_addr =
>>> +                               amdgpu_bo_kptr(adev->uvd.inst[j].vcpu_bo);
>>>         }
>>>
>>>         for (i = 0; i < adev->uvd.max_handles; ++i) {
>>> @@ -339,11 +348,8 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>>                 adev->uvd.filp[i] = NULL;
>>>         }
>>>
>>> -       /* from uvd v5.0 HW addressing capacity increased to 64 bits */
>>> -       if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>>> -               adev->uvd.address_64_bit = true;
>>> -
>>> -       r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo);
>>> +       r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo,
>>> +                       true);
>>>         if (r)
>>>                 return r;
>>>
>>> @@ -1236,7 +1242,7 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>>         if (direct) {
>>>                 bo = adev->uvd.ib_bo;
>>>         } else {
>>> -               r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo);
>>> +               r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo, true);
>>>                 if (r)
>>>                         return r;
>>>         }
>>> --
>>> 2.47.2
>>>
> 

