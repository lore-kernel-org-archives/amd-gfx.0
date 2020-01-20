Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9627C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 11:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA48E207FF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 11:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub5znn7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA48E207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412F16E91E;
	Mon, 20 Jan 2020 11:58:40 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCCF06E91E
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 11:58:38 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id c9so29258962wrw.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 03:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=dkhoXGrBpm1FpSKAkYKcAKNXT8m+SF8f928hO5IGSL0=;
 b=Ub5znn7gOuf1RSElulXmFGCj7cAicKMMFDSD5bsmtBZZSUGPhX81/wCRq6RoftuJdV
 6GEZhmPRuNALLtxSmU/jO0bzrRiar2I7cc8bPUTfZQJsdhjSQkLOTDAk2pfBDT1hM0yD
 Q8UwJAyipZSiPZ3+6Pinf0TSbpkCOzwZKeJOFFHzaXf8ev07J+QEWMQijSEB/TRKJhS6
 0lsqlU5cpNIDlJL82T9ofwdgDIJ66R9Yo4gOz/WnFvh3hm7j2yi8/6CKIGYx94FBHMnO
 m4hb/AVlJcZmA1XMrBAVu9R16RXzYnP5PDhr86nMjHSj5HMJtmmCgGmgD//XZNRRyLLj
 jiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=dkhoXGrBpm1FpSKAkYKcAKNXT8m+SF8f928hO5IGSL0=;
 b=nazAFmm8MgnWa81kRSwEaNg0F+eJPiHZV11SRWxfqeaQ58+l/S2OdyRyQZVHPPXogP
 CA0hSyXg94oILjRNdC1hPdqQndC2N2cg7Kv3qsOxhGi8pXwFtWiq/vihs3jEtUGxS0kX
 iI0BCU/XI+8oY/9fIlJOSrWoqhSCiKLqVXmhx4PSHEi/mP+LH9zbQC78oJpL030tKG/J
 oOrfPXmIFPS5AoYn/VY5//yURm5GXzGgNE5VrcS8RdtF/R4KjJnaz6XrVsMW2O0PDVcb
 PmfRJdCA+xbRb3Tr2nmpo2qsV6el2iUDEn0RTtWxUWQYVcWLNYPKdAyKoCFW61b8JvSj
 S4dw==
X-Gm-Message-State: APjAAAXoVteri0M60TfYwEq7A6riA8iiMRyX7GPBv4vVLvQPVEx7Re1O
 ak2CKEZ53QUzwH0BODGox8YPUrCt
X-Google-Smtp-Source: APXvYqwkImBvihusnRg9OPCJ5jGqkC2z9NsM+0OpLF9T3FwNXmytcOZ6+rjU/A5XL9y6pLmMhjm3Pw==
X-Received: by 2002:a5d:4045:: with SMTP id w5mr17896460wrp.59.1579521517392; 
 Mon, 20 Jan 2020 03:58:37 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id x17sm46308350wrt.74.2020.01.20.03.58.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Jan 2020 03:58:36 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/amdgpu: fix VRAM partially encroached issue in
 GDDR6 memory training
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200120110822.30163-1-tianci.yin@amd.com>
 <20200120110822.30163-2-tianci.yin@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d2cf1e77-9d4a-229a-95e9-bc47b7f89389@gmail.com>
Date: Mon, 20 Jan 2020 12:58:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200120110822.30163-2-tianci.yin@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Long Gang <Gang.Long@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.01.20 um 12:08 schrieb Tianci Yin:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> In GDDR6 BIST training, a certain mount of bottom VRAM will be encroached by
> UMC, that causes problems(like GTT corrupted and page fault observed).
>
> [how]
> Saving the content of this bottom VRAM to system memory before training, and
> restoring it after training to avoid VRAM corruption.

You need to re-order the patches, this one should come first and the 
other one last.

One more style nit pick below.

>
> Change-Id: I04a8a6e8e63b3619f7c693fe67883b229cbf3c53
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 32 ++++++++++++++++++++++++-
>   2 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 3265487b859f..611021514c52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -172,6 +172,8 @@ struct psp_dtm_context {
>   #define MEM_TRAIN_SYSTEM_SIGNATURE		0x54534942
>   #define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES	0x1000
>   #define GDDR6_MEM_TRAINING_OFFSET		0x8000
> +/*Define the VRAM size that will be encroached by BIST training.*/
> +#define GDDR6_MEM_TRAINING_ENCROACHED_SIZE	0x2000000
>   
>   enum psp_memory_training_init_flag {
>   	PSP_MEM_TRAIN_NOT_SUPPORT	= 0x0,
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 685dd9754c67..51011b661ba8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -972,7 +972,10 @@ static int psp_v11_0_memory_training_init(struct psp_context *psp)
>   static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   {
>   	int ret;
> +	void *buf;
> +	uint32_t sz;
>   	uint32_t p2c_header[4];
> +	struct amdgpu_device *adev = psp->adev;
>   	struct psp_memory_training_context *ctx = &psp->mem_train_ctx;
>   	uint32_t *pcache = (uint32_t*)ctx->sys_cache;

In general it is preferred to order the lines in reverse xmas tree.

E.g. long lines with pre-initializes variables such as adev, ctx, pcache 
first. And temporary stuff like i, ret, buf etc last.

Apart from that this looks good to me,
Christian.

>   
> @@ -989,7 +992,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   		return 0;
>   	}
>   
> -	amdgpu_device_vram_access(psp->adev, ctx->p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);
> +	amdgpu_device_vram_access(adev, ctx->p2c_train_data_offset, p2c_header, sizeof(p2c_header), false);
>   	DRM_DEBUG("sys_cache[%08x,%08x,%08x,%08x] p2c_header[%08x,%08x,%08x,%08x]\n",
>   		  pcache[0], pcache[1], pcache[2], pcache[3],
>   		  p2c_header[0], p2c_header[1], p2c_header[2], p2c_header[3]);
> @@ -1026,11 +1029,38 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   	DRM_DEBUG("Memory training ops:%x.\n", ops);
>   
>   	if (ops & PSP_MEM_TRAIN_SEND_LONG_MSG) {
> +		/*
> +		 * Long traing will encroach certain mount of bottom VRAM,
> +		 * saving the content of this bottom VRAM to system memory
> +		 * before training, and restoring it after training to avoid
> +		 * VRAM corruption.
> +		 */
> +		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
> +
> +		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
> +			DRM_ERROR("visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
> +				  adev->gmc.visible_vram_size,
> +				  adev->mman.aper_base_kaddr);
> +			return -EINVAL;
> +		}
> +
> +		buf = vmalloc(sz);
> +		if (!buf) {
> +			DRM_ERROR("failed to allocate system memory.\n");
> +			return -ENOMEM;
> +		}
> +
> +		memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
>   		ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
>   		if (ret) {
>   			DRM_ERROR("Send long training msg failed.\n");
> +			vfree(buf);
>   			return ret;
>   		}
> +
> +		memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> +		adev->nbio.funcs->hdp_flush(adev, NULL);
> +		vfree(buf);
>   	}
>   
>   	if (ops & PSP_MEM_TRAIN_SAVE) {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
