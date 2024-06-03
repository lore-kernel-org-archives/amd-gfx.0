Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3C4C25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 11:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD8010E15A;
	Mon,  3 Jun 2024 11:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V1PrjVs3";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1803110E15A
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 11:05:11 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-42121d28664so36141395e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Jun 2024 04:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717412709; x=1718017509; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GCBUJLfdhvprHitC4xGwEIDNEjx1Z1/MRUOYgj/BFvQ=;
 b=V1PrjVs3FuydzRLYFS0keMyXPxhZvJZbwzaNpoxxLD5TO6mWqdph/4KLGC1lmNkGxr
 BYnbRt+Ehg2xNJO/bojlGF8Mt/qYUeu681VuLTvuEPDAxMlDWwVqOdGRYWnk5VHRO4ea
 woJSNIqAO2Kw+mnqc7psGnCqfvIDKPqeUflY/Aw+Cbr6JMm6NYo0XWY7xbm2Pkat0Fpk
 CV9GfLgFFDGaWQ2ELua/970Ca3zCeCTq25Vx7px5R8laMxBDIP3E+0lEuLYgj66DcJxt
 k8M+A+EFfyzjAcpD0E2I2K80SvzNJSZTgAFX4VnNBr92TDIWkY/5Or7okull6MEhhwQl
 PmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717412709; x=1718017509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GCBUJLfdhvprHitC4xGwEIDNEjx1Z1/MRUOYgj/BFvQ=;
 b=MApYIah70lW6UwYTbWkxZ4bj4yLvNPmEkLoiAU9rAtnwazyJklPDXm2eXCZ+lEE3r3
 425YGVheAZBqtaAxykTxKIlnGnxChUpOmIOBnaags3almB0lyXXExvRvBy2P1UuZMhGI
 ps8wibQRPWwWgwEsW2D5t7wvN4ocgf2GGbgrwNbT1F3IMSOD3TL9tU+9m0n2Txo/1ERG
 MTbn5LnTW+0thdc84TlSQHmEWLQ+owwvqnZaL6lqnxgjgCjFh4rGdcbwRMoGpX6U2fBh
 XsMT5HgUeKiZrq5XYapyEDmEUDOjh4tkrJvN17pccHJD6VFmRrclYAzjI1sIfwFEvmVv
 bUbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFAwDMjNMedLkqNgd8QSD+qJ4me6gGPyhU/aIa2iJCIey+u+BxnD56EzhzojRwTv5f2LWYWO98+zoiLne+x0twwxqIybg76YqBnxF59g==
X-Gm-Message-State: AOJu0Yx75uw71ApdLKl73j/YdIUSTfKmZEvKBev9fVGfWEJUeMDV01AU
 yawoGwK97BxnO7F7Ufh8xJwy1+1ypjKcCrD7tZK9IW9XD1C6cgM7
X-Google-Smtp-Source: AGHT+IHScUJ3e3qFAN9YuSFiIU1dmnKm6cYowACg9pM5w0IKoUSnjHqFvAf62nQTpEiYg2n0qFQuCQ==
X-Received: by 2002:a05:600c:4704:b0:41f:e098:53e with SMTP id
 5b1f17b1804b1-4212e05ec5bmr79927645e9.17.1717412709056; 
 Mon, 03 Jun 2024 04:05:09 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213cd1c075sm34967215e9.0.2024.06.03.04.05.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:05:08 -0700 (PDT)
Message-ID: <9f3b4841-949f-4dbe-9b46-29e95ae34b41@gmail.com>
Date: Mon, 3 Jun 2024 13:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] drm/amdgpu: enhance amdgpu_ucode_request() function
 flexibility
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, alexander.deucher@amd.com
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
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

Am 31.05.24 um 08:52 schrieb Yang Wang:
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

Please drop that define and use NAME_MAX instead.

> +
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

That should probably have __printf() annotation so that the compiler can 
check the format and arguments.

See here 
https://elixir.free-electrons.com/linux/v6.10-rc2/source/include/linux/compiler_attributes.h#L171

Regards,
Christian.

>   void amdgpu_ucode_release(const struct firmware **fw);
>   bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
>   				uint16_t hdr_major, uint16_t hdr_minor);

