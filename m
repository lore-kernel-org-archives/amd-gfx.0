Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A1BC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 10:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A8123331
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 10:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A8123331
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B656E041;
	Wed, 20 Jan 2021 10:26:21 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32E26E041
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 10:26:20 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id hs11so30453647ejc.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 02:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=M7iGBEoYNibRiDPalxWg1Wr1VSDidmj2/Zhu9ehkUuc=;
 b=VXxy13LumtXdnkV1Z1PYm/1s240PaVBIvIDU2tVHNjPwhH5XSJxv6ojbwv4cRGDiAM
 Uo2JbnHXB7G0eZ4tPu/empWSVbGaV/Y4QzVXu5AjyhfwvGSX9sXL54neGnPLAM+Hhp6Q
 0lTuwBEu/DaJcqShQ4/1zVo06jIQYGnfBNfPgCE7G0PRQEdZS7UBnGgwOO0g5npWe1CY
 w/QXMOv6HchHt2iHFbKXKswsQTEdusKbBLn7ERzBivyqumDJwW4aMpqL97ghXEWppUjB
 FdYbv/KmcC648yF6cNiFg5KMnI2f1d4WlXzQfTv7LQ5X7m701NJpCtCOID+GYFvWbK+U
 OXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=M7iGBEoYNibRiDPalxWg1Wr1VSDidmj2/Zhu9ehkUuc=;
 b=HaBnNxzu+Mu/DeJA9NGdX2EzTiDiIOaBcvSr6PPI2JW74XS2x+xvBBrNDMcpAXkx7Z
 +xzOvf/TQ4wX4OkJ3NW74hyMMi8vgGp0n3+B0Lxvh/SpQc7BHn7bca5cTMzQBluCEEve
 +TZZPU9HFkgKXSCWKVqyX1K2yF201jRTQEfZbASw/lrw9nApGmw9EXNzMEc9useeFKSD
 u2IoOWLaJnpU1MQwdSE9AgNUHWi0X7+vaznHUpmyzhjwgaOTnb1B+EJ/6u6AZDcNzxhV
 2FnN74ERmr7AGpvr0UOCLKK+Vsa0EelyD1dvDNXnWvYfAYb30umsyvGW4DxQDrOaJVC7
 IdTQ==
X-Gm-Message-State: AOAM5320Ye/lwGipOzBMWkL0XhcfSvJ8Fpp9wcnIFFiVq4qOn96kBG9o
 Gtu48OlWucAN1fLDBCZyAu8NGrSPvos=
X-Google-Smtp-Source: ABdhPJy2VppLiL5/4+Xc1P6UPMZWng8gRooXG+ShHNoMeTY4Wp0kvFyTPH0FeNirojSvXomZW9p9Tg==
X-Received: by 2002:a17:906:1348:: with SMTP id
 x8mr5567563ejb.81.1611138379066; 
 Wed, 20 Jan 2021 02:26:19 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id cw21sm810825edb.85.2021.01.20.02.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Jan 2021 02:26:18 -0800 (PST)
Subject: Re: [PATCH] drm/amd/display: Implement functions to let DC allocate
 GPU memory
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, alexander.deucher@amd.com
References: <20210119204030.2794877-1-Bhawanpreet.Lakha@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fab8baec-78fa-d816-3e05-ad94215c83f2@gmail.com>
Date: Wed, 20 Jan 2021 11:26:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119204030.2794877-1-Bhawanpreet.Lakha@amd.com>
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
Cc: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.01.21 um 21:40 schrieb Bhawanpreet Lakha:
> From: Harry Wentland <harry.wentland@amd.com>
>
> [Why]
> DC needs to communicate with PM FW through GPU memory. In order
> to do so we need to be able to allocate memory from within DC.
>
> [How]
> Call amdgpu_bo_create_kernel to allocate GPU memory and use a
> list in amdgpu_display_manager to track our allocations so we
> can clean them up later.

Well that looks like classic mid-layering to me with a horrible 
implementation of the free function.

Christian.

>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  9 +++++
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 40 +++++++++++++++++--
>   3 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e490fc2486f7..83ec92a69cba 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1017,6 +1017,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   
>   	init_data.soc_bounding_box = adev->dm.soc_bounding_box;
>   
> +	INIT_LIST_HEAD(&adev->dm.da_list);
> +
>   	/* Display Core create. */
>   	adev->dm.dc = dc_create(&init_data);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 38bc0f88b29c..49137924a855 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -130,6 +130,13 @@ struct amdgpu_dm_backlight_caps {
>   	bool aux_support;
>   };
>   
> +struct dal_allocation {
> +	struct list_head list;
> +	struct amdgpu_bo *bo;
> +	void *cpu_ptr;
> +	u64 gpu_addr;
> +};
> +
>   /**
>    * struct amdgpu_display_manager - Central amdgpu display manager device
>    *
> @@ -350,6 +357,8 @@ struct amdgpu_display_manager {
>   	 */
>   	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
>   	bool force_timing_sync;
> +
> +	struct list_head da_list;
>   };
>   
>   enum dsc_clock_force_state {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 3244a6ea7a65..5dc426e6e785 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -652,8 +652,31 @@ void *dm_helpers_allocate_gpu_mem(
>   		size_t size,
>   		long long *addr)
>   {
> -	// TODO
> -	return NULL;
> +	struct amdgpu_device *adev = ctx->driver_context;
> +	struct dal_allocation *da;
> +	u32 domain = (type == DC_MEM_ALLOC_TYPE_GART) ?
> +		AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM;
> +	int ret;
> +
> +	da = kzalloc(sizeof(struct dal_allocation), GFP_KERNEL);
> +	if (!da)
> +		return NULL;
> +
> +	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
> +				      domain, &da->bo,
> +				      &da->gpu_addr, &da->cpu_ptr);
> +
> +	*addr = da->gpu_addr;
> +
> +	if (ret) {
> +		kfree(da);
> +		return NULL;
> +	}
> +
> +	/* add da to list in dm */
> +	list_add(&da->list, &adev->dm.da_list);
> +
> +	return da->cpu_ptr;
>   }
>   
>   void dm_helpers_free_gpu_mem(
> @@ -661,5 +684,16 @@ void dm_helpers_free_gpu_mem(
>   		enum dc_gpu_mem_alloc_type type,
>   		void *pvMem)
>   {
> -	// TODO
> +	struct amdgpu_device *adev = ctx->driver_context;
> +	struct dal_allocation *da;
> +
> +	/* walk the da list in DM */
> +	list_for_each_entry(da, &adev->dm.da_list, list) {
> +		if (pvMem == da->cpu_ptr) {
> +			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
> +			list_del(&da->list);
> +			kfree(da);
> +			break;
> +		}
> +	}
>   }

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
