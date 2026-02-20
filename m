Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D2FC5518F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 11:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBCB10E7EB;
	Fri, 20 Feb 2026 11:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="V5T3Vj4q";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E40B10E7EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 11:24:47 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so19911975e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 03:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1771586685; x=1772191485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hy5VInt5sZBNbKVyIpl2EWEo+We0uteVb+haTqbEUVI=;
 b=V5T3Vj4qKheW0VVB31v3aI/kO7HI/7LsCwnMy34YqoqABfnom1vhdMwaTWXTKfFzfd
 sD08C8SrHpCebITLxZiLe4wu9Q32XkkDjtWa6P9VL6SpdzOM/6/bGsqE5UyWjE7sju98
 SLN46Mv12VgusjXBcInetZwyL6DR3cwamag1qyQt1EpkzSEbxOe/g9nwdzDlKXP4pEtB
 iLkGJePf5WX7qC+4G2amAAxPRBesuRkx0jbDXjJqSIk4xW0Eo5osEWRcqMvmc1oAoTpW
 oNf1x0VOlwaX1fiwhv73gnjfGp2Wx5SHe+/RtgeARVqPOv4hLx6Z7e4/Cp5P/R8pKJLD
 bqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771586685; x=1772191485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hy5VInt5sZBNbKVyIpl2EWEo+We0uteVb+haTqbEUVI=;
 b=P1Jz4KvrtI1z2VBnPI97cASx4w87DiCzEdEEDE0HqRYV+Kgcy+0Ggqg8Wgv0mJmq2R
 VNAou2Y8DyIq2ecsbQYdezQuGnZH0INGq+jwAJq2Y+bcOlAw4BZSFUIJVE5bc1ksMHGX
 dZ9tClY06cQm1zezgXV4OxWyE50bl/47lzwbV/PpW5v4v5Sup2zfUtVwuGukm2Yzb+lt
 FIJqzI5aeVgv+BM+XbJLmk5Y0Ia7C1e2n/HCTYwEJ92ifao2Mzv9+fSZr70EWxcBQc07
 TwRCNQhNn+lwe0AeZwHICTKJat+Jhd/HJuILnJVdUZX4XSwE32Drp3sou8o1xfs80qKe
 jvKA==
X-Gm-Message-State: AOJu0Yy6YWzdLT1szkbG93kO43iyhfWJYoV4ql4FyGqgwyHDEMSn1mFi
 r9mO2l/hGk7+XWYWgD7udbmrjVRlBnXYxpUlIy9iNxIJnpocdRq/CnynT0EsEjL8gjpHzlnhdCb
 NB5BfVTg=
X-Gm-Gg: AZuq6aKxyHusDpnPc8C59zg2JyydUu35Snsq96djxkNG7kf2pmLjRd7q51qzOxbq3Xx
 FBsg3i5plHHpuueroBrHqv7+pULIk0qXsv/wbV98kL2UhJXoC2l0YSGS9+4FxT9uBtszSXUMhkA
 MyH+bWK1MnQBL+vmnKmmJVR3BeMBx3IDy+jRMUd+nXaLioKmsKODwoOsQo36fxux7pYwJgHb+D+
 f92uk27o/XIB3uWEq/q4kszKFAk7RBXNkxcIC7zwTKqItAaksWXkD0StCisIdckfgqbAsYs7StP
 6/AGyDC6JPUpD1Y8slowCmP4l9JNEG0WnBlxrqNUoi1UDFqCFdwnDC+/V4Wl9TrxhusUlHRs1BK
 q9L56vIS+yWE1qEuWWOcsWgO+Ng/bZlBUlu7dNhQ1F8Q+RhunHOc6ckIrAdOSWPVWsnsxyXt8Db
 QPPjxMzpXTHyF41cPgw1ga1oYSW2Yz2BJe2YSMw2PgzED6rTyHp3FYNco=
X-Received: by 2002:a05:600c:3f0a:b0:480:52fd:d2e4 with SMTP id
 5b1f17b1804b1-483a52b2e32mr27208995e9.0.1771586684877; 
 Fri, 20 Feb 2026 03:24:44 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a430a33esm17948875e9.32.2026.02.20.03.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 03:24:44 -0800 (PST)
Message-ID: <3c7f24f3-d1f7-4724-bf2e-8540fa2e2648@ursulin.net>
Date: Fri, 20 Feb 2026 11:24:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: update memdup_user with
 memdup_array_user
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260220082840.2192325-1-sunil.khatri@amd.com>
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


On 20/02/2026 08:28, Sunil Khatri wrote:
> memdup_user could return invalid memory allocation if
> there is an integer overflow. Using memdup_array_user
> make sure we validate the size requirements upfront
> and return with an error.

FYI:

https://lore.kernel.org/amd-gfx/20251205134035.91551-1-tvrtko.ursulin@igalia.com/

And later:

https://lore.kernel.org/amd-gfx/20260202125149.2067-7-christian.koenig@amd.com/.

Regards,

Tvrtko

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 +++++++++----------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 212056d4ddf0..a6eb703b62c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -480,8 +480,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   		return -ENOTSUPP;
>   
>   	num_syncobj_handles = args->num_syncobj_handles;
> -	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
> -				      size_mul(sizeof(u32), num_syncobj_handles));
> +	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
> +					    num_syncobj_handles, sizeof(u32));
>   	if (IS_ERR(syncobj_handles))
>   		return PTR_ERR(syncobj_handles);
>   
> @@ -501,8 +501,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	num_read_bo_handles = args->num_bo_read_handles;
> -	bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_read_handles),
> -				      sizeof(u32) * num_read_bo_handles);
> +	bo_handles_read = memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
> +					    num_read_bo_handles, sizeof(u32));
>   	if (IS_ERR(bo_handles_read)) {
>   		r = PTR_ERR(bo_handles_read);
>   		goto free_syncobj;
> @@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	num_write_bo_handles = args->num_bo_write_handles;
> -	bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_write_handles),
> -				       sizeof(u32) * num_write_bo_handles);
> +	bo_handles_write = memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
> +					     num_write_bo_handles, sizeof(u32));
>   	if (IS_ERR(bo_handles_write)) {
>   		r = PTR_ERR(bo_handles_write);
>   		goto put_gobj_read;
> @@ -666,37 +666,37 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>   		return -ENOTSUPP;
>   
>   	num_read_bo_handles = wait_info->num_bo_read_handles;
> -	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
> -				      size_mul(sizeof(u32), num_read_bo_handles));
> +	bo_handles_read = memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
> +					    num_read_bo_handles, sizeof(u32));
>   	if (IS_ERR(bo_handles_read))
>   		return PTR_ERR(bo_handles_read);
>   
>   	num_write_bo_handles = wait_info->num_bo_write_handles;
> -	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
> -				       size_mul(sizeof(u32), num_write_bo_handles));
> +	bo_handles_write = memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
> +					     num_write_bo_handles, sizeof(u32));
>   	if (IS_ERR(bo_handles_write)) {
>   		r = PTR_ERR(bo_handles_write);
>   		goto free_bo_handles_read;
>   	}
>   
>   	num_syncobj = wait_info->num_syncobj_handles;
> -	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
> -				      size_mul(sizeof(u32), num_syncobj));
> +	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
> +					    num_syncobj, sizeof(u32));
>   	if (IS_ERR(syncobj_handles)) {
>   		r = PTR_ERR(syncobj_handles);
>   		goto free_bo_handles_write;
>   	}
>   
>   	num_points = wait_info->num_syncobj_timeline_handles;
> -	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> -				       sizeof(u32) * num_points);
> +	timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> +					     num_points, sizeof(u32));
>   	if (IS_ERR(timeline_handles)) {
>   		r = PTR_ERR(timeline_handles);
>   		goto free_syncobj_handles;
>   	}
>   
> -	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> -				      sizeof(u32) * num_points);
> +	timeline_points = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> +					    num_points, sizeof(u32));
>   	if (IS_ERR(timeline_points)) {
>   		r = PTR_ERR(timeline_points);
>   		goto free_timeline_handles;

