Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2A7C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 07:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88B710E85A;
	Thu,  6 Jun 2024 07:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VP0BbRnB";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF1310E85A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 07:40:45 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-52b912198a6so791454e87.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jun 2024 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717659643; x=1718264443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dDY5auWUz8FBBhvzsz7ohtiCRgDeUS2mK75OTFfYVVI=;
 b=VP0BbRnBcyX/niPfBXyo7XY/kd/ookzQ0rrGkQzVqzcqQ9RicDKC6+4gIbIy3u79AH
 DK3AyIJCj/KiaOXstnpGdSCulyNMufO+lVqjHcbkms0Esp2teekAhoH9lG2Qo+FK//RB
 ilK1SlJ4FDtxSHnvPxCCuAZF6fjPT2ZCUaAQFzA5aSbwPSkgM+6fzFXUgdJui/2l/jq9
 aLH8qRPJTgCNSbQHPv2wmGnI0oBAmIpi9/Uciy7wjpHI44BaGz0DDr25/b4JionSOKuj
 iPq7FALoBdLcago73WsjZBBfYnJzLDJkDOVU6uUheF1h/sslQxJfmmQUvQrsLkXB8XWs
 h45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717659643; x=1718264443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dDY5auWUz8FBBhvzsz7ohtiCRgDeUS2mK75OTFfYVVI=;
 b=Hwz3S8lKS66zCfgOnt3dag8yTwjrpfVpfrGHYs8KGMncu68YcE9GQg35v5KS/4UU7y
 1rbODujsdRQapQWBAalFpVne635I7GJI+0VVRyVwIq05fTlMTYnx6CQucLSW7FRMbEso
 RnmTEM1W/hL62krrG47qs2qQJMh6uWqt9bcHD5iRlpKLcBEOj8j5LivawYpDR7gQo7JN
 zrL+5jLWcVPWpkw33mpmtDNyIVr5ROknNPBA1QEAcbnnU25FZOCAHY2oTPhSz/vrA+cE
 5X/rgMXD9WcDNq88ghw40zLfDkLLsd/HibMlKZpie0vcJ5Ux4Hir7iuANPAmwkoo8kqG
 x5Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1/fcG52yeLt4TiKl/p3g49EcPSlJ9fJaWKCD2qliOaMo4T0Xv2ZiqqUg+y4pb1uwqCY9snDwwfxYcCic9QDizjXo0hLCp/3YBXRKkJA==
X-Gm-Message-State: AOJu0YyNioaN6akcI/YnTkibMtmSYa5o8DXX92zn9DdOsVMM+PKNIWrR
 cyMBVpmdimNl7TrIzjp/xAqUMb/cg76l58Ry9qY44OabwF21OdsSDsFTB0pb
X-Google-Smtp-Source: AGHT+IFAdaJ1gssyv6WVjrEYlTOw96+wXL2Bix14fOPkAGs7iUZiqfauJLuc4fTPl4f8i52NZoJs5w==
X-Received: by 2002:ac2:5de6:0:b0:529:a739:d48d with SMTP id
 2adb3069b0e04-52bab507894mr3211879e87.45.1717659642661; 
 Thu, 06 Jun 2024 00:40:42 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158110dfesm47234515e9.19.2024.06.06.00.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 00:40:42 -0700 (PDT)
Message-ID: <fa967f4d-11df-440c-a8d2-a4bcec6310fe@gmail.com>
Date: Thu, 6 Jun 2024 09:40:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] drm/amdgpu: enhance amdgpu_ucode_request() function
 flexibility
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
 <20240603014212.1969546-2-kevinyang.wang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240603014212.1969546-2-kevinyang.wang@amd.com>
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

Am 03.06.24 um 03:41 schrieb Yang Wang:
> Adding formatting string feature to improve function flexibility.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 30 +++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  3 ++-
>   2 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index a9de78bb96e2..a452d9b6afdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -28,6 +28,8 @@
>   #include "amdgpu.h"
>   #include "amdgpu_ucode.h"
>   
> +#define AMDGPU_MAX_FW_NAME_LEN		(128)
> +

Please drop that and use NAME_MAX instead.

>   static void amdgpu_ucode_print_common_hdr(const struct common_firmware_header *hdr)
>   {
>   	DRM_DEBUG("size_bytes: %u\n", le32_to_cpu(hdr->size_bytes));
> @@ -1432,28 +1434,40 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>    *
>    * @adev: amdgpu device
>    * @fw: pointer to load firmware to
> - * @fw_name: firmware to load
> + * @fmt: firmware name format string
> + * @...: variable arguments
>    *
>    * This is a helper that will use request_firmware and amdgpu_ucode_validate
>    * to load and run basic validation on firmware. If the load fails, remap
>    * the error code to -ENODEV, so that early_init functions will fail to load.
>    */
>   int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
> -			 const char *fw_name)
> +			 const char *fmt, ...)
>   {
> -	int err = request_firmware(fw, fw_name, adev->dev);
> +	char fname[AMDGPU_MAX_FW_NAME_LEN];
> +	va_list ap;
> +	int r;
> +
> +	va_start(ap, fmt);
> +	r = vsnprintf(fname, sizeof(fname), fmt, ap);
> +	va_end(ap);
> +	if (r == sizeof(fname)) {
> +		dev_warn(adev->dev, "amdgpu firmware name buffer overflow\n");
> +		return -EOVERFLOW;
> +	}
>   
> -	if (err)
> +	r = request_firmware(fw, fname, adev->dev);
> +	if (r)
>   		return -ENODEV;
>   
> -	err = amdgpu_ucode_validate(*fw);
> -	if (err) {
> -		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
> +	r = amdgpu_ucode_validate(*fw);
> +	if (r) {
> +		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fname);
>   		release_firmware(*fw);
>   		*fw = NULL;
>   	}
>   
> -	return err;
> +	return r;
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index db745ab7b0c8..5bc37acd3981 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -594,8 +594,9 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr);
>   void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
>   void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
>   void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
> +__printf(3, 4)
>   int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
> -			 const char *fw_name);
> +			 const char *fmt, ...);

This needs __printf() annotation so that the compiler can complain if we 
do something incorrect.

Regards,
Christian.

>   void amdgpu_ucode_release(const struct firmware **fw);
>   bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
>   				uint16_t hdr_major, uint16_t hdr_minor);

