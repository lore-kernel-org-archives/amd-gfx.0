Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED50C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 07:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E0B10E9F3;
	Tue,  8 Mar 2022 07:37:29 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB96010E9F3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 07:37:27 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 p184-20020a1c29c1000000b0037f76d8b484so879156wmp.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Mar 2022 23:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=hVBShet5goESY24Z/6eAN4zqt0kCmBslVXWKNLoE/EY=;
 b=Km/Oh+LlslEN7Ll4VUfKS33Boq90wW/NO4Lij3BEhrM+qYm7A9rTRJifPoUU952Bhs
 UZmWL8cd7y2SEsgr64+0XaUT69XOigGbqNA0Ag4kZjVyDhNkPtxmkxC1Q1SHQ0SE0I4m
 6XciLipTvAELFaYrZbdyPzS9lKMKvpM5U5uKdTFUwakGwUuSZ9BI1VdWcX6S1gXF0DVS
 W4uPx5Ajt4PEH6tNatr+PTV679udGalDtvDmKHyl1UBUHzPcWbjAWf1YRYBET7u5WzKw
 jy06mMNq2JkDc263aVqs/jChuwSypkpN05u3nVlKqV77g18Xp1IXkdLq5BUJHs7KzJIf
 aY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hVBShet5goESY24Z/6eAN4zqt0kCmBslVXWKNLoE/EY=;
 b=twVPtnEAgY/U2jRgaEyw172OPGb8CYliNOA8bhguSK2LU+gFDoQVGo2uCHruvAGi2f
 nDhvWtEZMdpg+DjADrfnCg0W/jrLxPDhscE7cEQCFVvJUPjMqjIaj1/VywJRKYRXg9Ec
 nHIYlO/aJpH4+TcK/n/khWe7JkgTAHZ/9P5V5QgOPlWFo8YLVvxwTSQ15Mbo3W4wjgH/
 5c8K0EVve411G+8k4JycsyAPcbNJ30PZyEKRmzYTGGFKvQJ0Bi/ZPdF8hIZToDv/YkDR
 hqMDHI32VugkovkFgIDpxJ9FJ5VRyDSSkPBjC101lCXFIEPgQcAiDhrsk7yW+sfTL29r
 is3Q==
X-Gm-Message-State: AOAM531kAOauZ2v6BkC/Gg9aCHBX1EOLwc8+TUu54Nk40wlVe72jWSZS
 ob5VcPERaXTb8oeldipm8Wazld64Cu4=
X-Google-Smtp-Source: ABdhPJz3XZYT9xfpr/FgAjZAzkV3ZUo9lAvXG846Z2yi3MowAAqqwwefhaN6G5jlxcdHYMYRi/yChA==
X-Received: by 2002:a05:600c:4f85:b0:382:e2bf:5fd2 with SMTP id
 n5-20020a05600c4f8500b00382e2bf5fd2mr2362752wmq.30.1646725046134; 
 Mon, 07 Mar 2022 23:37:26 -0800 (PST)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b00380deeaae72sm1937940wmb.1.2022.03.07.23.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Mar 2022 23:37:25 -0800 (PST)
Message-ID: <cbebb9b6-705e-e6fc-9ff0-41c35c3ee94b@gmail.com>
Date: Tue, 8 Mar 2022 08:37:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
 <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
 <YicG3THG9sem8Uet@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YicG3THG9sem8Uet@lang-desktop>
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
Cc: amd-gfx@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.03.22 um 08:33 schrieb Lang Yu:
> On 03/08/ , Christian König wrote:
>>
>> Am 08.03.22 um 04:39 schrieb Lang Yu:
>>> It is a hardware issue that VCN can't handle a GTT
>>> backing stored TMZ buffer on Raven.
>>>
>>> Move such a TMZ buffer to VRAM domain before command
>>> submission.
>>>
>>> v2:
>>>    - Use patch_cs_in_place callback.
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68 +++++++++++++++++++++++++++
>>>    1 file changed, 68 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> index 7bbb9ba6b80b..810932abd3af 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>> @@ -24,6 +24,7 @@
>>>    #include <linux/firmware.h>
>>>    #include "amdgpu.h"
>>> +#include "amdgpu_cs.h"
>>>    #include "amdgpu_vcn.h"
>>>    #include "amdgpu_pm.h"
>>>    #include "soc15.h"
>>> @@ -1905,6 +1906,72 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>>>    	.set_powergating_state = vcn_v1_0_set_powergating_state,
>>>    };
>>> +/**
>>> + * It is a hardware issue that Raven VCN can't handle a GTT TMZ buffer.
>>> + * Move such a GTT TMZ buffer to VRAM domain before command submission.
>>> + */
>>> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
>>> +				struct amdgpu_job *job,
>>> +				uint64_t addr)
>>> +{
>>> +	struct ttm_operation_ctx ctx = { false, false };
>>> +	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
>>> +	struct amdgpu_vm *vm = &fpriv->vm;
>>> +	struct amdgpu_bo_va_mapping *mapping;
>>> +	struct amdgpu_bo *bo;
>>> +	int r;
>>> +
>>> +	addr &= AMDGPU_GMC_HOLE_MASK;
>>> +	if (addr & 0x7) {
>>> +		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
>>> +	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
>>> +		return -EINVAL;
>>> +
>>> +	bo = mapping->bo_va->base.bo;
>>> +	if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
>>> +		return 0;
>>> +
>>> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>> +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>> +	if (r) {
>>> +		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
>>> +		return r;
>>> +	}
>> Well, exactly that won't work.
>>
>> The message structure isn't TMZ protected because otherwise the driver won't
>> be able to stitch it together.
>>
>> What is TMZ protected are the surfaces the message structure is pointing to.
>> So what you would need to do is to completely parse the structure and then
>> move on the relevant buffers into VRAM.
>>
>> Leo or James, can you help with that?
>  From my observations, when decoding secure contents, register
> GPCOM_VCPU_DATA0 and GPCOM_VCPU_DATA1 are set to a TMZ buffer address.
> And this way works when allocating TMZ buffers in GTT domain.

As far as I remember that's only the case for the decoding, encoding 
works by putting the addresses into the message buffer.

But could be that decoding is sufficient, Leo and James need to comment 
on this.

Regards,
Christian.

>
> Regards,
> Lang
>
>> Regards,
>> Christian.
>>
>>> +
>>> +	return r;
>>> +}
>>> +
>>> +static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>> +					   struct amdgpu_job *job,
>>> +					   struct amdgpu_ib *ib)
>>> +{
>>> +	uint32_t msg_lo = 0, msg_hi = 0;
>>> +	int i, r;
>>> +
>>> +	for (i = 0; i < ib->length_dw; i += 2) {
>>> +		uint32_t reg = amdgpu_ib_get_value(ib, i);
>>> +		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>>> +
>>> +		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
>>> +			msg_lo = val;
>>> +		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
>>> +			msg_hi = val;
>>> +		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
>>> +			r = vcn_v1_0_validate_bo(p, job,
>>> +					     ((u64)msg_hi) << 32 | msg_lo);
>>> +			if (r)
>>> +				return r;
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +
>>>    static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>>>    	.type = AMDGPU_RING_TYPE_VCN_DEC,
>>>    	.align_mask = 0xf,
>>> @@ -1914,6 +1981,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>>>    	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
>>>    	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
>>>    	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
>>> +	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>>>    	.emit_frame_size =
>>>    		6 + 6 + /* hdp invalidate / flush */
>>>    		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +

