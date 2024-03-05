Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A50C54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 09:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587DD10E178;
	Tue,  5 Mar 2024 09:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YTHi679Z";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B2BF10E185
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 09:14:08 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-33d0a7f2424so269961f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Mar 2024 01:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709630046; x=1710234846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J+cRdr5LiRnRYpoj7K5ALbCjwJRm5GkKz/w1J0DlYMU=;
 b=YTHi679ZsdpuFpKZga4dKugFQkeKfLVH5fPfx0JX/qgj44gI2nneJpF3HxKrWsVRmb
 V2GT2o30L4Gg8RHBAubY7WCvxUzgZB/BdefZCN1kZ4OMTy+LMY676KbvvXWzdwg9CsGY
 k3SwOPYzqgipcsQwmeaeYYgFqRimkdMk6eW0TJo9aquxz7zHQkkjrNZeUy5LWMh/1m6r
 Bzub/+wUlCrwXG2TXQFPFjlon/smF0ubvUGDLdR0JG65Omk39dGFuo0aCKFtw6zF6Kcr
 XgSN92C7qEfHWzPQifP1MJcP2dZv9DvPUv29Irp9Air4SksS7MnTm3OW1eIyP41zzdjx
 8sMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709630046; x=1710234846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J+cRdr5LiRnRYpoj7K5ALbCjwJRm5GkKz/w1J0DlYMU=;
 b=k2M5KuSenDsddPBqAdoFjV/ZUbcSLkkeL2WmS4dMSRUdYBYISyMkGD+vIvX9Q8FLwp
 JgEXMVVaVQqXQIEkAb8dsH0ZKO4n5OR9NGTuQhDB7k4LvXQBhSLMkVFqX028eRQsI1/2
 jK+81VMcC6jX+fF+vOrm/N0pb8yh+AYofI0wobZyywpGizMZ0XbQ2lo+YlMUJlORv0nQ
 qlybvuF+Li+a8R5nz5KiPANPjvb95kWIyjExLiEI1NoT5lw7ULUf+CcOFz05eCn/oY5u
 RmsVbxPL2reZbAA3z2ip0nBwFbOgDXXcXNwyWfiFbtbQo8khfUWzkxjKGQz6eoyCviK8
 3ehg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXiwDi/UlJ5GeNsjmVg4YjFCI4XZxN91BhJRFfH1s6c3AB5peAQphKlz6RkShGimysyrzVsuWMy6j0c148/lRgF5rpGVcq1rJAGtFR+Q==
X-Gm-Message-State: AOJu0YyObTig3z7MpQhNAZOIcdpuzS2hX6tL8Z+5w+RI6EnnaTHkpBli
 9yqG8COjObEsdzXLo+VhMOHW/Tl4hal9IuyLEbjUZi1srCGnVWoD
X-Google-Smtp-Source: AGHT+IHx2BeYoeRhmvVNnSYMqkK8fXx35THg6xGa+0SItX34bn3CdnSP4vkbqC4VxY2WDpTQD5UtxQ==
X-Received: by 2002:adf:ea42:0:b0:33d:adce:568a with SMTP id
 j2-20020adfea42000000b0033dadce568amr7370225wrn.33.1709630046326; 
 Tue, 05 Mar 2024 01:14:06 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 da8-20020a056000196800b0033b87c2725csm14331230wrb.104.2024.03.05.01.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 01:14:05 -0800 (PST)
Message-ID: <aacba67b-ecab-486b-9cc6-58f7867f792c@gmail.com>
Date: Tue, 5 Mar 2024 10:14:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: Add HDP flush to VCN v4.0.3
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, samir.dhume@amd.com,
 leo.liu@amd.com
References: <20240305064031.548905-1-lijo.lazar@amd.com>
 <ea7e75ed-0060-4c40-b43a-1baecadd4ef9@gmail.com>
 <f01dea79-b5fd-4026-8b87-8c333bb01c15@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <f01dea79-b5fd-4026-8b87-8c333bb01c15@amd.com>
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

Am 05.03.24 um 10:01 schrieb Lazar, Lijo:
> On 3/5/2024 2:22 PM, Christian König wrote:
>> Am 05.03.24 um 07:40 schrieb Lijo Lazar:
>>> VCN 4.0.3 cannot trigger HDP flush with RRMT enabled. Instead, trigger
>>> HDP flush from host side before ringing doorbell.
>> Well that won't work like that.
>>
>> The HDP flush is supposed to be emitted into the ring buffer of the
>> engine. If you just "emulate" it by a register write than that write
>> comes at the wrong time.
>>
>> This code here is seriously broken.
>>
> This approach was in fact suggested by VCN IP and FW team since RRMT is
> not working from VCN side to do a remote flush of HDP (HDP is active
> only in one of the AIDs). They mentioned that VCN doesn't need to flush
> HDP at the time of processing.

In this case you don't need to implement anything here.

See amdgpu_device_flush_hdp(), we already have the CPU fallback for the 
engines which don't have access to the HDP:

#ifdef CONFIG_X86_64
         if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
                 return;
#endif
         if (adev->gmc.xgmi.connected_to_cpu)
                 return;

         if (ring && ring->funcs->emit_hdp_flush)
                 amdgpu_ring_emit_hdp_flush(ring);
         else
                 amdgpu_asic_flush_hdp(adev, ring);

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 25 +++++++++++++++++++++++++
>>>    1 file changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> index 810bbfccd6f2..7b5ad13b618e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>> @@ -36,6 +36,7 @@
>>>    #include "vcn/vcn_4_0_3_offset.h"
>>>    #include "vcn/vcn_4_0_3_sh_mask.h"
>>>    #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
>>> +#include <uapi/linux/kfd_ioctl.h>
>>>      #define mmUVD_DPG_LMA_CTL        regUVD_DPG_LMA_CTL
>>>    #define mmUVD_DPG_LMA_CTL_BASE_IDX    regUVD_DPG_LMA_CTL_BASE_IDX
>>> @@ -1380,6 +1381,26 @@ static uint64_t
>>> vcn_v4_0_3_unified_ring_get_wptr(struct amdgpu_ring *ring)
>>>                        regUVD_RB_WPTR);
>>>    }
>>>    +static void vcn_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>> +{
>>> +    /* VCN engine access for HDP flush doesn't work when RRMT is
>>> enabled.
>>> +     * This is a workaround to avoid any HDP flush through VCN ring.
>>> Instead
>>> +     * HDP flush will be done by driver while submitting doorbell.
>>> +     */
>>> +}
>>> +
>>> +static void vcn_v4_0_3_flush_hdp(struct amdgpu_ring *ring)
>>> +{
>>> +    struct amdgpu_device *adev = ring->adev;
>>> +
>>> +#ifdef CONFIG_X86_64
>>> +    if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev))
>>> +        return;
>>> +#endif
>>> +    if (ring->wptr)
>>> +        WREG32_NO_KIQ((adev->rmmio_remap.reg_offset +
>>> KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
>>> +}
>>> +
>>>    /**
>>>     * vcn_v4_0_3_unified_ring_set_wptr - set enc write pointer
>>>     *
>>> @@ -1394,6 +1415,9 @@ static void
>>> vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>        if (ring != &adev->vcn.inst[ring->me].ring_enc[0])
>>>            DRM_ERROR("wrong ring id is identified in %s", __func__);
>>>    +    /* Flush HDP before ringing doorbell */
>>> +    vcn_v4_0_3_flush_hdp(ring);
>>> +
>>>        if (ring->use_doorbell) {
>>>            *ring->wptr_cpu_addr = lower_32_bits(ring->wptr);
>>>            WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
>>> @@ -1420,6 +1444,7 @@ static const struct amdgpu_ring_funcs
>>> vcn_v4_0_3_unified_ring_vm_funcs = {
>>>        .emit_ib = vcn_v2_0_enc_ring_emit_ib,
>>>        .emit_fence = vcn_v2_0_enc_ring_emit_fence,
>>>        .emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
>>> +    .emit_hdp_flush = vcn_v4_0_3_ring_emit_hdp_flush,
>>>        .test_ring = amdgpu_vcn_enc_ring_test_ring,
>>>        .test_ib = amdgpu_vcn_unified_ring_test_ib,
>>>        .insert_nop = amdgpu_ring_insert_nop,

