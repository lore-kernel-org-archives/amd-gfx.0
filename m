Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0B2106FD9E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E346410EB28;
	Fri, 13 Mar 2026 08:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="WvIWWQao";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C2E10EB28
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 08:25:16 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4853fd7b59aso11758955e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 01:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1773390315; x=1773995115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HbwFsW/ffBNv/udCrxKZCmfWCQvOiNCdNcwbOwm4wk8=;
 b=WvIWWQaodJGdKWM1+TH3V14wFAv6T1acRwaLkYpCnVBgEZ8vqWCASmGq5k2Zam7WPM
 W0OBE+PjDfvU+z9dLjiDs7QQc4QLC8tc6gHcsAmwr/n3En+eTnqPaVkgShH1NowolL+j
 0LsGMo+YRtHo11msQI3CKHXoskxVhUy/786GUZxvn2FRWr66Nxhz4Mz7iBWvp+nwqvcc
 VSpUomr/KJZkfQYAamh2XrAUotBr4yK5GMwcUas1DZ7lcVaxWHFGO/XTyRmjOkO1rRlW
 kfFK/PFGXcVCQFurOVrhCZQWP4WdwairZWJIBZDF3xaZ33+TJ/5kf2KxRiorq+RlUW3m
 fKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773390315; x=1773995115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HbwFsW/ffBNv/udCrxKZCmfWCQvOiNCdNcwbOwm4wk8=;
 b=J8pISw8Wxv6YXQjtWJ9Fw8DDNa1PB9kRQbREY48GNhtwF94+Mqc74BC/bT5eOMtGMA
 ZRMJgPS583PtHUy/C9qdfEa9TgP2RkbH/t0EWML8723kZK3Af9IEpTOBdVY6Ow67Vx/L
 GMlG4byoUDh4Nj1MCOrG4+iRzKZsfiDhYEgsM4DLZKdKo8CrldnfIG8cqF5ZFKbZ4YbF
 Pm2+nM+Tj/7RGkS3U9U8nG3cmWVIt83pFpGDBJf6c0noBffCGsORqYLmN2ryoH9G0JYj
 YNNAl9nns5eCbd1aYdctGf/a4KHBaS8DDtlLjE3353bkaOWi/Xp0nSA0XPPF+si5bYdM
 tjUg==
X-Gm-Message-State: AOJu0Yzdw3jraBZPH/rvTvO+181kbYLOzbBFb9C2fHs46L7+FMRNjoCK
 hasIb6psfMCfbSafBmzeNbFIXRZUQcJhVMhIHPAy+aa1hpUmK7E1dSlTJVNvGcGCClI=
X-Gm-Gg: ATEYQzxyMKWlzbS7WpwrtpAEnz/Rbqqyu6iMLsInnC0xYxWDSVPhNi//wwqATbuIv+x
 tG67pQpspIjLKTTZTXVAoHRiLa3h3XH1wsP7B24KgMdlh9Pg2fjn1GCuJ171BuUzLyR4O2BN0UY
 Vs0DQ77moActYqe12J9sI6bfzeALTCkC8oXT5xXA9D9OwsNv1Cajm39dWdZgjvijajgc4QS0Eab
 n83Wo/uufklcN0rWT64fhtpYxIRjtGf2Dl5gv7YUpw4Wiw7bz7RHoCRFosl4KTZ+sRU23z5DZ82
 N9W0GiYPQeoPxN6a6YB0qnoQzYCYEL3N1fxUpToQz6LPKZu7W+a8OlMIR7b4+PA6raV5+WKZxmQ
 jzSFSiyXjew4NlVKk41v40FctIlCwBjVFE5LRIv3ggPpYql6ob3WH6D/TvIyZOMWFiEsjpiKa/J
 NE/p16qEepEJZ+aBKqPgex8PoJWe0wGEKdXD3BogAdrM+6
X-Received: by 2002:a05:600c:1e8c:b0:485:41c4:e2e5 with SMTP id
 5b1f17b1804b1-485567090cdmr31379785e9.27.1773390314651; 
 Fri, 13 Mar 2026 01:25:14 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aac28bsm274812015e9.1.2026.03.13.01.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 01:25:14 -0700 (PDT)
Message-ID: <49f1aa0b-6ac5-4850-ace9-38b0570872e8@ursulin.net>
Date: Fri, 13 Mar 2026 08:25:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] drm/amdgpu/userq: Use kvfree instead of kfree in
 amdgpu_userq_wait_ioctl
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260313072140.3327678-1-sunil.khatri@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260313072140.3327678-1-sunil.khatri@amd.com>
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


On 13/03/2026 07:21, Sunil Khatri wrote:
> In function amdgpu_userq_wait_ioctl, drm_gem_objects_lookup allocates
> memory via kvmalloc and hence when that memory is freed the memory
> via kvfree.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 76f32fd768fb..fad595401a77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -936,11 +936,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   put_gobj_write:
>   	for (i = 0; i < num_write_bo_handles; i++)
>   		drm_gem_object_put(gobj_write[i]);
> -	kfree(gobj_write);
> +	kvfree(gobj_write);
>   put_gobj_read:
>   	for (i = 0; i < num_read_bo_handles; i++)
>   		drm_gem_object_put(gobj_read[i]);
> -	kfree(gobj_read);
> +	kvfree(gobj_read);
>   free_timeline_points:
>   	kfree(timeline_points);
>   free_timeline_handles:


Oops, my bad again.

2de9353e193f ("drm/amdgpu/userq: Use drm_gem_objects_lookup in 
amdgpu_userq_wait_ioctl")
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

