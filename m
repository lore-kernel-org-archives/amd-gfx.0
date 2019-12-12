Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B5C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D5A214AF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fj+Bb8Ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D5A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9190D6EC7C;
	Thu, 12 Dec 2019 08:14:30 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 058406EC7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 08:14:29 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id d16so1636419wre.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 00:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=8wOUY+w/NGxXkq8M/lgvMtcWnGrLxBhX56u8nJsURKw=;
 b=fj+Bb8NyJ+1CJaRhE53eIFEC1ymYmgPClGZZ45K3GpllDVDRNDbLSzL7WVxSfqDZmu
 DDJoBBzwBTG0u+iIwNW0VR32aOrAFCx9ICASAC/JQCCWllNGLkplA4AoZKU+fclZBngq
 Jy62nVrBPSKWq5s7ojPhkRhl0Czf6s8nbLrXO29oHKBqYPbsjzw6C5Giol9DFAyARxY1
 uQv0zHaIPW6qm3wPQM0KB8xCp/bcLEky4w3W56I9qPVMFz2k5JlPzkV0ygytrPu+hpR3
 pK3Vv/2ERvkDnn/cCOc5BsojoHf5GjryWApWZL3FQxehAiIWiVMiByqDBWHqRKm+E7qw
 lk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=8wOUY+w/NGxXkq8M/lgvMtcWnGrLxBhX56u8nJsURKw=;
 b=h1X+UNvFG2Dz8KcXIuMic0jwtsMhYnozgUEMbVWLHFQ8QTchlb9ZVgPTNn5gkpwCX/
 4R4yjWGTzjO5xNg1u3mTXQ3ike2d5k/Shpr/yPZmXyvvBCX822CHyed0FVo8iV8c5HMH
 NtA4zT4l9z+vIxLE7YhmmKeR6IRkjG1sH5ur3pNr0PpJTIogkrsFfBgphlzqdZ2pcESC
 v036jphB+7cWOrnuGxfWtICtwEsKJqg2HKGRx7w0hHq+oLToa09t7UGu2aJVmOCpl0px
 bsNlPT+M1KPcw5cj1pQgkYHfY4N578Zb019yaRuiHfTlv0ShpeBc7mLaeeQhxGL33xUx
 JJQw==
X-Gm-Message-State: APjAAAV+FpeydrOaTENlvpxV6tE07KIjpJUwuiNnmY2rN+qoC8mhpZ/V
 W5CTd6Rzcmes7eA5ygCFtog=
X-Google-Smtp-Source: APXvYqwsra39DkmaPTsIotKWJ9anpTeuIeoUamNq01rSedVch+6eb0JK9vBe8a5FDLvQBRwGQllwkQ==
X-Received: by 2002:adf:eb09:: with SMTP id s9mr4893819wrn.61.1576138467524;
 Thu, 12 Dec 2019 00:14:27 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u8sm5242877wmm.15.2019.12.12.00.14.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 00:14:26 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: s/ENCRYPTED/SECURE/ on GEM create flag
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191211162112.1991270-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5f7d3d51-71fd-76e7-91f9-3d48fafdcf57@gmail.com>
Date: Thu, 12 Dec 2019 09:14:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211162112.1991270-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.12.19 um 17:21 schrieb Alex Deucher:
> Rename to SECURE to align with the CS flag naming.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I was rather close to given an acked-by, but then thought if that 
actually makes sense.

The flags describe what should happen to the buffer and CS, and 
considering that to distinct that actually makes sense.

In other words the buffer is encrypted and because of this can only be 
accessed by a secure submission.

Regards,
Christian.

> ---
>
> Several other teams thought it would be cleaner to call it SECURE
> since it aligns better with the CS interface.  I don't have a
> strong opinion either way.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
>   include/uapi/drm/amdgpu_drm.h              | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f39012e4a0fa..0691692f096e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -227,7 +227,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   		      AMDGPU_GEM_CREATE_VRAM_CLEARED |
>   		      AMDGPU_GEM_CREATE_VM_ALWAYS_VALID |
>   		      AMDGPU_GEM_CREATE_EXPLICIT_SYNC |
> -		      AMDGPU_GEM_CREATE_ENCRYPTED))
> +		      AMDGPU_GEM_CREATE_SECURE))
>   
>   		return -EINVAL;
>   
> @@ -235,7 +235,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
>   		return -EINVAL;
>   
> -	if (!adev->tmz.enabled && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
> +	if (!adev->tmz.enabled && (flags & AMDGPU_GEM_CREATE_SECURE)) {
>   		DRM_ERROR("Cannot allocate secure buffer while tmz is disabled\n");
>   		return -EINVAL;
>   	}
> @@ -261,7 +261,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   		resv = vm->root.base.bo->tbo.base.resv;
>   	}
>   
> -	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
> +	if (flags & AMDGPU_GEM_CREATE_SECURE) {
>   		/* XXX: pad out alignment to meet TMZ requirements */
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 2eeafc77c9c1..5728e5a27fb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -232,7 +232,7 @@ static inline bool amdgpu_bo_explicit_sync(struct amdgpu_bo *bo)
>    */
>   static inline bool amdgpu_bo_encrypted(struct amdgpu_bo *bo)
>   {
> -	return bo->flags & AMDGPU_GEM_CREATE_ENCRYPTED;
> +	return bo->flags & AMDGPU_GEM_CREATE_SECURE;
>   }
>   
>   bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 918ac3548cd3..2ae80d31aecf 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -135,11 +135,11 @@ extern "C" {
>    * releasing the memory
>    */
>   #define AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE	(1 << 9)
> -/* Flag that BO will be encrypted and that the TMZ bit should be
> +/* Flag that BO will be secure and that the TMZ bit should be
>    * set in the PTEs when mapping this buffer via GPUVM or
>    * accessing it with various hw blocks
>    */
> -#define AMDGPU_GEM_CREATE_ENCRYPTED		(1 << 10)
> +#define AMDGPU_GEM_CREATE_SECURE		(1 << 10)
>   
>   struct drm_amdgpu_gem_create_in  {
>   	/** the requested memory size */

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
