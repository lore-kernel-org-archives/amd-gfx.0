Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AC5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 09:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04E410E538;
	Wed, 16 Mar 2022 09:41:41 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7740910E538
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 09:41:40 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id pv16so3016800ejb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=RQYirHwvhmIuItSWRGIX96Iau4gBR4+08mHtVrf4Vc4=;
 b=MUkRHPitHPi0q4bgpz/CzxLJSYwTfn1n1hzujhq63tlutcnepTsXtAdpy9M4/K26GY
 HSrP4jjLl0qmvfiqrkedIeHW5Yup9OSv2n4F5K7dYgyU70tu4TuE2o9rzbngADCGEDfw
 noHrItx/4rvCGAT7kQE9wAC/kO59hpl71XJZcjPfFRNOfzIGBaX1HymOcq9Xdk1UU0UI
 ZGSvPgITWH1bBCUuZ1YSsQA4LzzRexA+rboALnUNh7u7jU3YlUEyXu4b0P28ikUQEjVI
 HgDJcY1DGQYuSqFzeFEBf44BS21xgM+qoHonpMDX2f7o7cAv4yrjS7Jlg/U01rbj+l6C
 B/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=RQYirHwvhmIuItSWRGIX96Iau4gBR4+08mHtVrf4Vc4=;
 b=KzCgMPJY8M5488WY8DAIAoe8QvWIeu9dOnkS0Q3B7s9kpQYMRBdqiWUE1TJHr6Xoqd
 6pPM0Z6Qb2fK/KBlGHVRaAGlROHTmWWFgzoQrrK4oPKI6kyUVswVwJ07tH+KHDxTuqYS
 VgUMeB1z6kAxMwn1SOIJa0FBG4mVZbV3HPFQe0S5B8IV5s9x87VZXG2JIsYN5LeTRIJw
 fwchzMqVATpRlla2dp0Bp2lJca9pPQeHi6C5LTD3fdH9nxlQWM2JwPfw1Vh7SHM1vUzF
 tDWHKWjJCZ2gKj2Bn00v7oRmPhnX2Nl6dGClPkxj4sgGUzqCxkbGNEkOoK8+K77Gwk6W
 0FFg==
X-Gm-Message-State: AOAM533EWE6fH6a85wPsR9tlB15oc5VDjSLCxr07KGbuuk7E+AZGuGkk
 YIdQh/rTCdmHnIlls4MANRw=
X-Google-Smtp-Source: ABdhPJy0BlbREB1JRUK5hwpvumws66QEQvcM5rJcl32v8jzU8GGW5IaYu878Iq6OcawfhcoS7nCggg==
X-Received: by 2002:a17:906:dc8c:b0:6df:7971:e730 with SMTP id
 cs12-20020a170906dc8c00b006df7971e730mr2047239ejc.66.1647423698816; 
 Wed, 16 Mar 2022 02:41:38 -0700 (PDT)
Received: from ?IPV6:2a02:908:1252:fb60:6d1e:c9c:e665:48a3?
 ([2a02:908:1252:fb60:6d1e:c9c:e665:48a3])
 by smtp.gmail.com with ESMTPSA id
 ho14-20020a1709070e8e00b006dbd26c2182sm640174ejc.156.2022.03.16.02.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 02:41:38 -0700 (PDT)
Message-ID: <aa16b25a-197d-87d5-001f-87fdfcd1a139@gmail.com>
Date: Wed, 16 Mar 2022 10:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] drm/amdgpu: add workarounds for VCN TMZ issue on
 CHIP_RAVEN
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220314024519.2201231-1-Lang.Yu@amd.com>
 <39dcbcab-8a92-4a01-e355-6e37ac4f1ce6@molgen.mpg.de>
 <YjE9CDYjvJ72IQNg@lang-desktop>
 <c502a443-0987-6d88-1ef3-603723f04634@molgen.mpg.de>
 <YjGB+Dx4nUIOyuMf@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YjGB+Dx4nUIOyuMf@lang-desktop>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 16.03.22 um 07:21 schrieb Lang Yu:
> On 03/16/ , Paul Menzel wrote:
>> Dear Lang,
>>
>>
>> Am 16.03.22 um 02:27 schrieb Lang Yu:
>>> On 03/15/ , Paul Menzel wrote:
>>>> Am 14.03.22 um 03:45 schrieb Lang Yu:
>>>>
>>>> Thank you for your patch. A shorter commit message summary would be:
>>>>
>>>>> drm/amdgpu: Work around VNC TMZ issue on CHIP_RAVEN
>>>>> It is a hardware issue that VCN can't handle a GTT
>>>>> backing stored TMZ buffer on CHIP_RAVEN series ASIC.
>>>> Where is that documented, and how can this be reproduced?
>>> It is documented in AMD internal Confluence and JIRA.
>>> Secure playback with a low VRAM config(thus TMZ buffer
>>> will be allocted in GTT domain) may reproduce this issue.
>> It’d be great if as much of the details from this non-publicly accessible
>> information could be added to the commit message, and a way to reproduce
>> this as there does not seem to be a test for this. (Also I guess a tag with
>> a reference to the internal issue would be acceptable, so in case more
>> question surface in the future.)
> Thanks. I will add an internal link.

Lang, please don't!

This isn't an information which is expected to be made public.

Regards,
Christian.

>
> Regards,
> Lang
>
>>>>> Move such a TMZ buffer to VRAM domain before command
>>>>> submission as a wrokaround.
>>>> workaround
>>>>
>>>> Please use a text width of 75 characters per line.
>>> Thanks for your comments. I will take care about this.
>>>
>>>>> v2:
>>>>>     - Use patch_cs_in_place callback.
>>>>>
>>>>> v3:
>>>>>     - Bail out early if unsecure IBs.
>>>>>
>>>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 71 +++++++++++++++++++++++++++
>>>>>     1 file changed, 71 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>> index 7bbb9ba6b80b..1ac9e06d3a4d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>>>>> @@ -24,6 +24,7 @@
>>>>>     #include <linux/firmware.h>
>>>>>     #include "amdgpu.h"
>>>>> +#include "amdgpu_cs.h"
>>>>>     #include "amdgpu_vcn.h"
>>>>>     #include "amdgpu_pm.h"
>>>>>     #include "soc15.h"
>>>>> @@ -1905,6 +1906,75 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>>>>>     	.set_powergating_state = vcn_v1_0_set_powergating_state,
>>>>>     };
>>>>> +/*
>>>>> + * It is a hardware issue that VCN can't handle a GTT TMZ buffer on
>>>>> + * CHIP_RAVEN series ASIC. Move such a GTT TMZ buffer to VRAM domain
>>>>> + * before command submission as a workaround.
>>>>> + */
>>>>> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
>>>>> +				struct amdgpu_job *job,
>>>>> +				uint64_t addr)
>>>>> +{
>>>>> +	struct ttm_operation_ctx ctx = { false, false };
>>>>> +	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
>>>>> +	struct amdgpu_vm *vm = &fpriv->vm;
>>>>> +	struct amdgpu_bo_va_mapping *mapping;
>>>>> +	struct amdgpu_bo *bo;
>>>>> +	int r;
>>>>> +
>>>>> +	addr &= AMDGPU_GMC_HOLE_MASK;
>>>>> +	if (addr & 0x7) {
>>>>> +		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
>>>>> +	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	bo = mapping->bo_va->base.bo;
>>>>> +	if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
>>>>> +		return 0;
>>>>> +
>>>>> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
>>>>> +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>> +	if (r) {
>>>>> +		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
>>>> to validate
>>>>
>>>>> +		return r;
>>>>> +	}
>>>>> +
>>>>> +	return r;
>>>>> +}
>>>>> +
>>>>> +static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>>>> +					   struct amdgpu_job *job,
>>>>> +					   struct amdgpu_ib *ib)
>>>>> +{
>>>>> +	uint32_t msg_lo = 0, msg_hi = 0;
>>>>> +	int i, r;
>>>> Use unsigned int for the counter variable?
>>> You can see both signed and unsigned are used in kernel.
>>> (e.g., mm/page_alloc.c).
>>>
>>> For this case, I think it makes no difference.
>>>
>>> In a word, we should consider the specific context.
>> Although it makes technically no difference, I prefer to use the best
>> matching type to convey the intention of the variable to the reader. But you
>> are right, there is no hard rule for it.
>>
>>
>> Kind regards,
>>
>> Paul
>>
>>>>> +
>>>>> +	if (!(ib->flags & AMDGPU_IB_FLAGS_SECURE))
>>>>> +		return 0;
>>>>> +
>>>>> +	for (i = 0; i < ib->length_dw; i += 2) {
>>>>> +		uint32_t reg = amdgpu_ib_get_value(ib, i);
>>>>> +		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
>>>>> +
>>>>> +		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
>>>>> +			msg_lo = val;
>>>>> +		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
>>>>> +			msg_hi = val;
>>>>> +		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
>>>>> +			r = vcn_v1_0_validate_bo(p, job,
>>>>> +						 ((u64)msg_hi) << 32 | msg_lo);
>>>>> +			if (r)
>>>>> +				return r;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>     static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>>>>>     	.type = AMDGPU_RING_TYPE_VCN_DEC,
>>>>>     	.align_mask = 0xf,
>>>>> @@ -1914,6 +1984,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>>>>>     	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
>>>>>     	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
>>>>>     	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
>>>>> +	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>>>>>     	.emit_frame_size =
>>>>>     		6 + 6 + /* hdp invalidate / flush */
>>>>>     		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
>>>>
>>>> Kind regards,
>>>>
>>>> Paul

