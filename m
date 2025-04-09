Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA4AC36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 13:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C121E10E064;
	Wed,  9 Apr 2025 13:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ES2Nk4nI";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9611A10E8C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 13:44:10 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so5329856f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Apr 2025 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744206249; x=1744811049; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1gDreW5HNfCxwpyGFHBxgmfdz5tpyJHtJtQMxc8B/0A=;
 b=ES2Nk4nIjN9thfd64cwDzNDsufrctZq1bzXIlIcgHzvL0jR0jCrPwC/TPW0t3gDdfo
 +4zBGf1ZhJq6Se3JO87FlWWGLgkbCqI1IHs3LsG//dIUG+71cEzM0/ojwCMZpM4joXkD
 A7S3waVCyO1Cww6m7649dstJ75fGEE2tDm25vUFUwa/BiBkJAyAS6ZTRCy46t1PfSqnh
 kFCshUjdgh4ehGGFNDe92OnHNjg9gml12EbEJ0KHpLP+oRskO2QX+/rLu0Bvi0rwAdIk
 fd3YbJ3o2JaDV0EhTII5WYcPmUDjcZfBQiNBKYrigJ33m6vhLjd8pUwJ1KmIWJ1cCWLq
 VQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744206249; x=1744811049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1gDreW5HNfCxwpyGFHBxgmfdz5tpyJHtJtQMxc8B/0A=;
 b=ageTtaF9Wa0Jtc5tOG2If6ijvmE2qg+zdFWbYmcSB9+qBChsxRDDZLn3uizQ04ePgK
 nVF1PJr6OAFmlfJooWhLbdP++gbB+mCo2vJWcyaBRDF9um5NZGBat1Pocl+9scNrmtNc
 iiy6LsNQz4MXxDbnBZBgNcw7XAssmNipsx55Jfxds512U7+YJjsJ6xo7yqIR40tpvt8y
 6yeKwv8bvNaw9WFDgClAB7OkGAvGgDjnQjZgaIbUg6fJlEYqg3TQxh5lfuzXMfSbCoJy
 SEibhLtZFbNpXHwUPMATfKQqR/8qsPuELsp/PEJGkECUOgutuXGsyjkiIUjP22HP99U8
 SbQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwGZD4kn0KsVm7wwnWcaQoC7hwWpxu7gFgQaXjaw2XL5zDt5huWbq3M9sSX9uj/zMxN9nVYBcL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbRnrHW9XYjYPKqssBg8lZcqfyvLCWpDelzviVaIuIQm5QxUX/
 fj7R1xFltqde6m5rXWJd7WkfyqKAu/gy0yY07mjuve1lWR5wfcl3
X-Gm-Gg: ASbGncuL+PIBwHNb97UbCsOHaEzmvEtRGmvZjWyyj8TtouLdPwNTKBPtgELcWTnJ/VG
 5d85bu6yysDxR9LlUqpIkm0eQLGgyn5WDzVbEXqFsWzLW1fY/UwaPfdxZyfYTf+bQz//oZ713Sf
 kpBAPTJTfZeqAA2qeD+U+5kyudvTDG7il7wk1bfbAOs0fvYZI+C9K87d3Ete9D7pSGijXqLV8Zs
 1Tn9wV0lOomG7sLfJVBQbU3/i9B44xHteKEmFpTaDdIr3SyVfLqWgg2Yj54tE4yrTwK1hi8ZDxZ
 naFksYMuTpsJp59eSBE3Be+w9rAfXXaLn/fbRVfTuoVwt/RGpOOYE02bEnDolnPdQOwROr3b/AX
 iaRMh
X-Google-Smtp-Source: AGHT+IE+J+23UttdJtvRyNCMnt6ZHJ73qwkfHqTj8/S90W2mefCuKgTUf5sxd7OW6EsOi64C8xsIoA==
X-Received: by 2002:a05:6000:18ae:b0:391:2d76:baaa with SMTP id
 ffacd0b85a97d-39d88561240mr2306937f8f.46.1744206248968; 
 Wed, 09 Apr 2025 06:44:08 -0700 (PDT)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893f0cfdsm1697320f8f.76.2025.04.09.06.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 06:44:08 -0700 (PDT)
Message-ID: <37c69d11-c82e-4ef9-9e01-661869cdb9d0@gmail.com>
Date: Wed, 9 Apr 2025 15:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace tmp_adev with hive in
 amdgpu_pci_slot_reset
To: Ce Sun <cesun102@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dan.carpenter@linaro.org
References: <20250409133955.26169-1-cesun102@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20250409133955.26169-1-cesun102@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Am 09.04.25 um 15:39 schrieb Ce Sun:
> Checking hive is more readable.
>
> The following smatch warning:
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:6820 amdgpu_pci_slot_reset()
> warn: iterator used outside loop: 'tmp_adev'
>
> Fixes: 8ba904f54148 ("drm/amdgpu: Multi-GPU DPC recovery support")

I think we should drop that. While the existing code didn't looked nice it would actually work as far as I can see.

> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Ce Sun <cesun102@amd.com>

Apart from that Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 60269fba5745..6fb234832ff3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6784,8 +6784,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_reset_context reset_context;
> -	struct amdgpu_device *tmp_adev = NULL;
> -	struct amdgpu_hive_info *hive = NULL;
> +	struct amdgpu_device *tmp_adev;
> +	struct amdgpu_hive_info *hive;
>  	struct list_head device_list;
>  	int r = 0, i;
>  	u32 memsize;
> @@ -6846,7 +6846,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  		dev_info(adev->dev, "PCIe error recovery succeeded\n");
>  	} else {
>  		dev_err(adev->dev, "PCIe error recovery failed, err:%d\n", r);
> -		if (tmp_adev) {
> +		if (hive) {
>  			list_for_each_entry(tmp_adev, &device_list, reset_list)
>  				amdgpu_device_unset_mp1_state(tmp_adev);
>  			amdgpu_device_unlock_reset_domain(adev->reset_domain);

