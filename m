Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129CEC36018
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Sep 2024 12:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD66310E474;
	Tue, 17 Sep 2024 12:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RMPkWa7+";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38B710E46C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726575966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uEGssPI2MZgcV8pXcwA+wieYfiMi4q7bjaWYcO2wC20=;
 b=RMPkWa7+SlS30vBZU44RCNdYqofdUVe+gUYpMeiuDYDyWIDlQ7f2SvTGQy22/J91gwg2BE
 t99UAPKZcPS3P7n3QuGfScnMByjf38KfMms5ZPInGjZYCi5J9fxB4zfnv/z/SlJjjFW3Uo
 yDmQ7P8WeqTO7/zcSl3kem3GejFeUVs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286--4PI-6YYNnaHwbNY2oEnfQ-1; Tue, 17 Sep 2024 08:26:03 -0400
X-MC-Unique: -4PI-6YYNnaHwbNY2oEnfQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb080ab53so35318655e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 05:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575960; x=1727180760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uEGssPI2MZgcV8pXcwA+wieYfiMi4q7bjaWYcO2wC20=;
 b=S0smSYuozhpWNkXO4Ct/6YpJ+kqCjPA7JBT9ynRrwQYerR1+iXFQZoNuW3mXgmbnlM
 Y47XVnY0l2qduYXtsVi1VQavD2OJpasgHWyRk+bHOxPNa14a7kQQhONuIlIiNZx+dGT5
 AWfJH1RnXvVkC8MpK6Iqgyh0atFnosT/8IJreloIrE83/79Jbe8fJ1MA2ARJiLv3IdEW
 eEH7+AO+Dhe5vObBil1Q8kSdB/Cy9k+QeJoMlYuwvI8xPSC6T8xhZlQSENzeEk4f4tEL
 JBnu3ztdfGvWDNOAzKQ3eCzoJYJgpSsbxSOX3aVUHbqfC6PLdyL0cBKBQu5TTdqcXBet
 oFTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmAtXuv/Oj7qe4mCkJ3+iiSlpJE5IPz/8xiMh8EJ48k9x3H67I0kO+RJj7fYRVRyBjKvQWkAbV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrgMlbG0U+nrHj+yV/uYcS5pbrKjnyPFlJ1S5HJo1ft5oE/JmI
 c8o7eUJzdToGJo/4mZWyUbrmXyi8/SxbZX/ailZXz/qc/D66VP+pVafAZ+NyMDnBKGiuCeH3Gqs
 WZvdxLpilVwgPLhW23TGe9QLDXCSop0KGAKUZpQtrORRo9/nnxNGyBiORtdDu9iw=
X-Received: by 2002:a05:600c:1d23:b0:428:eb6:2e73 with SMTP id
 5b1f17b1804b1-42cdb58db62mr145843785e9.29.1726575959889; 
 Tue, 17 Sep 2024 05:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0jbwSBYytCdU+Bu8kjEc0nWinMC6KrvgTzoFbP+dxniCUqWXx6FRdolXeJwjqomLSh6+2sQ==
X-Received: by 2002:a05:600c:1d23:b0:428:eb6:2e73 with SMTP id
 5b1f17b1804b1-42cdb58db62mr145843575e9.29.1726575959357; 
 Tue, 17 Sep 2024 05:25:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722?
 ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da242185dsm101745305e9.33.2024.09.17.05.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 05:25:58 -0700 (PDT)
Message-ID: <b1191ab8-a3c6-4873-9a96-58c8e47c9e0c@redhat.com>
Date: Tue, 17 Sep 2024 14:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
To: Lu Yao <yaolu@kylinos.cn>, alexdeucher@gmail.com,
 ckoenig.leichtzumerken@gmail.com, daniel@ffwll.ch
Cc: Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 srinivasan.shanmugam@amd.com, sunil.khatri@amd.com
References: <20240802071752.116541-1-yaolu@kylinos.cn>
 <20240812060914.102614-1-yaolu@kylinos.cn>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240812060914.102614-1-yaolu@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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

On 12/08/2024 08:09, Lu Yao wrote:
> Add support for the drm_panic module, which displays a pretty user
> friendly message on the screen when a Linux kernel panic occurs.

 From a drm_panic point of view, it looks good to me.
I don't have the required hardware, so unfortunately I wasn't able to 
test it.

Best regards,

-- 

Jocelyn


> 
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
> Changes in v2:
> 1. Drop include "drm_internal.h"
> 2. Add disabling DC tiling ops.
> Per suggestion from previous thread:
> https://patchwork.freedesktop.org/patch/606879/?series=136832&rev=1
> ---
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 48 +++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index 05c0df97f01d..ba1b7a36caa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -28,6 +28,7 @@
>   #include <drm/drm_modeset_helper.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_vblank.h>
> +#include <drm/drm_panic.h>
>   
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
> @@ -2600,6 +2601,52 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
>   	.get_scanout_position = amdgpu_crtc_get_scanout_position,
>   };
>   
> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct drm_plane *plane,
> +							 struct drm_scanout_buffer *sb)
> +{
> +	struct drm_framebuffer *fb;
> +	struct amdgpu_bo *abo;
> +	struct amdgpu_crtc *amdgpu_crtc;
> +	struct amdgpu_device *adev;
> +	uint32_t fb_format;
> +
> +	if (!plane->fb)
> +		return -EINVAL;
> +
> +	fb = plane->fb;
> +
> +	abo = gem_to_amdgpu_bo(fb->obj[0]);
> +	amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
> +	adev = drm_to_adev(fb->dev);
> +
> +	if (!abo->kmap.virtual &&
> +	    ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->kmap)) {
> +		DRM_WARN("amdgpu bo map failed, panic won't be displayed\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> +		iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual);
> +	else
> +		iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
> +
> +	sb->width = fb->width;
> +	sb->height = fb->height;
> +	sb->format = fb->format;
> +	sb->pitch[0] = fb->pitches[0];
> +
> +	/* Disable DC tiling */
> +	fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
> +	fb_format &= ~GRPH_ARRAY_MODE(0x7);
> +	WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
> +
> +	return 0;
> +}
> +
> +static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_helper_funcs = {
> +	.get_scanout_buffer = dce_v6_0_drm_primary_plane_get_scanout_buffer
> +};
> +
>   static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>   {
>   	struct amdgpu_crtc *amdgpu_crtc;
> @@ -2627,6 +2674,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>   	amdgpu_crtc->encoder = NULL;
>   	amdgpu_crtc->connector = NULL;
>   	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_funcs);
> +	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_primary_plane_helper_funcs);
>   
>   	return 0;
>   }

