Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9ADC83F21
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 13:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBD110E0E2;
	Tue, 15 Jul 2025 13:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="HnAzQgwp";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC72110E0E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 13:16:40 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4561ca74829so19004975e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1752585399; x=1753190199; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KSNHtnaETw4DtlzGAY8NvYjbcn3Lhzp8vASuZK7f+jQ=;
 b=HnAzQgwpJ8NKiyrjLBobTrQYLg4GDH8Lkh5p+8QU1zV6TPl+xDvuthHKT0Z/Svcx0T
 ejUrfl6t3QTPeNH/VhP/Hmaf4cxPYLpEb1Ry+CigJoqJDy6Vs52kQZfnNqdf1rYbFzun
 PQiZxLYJtK8dM3Iqc71DWxIECyc9a0Zq9PiUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752585399; x=1753190199;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSNHtnaETw4DtlzGAY8NvYjbcn3Lhzp8vASuZK7f+jQ=;
 b=QuMZF1i3SYxTorI/5xf8spqb3fXqgQLmPhcZscQN7RhZsVZS93VZOmNTSHb8rn25R/
 f1RYwOTl1/gLfB2S6oFsVpfzk0ONkLRfHlukVkpq+6zJ5PEZVwyLasyxah/OaltU6LwW
 g2v9wLZbmC2Q2s2n11VZtlR18icuFf5Xxs/XqD2wk1xlMwCakjjWFd4BP5DPLO2bIk/A
 Q0OwzZIUmnBWuPO6idadtHzQxIB0CV3xzvgGhfmYeOGATKFPxTZVT5p67CAaKS/GruIl
 ZtJHbp88t8E5XQXaL1f1G0agYNSi86mG1nHZSG9iYew5Lf8Zn0xJt1PpSwY52+kHfpv3
 f/nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV7zpkpOnDIa3hFXzvyASsDpV3CgVp+1Pb6HKLKN0gHm2WcIGOxCS5MPaV3VfL0x27YmbiYEXa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyOkx4x/bSrIRHCy4hnWU9L/RGBITiIfDLHvjLP7sqqgTzJ6ne
 LMBgrTGngeTBwFmXBFuDnvvC7leoS1+WSVt2YlRnlPbllxkL7H3IGWlPCWDRjSITrl8=
X-Gm-Gg: ASbGnctXfZLd7Uoo3jWX9iKWqE+Gp8BUHgxHMvnge6eU6HIGYnAFd8YF3ZO26b5DKvh
 bKEeg3mnhK8AgMaKvpT3H0Tn2CkF/+x2bHdN3hz5BNDXxccbp3vQL0FY0Wj+cvnrDMmbbcWDv7/
 likEUeR3EOcw//uk7hBKVWgVgU7YDCtE3vUQETy57ti7lx19ITK8Rz8tlIMjFuV32dbyD+ZSI76
 k3xQSWSq/cXfFhjsH2OA8ZQBlfDU+vBWxTw30wl8sD1pokyigcC8pUtWK3gnYbZ6Ijd6e2jz5/Y
 i+LPJ5DfvpCu863Q88WP9iJ/qIKg8oj8fAsoI32uqEGE/KqdHj4rz9ayRa9kKHSOE+58+ZAInw2
 JdJ9p92obnvpSXs3udXf+GSZXbM1BzGBSZwHNCNLDeDxM
X-Google-Smtp-Source: AGHT+IE6AVE3VzANWiPdrua10GyZdj4f6vBrn2kcw3n5QovC7tZwk4OkyMeCMgiFtC85TLlBWyscYg==
X-Received: by 2002:a05:600c:610:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-455174367demr115789855e9.2.1752585399385; 
 Tue, 15 Jul 2025 06:16:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562797b8d2sm19149335e9.8.2025.07.15.06.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 06:16:38 -0700 (PDT)
Date: Tue, 15 Jul 2025 15:16:37 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/amdgpu: Use dma_buf from GEM object instance"
Message-ID: <aHZUtdhU26IVoNwa@phenom.ffwll.local>
References: <20250715082635.34974-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715082635.34974-1-tzimmermann@suse.de>
X-Operating-System: Linux phenom 6.12.30-amd64 
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

On Tue, Jul 15, 2025 at 10:26:22AM +0200, Thomas Zimmermann wrote:
> This reverts commit 515986100d176663d0a03219a3056e4252f729e6.
> 
> The dma_buf field in struct drm_gem_object is not stable over the
> object instance's lifetime. The field becomes NULL when user space
> releases the final GEM handle on the buffer object. This resulted
> in a NULL-pointer deref.
> 
> Workarounds in commit 5307dce878d4 ("drm/gem: Acquire references on
> GEM handles for framebuffers") and commit f6bfc9afc751 ("drm/framebuffer:
> Acquire internal references on GEM handles") only solved the problem
> partially. They especially don't work for buffer objects without a DRM
> framebuffer associated.
> 
> Hence, this revert to going back to using .import_attach->dmabuf.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index ff98c87b2e0b..5743ebb2f1b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -514,7 +514,7 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
>  		return false;
>  
>  	if (drm_gem_is_imported(obj)) {
> -		struct dma_buf *dma_buf = obj->dma_buf;
> +		struct dma_buf *dma_buf = obj->import_attach->dmabuf;
>  
>  		if (dma_buf->ops != &amdgpu_dmabuf_ops)
>  			/* No XGMI with non AMD GPUs */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6626a6e64ff5..d1ccbfcf21fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -317,7 +317,8 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>  	 */
>  	if (!vm->is_compute_context || !vm->process_info)
>  		return 0;
> -	if (!drm_gem_is_imported(obj) || !dma_buf_is_dynamic(obj->dma_buf))
> +	if (!drm_gem_is_imported(obj) ||
> +	    !dma_buf_is_dynamic(obj->import_attach->dmabuf))
>  		return 0;
>  	mutex_lock_nested(&vm->process_info->lock, 1);
>  	if (!WARN_ON(!vm->process_info->eviction_fence)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index af0f655dfd5b..b9b4f7d9186e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1272,7 +1272,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>  		struct drm_gem_object *obj = &bo->tbo.base;
>  
>  		if (drm_gem_is_imported(obj) && bo_va->is_xgmi) {
> -			struct dma_buf *dma_buf = obj->dma_buf;
> +			struct dma_buf *dma_buf = obj->import_attach->dmabuf;
>  			struct drm_gem_object *gobj = dma_buf->priv;
>  			struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
>  
> -- 
> 2.50.0
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
