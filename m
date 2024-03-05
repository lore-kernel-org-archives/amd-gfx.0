Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408ECC54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 09:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9944112981;
	Tue,  5 Mar 2024 09:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QL4VxotI";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35CB11297D
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 09:18:16 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-33ddd1624beso3517273f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Mar 2024 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709630295; x=1710235095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1wnnDCuevAWEv8/1aqb/aSMZJ+ekGepksubADplsek0=;
 b=QL4VxotI39wJTH+8SMjjGv8M5Nsa3VoavNYrcQzXXFUpaojK1cK9V1iisduNhC660V
 JGOrRj9XUYfZYVyvA48q7+yBdVOhfKAFiZqPS1HkBZXaXKfPFcXhsTWyvPHgkasehlfW
 DuYq09FyAH/Q6uYgqs32g6iEjPyJ7PLQUzN5b0dyl7I78FEcFLaCLbfLFop8juEdJj5E
 EbSX8xNkH4NA9lIbonQaCZAQoyBhWquXf+OSBjF1wcZm+RVRSItyPKGan/UcYyXJZ2eP
 cheISKQYdq4iBhPNxdBXNvHVNViKS69taXTijCIz3e4zwZflRi0+0gwagoVF558IcDNO
 S1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709630295; x=1710235095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1wnnDCuevAWEv8/1aqb/aSMZJ+ekGepksubADplsek0=;
 b=JuH73UgG7b/7zfthoBoYb3ehsaqCuVr3k7fJikoRuLAI7ufilCW0tCc15sTKf7qZ2u
 2gC44lLFbKEnEqdbfpXCCo6kjUr1yNSpf0eUdIGyR91wPLqcFCF885PN2eWIn4xllPua
 lbGFR05r+ANl2JUC1A73XD+mjs6a12obDm/QJz3ylvKmUBdEnRzF130FBoIKOAdPod70
 IZx7Za2D9mRZnd3HgJopx6tWoXdGrl9NfhNIYxZxeCR/TrKE434RTrrl9FjY5NOvfbLL
 l17smSYMbSoUxr3evhsIPkoMR7oWsCs+QNWlbUvoGqrMs/hnPespPFpr+6FmXKhO9DZV
 B8AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+rJoNT90A9zxa7qwiL4inzVQXjn2uQcEqvxA3CGw621g3G7b+TuvYHHEaCpFw0Mv9ORsp0qMM6KReP+rcjfYUDD6hrGU3uGO6NWce9w==
X-Gm-Message-State: AOJu0YwDgBHXEMf6HSuZ0qgO8qYNn0z0zx1Vv2o6EzX12Y9UuXJdkWM1
 fdjq5g/zB0hsXxGsAmoBWVj3IslAQeQxSZt1lTSKiuBKWlfyCRTf05Oaexc9pmg=
X-Google-Smtp-Source: AGHT+IGsLndR5WlhIKu0ugXPzawOuM2AOS6i5wM+ABN5BT3aGKZrL4qPzlh8zhxZU46lL5niVH6vCg==
X-Received: by 2002:adf:a792:0:b0:33e:4865:9ced with SMTP id
 j18-20020adfa792000000b0033e48659cedmr1531016wrc.2.1709630292656; 
 Tue, 05 Mar 2024 01:18:12 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a5d634b000000b0033d6fe3f6absm14269794wrw.62.2024.03.05.01.18.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 01:18:12 -0800 (PST)
Message-ID: <bcbec910-fcc4-4b84-a74b-6b6b0db0907c@gmail.com>
Date: Tue, 5 Mar 2024 10:18:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Use offsets local to VCN in VF
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, samir.dhume@amd.com,
 leo.liu@amd.com
References: <20240305064031.548905-1-lijo.lazar@amd.com>
 <20240305064031.548905-2-lijo.lazar@amd.com>
 <6d178a2f-c404-422f-b5ee-1a138f8826e9@gmail.com>
 <ac9f28d4-ab49-4143-8b2c-c226d6323a16@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ac9f28d4-ab49-4143-8b2c-c226d6323a16@amd.com>
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

Am 05.03.24 um 10:03 schrieb Lazar, Lijo:
>
> On 3/5/2024 2:24 PM, Christian König wrote:
>>
>> Am 05.03.24 um 07:40 schrieb Lijo Lazar:
>>> For VCN 4.0.3, use only the local addressing scheme while in VF
>>> mode. This includes addressing scheme used for HUB offsets.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 20 +++++++++++++++++++-
>>>    1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> index 7b5ad13b618e..a27f3f260aab 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> @@ -1381,6 +1381,24 @@ static uint64_t
>>> vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>>>                        regUVD_RB_WPTR);
>>>    }
>>>    +static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring
>>> *ring,
>>> +                unsigned int vmid, uint64_t pd_addr)
>>> +{
>>> +    struct amdgpu_vmhub *hub;
>>> +
>>> +    /* For VF, only local offsets should be used */
>>> +    if (amdgpu_sriov_vf(ring->adev))
>>> +        ring->vm_hub = AMDGPU_MMHUB0(0);
>> That is clearly a no-go since the vm_hub must be statically and can't be
>> changed here.
>>
> After HUB allocation, the only usage of this hub pointer is to calculate
> use the right offset. We still want VCN to use the right hub, only thing
> is register offsets in MMHUB(0) are equal to 'local offsets'.

The vm_hub is a static setup describing how the engine works. You 
basically just insert an illegal value here to fix your register offset 
calculation.

That is absolutely *not* something you can do.

What exactly is the requirement?

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>> +    hub = &ring->adev->vmhub[ring->vm_hub];
>>> +
>>> +    pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>>> +
>>> +    /* wait for reg writes */
>>> +    vcn_v2_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
>>> +                    vmid * hub->ctx_addr_distance,
>>> +                    lower_32_bits(pd_addr), 0xffffffff);
>>> +}
>>> +
>>>    static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>    {
>>>        /* VCN engine access for HDP flush doesn't work when RRMT is
>>> enabled.
>>> @@ -1443,7 +1461,7 @@ static const struct amdgpu_ring_funcs
>>> vcn_v4_0_3_unified_ring_vm_funcs = {
>>>        .emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
>>>        .emit_ib = vcn_v2_0_enc_ring_emit_ib,
>>>        .emit_fence = vcn_v2_0_enc_ring_emit_fence,
>>> -    .emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
>>> +    .emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
>>>        .emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>>>        .test_ring = amdgpu_vcn_enc_ring_test_ring,
>>>        .test_ib = amdgpu_vcn_unified_ring_test_ib,

