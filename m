Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BC5C77B72
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 07:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E1110E3A3;
	Mon, 17 Apr 2023 07:22:39 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCA210E3A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Apr 2023 07:22:35 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 eo6-20020a05600c82c600b003ee5157346cso14949587wmb.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Apr 2023 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681716154; x=1684308154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7r51oPm/oSEIlApG6o1zsC2abmPrsqsbQTe6wjCpeyg=;
 b=rCNDRAv7NBCG1WfChaAKfqRSUh4rJTmz8FRvdKiUlhCyObymvB6eXRfHZHYJpLiv9T
 gLMi71/qB4Iyh8cTaZUoFooZlUP1JTYINur9STCDnAcsOmF0Fa48AC+Cc4D+WoNx8V5L
 FzJW+ArWdn3qWsIlT8NPLjxMREczXlQOwuxGIiqHDdU/0ue5dVD3hn6A9q3fEiVbaxJG
 mMxb2jiASSiL5nG89o78kjDYKsT2IFm0Z02YzygTvfGIubeKEtZSdnJ14atX1KDFYqfo
 O9xBtOWAS+2p5F3BMELOxririCs3SXYAcaprnPjdsJm0Asq6eLYUXrVHDKiJN7tW3xQD
 XmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681716154; x=1684308154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7r51oPm/oSEIlApG6o1zsC2abmPrsqsbQTe6wjCpeyg=;
 b=SA4iT9kmM3NwnnP5TPZoVpRZZlXLOnt/0+8pCezxI91aECHi+3KB2d8To+58x0eSym
 lrUbKOKusG1JHvNNLQTCHn13f7lEElqjX8nfvV83LKg4eB8d9vRpCUmqkiB7evI1jjvg
 Yf6ACDxuwiyhH2M3adVXXQtFvJMZ6V/PLUeUdX5bymD6MpP2BYy/vCrUN3J8PtRks0fH
 JjxVz7O4I7xLtBWE+AugsBTARHX56BW1yT09kJ08q3NN3ndtzrXqYJGP4tAd+phdT/CB
 PBY655+U5o6ay1SyKvVv+oD2FrMNhQMS3QG+m4wJzAA1/X9JDlyQ7VTwPcRJp+rehdHL
 IwPg==
X-Gm-Message-State: AAQBX9fCnvcSg0dn1RskcXT/enDpxUcF0V+VBasC9bjcDfwd1qFfqdgp
 buuUdz0EB3SFyw3m47IMM9Y=
X-Google-Smtp-Source: AKy350YUTO09eCHiZidYHLKsrDZ6vgW0dWqW9Xkjwi0Rfa32aTs9Wfdk03n7IF2HM92mL/HzOrhTMw==
X-Received: by 2002:a7b:c40a:0:b0:3f1:7372:66d1 with SMTP id
 k10-20020a7bc40a000000b003f1737266d1mr1567656wmi.0.1681716154068; 
 Mon, 17 Apr 2023 00:22:34 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 f24-20020a7bcd18000000b003f09a9151c1sm11096280wmj.30.2023.04.17.00.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Apr 2023 00:22:33 -0700 (PDT)
Message-ID: <cf736b53-fb80-4b5f-4c94-a815fe5da35d@gmail.com>
Date: Mon, 17 Apr 2023 09:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Content-Language: en-US
To: Alan Liu <HaoPing.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230414162215.1201883-1-HaoPing.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230414162215.1201883-1-HaoPing.Liu@amd.com>
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
Cc: bhawanpreet.lakha@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.04.23 um 18:22 schrieb Alan Liu:
> [Why]
> After gpu-reset, sometimes the driver would fail to enable vblank irq,
> causing flip_done timed out and the desktop freezed.
>
> During gpu-reset, we will disable and enable vblank irq in dm_suspend()
> and dm_resume(). Later on in amdgpu_irq_gpu_reset_resume_helper(), we
> will check irqs' refcount and decide to enable or disable the irqs
> again.
>
> However, we have 2 sets of API for controling vblank irq, one is
> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has
> its own refcount and flag to store the state of vblank irq, and they
> are not synchronized.
>
> In drm we use the first API to control vblank irq but in
> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.
>
> The failure happens when vblank irq was enabled by dm_vblank_get()
> before gpu-reset, we have vblank->enabled true. However, during
> gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state
> checked from amdgpu_irq_update() is DISABLED. So finally it will disable
> vblank irq again. After gpu-reset, if there is a cursor plane commit,
> the driver will try to enable vblank irq by calling drm_vblank_enable(),
> but the vblank->enabled is still true, so it fails to turn on vblank
> irq and causes flip_done can't be completed in vblank irq handler and
> desktop become freezed.
>
> [How]
> Combining the 2 vblank control APIs by letting drm's API finally calls
> amdgpu_irq's API, so the irq's refcount and state of both APIs can be
> synchronized. Also add a check to prevent refcount from being less then
> 0 in amdgpu_irq_put().
>
> v2:
> - Add warning in amdgpu_irq_enable() if the irq is already disabled.
> - Call dc_interrupt_set() in dm_set_vblank() to avoid refcount change
>    if it is in gpu-reset.
>
> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c         |  3 +++
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 17 ++++++++++++++---
>   2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index a6aef488a822..c8413470e057 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *src,
>   	if (!src->enabled_types || !src->funcs->set)
>   		return -EINVAL;
>   
> +	if (WARN_ON(!amdgpu_irq_enabled(adev, src, type)))
> +		return -EINVAL;
> +
>   	if (atomic_dec_and_test(&src->enabled_types[type]))
>   		return amdgpu_irq_update(adev, src, type);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 1d924dc51a3e..514fefef109d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -169,10 +169,21 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   	if (rc)
>   		return rc;
>   
> -	irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
> +	if (amdgpu_in_reset(adev)) {
> +		irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
> +		/* During gpu-reset we'll disable and then enable vblank irq,
> +		 * so don't use amdgpu_irq_get/put() to avoid refcount change.
> +		 */
> +		if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
> +			rc = -EBUSY;
> +	} else {
> +		rc = (enable)
> +			? amdgpu_irq_get(adev, &adev->crtc_irq, acrtc->crtc_id)
> +			: amdgpu_irq_put(adev, &adev->crtc_irq, acrtc->crtc_id);
> +	}

It would be cleaner if we could do this on a higher level, e.g. in the 
GPU reset code.

But for now that should do it and I think this could even be back-ported 
to stable.

Regards,
Christian.

>   
> -	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
> -		return -EBUSY;
> +	if (rc)
> +		return rc;
>   
>   skip:
>   	if (amdgpu_in_reset(adev))

