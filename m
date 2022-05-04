Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E7FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 13:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E56010EC9A;
	Wed,  4 May 2022 13:50:34 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C88110EC9A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 13:50:33 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id ba17so1777524edb.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 May 2022 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=OIV0Vk13qnsFKFz8TPblIh49iz/TgX53JVONyBNdqZ4=;
 b=ZtSeMuhZ8AG4oTPh7Iyq2zM/X3HEb2p3r4n0wpF6w6snIDMslO+hh4jEIBQR3sjWhl
 5bzlfo7rEra0oHAFW3m9YwSfqMUU6bGux3bem4LTceIkcjQWqEH3NGRsu08NdYPhblyA
 hx1d6MRUqob5wcVjafdtZ/6COUzP3iEpWXPDDmXZRqq8bkWlmQE4r4e2HUPwBBUVAyJx
 Vw05CxxGErpOpITXjqQQP0DcumHkmXOp5zJb9y7vFuqrtXajjKDsmSErwLgeGJctlDfh
 xlqglYq57YYOBSOik5a0mD58NPAe64I8ptcT9vNqcdM4D13Xd2nwqIcQV5pZjLs8bGw2
 1lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=OIV0Vk13qnsFKFz8TPblIh49iz/TgX53JVONyBNdqZ4=;
 b=bjrw28iRWy2Yq7DfCGISrAO8FeB6/0FDj8yZge1HqjgLpU+yBAhJ5zTg5sYW7yzpF4
 GwtYHlbSnsa/QKitS57oQkTGg49IRhqA5SU5mY3S4F5r0MD7jAlK5Si41iKTkXKjo1k8
 AIy5QB1axgXXKzP5pQTiIq+wrYQlO2IeU3Z+hYS4bjh+hbMR1GJ29V7DIP+irFwyCJhX
 O1T337WylUh/fBXshMqFj+MsGpR1eHszqLzCf93XpT7JR3undXJNonYMcaYWr66Ha9fg
 L55x38jAb/V0dXXFXx65kg/XlQO2QIfrAFMGjWRAx6WN9bVFby9aoTpxogi6G0wawIca
 dK2w==
X-Gm-Message-State: AOAM531RkCLDjVQqYuTnmO0mQyHikWBv0vcptD/bhI9Ake0YukkV/noq
 AXcrG5Za1Cu73eI+yBXI1WA=
X-Google-Smtp-Source: ABdhPJxGWcTTQtngXs3nK92xBqXi3Wrt65mq8FoYtdMyLKu28BieD3xVEjN/QA5UhSdA53/PlcYB9A==
X-Received: by 2002:a05:6402:1148:b0:416:a4fb:3c2e with SMTP id
 g8-20020a056402114800b00416a4fb3c2emr23330014edw.182.1651672231642; 
 Wed, 04 May 2022 06:50:31 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:808:29f:6aa7:520c?
 ([2a02:908:1256:79a0:808:29f:6aa7:520c])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a50fd8f000000b0042617ba63b0sm9192308edt.58.2022.05.04.06.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 May 2022 06:50:31 -0700 (PDT)
Message-ID: <31963fb8-0df4-b593-3fa4-b05976855b80@gmail.com>
Date: Wed, 4 May 2022 15:50:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/3] drm/amdgpu/vcn3: replace ip based software ring
 decode with common vcn software ring decode
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220504132326.629117-1-James.Zhu@amd.com>
 <20220504132326.629117-2-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220504132326.629117-2-James.Zhu@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.05.22 um 15:23 schrieb James Zhu:
> Replace ip based software ring decode with common vcn software ring decode.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 82 ++++-----------------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h | 12 ----
>   2 files changed, 11 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c7280ca5e836..f761c569fcc6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -30,6 +30,7 @@
>   #include "soc15d.h"
>   #include "vcn_v2_0.h"
>   #include "mmsch_v3_0.h"
> +#include "vcn_sw_ring.h"
>   
>   #include "vcn/vcn_3_0_0_offset.h"
>   #include "vcn/vcn_3_0_0_sh_mask.h"
> @@ -1731,67 +1732,6 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
>   	}
>   }
>   
> -void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
> -      u64 seq, uint32_t flags)
> -{
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> -
> -	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_FENCE);
> -	amdgpu_ring_write(ring, addr);
> -	amdgpu_ring_write(ring, upper_32_bits(addr));
> -	amdgpu_ring_write(ring, seq);
> -	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_TRAP);
> -}
> -
> -void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
> -{
> -	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
> -}
> -
> -void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -        struct amdgpu_ib *ib, uint32_t flags)
> -{
> -	uint32_t vmid = AMDGPU_JOB_GET_VMID(job);
> -
> -	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_IB);
> -	amdgpu_ring_write(ring, vmid);
> -	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
> -	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> -	amdgpu_ring_write(ring, ib->length_dw);
> -}
> -
> -void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
> -        uint32_t val, uint32_t mask)
> -{
> -	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
> -	amdgpu_ring_write(ring, reg << 2);
> -	amdgpu_ring_write(ring, mask);
> -	amdgpu_ring_write(ring, val);
> -}
> -
> -void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
> -        uint32_t vmid, uint64_t pd_addr)
> -{
> -	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
> -	uint32_t data0, data1, mask;
> -
> -	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> -
> -	/* wait for register write */
> -	data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
> -	data1 = lower_32_bits(pd_addr);
> -	mask = 0xffffffff;
> -	vcn_v3_0_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
> -}
> -
> -void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> -      uint32_t val)
> -{
> -	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WRITE);
> -	amdgpu_ring_write(ring,	reg << 2);
> -	amdgpu_ring_write(ring, val);
> -}
> -
>   static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_DEC,
>   	.align_mask = 0x3f,
> @@ -1804,22 +1744,22 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
>   	.emit_frame_size =
>   		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
>   		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
> -		4 + /* vcn_v3_0_dec_sw_ring_emit_vm_flush */
> -		5 + 5 + /* vcn_v3_0_dec_sw_ring_emit_fdec_swe x2 vm fdec_swe */
> -		1, /* vcn_v3_0_dec_sw_ring_insert_end */
> -	.emit_ib_size = 5, /* vcn_v3_0_dec_sw_ring_emit_ib */
> -	.emit_ib = vcn_v3_0_dec_sw_ring_emit_ib,
> -	.emit_fence = vcn_v3_0_dec_sw_ring_emit_fence,
> -	.emit_vm_flush = vcn_v3_0_dec_sw_ring_emit_vm_flush,
> +		4 + /* vcn_dec_sw_ring_emit_vm_flush */
> +		5 + 5 + /* vcn_dec_sw_ring_emit_fdec_swe x2 vm fdec_swe */
> +		1, /* vcn_dec_sw_ring_insert_end */

Maybe add that calculation as define to vcn_sw_ring.h.

Apart from that looks really good to me.

Regards,
Christian.

> +	.emit_ib_size = 5, /* vcn_dec_sw_ring_emit_ib */
> +	.emit_ib = vcn_dec_sw_ring_emit_ib,
> +	.emit_fence = vcn_dec_sw_ring_emit_fence,
> +	.emit_vm_flush = vcn_dec_sw_ring_emit_vm_flush,
>   	.test_ring = amdgpu_vcn_dec_sw_ring_test_ring,
>   	.test_ib = NULL,//amdgpu_vcn_dec_sw_ring_test_ib,
>   	.insert_nop = amdgpu_ring_insert_nop,
> -	.insert_end = vcn_v3_0_dec_sw_ring_insert_end,
> +	.insert_end = vcn_dec_sw_ring_insert_end,
>   	.pad_ib = amdgpu_ring_generic_pad_ib,
>   	.begin_use = amdgpu_vcn_ring_begin_use,
>   	.end_use = amdgpu_vcn_ring_end_use,
> -	.emit_wreg = vcn_v3_0_dec_sw_ring_emit_wreg,
> -	.emit_reg_wait = vcn_v3_0_dec_sw_ring_emit_reg_wait,
> +	.emit_wreg = vcn_dec_sw_ring_emit_wreg,
> +	.emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
>   	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
> index 7a6655d3b79d..31683582d778 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
> @@ -26,16 +26,4 @@
>   
>   extern const struct amdgpu_ip_block_version vcn_v3_0_ip_block;
>   
> -void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
> -      u64 seq, uint32_t flags);
> -void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring);
> -void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
> -      struct amdgpu_ib *ib, uint32_t flags);
> -void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
> -      uint32_t val, uint32_t mask);
> -void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
> -      uint32_t vmid, uint64_t pd_addr);
> -void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
> -      uint32_t val);
> -
>   #endif /* __VCN_V3_0_H__ */

