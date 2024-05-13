Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FF4C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 11:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E22F10E6FC;
	Mon, 13 May 2024 11:54:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ifep1ceu";
	dkim-atps=neutral
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84E0510E6FC;
 Mon, 13 May 2024 11:54:58 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-2e0933d3b5fso62113581fa.2; 
 Mon, 13 May 2024 04:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715601296; x=1716206096; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gkWrpMbT160QX8etadVw3QNSncen2WpGm7FU8IV2vG8=;
 b=Ifep1ceudiC8uB+P1n1z+z9s+EYQvIP6S8aL25yWM8AJoSA5hEhUWWzm3JcTw0mVed
 OEJ4jyKA/sN27HAnZTD8GqN2hBdZPKM9m/hG0jJ/bocj7rlZ5Eueag8DEG+Lmfw6acnL
 RhxUUmJPttuyU9/wy86ZbuU+Sr/PE+zJsnuzRnO1Z5icgqwsDqQcg34oCly7baMqBVYH
 /j14NtwT/Tt6A2tNdzhEFNAvZBoj6kRJ1ZIN1bANo+J/Nt7B0gdKSyYfdw3yEtQDS2IC
 LKZf5hFTubsXx2jxNDq/MZV19GH95Demhe31ctzgDkadbYqQa6ENaGZPF251yDJr/kqu
 x4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715601296; x=1716206096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gkWrpMbT160QX8etadVw3QNSncen2WpGm7FU8IV2vG8=;
 b=ZlJ9IVCUf31SDIQJ3iZoDLWX5H1wl4AmEyGwM4RAZWbnGLng/TZcwzoeGrDXOivXq4
 OLZrcEHT1M1/M35FzUYHQ+hLamm4B6GBqOp5rJLn5z+ARCrBex17YsiCMVvfzRwYL9yV
 6PLSP5HVYeV8pITYARafJ4j2xVQduNYSaO12xX1usp03LM4a/az1i3MJ2kJxkVIYHOfK
 ZwR3820/JtSRq0eCueqrbKiqVQHH+nUW048H/wsFdbjoZsQJ77jIMWs1f69qZxce2nub
 7NgaGVChorpJ0PhATeDtucFBZxRa2iCE8eBObBGMStcnNEC8gCux8XqKx3ccj6L78aAy
 HFYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx7zG1JQQnJNj4wK6/k8l8T725xHL0Ijyll3txDEARHeDMyFOWsfSfi9Y2UrIVvZvihNcwcdKVvICfs7muGFNvETYDShIHrGPRLEbo9aZ18zA2XZBVFtfq/4Zz+/eI9wnbeBY3Xl16nxs2eXsc
X-Gm-Message-State: AOJu0YwZthPHMXy9Ytq7B4G6sg/S5wX3+NtlvWN4Fopi7vDg/jdBcBTA
 b4XSy51RGXwdSOGDgA3Vo9l1ZgcD9ece7LyeuvlWNxpQpYflLQ/w
X-Google-Smtp-Source: AGHT+IHavjprewU8HemKAAUcDJry0RMSDZxfPy8GbQ+53u+j5iKEKjHG05nrkouXF+12V6vxjItN3Q==
X-Received: by 2002:a2e:b1c6:0:b0:2e1:f6f7:89c7 with SMTP id
 38308e7fff4ca-2e5204aee0dmr53224501fa.49.1715601296155; 
 Mon, 13 May 2024 04:54:56 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f88111033sm191061725e9.34.2024.05.13.04.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 04:54:55 -0700 (PDT)
Message-ID: <849adc1e-b4fc-4fd1-aefb-d5da2d8c560a@gmail.com>
Date: Mon, 13 May 2024 13:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] drm/amdgpu: don't trample pdev drvdata
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, amd-gfx@lists.freedesktop.org
References: <20240510181212.264622-22-matthew.auld@intel.com>
 <20240510181212.264622-24-matthew.auld@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240510181212.264622-24-matthew.auld@intel.com>
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

Am 10.05.24 um 20:12 schrieb Matthew Auld:
> The driver release callback is called when a particular drm_device goes
> away, just like with drmm, so here we should never nuke the pdev drvdata
> pointer, since that could already be pointing to a new drvdata.
> For example something hotunplugs the device, for which we have an open
> driver fd, keeping the drm_device alive, and in the meantime the same
> physical device is re-attached to a new drm_device therefore setting
> drvdata again. Once the original drm_device goes away, we might then
> call the release which then incorrectly tramples the drvdata.
>
> The driver core will already nuke the pointer for us when the pci device
> is removed, so should be safe to simply drop. Alternative would be to
> move to the driver pci remove callback.
>
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org

Oh! Very good catch! That might become important for a feature we 
current discuss internally.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index a0ea6fe8d060..d5fed007c698 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1450,7 +1450,6 @@ void amdgpu_driver_release_kms(struct drm_device *dev)
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   
>   	amdgpu_device_fini_sw(adev);
> -	pci_set_drvdata(adev->pdev, NULL);
>   }
>   
>   /*

