Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10246C636D7
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Feb 2023 06:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65A6510E034;
	Thu, 23 Feb 2023 06:47:54 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E132610E034
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Feb 2023 06:47:51 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id bo30so9237942wrb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 22:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kVpAYmpm0HsiTbq/m08zzodUpsJ5l7wE3CgbpE7ZaOU=;
 b=Met3ym7mlbDAY2Ii1GdhBVgcJ8UN5l7a22adZAk/V/F6B8ag7sakeqXLtkA22XYF4N
 ASFzno9rbz4XEcmxil02SM3nbnXSMv0PW2y7x3kT4+MBRhjl1JNi9GZ3iiQ14njkPHt1
 q4FmEp0xFLqGo5KQE7lA5Qgobtxb0ts6AtKLa1BHWPQNRtEx3pow+a/QHw/ImGJXJzbi
 7/gMYMXThACzad2n+BU27hkGREgIdjoqwPNON1zq9MBKnUVeqmABMoZXA3p5lA9FeXv9
 W1U7Ibd0BfLCG8Lprf4nwe2EQ997G8IxX6lTBiqQvqUfw4UTLa86VT+edwrRejCmPLlU
 iIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kVpAYmpm0HsiTbq/m08zzodUpsJ5l7wE3CgbpE7ZaOU=;
 b=AsqRzzY9IFhixJQKY6B2JPNz8ySu+zG54QmmnmCBIdCau/pk+rD12UUlaylSuRlx8V
 y0UVHvwgz+ChURL9+NvAw/aevwVLuErpH3B47pEOZeDAdJY0ikEu/W0sQ/PElgp/AxvD
 a/er4uGocrcYIJ68NrkZtnofhO6CCEeJHI5faBatDxHm9vlUoTZoolYA5grOxBqbaNS9
 p/6hChKN0xpxgOxdGJdIWmPCgXx9ek3WUeIlcAGPhrH7mTZ+lVGT+p2y7hoMMUb9B7aj
 kb86xuiVXFy+DQnCUvbz/ajePT98AnZQwBYJ8UYrdfj/4uRCOhszL8Dc14ItEUG6/mqI
 Li5w==
X-Gm-Message-State: AO0yUKVBwPu7ZD4b0i4swseosgOqdeIZHocUSoqqWrK8R2KaKaiNBd8T
 TAjcmsP7msQTuA1tVYFVVNI=
X-Google-Smtp-Source: AK7set9LqntXcEyMBjV8wkNRr0OWNSBCoN2A2hnpzLOqHag7k5Zs9kJ0ioY/FlGwgqP/lR4VxZoIrw==
X-Received: by 2002:adf:f0c3:0:b0:2c7:144a:3ac1 with SMTP id
 x3-20020adff0c3000000b002c7144a3ac1mr465758wro.14.1677134870075; 
 Wed, 22 Feb 2023 22:47:50 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 d18-20020a5d6452000000b002c54f4d0f71sm10555542wrw.38.2023.02.22.22.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Feb 2023 22:47:49 -0800 (PST)
Message-ID: <b1de9e63-5194-4ca5-e033-25674e2b7d92@gmail.com>
Date: Thu, 23 Feb 2023 07:47:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: support more AV1 encoding requests
Content-Language: en-US
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
References: <20230222231131.191619-1-David.Wu3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230222231131.191619-1-David.Wu3@amd.com>
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
Cc: alexander.deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.02.23 um 00:11 schrieb David (Ming Qiang) Wu:
> Ensuring accurate IB package searching and covers
> more corners for AV1 encoding requests.

That at least looks much cleaner now. Do we already have the Mesa 
patches ready which use this?

Regards,
Christian.

>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 81 +++++++++++++++++++++++++--
>   1 file changed, 75 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 22a41766a8c7..8235ff3820ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1726,6 +1726,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>   
>   #define RADEON_VCN_ENGINE_TYPE_ENCODE			(0x00000002)
>   #define RADEON_VCN_ENGINE_TYPE_DECODE			(0x00000003)
> +#define RADEON_VCN_ENGINE_TYPE_ENCODE_QUEUE		(0x00000004)
>   
>   #define RADEON_VCN_ENGINE_INFO				(0x30000001)
>   #define RADEON_VCN_ENGINE_INFO_MAX_OFFSET		16
> @@ -1733,21 +1734,86 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
>   #define RENCODE_ENCODE_STANDARD_AV1			2
>   #define RENCODE_IB_PARAM_SESSION_INIT			0x00000003
>   #define RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET	64
> +#define RENCODE_IB_ENC_QUE_INSTRUCTION			(0x32000001)
> +#define RENCODE_IB_ENC_QUE_INSTRUCTION_MAX_OFFSET	64
>   
>   /* return the offset in ib if id is found, -1 otherwise
>    * to speed up the searching we only search upto max_offset
>    */
> -static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int max_offset)
> +static int vcn_v4_0_enc_find_ib_param(uint32_t *ptr, int size, uint32_t id, int max_offset)
>   {
>   	int i;
>   
> -	for (i = 0; i < ib->length_dw && i < max_offset && ib->ptr[i] >= 8; i += ib->ptr[i]/4) {
> -		if (ib->ptr[i + 1] == id)
> +	for (i = 0; i < size && i < max_offset && ptr[i] >= 8; i += ptr[i] / 4) {
> +		if (ptr[i + 1] == id)
>   			return i;
>   	}
>   	return -1;
>   }
>   
> +static int vcn_v4_0_enc_queue_msg(struct amdgpu_cs_parser *p,
> +				  struct amdgpu_job *job,
> +				  struct amdgpu_ib *ib)
> +{
> +	struct ttm_operation_ctx ctx = { false, false };
> +	struct amdgpu_bo_va_mapping *map;
> +	struct amdgpu_bo *bo;
> +	uint64_t start, end;
> +	int i;
> +	void *ptr;
> +	int r;
> +	int data_size = 0;
> +	uint64_t addr;
> +	uint32_t *msg;
> +
> +	i = vcn_v4_0_enc_find_ib_param(ib->ptr, ib->length_dw, RENCODE_IB_ENC_QUE_INSTRUCTION,
> +		RENCODE_IB_ENC_QUE_INSTRUCTION_MAX_OFFSET);
> +	if (i >= 0) {
> +		addr = ((uint64_t)ib->ptr[i + 3]) << 32 | ib->ptr[i + 2];
> +		data_size = ib->ptr[i + 4];
> +	}
> +
> +	if (!data_size) /* did not find */
> +		return 0;
> +
> +	addr &= AMDGPU_GMC_HOLE_MASK;
> +	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
> +	if (r) {
> +		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
> +		return r;
> +	}
> +
> +	start = map->start * AMDGPU_GPU_PAGE_SIZE;
> +	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
> +	if (addr & 0x7) {
> +		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
> +		return -EINVAL;
> +	}
> +
> +	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
> +	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +	if (r) {
> +		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
> +		return r;
> +	}
> +
> +	r = amdgpu_bo_kmap(bo, &ptr);
> +	if (r) {
> +		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
> +		return r;
> +	}
> +
> +	msg = ptr + addr - start; /* IB with SESSION_INIT */
> +	i = vcn_v4_0_enc_find_ib_param(msg, data_size, RENCODE_IB_PARAM_SESSION_INIT,
> +		RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
> +	if (i >= 0 && msg[i + 2] == RENCODE_ENCODE_STANDARD_AV1)
> +		r = vcn_v4_0_limit_sched(p, job);
> +
> +	amdgpu_bo_kunmap(bo);
> +	return r;
> +}
> +
>   static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>   					   struct amdgpu_job *job,
>   					   struct amdgpu_ib *ib)
> @@ -1763,12 +1829,13 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>   		return 0;
>   
>   	/* RADEON_VCN_ENGINE_INFO is at the top of ib block */
> -	idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO,
> +	idx = vcn_v4_0_enc_find_ib_param(ib->ptr, ib->length_dw, RADEON_VCN_ENGINE_INFO,
>   			RADEON_VCN_ENGINE_INFO_MAX_OFFSET);
>   	if (idx < 0) /* engine info is missing */
>   		return 0;
>   
>   	val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
> +
>   	if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
>   		decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
>   
> @@ -1779,10 +1846,12 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>   			decode_buffer->msg_buffer_address_lo;
>   		return vcn_v4_0_dec_msg(p, job, addr);
>   	} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
> -		idx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT,
> -			RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
> +		idx = vcn_v4_0_enc_find_ib_param(ib->ptr, ib->length_dw,
> +			RENCODE_IB_PARAM_SESSION_INIT, RENCODE_IB_PARAM_SESSION_INIT_MAX_OFFSET);
>   		if (idx >= 0 && ib->ptr[idx + 2] == RENCODE_ENCODE_STANDARD_AV1)
>   			return vcn_v4_0_limit_sched(p, job);
> +	} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE_QUEUE) {
> +		return vcn_v4_0_enc_queue_msg(p, job, ib);
>   	}
>   	return 0;
>   }

