Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAF7C27C52
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 09:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D5210E39E;
	Wed,  5 Jun 2024 09:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AxkA2enz";
	dkim-atps=neutral
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BC110E39E
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 09:08:04 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-52b87e8ba1eso7072012e87.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Jun 2024 02:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717578482; x=1718183282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xNEZIvyZRl7nqH/pI30ulnM8hy6ZAXRZUJ8DrK5OjrY=;
 b=AxkA2enz5rDiPin1xtR19KeI5qxkVcy8Kew57ruKaFB1bcKmD4NW/LE+E6LdOoB7dY
 MbhcdvBaWI8GUuy0W4arAHb6fb7wpZCyiKP/QnEO+i7xBGBeBzsJQ8I38o7KFO9eUyeH
 c8qPZ2nS0NgcSXwc1uYiehMAr1AVC2hvZ3RijrorYWWgv4Od4QiFcFha71kpDSkGd31Z
 GIXOtus+UcLeOZrUSMVDKKomiPM3YRXNyZ3ardFTcg8AJ7HMXF+UA9Tb9ReFDytPL3jm
 A1dXZlhO1Vt8s3ikrsWivvnr25QZJDtO6GhMfsRcDbAcpNxeZtzjXJpnrfFf3fcHhFso
 V1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717578482; x=1718183282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xNEZIvyZRl7nqH/pI30ulnM8hy6ZAXRZUJ8DrK5OjrY=;
 b=HGMrvryTIXQjH3JU310QLju3bY3d4WGvO5Uy0ocldNZL/o4x2Yk/QUdD6FMk8QeJS1
 iQbXXG5Pr6SkG5ln/j2xxx9hI7N09zaVeT30JY/FonoMDo4HI+HlFvbvhs/Q0kMz05Sp
 BSgObxx23FVbr7itXJH6B5kkJRD0bpjyUQT5pxRBH0EpAv7otUa6PvpQLQ19yK2j9Wgm
 FrMNkaxGbwYcmHVy/fpfYZbl/flsdKVcilye0x8OUH/OIxafNNLZ/o9MU/doRwu6nWRZ
 pB745GLCggVi7OwAAeWtauz4exZgbRl2laBsTBa5Y9KdawQ2/MxRCEPH1HRRwhpBE+RO
 gEZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ2mihcC2rAsiHC24+eGc7Wkr+LifUpgvl2LnkYir2dSz+HMjiAx07BfjyOxNIqvNzt0xSqPv9G6SQ4GB2/yQFyYJxPcpPGUTB0wptaA==
X-Gm-Message-State: AOJu0YyBsKXjMw/fh6s6JUEQHQS9181TZlG2l83c1PM+LfzF3vKtwVi9
 hTEvVXJel+AzxFNj9onikHqnsNOnvGU5zmfakLEwzEIB5B498zrb0Imm8aus
X-Google-Smtp-Source: AGHT+IE2/b0yAlInoulo93wJTowpd80wgK4OErhT8iV6Jm7KOIwHpq92cak8Yd8VrdGdiCV0s7j3fg==
X-Received: by 2002:ac2:484a:0:b0:52b:829c:34da with SMTP id
 2adb3069b0e04-52bab510ae6mr1287925e87.59.1717578482227; 
 Wed, 05 Jun 2024 02:08:02 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215811d992sm13087385e9.26.2024.06.05.02.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 02:08:01 -0700 (PDT)
Message-ID: <9bfc885e-f3c6-48b8-bcfb-33d66fc783d7@gmail.com>
Date: Wed, 5 Jun 2024 11:08:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add reset source in various cases
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Lijo.Lazar@amd.com
References: <20240604155819.89855-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240604155819.89855-1-jinhuieric.huang@amd.com>
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

Am 04.06.24 um 17:58 schrieb Eric Huang:
> To fullfill the reset event description.
>
> Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c   | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c   | 1 +
>   3 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 10832b470448..dff7033f2026 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -980,6 +980,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
>   
>   	reset_context.method = AMD_RESET_METHOD_NONE;
>   	reset_context.reset_req_dev = adev;
> +	reset_context.src = AMDGPU_RESET_SRC_USER;
>   	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>   
>   	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index e4742b65032d..cf0c4470ab9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -77,6 +77,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   
>   		reset_context.method = AMD_RESET_METHOD_NONE;
>   		reset_context.reset_req_dev = adev;
> +		reset_context.src = AMDGPU_RESET_SRC_JOB;
>   		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>   
>   		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8dbfdb767f94..33f592ec8bde 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2487,6 +2487,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   
>   		reset_context.method = AMD_RESET_METHOD_NONE;
>   		reset_context.reset_req_dev = adev;
> +		reset_context.src = AMDGPU_RESET_SRC_RAS;
>   
>   		/* Perform full reset in fatal error mode */
>   		if (!amdgpu_ras_is_poison_mode_supported(ras->adev))

