Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D888AE7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 09:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB0B10EF68;
	Fri, 13 Dec 2024 09:00:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f04s0396";
	dkim-atps=neutral
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B9810EF68
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 09:00:25 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso9979675e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 01:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734080424; x=1734685224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xxFYciqwFV2cndQH7JmXW6mDpDzvGX2lKICy0a5G1GY=;
 b=f04s03965s+3UGVQq+WmKMeRb+eXBWH708K0ppxI5wwM8NONIcCU5GKewUxNSCNq0W
 t1y0GOeZ5f5h3oH6oLbJ/8m+w4kwINoNGfglLZO95Rq3yKbvgaWy4aIdkJshiZppx9vD
 Jvnnz8LVoZbPm2wGnJlC8xtbfsgNzW3mwN2EIqfUBthuxRJmigVsdFKMkVP8PpSpDG2M
 tf67m6lq+pOBq1AaEUJRZ87/vF4wNpQd8js98YCKI25+NYjS1MV+dmJfWphMVrhiHoAf
 cOS/NzRJ9f83HiassVmTmjolfIoP3bo4fnTncsPoZOeWg3m5s8pTTWBtBwb1QwnOo0wc
 mpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734080424; x=1734685224;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xxFYciqwFV2cndQH7JmXW6mDpDzvGX2lKICy0a5G1GY=;
 b=mXvHda7V5IEzjyTZy5GgqexTaPzI/nebbxryiBmCtAtwgBIdURpdnMzJCApeCKp/Ag
 L7935xRx46DTsdatD/ifqRy5rKYPwif1M7DKcYYUAY5Hq4teR08QYQSLDEa1aDQZk4lW
 +8JIsz83owhYZng2XpHoeAyL96lKCD/3x41zsUyYkmvcU9BAoj3Gex7mGbgIexcjPfLY
 2gU4Nspve56/6otrgwkTwAe8NnUek99FyQui+mMXviiSjnEDyUs8WXWxmzBbQSH7cBtB
 J8Yc3Zo003c0DGxS6dn1G5bAIUEjiH8cyRdR48/ccZUw1WBlVi1hpU1Bi3TMgKdy65ZA
 dOrg==
X-Gm-Message-State: AOJu0YyIQ04SsGOiauHq59Pj99k/MYwTysj3G+1b/T951X9eJP5cHrrC
 bz+qTlDxNDo6OAsZbj/lrGevpKsAGtjk2vt+gup7DAjKG8WyvJ6poVaa0lf1
X-Gm-Gg: ASbGncsMdeea455wwpNnOzqVHdXZDcqFxC7smf657N0PJ6dJcVoZlG2LEATzQJF+DM4
 DixMDbNisJr+hynjlTR9e4Vs5VR0vHcLIzVsiOuxpDpJh3cw6mnVC37tSNduuGYsJYPY9YV8oGY
 NunRVh8WXc4C+f8OM/YQg2CH/wyD6HdIQ94nKtRsv4oq39yLwbZDyeuGS9yFZv49KDLXOqKqIXp
 Bt4xdqMgr72JRk9Pu4hdkoxxmZUmfcOFIzRmUuf/EUGvH7SKohLqpfsxoKwK9n6Z1Zdxzmu0JSh
 gGXUR2txMg==
X-Google-Smtp-Source: AGHT+IHc9mmquC1pWGgV/MrifZ6+x1Zd+SmAv9vv8xcZKYHUuj2WFOeq8l+s/5Hllm4mTYOOb1NFbQ==
X-Received: by 2002:a05:600c:3ba1:b0:436:1b7a:c0b8 with SMTP id
 5b1f17b1804b1-4362aa15453mr12044025e9.7.1734080423909; 
 Fri, 13 Dec 2024 01:00:23 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a609esm6502746f8f.40.2024.12.13.01.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 01:00:23 -0800 (PST)
Message-ID: <4b6ab16e-fd17-4fa5-b65b-57cdc33717b7@gmail.com>
Date: Fri, 13 Dec 2024 10:00:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: fix amdgpu_coredump
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
To: amd-gfx@lists.freedesktop.org, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: Alexander.Deucher@amd.com
References: <20241213085255.1449-1-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20241213085255.1449-1-christian.koenig@amd.com>
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

Sunil please take a look as well.

Thanks,
Christian.

Am 13.12.24 um 09:52 schrieb Christian König:
> The VM pointer might already be outdated when that function is called.
> Use the PASID instead to gather the information instead.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 946c48829f19..824f9da5b6ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -343,11 +343,10 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>   	coredump->skip_vram_check = skip_vram_check;
>   	coredump->reset_vram_lost = vram_lost;
>   
> -	if (job && job->vm) {
> -		struct amdgpu_vm *vm = job->vm;
> +	if (job && job->pasid) {
>   		struct amdgpu_task_info *ti;
>   
> -		ti = amdgpu_vm_get_task_info_vm(vm);
> +		ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
>   		if (ti) {
>   			coredump->reset_task_info = *ti;
>   			amdgpu_vm_put_task_info(ti);

