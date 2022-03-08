Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E42C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 07:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B7110EBAD;
	Tue,  8 Mar 2022 07:13:03 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C499E10EBB3
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 07:13:01 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id g3so10968597edu.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Mar 2022 23:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=0l+OEyW6caF77Mkx1bxiwIDkMKrzQVFQS0pd0px/Ydo=;
 b=JlOGmvToKLCYK/GVNu32bwTVsv/1rYokwCe2NSjwZ+bkZTfiXnOfH0Be9GmMUWhV8e
 3CqNjcmKckGsbG9ON9Vmg20pN2/tMuFJ9W/wv/ovTLR8+9Ptogtw2YMnmtev4ncPPhk+
 5Ya0IbRuGsFeL2Vb/NmjDv0QE1h2G8DfzOmq/GEX+yeNuyp3rU9d5kzB2BRvKIGGyBuW
 RqXMs22OWGTu7c+dA1r4qVo4v6e+YMR9XbyaqjLkRvkFqobmJdFNhHeBkS33SUetdufQ
 S1W20rbc6aBPd19TXyJcMUkLP87CwBp+yOnx2hgu1wT41V+QdP/82JWvpnXMGDRZhalG
 i9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=0l+OEyW6caF77Mkx1bxiwIDkMKrzQVFQS0pd0px/Ydo=;
 b=ksEbM3Qj2m+eHkVj30LOO5O7VS6XMeG/Wb/L6N1huwdMJWxFNV83J3PlQEKRylUnJl
 F3s3NJEguhfAdBJTFMAu//AFSeiXVueRwBhyz7pCxcsYpeMKdbaop9aec02FJdbLTqg+
 rpW0w01v0Lgee6VQZ/ex2vKMqo5V7iN+C2oXhveXoP8ApnQ//4oUm44W0ntU2ukSzI5e
 08Q2hKTGorwAKHvhd1pW0rK6RDe5cENB3zmY5/gWTyb5x5eGIzk7y83eH3qiJAkIyLkT
 q+a70IHLFFSY38fesPNTxYnrGsmPVwyTk00fzeFz+tnmjYxQiaBna7lYEYXQSLTWC8dE
 6umg==
X-Gm-Message-State: AOAM530hoH5BHya4T3ZHwLXCqOcWngBLFfppAqcsi/rLqNjlyoIN6BDb
 z5v5XS3aje/kdf1eKENAI942L7lcq3U=
X-Google-Smtp-Source: ABdhPJzI9PdlwwkkSfxuctwGhuIDMfoBVi4MrgbOfjCAZqrVOQZVO/MdtBeNQrx1IdJTKhNyURGkmg==
X-Received: by 2002:a05:6402:6c3:b0:415:ffc9:3a09 with SMTP id
 n3-20020a05640206c300b00415ffc93a09mr14843529edy.403.1646723580208; 
 Mon, 07 Mar 2022 23:13:00 -0800 (PST)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a170906471200b006da8a883b5fsm5452344ejq.54.2022.03.07.23.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Mar 2022 23:12:59 -0800 (PST)
Message-ID: <0f785eed-9b48-9782-c817-30fbb24eaf4f@gmail.com>
Date: Tue, 8 Mar 2022 08:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] drm/amdgpu: add workarounds for Raven VCN TMZ issue
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org,
 "Liu, Leo" <Leo.Liu@amd.com>, "Zhu, James" <James.Zhu@amd.com>
References: <20220308033941.999933-1-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220308033941.999933-1-Lang.Yu@amd.com>
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
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 08.03.22 um 04:39 schrieb Lang Yu:
> It is a hardware issue that VCN can't handle a GTT
> backing stored TMZ buffer on Raven.
>
> Move such a TMZ buffer to VRAM domain before command
> submission.
>
> v2:
>   - Use patch_cs_in_place callback.
>
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 68 +++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 7bbb9ba6b80b..810932abd3af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -24,6 +24,7 @@
>   #include <linux/firmware.h>
>   
>   #include "amdgpu.h"
> +#include "amdgpu_cs.h"
>   #include "amdgpu_vcn.h"
>   #include "amdgpu_pm.h"
>   #include "soc15.h"
> @@ -1905,6 +1906,72 @@ static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>   	.set_powergating_state = vcn_v1_0_set_powergating_state,
>   };
>   
> +/**
> + * It is a hardware issue that Raven VCN can't handle a GTT TMZ buffer.
> + * Move such a GTT TMZ buffer to VRAM domain before command submission.
> + */
> +static int vcn_v1_0_validate_bo(struct amdgpu_cs_parser *parser,
> +				struct amdgpu_job *job,
> +				uint64_t addr)
> +{
> +	struct ttm_operation_ctx ctx = { false, false };
> +	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct amdgpu_bo *bo;
> +	int r;
> +
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +	if (addr & 0x7) {
> +		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> +		return -EINVAL;
> +	}
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr/AMDGPU_GPU_PAGE_SIZE);
> +	if (!mapping || !mapping->bo_va || !mapping->bo_va->base.bo)
> +		return -EINVAL;
> +
> +	bo = mapping->bo_va->base.bo;
> +	if (!(bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED))
> +		return 0;
> +
> +	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	if (r) {
> +		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
> +		return r;
> +	}

Well, exactly that won't work.

The message structure isn't TMZ protected because otherwise the driver 
won't be able to stitch it together.

What is TMZ protected are the surfaces the message structure is pointing 
to. So what you would need to do is to completely parse the structure 
and then move on the relevant buffers into VRAM.

Leo or James, can you help with that?

Regards,
Christian.

> +
> +	return r;
> +}
> +
> +static int vcn_v1_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
> +					   struct amdgpu_job *job,
> +					   struct amdgpu_ib *ib)
> +{
> +	uint32_t msg_lo = 0, msg_hi = 0;
> +	int i, r;
> +
> +	for (i = 0; i < ib->length_dw; i += 2) {
> +		uint32_t reg = amdgpu_ib_get_value(ib, i);
> +		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
> +
> +		if (reg == PACKET0(p->adev->vcn.internal.data0, 0)) {
> +			msg_lo = val;
> +		} else if (reg == PACKET0(p->adev->vcn.internal.data1, 0)) {
> +			msg_hi = val;
> +		} else if (reg == PACKET0(p->adev->vcn.internal.cmd, 0)) {
> +			r = vcn_v1_0_validate_bo(p, job,
> +					     ((u64)msg_hi) << 32 | msg_lo);
> +			if (r)
> +				return r;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +
>   static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0xf,
> @@ -1914,6 +1981,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ring_vm_funcs = {
>   	.get_rptr = vcn_v1_0_dec_ring_get_rptr,
>   	.get_wptr = vcn_v1_0_dec_ring_get_wptr,
>   	.set_wptr = vcn_v1_0_dec_ring_set_wptr,
> +	.patch_cs_in_place = vcn_v1_0_ring_patch_cs_in_place,
>   	.emit_frame_size =
>   		6 + 6 + /* hdp invalidate / flush */
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +

