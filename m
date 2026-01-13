Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBE1D2D0FB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 13:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C498911A;
	Tue, 13 Jan 2026 13:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K8OnxdR9";
	dkim-atps=neutral
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B038911A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:22:32 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-4ee14ba3d9cso83630561cf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 05:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768310552; x=1768915352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7o3gdAVsbkG4pSvtEEJrn+vyfH4Mvry9MCrwqL54Ms=;
 b=K8OnxdR9Uc//MPuMcSv/bEyEebJSV3Lg6Wuo65PFfIimnM8jjA8wV4DysQB2+l7gXm
 rtr5OWKcG4MpHchY9sOutRhCH4KzAP4r4jMXAfWFYXbl51fd9r++lENe4ZW3gpd1hFl8
 qdnJxpCCqN/gR9xrFT00HvGSTx4uQrbx+ky3XnPn91R0vxrYMwOWsvgCoNZxquuLF7UI
 RuoC00U1zQJkiL8f9HueFsxCC+ELHRqO/gZ92Ttv5wUefP8aYqOYIzHLQvOs9GodFBgL
 B8PyLlMv6cFQTWO1bNidUpJ5rCJDWCGaw5QZszxoO/3qLWsZWWOx7lUyFjf56AG+N2nG
 iItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768310552; x=1768915352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b7o3gdAVsbkG4pSvtEEJrn+vyfH4Mvry9MCrwqL54Ms=;
 b=f7ECoDG+7H1WZVNPf8Q2klnxZGf515+HfXwEbxy55dHDw/Kq13SUqEszqpAgFvOs14
 4L7vQaNNL8kVolGvs1fhNiANMxADvcs1YfMrIQO004LmDqHwb/JVK6n3GH2V0egwdtP9
 2uc5SkVVtbQ/wKDVCQfHIOGcO4XbV7R3lNbx3MQim+LAhbNQeNTgJ72OUmBL5OxByQa3
 IqXeMEQ1KtHaZddp68Z993AlE/CWZvPtxrN9UELRYdAnwLQl8w1gYgFmwzEyHItpRzqe
 ebGe0Alqp4ckf3atVnucfeVuCPLNAo3NX3L87EkO6xbSOQT12cc149Z7E5CGgDJFkPxd
 w5lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq2In353AYWWQT1QUJ3o4GCy0LdBdaui3kc1UONV/YfSRwr3PSeMF7bT85ArcRX4qA5v8X60VU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGSigZBm0tlpzIYUM1hiIci08pOWvTa6ne3kqkM0Ib7FR5ok45
 nWhbk1civBq8WBGuUXe/yiY9dWb58KTBoi0HqBSyV/E6hlNvMr4kXjhUFRuwwDUa
X-Gm-Gg: AY/fxX5socACtsaIIQ8H1+hWFIJos7cuIpJbEZ1xTpEA0SIs5wa0olEtykoRYjQ1wK3
 /0CaF06fb056KKJ8GwtJnggdz8dxat/LapCw1MMvfc9008ro+nRBy8dJiFNw44yXOUORhDFZDax
 2t6sLXML0VKLPC3cRWk9izySCx5iis6DeXOJ+q/EnDaMVQ1V4ST65Jfmf1rgbtAloIopBdTDF8U
 cnUnsuvVBDUWdFFlBNy8MPCssBU+dS7sYY0ziUmgjUwDZLsx36GeljKMf1+wdRF91ZErbIzvzkD
 EjesSXpELfkjGJOA5PY3pHklQvjmlBF6y0Di1FkA/aEQ4W+h4fX6asFpF+g8fTE7rzyDGGtCkYv
 elL/RAEarDUXeoHQb8Nq/LPXhTfr8jFfbudGUC/K55ABaPAl8Sdl1oHL88VN+jqauRcZEDm2m7o
 9+3DIWlrHc58t5z+XYCiIpiIuVUsuhJOcj4xdcycBYZMAmss2v9u6m1g==
X-Google-Smtp-Source: AGHT+IFHXGNz9EOecvNHRuPfMKJS9wfhbpWWGrxh6fLyFkBrHaO/pdjMTfkN0IQ4QSF9zHYrhgcgDw==
X-Received: by 2002:a05:622a:1b9f:b0:4ee:209c:be59 with SMTP id
 d75a77b69052e-4ffb49e6644mr301563481cf.55.1768310551725; 
 Tue, 13 Jan 2026 05:22:31 -0800 (PST)
Received: from [10.254.120.192] (mkmvpn.amd.com. [165.204.54.211])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8d55656sm145401531cf.9.2026.01.13.05.22.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Jan 2026 05:22:31 -0800 (PST)
Message-ID: <0426aa4f-869c-484a-b057-a4877fe3d26a@gmail.com>
Date: Tue, 13 Jan 2026 14:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/42] drm/amdgpu: drop drm_sched_increase_karma()
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <20260108144843.493816-31-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260108144843.493816-31-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 1/8/26 15:48, Alex Deucher wrote:
> It was leftover from when the driver supported drm sched
> resubmit.  That was dropped long ago, so drop this as well.

We unfortunately still need that to update the guilty flag in the context so that amdgpu_ctx_query2() works correctly.

But we could change the code in amdgpu_ctx_query2() to check the individual entities for error codes instead.

Regards,
Christian.

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 868ab5314c0d1..c9954dd8d83c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5808,9 +5808,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>  
>  	amdgpu_fence_driver_isr_toggle(adev, false);
>  
> -	if (job && job->vm)
> -		drm_sched_increase_karma(&job->base);
> -
>  	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
>  	/* If reset handler not implemented, continue; otherwise return */
>  	if (r == -EOPNOTSUPP)

