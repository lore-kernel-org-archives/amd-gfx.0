Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F349C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 06:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD09010E74C;
	Thu, 22 Aug 2024 06:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HvSeOC3b";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3520210E768
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 06:35:09 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-429da8b5feaso3466875e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 23:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724308507; x=1724913307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JNAwNegeQ0bETclMd055CmXfBGKKA6B8Z+TfeyDl1Ik=;
 b=HvSeOC3bQUFZgKUWgeXLJuaA+dfEFk1JUheo8N6So8LPkGs3VTeudEUp7tqvIh74Ud
 JBO6h5vOFjKfeOKGs8xs5P8lVPIXP7i3lA59bO+DC9cV6EkVh1X4/kfr1MFmq2vmrDwW
 QdiywCSEhDLSqQ1X6xGXvnRWRjLWlv8hHPI8l2fqpf2+Vj3lEN6wixLv/9lsODe9SJYW
 9yPcINJfQroyS2dQ0FAaZBRnT3kqE2JyDLBqKxz0P914z84x8RiLGSbJB8t5xskjNsLU
 StYb3j1g/CAuZiYgvSfluWuZLPMBFrg6aR8BjiihUPMHXLB8kQn753rdySuftFqwj7ip
 aa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724308507; x=1724913307;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JNAwNegeQ0bETclMd055CmXfBGKKA6B8Z+TfeyDl1Ik=;
 b=AWdWcoe0M8f+JyvXOYqj4FxZKQ9b6znGGMp11pYiSMJf1g4T6aKj6yIvNu0EIQlCPf
 XIOywpKXlghzV65rjBwN8+tjt3EKWspzU6/XnP74KxNxeAZnAKbqpKWRJizZnrlcBl44
 JTB7Qf9f17uUKtgGIGzhDNPmjr6BDh7Su2QfKF/nq8AwD0OPyh7CqpRHAK7nPAiu17xL
 qxLVf8eoGNQ3EplSW1u79vB8g7/7MCohtmWQbhCxBncfj+/42x35J33n3WgKv+866WTc
 GoRoBUids0FspIMfbHQm5Bhy2TwlY81k1Hnv/kF1usoX+CtjOXiO8bPIafr1UiaFLCVQ
 uhcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4QRlvGK9KSiEHheWcxBjnWEk8MFwil57MTKWdwfT8j4areKrpBMdK1wrhTdxMC+zj1QB5ZD/D@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEHCgOl02P3P3HGdN8l9e6uxS8uVB0f5jwSKTTq50ztpZoiaEi
 T0j5CuBJ3K0Qv7arGoK0h/zXsDWTN8haXl0ZU2PDjeNd4xVlal/J
X-Google-Smtp-Source: AGHT+IFMowenqVP4JtOqKRjFdv0aT08aRw5eI+wA4d5CoU6vP7FxsFLqaeWWlhqwgy51m1neAsjYaQ==
X-Received: by 2002:a5d:6b86:0:b0:371:8eea:24b7 with SMTP id
 ffacd0b85a97d-37308d75b8dmr501843f8f.50.1724308506735; 
 Wed, 21 Aug 2024 23:35:06 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abefc626fsm49730115e9.31.2024.08.21.23.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 23:35:06 -0700 (PDT)
Message-ID: <d6664bb5-7b32-48cc-b7e3-dba7bfade792@gmail.com>
Date: Thu, 22 Aug 2024 08:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] drm/amdgpu/gfx9: Apply Isolation Enforcement to GFX
 & Compute rings
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
 <20240815000501.1845226-16-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240815000501.1845226-16-alexander.deucher@amd.com>
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

Am 15.08.24 um 02:04 schrieb Alex Deucher:
> From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>
> This commit applies isolation enforcement to the GFX and Compute rings
> in the gfx_v9_0 module.
>
> The commit sets `amdgpu_gfx_enforce_isolation_ring_begin_use` and
> `amdgpu_gfx_enforce_isolation_ring_end_use` as the functions to be
> called when a ring begins and ends its use, respectively.
>
> `amdgpu_gfx_enforce_isolation_ring_begin_use` is called when a ring
> begins its use. This function cancels any scheduled
> `enforce_isolation_work` and, if necessary, signals the Kernel Fusion
> Driver (KFD) to stop the runqueue.
>
> `amdgpu_gfx_enforce_isolation_ring_end_use` is called when a ring ends
> its use. This function schedules `enforce_isolation_work` to be run
> after a delay.
>
> These functions are part of the Enforce Isolation Handler, which
> enforces shader isolation on AMD GPUs to prevent data leakage between
> different processes.
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 3045b8b0796d..21089aadbb7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7470,6 +7470,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>   	.reset = gfx_v9_0_reset_kgq,
>   	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
> +	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
> +	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,

Does it make sense to have that for the MCBP ring as well?

Christian.

>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
> @@ -7528,6 +7530,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
>   	.patch_de = gfx_v9_0_ring_patch_de_meta,
>   	.patch_ce = gfx_v9_0_ring_patch_ce_meta,
>   	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
> +	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
> +	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
> @@ -7569,6 +7573,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>   	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
>   	.reset = gfx_v9_0_reset_kcq,
>   	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
> +	.begin_use = amdgpu_gfx_enforce_isolation_ring_begin_use,
> +	.end_use = amdgpu_gfx_enforce_isolation_ring_end_use,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {

