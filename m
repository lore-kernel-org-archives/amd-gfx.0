Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B5DCD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 12:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B4B10EA94;
	Tue, 16 Jun 2026 12:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="b6tmG1al";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A72510EA94
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 12:08:26 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-bef1e6423e7so474562466b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781611705; x=1782216505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iWtK1UuaH6SentuRqvDDNx2oPv8jl3cZJjeeiAH2uMg=;
 b=b6tmG1alwHws7sWgwWWAGtnDzooU3RNMrVCWyCg24lerNWRcrIAZc1z4ZOeapcS+qb
 uMghe3jzH8sASHJKfqdguIY4hpO9ax3Why0DkR7oYFgXflNMHybDF5EgXQy3BMJolKXh
 Bj9mPuW1i4TzOvS9yV4Fj2gSV0tNVlNA5mZX5k7ceVTx0wigWHCM42HmFS0RGmBA+qWe
 PUrBxWD1SWYJJszIostb7e+MbfowhLSrxI92DpFxCq1qo0R4emMPfTSVKI0HDZti/HJy
 cRYRhBYXzxgD04dfyrK1ZTf9IK73i+YcYXZls5xT8I+yF332gjjKGjQNshSd/2/BpJfx
 YesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781611705; x=1782216505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iWtK1UuaH6SentuRqvDDNx2oPv8jl3cZJjeeiAH2uMg=;
 b=LbdotWTpz+1nsDNy/iiYXFiXPGPrrDGUJh4wZpPoi8JbqtECxeKSGA/4gyF4Y0XjBC
 9kGbg4erN24+xH3VPdsQAUyQeD+nKUsrhaUK63HSP6leKVjNVjBauz+sEF2QMVlCMDJT
 WYlWAIybZHHaD4fq9kUokjA2nGSlbdNvHv4B6HOo8K2Zz+9pxNBjHbp1OO7jVmYFTWLG
 a0Yb1GvcVpTaKyn2Ow06M3KzzaiBYqjDjUqfckgbygQ81wygEjpdOtVrVHwo3z7kcWac
 kqyeQ4QD2Q7XYO7sZoFlEfJykWsf1AeiRYcLfjWydmdyDn9TWbRjHhHAYo8h75pO34/v
 f3uQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KMDOdLmOPFvgF9csyaVblyDseBdDKss6Yivd9gIwy29E9AS+WFu1GEf5K0l6iHg87VL+46Dfh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxV/oXp2zKo/z5nPyDMcm+r3WWHo/vEqggyCmFBfSbvOZeYY3eU
 b7C4lirbmyRt0+r5K5R+pOklgTP2Md0nJ1PcuRmV6WmhTIB/FLtg/Ri3JqNe9ZMApNI=
X-Gm-Gg: Acq92OHqGBDKRzKR7mlkRtN0Hu9wSGXw6TcXzD9axHlqviX3BQCofOaqT28Rc5dw8L8
 9ahtQtrfQlgrZ9joUk/qJmSHXaB6JsvFH4Een+lPwJKzw2R6NCrpTPV8XYVcC2vtlo66t0f5Jhf
 rkZdUKkshvmK4WDnI27wuUe0ZoCNJksxwbIVYyLyLuTu/HOu9DdFh533qI8tajrlqDPVtw+ur7a
 i5W6QdCCRLw0q5MLK00fGHLVOfaonHrKrnjnafH2+ORVCkjea+I8814Ly0U0ZvCBN5XgnMtE2Mo
 Oa4v6fo6qasqOhJgf78ACYWMF+QdRNo6gbnh5bgxBtRj/UcRK3q1FMfYHg5T6tAWN24/NbmIfkS
 DgAzh7O3SAz1vyWoDjkf8jvO61IbHKkRR/5KUmJn+/96JkYtQu+n+W8UwxdlK/29O6W0POc+22e
 jltviWvv/fFNI1vjFqTsuIYBVZ6oMwuXAnRBsEdAHkcHpi6rNubOlH5lw=
X-Received: by 2002:a17:907:1c1e:b0:bed:e575:d54d with SMTP id
 a640c23a62f3a-c043d6bffa1mr166246866b.42.1781611704947; 
 Tue, 16 Jun 2026 05:08:24 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfe7cc615b7sm579221566b.48.2026.06.16.05.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 05:08:24 -0700 (PDT)
Message-ID: <ae08836c-95b6-42a1-8173-108c5b4b5925@ursulin.net>
Date: Tue, 16 Jun 2026 13:08:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Use system unbound workqueue for soft IH
 ring
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, amir.shetaia@amd.com
References: <20260513170849.27061-1-timur.kristof@gmail.com>
 <20260513170849.27061-4-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260513170849.27061-4-timur.kristof@gmail.com>
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


On 13/05/2026 18:08, Timur Kristóf wrote:
> Allow the kernel to dispatch the soft IH work on other CPUs.
> 
> Otherwise it can happen that the soft IH ring fills up
> before it actually starts processing anything, which
> can easily happen with retry page faults, in which case
> the CP repeatedly spams the CPU with a lot of interrupts.
> 
> This significantly improves retry page fault handling on
> GPUs that don't have the filter CAM and must rely on
> software based filtering.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 82bc6d657e5a..515fc32051c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -549,7 +549,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>   			 unsigned int num_dw)
>   {
>   	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
> -	schedule_work(&adev->irq.ih_soft_work);
> +	queue_work(system_unbound_wq, &adev->irq.ih_soft_work);
>   }
>   
>   /**

Look good to me.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Maybe later we can consider a high priority driver specific worker or 
something but for now moving away from default system percpu sounds like 
it addresses the problem statement.

Regards,

Tvrtko

