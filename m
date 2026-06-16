Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA27CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 11:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ADD410EA5D;
	Tue, 16 Jun 2026 11:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="JxQBus+M";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC1B110EA5D
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 11:39:59 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso33042135e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 04:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1781609998; x=1782214798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DyFKsTINcc/CTVziVRLWtE3+d2u8WLYlUcuu0UgiNaw=;
 b=JxQBus+MlGEGq/92ftcB3wWDSHKlXVoLvA6+KgZCRhFeHaIZ/kwP2dpoOppzQFR/TP
 TBnMpbBLgiPCdegxzx5Gl4qsKqdAV4SqqcMA4Q5dM01+0Ike4l65m2Koh/NpTMmqwwAm
 Neus71QZLcD61RfDyvyW0FDKgSFDLgevBjhF5b8LaAZFRR/dQ/MHXQzJU1CCnP6iLIGy
 5Nq3KE77eiERaBGPv88MB9D3XvpLahtbZi0gvQfP9RIwmoGFAGq9DeIW2M3srXcOJk6f
 IyqR+fCrgfk5ugBmjy//BGJKnfPGyfHyNiM+XOI4R6FhLMFk/Ru0l8ZG59YezUiM9Qxp
 gCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781609998; x=1782214798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DyFKsTINcc/CTVziVRLWtE3+d2u8WLYlUcuu0UgiNaw=;
 b=pWaDohim8WMXNIzh7jWv98UnAJ3+uudVXUWbZ/4qPPKMmCHCOGk/MxQtynTk+ibp/7
 ZB1fWK3ZA4pMe7FMCqtp0danWfEKvvlhg+1hcnBrYBYDBlaDQChscyrOG0EQc37HcyK5
 O2PRou2PQB+CAdJPGjptkHredgl2M7d7fsvxk7IwMGvgpl4RSIgyEq3l36LRIMsqEr15
 QtrNbmdRzHd73q31npodc73WngyE6UrnJaAIDkabqqgJsIKmvMcSxT55mO/OSZNejOUL
 PTW9mADJ2HqayXIg3bDmo6+k5Y4MSDqg5BmET6R7T7Dh7V9a72P6tpLOvCPlfMvV9qQb
 lqwA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8b3pxWJCvhCdln65UqFKoYNZMiCKuakQNEgIFpEJqL0c5RFy8HXAB1neIxtT6jxj+6asXWvQX3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHXXxl5JCQfa/JjTjrmUCDxZC4wGubkI8Hrqt9bmMkjwwti6cw
 TFDEEG7PnRWEE246/tkqLh1KpILqPzcBiJCqkq9plQax/nKjoC1ahv8xx9O0PLdZOis=
X-Gm-Gg: Acq92OGnw7qlneOoKTQyhUB2t37fOwXWAYWXqFMK5nt/r1clsCFqoriCfcl3SgOnXBU
 wRiy4Zc+etDExKBiYIdfp5h5tvX5+nuKBbywlz07tv7sIoqSB/LlEGo5GxbjHI1Ve22pCFEHQkD
 JNA8CREwmupmPj9Q+1uKCAecxKtcCOmCuYyKMME+QKcM3uzHLEHkftW0wLne83b4b/+BoTJmeky
 tPoUczglkDDT41SExDrYB4sPNFSweFj1pKl1BQQJglac8X9fF/CPPuGuiOMkM2ZyMA/L+EjTp7D
 I0sdfBgECbaR+Z+wBrMwmCRhMABw9zn6tkD/hBNkTsRKPbXYrj3LPfoYkLGaRwPLHwf+Vz5BODA
 f3iVSlxzW70r59CdbONV+lJAaiQckmxWKNnVegYv7BqHOvvGdLiVI3VzkJoIJMnKW9Y4NvYLA86
 VpAslYzqgorQ/H5IpVog2W99AZ0nkF82iAUAfgEw90B6ax
X-Received: by 2002:a05:600c:6206:b0:492:325c:c691 with SMTP id
 5b1f17b1804b1-492325cca2emr10553875e9.17.1781609997976; 
 Tue, 16 Jun 2026 04:39:57 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a58becsm52782815e9.7.2026.06.16.04.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 04:39:57 -0700 (PDT)
Message-ID: <6f5c367e-b234-491b-81e2-d928cd54050d@ursulin.net>
Date: Tue, 16 Jun 2026 12:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] amdgpu/ih: Don't perturb HW registers when accessing
 soft IH ring
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, amir.shetaia@amd.com
References: <20260513170849.27061-1-timur.kristof@gmail.com>
 <20260513170849.27061-3-timur.kristof@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260513170849.27061-3-timur.kristof@gmail.com>
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
> The soft IH ring is implemented entirely in software.
> We shouldn't read (or write) and HW registers when accessing it.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c   | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c   | 7 +++++++
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 4 ++++
>   4 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index 333e9c30c091..65e5d21753f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -439,6 +439,10 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
>   	struct amdgpu_ih_regs *ih_regs;
>   
>   	wptr = le32_to_cpu(*ih->wptr_cpu);
> +
> +	if (ih == &adev->irq.ih_soft)
> +		goto out;
> +

Would it be feasible to move amdgpu_ih_funcs from device global into the 
IH rings themselves? Then we could have soft IH ops and it would be very 
clean.

Possibly also cleanup all the protoptyes to operate only on ih and not 
the adev + ih pair.

Regards,

Tvrtko

>   	ih_regs = &ih->ih_regs;
>   
>   	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> @@ -514,6 +518,9 @@ static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ih_regs *ih_regs;
>   
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>   	if (ih->use_doorbell) {
>   		/* XXX check if swapping is necessary on BE */
>   		*ih->rptr_cpu = ih->rptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> index 699c274d357e..9dbc20131410 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> @@ -410,6 +410,10 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *adev,
>   	struct amdgpu_ih_regs *ih_regs;
>   
>   	wptr = le32_to_cpu(*ih->wptr_cpu);
> +
> +	if (ih == &adev->irq.ih_soft)
> +		goto out;
> +
>   	ih_regs = &ih->ih_regs;
>   
>   	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> @@ -481,6 +485,9 @@ static void ih_v6_1_irq_rearm(struct amdgpu_device *adev,
>   static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
>   			       struct amdgpu_ih_ring *ih)
>   {
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>   	struct amdgpu_ih_regs *ih_regs;
>   
>   	if (ih->use_doorbell) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> index 6de9e87e04e1..bd332e8cc5bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> @@ -457,6 +457,10 @@ static u32 ih_v7_0_get_wptr(struct amdgpu_device *adev,
>   	struct amdgpu_ih_regs *ih_regs;
>   
>   	wptr = le32_to_cpu(*ih->wptr_cpu);
> +
> +	if (ih == &adev->irq.ih_soft)
> +		goto out;
> +
>   	ih_regs = &ih->ih_regs;
>   
>   	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> @@ -527,6 +531,9 @@ static void ih_v7_0_set_rptr(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_ih_regs *ih_regs;
>   
> +	if (ih == &adev->irq.ih_soft)
> +		return;
> +
>   	if (ih->use_doorbell) {
>   		/* XXX check if swapping is necessary on BE */
>   		*ih->rptr_cpu = ih->rptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> index 4cd325149b63..e7ed37bb48e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -417,6 +417,10 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
>   		 */
>   		wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> +		if (ih == &adev->irq.ih_soft)
> +			goto out;
> +
> +
>   		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
>   			goto out;
>   	}

