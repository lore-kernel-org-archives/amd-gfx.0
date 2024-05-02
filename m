Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA99C04FFE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 13:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6821B10F58C;
	Thu,  2 May 2024 13:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VsQ2ngT5";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325EE10F58C
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 13:16:50 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-349545c3eb8so5109677f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 06:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714655808; x=1715260608; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uBf44ZZn8B+wSMze9H+J/Tx1J+pUi/cljzLCff+BXlI=;
 b=VsQ2ngT59v4OnB6rNZdrjev16hdnL4xUji1DI6WIJkUa66mEdLwbAb8xU1lqmyzjwr
 C4D8ogKSwoTWD3D0RfsDAVW1kYheH2Gl9BONMiHG9SsvuvY5u5w2Y9sldMJxz2P7xQA3
 yqSuoqn6gnRExDUSHgObi6aEgNc7AEWONvJXHx6hyIGCw8RMFp9fKbDHxW8JwFoRFOQm
 xNpG7tBFDSxTcBVsWzkiZRQEgUQ89Lg5QUw0rAISEHFEdfn3/3QOBtJLBKvM6uvOPZ4Z
 bcsWbGwOuKAZ0ym6G6jQlsD7Wn8/gukqjDYUPP2PCcWXG15R2BgcRfVL5q+ZV3SHMHZP
 xX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714655808; x=1715260608;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uBf44ZZn8B+wSMze9H+J/Tx1J+pUi/cljzLCff+BXlI=;
 b=PidY5Uu7uyuqG6fZp0nXa5QTRDZFG00eM84z1YkDQLYR3UXUjpv9a/LT3q1U4Riqkh
 jNjkOmdKLrM9d5cy53gyOQEHfe9MIYNTQ6vuaNyoTPVRHfX4lJ8y73oKOCgu7sZQOxEl
 Jtdaeu4BzkTn4RaOgkwZLtN9G5xfD0XcT5XlCQQFhY0owp44mCKeLgmpXbGLr8mDRMYF
 fIWYI2iEpKcJ+j2nQMVw5sAD5gwDWsig3fvjK9DpLXMrZxxulOxacjbgEzmnxQ2YtJDx
 GXLEFskxKj5kF+0MdC93k4T/uU1ptY0apKe7mtl3U/+PiQOgGXvHU+CW7wTgnhqtBlg8
 fv4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmda0LBGYWflvb87z5/98rKjwm4J3Rb/doHSaz5atZiXsYa/JFAKDIcMb7/T6UstJ6Dbq+9AKrVkNUFjwx4fe/XKQmMedEZ7v6oWBTig==
X-Gm-Message-State: AOJu0YyYxkj6W5O/qNyBNoNjiQUiYLEmuouL+D+10fIlr6NLwlAg3avx
 SM0zk2GmSk2L1mKVIe9b3Cs/ReHDcya6MHav0T2KQ7YxzAutDF+V
X-Google-Smtp-Source: AGHT+IFV0sso42zQ+MNRztDcUtlDudnWJljuYELNC2ulGRRFCNC4fEBAxN/eO3op4KjMxbaktSlSyA==
X-Received: by 2002:adf:f3c7:0:b0:34d:b5c7:65f1 with SMTP id
 g7-20020adff3c7000000b0034db5c765f1mr3523222wrp.65.1714655808161; 
 Thu, 02 May 2024 06:16:48 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 z18-20020adff1d2000000b0034df178a9acsm1244510wro.99.2024.05.02.06.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 06:16:47 -0700 (PDT)
Message-ID: <00d43d65-333e-4b2d-861e-11d01e7931b0@gmail.com>
Date: Thu, 2 May 2024 15:16:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] drm/amdgpu: Only show VRAM in fdinfo if it exists
To: Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20240430172748.61576-1-tursulin@igalia.com>
 <20240430172748.61576-6-tursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240430172748.61576-6-tursulin@igalia.com>
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

Am 30.04.24 um 19:27 schrieb Tvrtko Ursulin:
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Do not emit the key-value pairs if the VRAM does not exist ie. VRAM
> placement is not valid and accessible.

Yeah, that's unfortunately rather misleading.

Even APUs have VRAM or rather stolen system memory which is managed by 
the graphics driver.

We only have a single compute model which really doesn't have VRAM at all.

Regards,
Christian.

>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 29 +++++++++++++---------
>   1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> index a09944104c41..603a5c010f5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
> @@ -83,25 +83,30 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
>   	 */
>   
>   	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
> -	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
>   	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
>   	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
> -	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
> -		   stats.visible_vram/1024UL);
> -	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
> -		   stats.evicted_vram/1024UL);
> -	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
> -		   stats.evicted_visible_vram/1024UL);
> -	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
> -		   stats.requested_vram/1024UL);
> -	drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
> -		   stats.requested_visible_vram/1024UL);
>   	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
>   		   stats.requested_gtt/1024UL);
> -	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
>   	drm_printf(p, "drm-shared-gtt:\t%llu KiB\n", stats.gtt_shared/1024UL);
>   	drm_printf(p, "drm-shared-cpu:\t%llu KiB\n", stats.cpu_shared/1024UL);
>   
> +	if (!adev->gmc.is_app_apu) {
> +		drm_printf(p, "drm-memory-vram:\t%llu KiB\n",
> +			   stats.vram/1024UL);
> +		drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
> +			   stats.visible_vram/1024UL);
> +		drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
> +			   stats.evicted_vram/1024UL);
> +		drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
> +			   stats.evicted_visible_vram/1024UL);
> +		drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
> +			   stats.requested_vram/1024UL);
> +		drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
> +			   stats.requested_visible_vram/1024UL);
> +		drm_printf(p, "drm-shared-vram:\t%llu KiB\n",
> +			   stats.vram_shared/1024UL);
> +	}
> +
>   	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
>   		if (!usage[hw_ip])
>   			continue;

