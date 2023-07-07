Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D2EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 07:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0662F10E06E;
	Fri,  7 Jul 2023 07:06:04 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAFD10E06E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 07:06:01 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51d9128494cso1876731a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Jul 2023 00:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688713558; x=1691305558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/iBHfox0Lle8GPgehpa77NSL6g+NO3B72O1NTvYQEZk=;
 b=bm+cTR7RQLMtxoNw236RVCJEb/pu3nPMANH9T9DjWFWJe7eg+DDceyOQ6MD87M1iZQ
 cb7nClsmazLkcy2GpOh9zU9bDktUzDppvKivFajunvQHKhEYsusV2NXdNbol3zrk3bHQ
 KlJJTR58u0aZBDXagBAa2CX7TfFWmE7HTBctSU2FWn4lkbHXXEQL0Pxo7WgKk0N33edb
 qU4tHx7B3dxAwNfJG384X5SrBYqFpsfWiXaTzrTid65nWScFfjW2crhZ7Be31y1v7OJo
 8GmWsTYy5TRB3k0mwWkCKudkNUtDZZ6aoSrMD/Gs79pJsYrOJeCBef3O/drzVQ74g0Ep
 m/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688713558; x=1691305558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/iBHfox0Lle8GPgehpa77NSL6g+NO3B72O1NTvYQEZk=;
 b=Htr5vXreIznEmpKs4alOr4fRTIe8sIFnl/1wiczMKaA7SzM0p5Wa9lD2XfnTvBZ2eF
 gnC/XU+iNaXK4UustHIiOnSgPiJz/ZphjYWqhjcn+vE+5bmnD5+eDYa48iXaN1QfFTrX
 +BpmJEqwzGV3OCo8kJLr7aQbNxyQXhbpoU+EmdM/XxeWzHjZwcOTdy5tMnXhRkgISHJp
 HHOIzWSm4X62WQLlDtkHsQ1JoleJFiKnvQhw9rqSZAG8uMh8cc+pB329nU9NonZnxTPy
 PNSyjkH9SCui7DBMPCsba9zOZMBwdvqbEB9+cl2Ivq7uPHI0aOUERsySLsDoodG/Bi9x
 MAZA==
X-Gm-Message-State: ABy/qLbN1P3W+Knpn3T2f4mUZnJnb7Q7s7Y1NnhTEgoQ2DaOGOzAqc6i
 /Og5Sz+JMyf9ge+vxBLeJvw=
X-Google-Smtp-Source: APBJJlFl0vXIZBXxt9m76evXnulDyxOUMd/Gs3YuH61yLTGPhswkgzXdh7H4dDs0fVtQXSYcr7+4Nw==
X-Received: by 2002:a05:6402:1645:b0:51e:34d5:a23f with SMTP id
 s5-20020a056402164500b0051e34d5a23fmr2759216edx.23.1688713558104; 
 Fri, 07 Jul 2023 00:05:58 -0700 (PDT)
Received: from ?IPV6:2a00:e180:151d:fd00:ccd:1e13:686f:fcec?
 ([2a00:e180:151d:fd00:ccd:1e13:686f:fcec])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a056402184700b0051de2455041sm1654800edy.24.2023.07.07.00.05.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 00:05:57 -0700 (PDT)
Message-ID: <8f6f65d5-13b3-0798-7e0b-df502dfca2ce@gmail.com>
Date: Fri, 7 Jul 2023 09:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] drm/amdgpu:update kernel vcn ring test
Content-Language: en-US
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, leo.liu@amd.com,
 veerabadhran.gopalakrishnan@amd.com, sathishkumar.sundararaju@amd.com
References: <20230706144720.3841607-1-saleemkhan.jamadar@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230706144720.3841607-1-saleemkhan.jamadar@amd.com>
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
Cc: srinath.rao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 06.07.23 um 16:47 schrieb Saleemkhan Jamadar:
> add session context buffer to decoder ring test.
>
> v4 - data type, explain change of ib size change (Christian)
> v3 - indent and  v2 changes correction. (Christian)
> v2 - put the buffer at the end of the IB (Christian)
>
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> Acked-by: Leo Liu <leo.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 11 +++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  5 ++++-
>   2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 2d94f1b63bd6..9bdfe665f603 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -573,7 +573,8 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   	int r, i;
>   
>   	memset(ib, 0, sizeof(*ib));
> -	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
> +	/* 34 pages : 128KiB  session context buffer size and 8KiB ib msg */
> +	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
>   			AMDGPU_IB_POOL_DIRECT,
>   			ib);
>   	if (r)
> @@ -608,7 +609,8 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   	int r, i;
>   
>   	memset(ib, 0, sizeof(*ib));
> -	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
> +	/* 34 pages : 128KB  session context buffer size and 8KB ib msg */
> +	r = amdgpu_ib_get(adev, NULL, AMDGPU_GPU_PAGE_SIZE * 34,
>   			AMDGPU_IB_POOL_DIRECT,
>   			ib);

One more question here: Does the create and destroy message need to 
point to the same session context buffer or is it ok that we use a 
separate dummy for both?

Either way we should probably clear the context buffer with zeros.

Apart from that this now looks good to me,
Christian.

>   	if (r)
> @@ -700,6 +702,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	struct amdgpu_job *job;
>   	struct amdgpu_ib *ib;
>   	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
> +	uint64_t session_ctx_buf_gaddr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr + 8192);
>   	bool sq = amdgpu_vcn_using_unified_queue(ring);
>   	uint32_t *ib_checksum;
>   	uint32_t ib_pack_in_dw;
> @@ -730,6 +733,10 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
>   	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
>   
> +	decode_buffer->valid_buf_flag |=
> +				cpu_to_le32(AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER);
> +	decode_buffer->session_context_buffer_address_hi = upper_32_bits(session_ctx_buf_gaddr);
> +	decode_buffer->session_context_buffer_address_lo = lower_32_bits(session_ctx_buf_gaddr);
>   	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
>   	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
>   	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index f1397ef66fd7..2df43cd76c10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -166,6 +166,7 @@
>   
>   #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
>   #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
> +#define AMDGPU_VCN_CMD_FLAG_SESSION_CONTEXT_BUFFER	0x00100000
>   
>   #define VCN_CODEC_DISABLE_MASK_AV1  (1 << 0)
>   #define VCN_CODEC_DISABLE_MASK_VP9  (1 << 1)
> @@ -357,7 +358,9 @@ struct amdgpu_vcn_decode_buffer {
>   	uint32_t valid_buf_flag;
>   	uint32_t msg_buffer_address_hi;
>   	uint32_t msg_buffer_address_lo;
> -	uint32_t pad[30];
> +	uint32_t session_context_buffer_address_hi;
> +	uint32_t session_context_buffer_address_lo;
> +	uint32_t pad[28];
>   };
>   
>   #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80

