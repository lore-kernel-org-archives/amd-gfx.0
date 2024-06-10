Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1817C27C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 09:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4B010E3FB;
	Mon, 10 Jun 2024 09:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IhBjuGDN";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB6810E3FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 09:37:37 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-52bbf73f334so2483304e87.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718012255; x=1718617055; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2wJXnIgW9bIQoKoJwN0ytu/ss2Q2jPLdNZjykSElPj4=;
 b=IhBjuGDNIHoRmpJ3Bvqx8LCJR46ixiu885rZhyQCZG3SC6sbYvQNYwdpNmmMDLFJo5
 JsQeN8POjOsDzCdGms5ZCBGiG27kcuj/n/aWXUD5DkoRTHEYyFiQpBvm27f1seruehg6
 J83DR3u0URvzh4JWBiq2iRWAxVDJ+JRJgbsyh2zJ1v/AdUsdFC2mrrM5n17Auj7jwGB9
 Pltr7wCjGnU9ZLyeRJuWRbxjnC95mGkI11/8QQqNUWuEKLhXu8/Oo+UXTSrM3Gz113yG
 TQ9htbeOqrmbj2sT4iNd+3NUSHotwWAsX2na7pfumCWM5rqKmFQ38WzeriygICo9f1AL
 NDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718012255; x=1718617055;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wJXnIgW9bIQoKoJwN0ytu/ss2Q2jPLdNZjykSElPj4=;
 b=MmAb+Bk16AJ75/xX8VJRXxHi3apNVDa27XaYoRhEnDpCFiVR5pxvpFHZz+pIii7JbK
 rXwvsm/bCPDWeKZODyz8ftO0XbmKUNlaMwqsz8ZmMiMg1uwmbaEzBOiOr1sJ2RSrw0Qo
 2YlLzlzGLK8manwRXNK6pf1a2OAC5B8t4fA576U+GNXfFSfy8HT4iLPR7myc+jjnWkHE
 bk19PlxzyzkJlDE1Pm/rb31UGjwSiqIwuWR0VvSbWR4Eo/TU6JdtgYiIfWTloNJo1R0u
 sGQm4JxnUoGc2rqNwDd0SlWtIt3BL9lyNuOYcnbZ/v+//3lpIWoVNJvpUAT0av5iOzeu
 emcg==
X-Gm-Message-State: AOJu0YwtCJbgUlpQ3g+kjbS41FwDVMQLgYnJYRr2nro+WfDh4xbhqx56
 eOkIWRvzBph6WQRs/bhla6WlBI7pvyDhOiA0Wm0pg835pggHRAwr
X-Google-Smtp-Source: AGHT+IHQPrM9cSLj6BqkKHp8KYWnVz2wwh4VaAaCzQ3y5/tCZLS+sXoPiCQUIo0qwghhlKxIalfyDA==
X-Received: by 2002:a05:6512:12c4:b0:52c:8a12:3d3b with SMTP id
 2adb3069b0e04-52c8a123eacmr1856006e87.56.1718012254612; 
 Mon, 10 Jun 2024 02:37:34 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c1aa2f7sm134421525e9.14.2024.06.10.02.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 02:37:34 -0700 (PDT)
Message-ID: <6e6acab2-2f6f-4104-8d65-081c7a206409@gmail.com>
Date: Mon, 10 Jun 2024 11:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amdgpu: explicitely set the
 AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
To: pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20240610092611.2894-1-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20240610092611.2894-1-christian.koenig@amd.com>
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

Just FYI: This is a completed untested set of WIP patches.

But it might get you a step closer of avoiding grabbing the runtime PM 
references.

Regards,
Christian.

Am 10.06.24 um 11:26 schrieb Christian König:
> Instead of having that in the amdgpu_bo_pin() function applied for all
> pinned BOs.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c             | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c              | 1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                | 1 +
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c                  | 2 ++
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c                  | 2 ++
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                   | 2 ++
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c                   | 2 ++
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c    | 1 +
>   9 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index cfec85563bc6..7ef518d888dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -233,6 +233,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
>   	}
>   
>   	if (!adev->enable_virtual_display) {
> +		new_abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   		r = amdgpu_bo_pin(new_abo,
>   				  amdgpu_display_supported_domains(adev, new_abo->flags));
>   		if (unlikely(r != 0)) {
> @@ -1739,6 +1740,7 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev)
>   
>   			r = amdgpu_bo_reserve(aobj, true);
>   			if (r == 0) {
> +				aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   				r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
>   				if (r != 0)
>   					dev_err(adev->dev, "Failed to pin cursor BO (%d)\n", r);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1eadcad1856d..f5a33178651e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1003,7 +1003,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>    */
>   int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
>   {
> -	bo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   	return amdgpu_bo_pin_restricted(bo, domain, 0, 0);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index e30eecd02ae1..2ce99ab63e4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -335,6 +335,7 @@ static int amdgpu_vkms_prepare_fb(struct drm_plane *plane,
>   	else
>   		domain = AMDGPU_GEM_DOMAIN_VRAM;
>   
> +	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   	r = amdgpu_bo_pin(rbo, domain);
>   	if (unlikely(r != 0)) {
>   		if (r != -ERESTARTSYS)
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index b44fce44c066..ff99475f7225 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1881,6 +1881,7 @@ static int dce_v10_0_crtc_do_set_base(struct drm_crtc *crtc,
>   		return r;
>   
>   	if (!atomic) {
> +		abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   		r = amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM);
>   		if (unlikely(r != 0)) {
>   			amdgpu_bo_unreserve(abo);
> @@ -2401,6 +2402,7 @@ static int dce_v10_0_crtc_cursor_set2(struct drm_crtc *crtc,
>   		return ret;
>   	}
>   
> +	aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
>   	amdgpu_bo_unreserve(aobj);
>   	if (ret) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> index 80b2e7f79acf..bae0d5ea4a4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -1931,6 +1931,7 @@ static int dce_v11_0_crtc_do_set_base(struct drm_crtc *crtc,
>   		return r;
>   
>   	if (!atomic) {
> +		abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   		r = amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM);
>   		if (unlikely(r != 0)) {
>   			amdgpu_bo_unreserve(abo);
> @@ -2485,6 +2486,7 @@ static int dce_v11_0_crtc_cursor_set2(struct drm_crtc *crtc,
>   		return ret;
>   	}
>   
> +	aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
>   	amdgpu_bo_unreserve(aobj);
>   	if (ret) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index db20012600f5..ac4271a84cc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1861,6 +1861,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
>   		return r;
>   
>   	if (!atomic) {
> +		abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   		r = amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM);
>   		if (unlikely(r != 0)) {
>   			amdgpu_bo_unreserve(abo);
> @@ -2321,6 +2322,7 @@ static int dce_v6_0_crtc_cursor_set2(struct drm_crtc *crtc,
>   		return ret;
>   	}
>   
> +	aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
>   	amdgpu_bo_unreserve(aobj);
>   	if (ret) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index 5b56100ec902..29bbf083c5d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1828,6 +1828,7 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crtc *crtc,
>   		return r;
>   
>   	if (!atomic) {
> +		abo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   		r = amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM);
>   		if (unlikely(r != 0)) {
>   			amdgpu_bo_unreserve(abo);
> @@ -2320,6 +2321,7 @@ static int dce_v8_0_crtc_cursor_set2(struct drm_crtc *crtc,
>   		return ret;
>   	}
>   
> +	aobj->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   	ret = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
>   	amdgpu_bo_unreserve(aobj);
>   	if (ret) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index b339642b86c0..81e87c079624 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -890,6 +890,7 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   	else
>   		domain = AMDGPU_GEM_DOMAIN_VRAM;
>   
> +	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   	r = amdgpu_bo_pin(rbo, domain);
>   	if (unlikely(r != 0)) {
>   		if (r != -ERESTARTSYS)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 08c494a7a21b..0d5fefb0f591 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -114,6 +114,7 @@ static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector
>   
>   	domain = amdgpu_display_supported_domains(adev, rbo->flags);
>   
> +	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   	r = amdgpu_bo_pin(rbo, domain);
>   	if (unlikely(r != 0)) {
>   		if (r != -ERESTARTSYS)

