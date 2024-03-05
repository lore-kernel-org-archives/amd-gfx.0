Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFC3C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 09:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43A311129A2;
	Tue,  5 Mar 2024 09:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PsdaDbwF";
	dkim-atps=neutral
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789411129A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 09:42:17 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-2d2305589a2so82683711fa.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Mar 2024 01:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709631735; x=1710236535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/B1CATCjWx/6SesoSZRpmHgPR+F5dmcpAzxKN27q4mE=;
 b=PsdaDbwFgarlGXLgRlv1nxUu6Gh4jcnVkFQ0g0P3V5tPFmRG6g0XycHr53Cltp411t
 QDaxBcrQNsin7++5T15DSpm/CG4Y9yN6vACoSX8qpenHqoC/wHtYY325p6Fezzaj0Izl
 zLkbn7HijUVu24V1IsZTRqXKPxb0rKqPECnxJnyITva0sEAr35CWtwVuPFO1Gyr8mo5f
 TvjGtpq1M6fZc10YeNaHnpzDb7YmuWCoqkSwL78BEHo7c4cxTQCi+LGtweQ3Rq6Hu0QX
 oMm0yp8yFw+qrYI8IF8FJItB/XHN5xG7RVx67QCM/P2wTyZXJ64okyJ7rkLUQKIMzdWF
 lbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709631735; x=1710236535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/B1CATCjWx/6SesoSZRpmHgPR+F5dmcpAzxKN27q4mE=;
 b=hiBbaoyebHfU4okgR0p3zT2w8sec7uWQxdn/bKtAT6HoYos2u3W2nNQ5AUWJiNctd0
 QVqP4wqpsLYI4pOh0cHj0DGnZ/5yOwiZLHO1WZcOr3d588R+fByi1Uh7YdG01LrueqHm
 XFHH3eK4gramFuCfwpWwcZYVzbSrLFvNfO6YgrsftdlqkIZlY3/J2TptPwwmKqmdzeJS
 2i64jA/gm/Kpm9pw9eCZIP0wRTLaJPWbBO1NVHUC8mSbkTGL5XRTTr2L+QLmqlDfdxkK
 BnbBtJqFzYzS0NZehqzPxNAitG/HuSsuR/7HSS14dxv0THBTaBDqbZPuyZPNCDluolXo
 X+JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWww/A2CyLXKIGdJo/8VmT4rz5thFwm5DQyMIvJtLgMoQIsW2H0cy0si+MmQKy+3bCKE1UPh9tk+q7DXLz8CEOrVUkRNoQ4JfaGLFDMDQ==
X-Gm-Message-State: AOJu0YzOt+eSGtHIZ/dHnya8+jxEwv4JciS83FUG97GZCoAeV69v0Jbn
 2fbViKMGrJj5mxrWtAfv6eeZ2XDTnAObVcnrJaeAXnCi+JWswHOmS38ii3MI3rg=
X-Google-Smtp-Source: AGHT+IH4krJrBfJ2BQx0grb+vqZVwBb3sTtTLLlZswEgUI3Gx+6LonMXlMktfcxhm/4ESbjVa7lCUg==
X-Received: by 2002:a2e:3a09:0:b0:2d3:9314:24d5 with SMTP id
 h9-20020a2e3a09000000b002d3931424d5mr814426lja.32.1709631735055; 
 Tue, 05 Mar 2024 01:42:15 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 q9-20020adf9dc9000000b0033e192a5852sm12359080wre.30.2024.03.05.01.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 01:42:14 -0800 (PST)
Message-ID: <36bf8877-2ffa-428b-bea6-b9df921b64b7@gmail.com>
Date: Tue, 5 Mar 2024 10:42:12 +0100
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
 <bcbec910-fcc4-4b84-a74b-6b6b0db0907c@gmail.com>
 <327ef17d-78ec-45aa-9525-dd50d9463d17@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <327ef17d-78ec-45aa-9525-dd50d9463d17@amd.com>
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

Am 05.03.24 um 10:33 schrieb Lazar, Lijo:
> On 3/5/2024 2:48 PM, Christian König wrote:
>> Am 05.03.24 um 10:03 schrieb Lazar, Lijo:
>>> On 3/5/2024 2:24 PM, Christian König wrote:
>>>> Am 05.03.24 um 07:40 schrieb Lijo Lazar:
>>>>> For VCN 4.0.3, use only the local addressing scheme while in VF
>>>>> mode. This includes addressing scheme used for HUB offsets.
>>>>>
>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 20 +++++++++++++++++++-
>>>>>     1 file changed, 19 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> index 7b5ad13b618e..a27f3f260aab 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> @@ -1381,6 +1381,24 @@ static uint64_t
>>>>> vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>>>>>                         regUVD_RB_WPTR);
>>>>>     }
>>>>>     +static void vcn_v4_0_3_enc_ring_emit_vm_flush(struct amdgpu_ring
>>>>> *ring,
>>>>> +                unsigned int vmid, uint64_t pd_addr)
>>>>> +{
>>>>> +    struct amdgpu_vmhub *hub;
>>>>> +
>>>>> +    /* For VF, only local offsets should be used */
>>>>> +    if (amdgpu_sriov_vf(ring->adev))
>>>>> +        ring->vm_hub = AMDGPU_MMHUB0(0);
>>>> That is clearly a no-go since the vm_hub must be statically and can't be
>>>> changed here.
>>>>
>>> After HUB allocation, the only usage of this hub pointer is to calculate
>>> use the right offset. We still want VCN to use the right hub, only thing
>>> is register offsets in MMHUB(0) are equal to 'local offsets'.
>> The vm_hub is a static setup describing how the engine works. You
>> basically just insert an illegal value here to fix your register offset
>> calculation.
>>
>> That is absolutely *not* something you can do.
>>
>> What exactly is the requirement?
>>
> The requirement is this way -
>
> We have multiple MMHUBs and each VCN can talk only to the local MMHUB.
>
> The absolute register offsets we store for each for an example reg at
> offset x is
> 	HUB0 = x, HUB1 = x + Y (stride), HUB2 = x + 2Y and so forth.
>
> However VCN cannot use the absolute register offset in the packet in VF
> mode, instead it should use a local offset for the local HUB in VF mode.
> A local offset of a register in the HUB is exactly the same as offset of
> HUB0 = x.
>
> What we do here is assign the HUB as regular here
> 	ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
>
> so that amdgpu_gmc_allocate_vm_inv_eng is allocated in the right way.
>
> Then at the time of flush, switch it back to point to HUB0 so that it
> uses the offsets of HUB0 in the packet. Actually, it's not required to
> switch this every time, one-time is fine after
> amdgpu_gmc_allocate_vm_inv_eng() is complete.

Yeah, but that is not something we can do. vm_hub is a constant and 
should never be manipulated to fulfill a requirement like that.

If the VCN engines requires that we don't use the aid offsets in the 
VCN_ENC_CMD_REG_WRITE and VCN_ENC_CMD_REG_WAIT packets then we need to 
adjust those packets and not the vm_hub.

Also please sync up such with with Leo, he is responsible for 
coordinating all MM work on the kernel. In general the VCN team should 
never contact your team directly with such requirements.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>> Thanks,
>>> Lijo
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +    hub = &ring->adev->vmhub[ring->vm_hub];
>>>>> +
>>>>> +    pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
>>>>> +
>>>>> +    /* wait for reg writes */
>>>>> +    vcn_v2_0_enc_ring_emit_reg_wait(ring, hub->ctx0_ptb_addr_lo32 +
>>>>> +                    vmid * hub->ctx_addr_distance,
>>>>> +                    lower_32_bits(pd_addr), 0xffffffff);
>>>>> +}
>>>>> +
>>>>>     static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>>>     {
>>>>>         /* VCN engine access for HDP flush doesn't work when RRMT is
>>>>> enabled.
>>>>> @@ -1443,7 +1461,7 @@ static const struct amdgpu_ring_funcs
>>>>> vcn_v4_0_3_unified_ring_vm_funcs = {
>>>>>         .emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
>>>>>         .emit_ib = vcn_v2_0_enc_ring_emit_ib,
>>>>>         .emit_fence = vcn_v2_0_enc_ring_emit_fence,
>>>>> -    .emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
>>>>> +    .emit_vm_flush = vcn_v4_0_3_enc_ring_emit_vm_flush,
>>>>>         .emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>>>>>         .test_ring = amdgpu_vcn_enc_ring_test_ring,
>>>>>         .test_ib = amdgpu_vcn_unified_ring_test_ib,

