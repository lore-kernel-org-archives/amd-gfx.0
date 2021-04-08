Return-Path: <SRS0=VH8F=JF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8F5C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 11:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3203261105
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Apr 2021 11:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3203261105
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A79EB6EA9B;
	Thu,  8 Apr 2021 11:19:17 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE096EA97
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Apr 2021 11:19:16 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 y20-20020a1c4b140000b029011f294095d3so2712171wma.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Apr 2021 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7MyYEn9i2H/YcmRBa5m+qswzCV9lJj45DGS2du8D2As=;
 b=VZ6krWmPnff3rHrTu1YBPFVdpjNvgWRo+PMkwb2/yv64ErPAFo1LTBr9XGLjEybJRp
 yDXvpbDylqRd0tH22iKkYhm00Hh3iU5gUzE+oevKRklnndB881b26zFi5PshljLdi40O
 h6ZckHexnPdr0xgMsvLhWxsst+VXghWxVOD8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7MyYEn9i2H/YcmRBa5m+qswzCV9lJj45DGS2du8D2As=;
 b=d35rv17SlygPLt1EclA4b+UKUiNqgkrVWvxUKt04PHhGTfVOby5WeYGXmKXg42aMWu
 0gwKlZ8ScOpfE1SHvddd8xvLBJhewzrHFQwtPjoOEOe5IvV4IBcik8TLOodDGmWlPglB
 tgUN5kAfshMGnV8ep8FgIrFmsO5uwQ7/WqDTTxeMunymavhtH207Kb9labZVYvtluw/s
 l+tqS5RWYsU+LvGwQBKFstzIFsNB44Bcyd52nYk+tbLDISRwMaPv4fkz8EXBQVVeoHqT
 muZdAWQp1R5yrVEsx9kKJKfPqYCQFzOHam6Fi3grDdZANAo4M8QXIxXL5NDBA3B+BZKb
 lKhg==
X-Gm-Message-State: AOAM5325X6/LNAhU7AGhJpFcC2LJNB21b89mhQKwOh3iEQmfRwISpo7L
 7LehqCDdP0uKJJiqXsr7PE3uPg==
X-Google-Smtp-Source: ABdhPJwVXGk6II7OwYliQ9jwB6zvIqzky42R8LIj54sh24c+NrzV1rA30sUfpWa13IAc+0jtn1AqhA==
X-Received: by 2002:a1c:7713:: with SMTP id t19mr6915193wmi.13.1617880755544; 
 Thu, 08 Apr 2021 04:19:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id g15sm11081167wmq.31.2021.04.08.04.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 04:19:14 -0700 (PDT)
Date: Thu, 8 Apr 2021 13:19:12 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/8] drm: Clean up mmap for TTM-based GEM drivers
Message-ID: <YG7msOScvAKpjAXx@phenom.ffwll.local>
References: <20210406090903.7019-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210406090903.7019-1-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: dri-devel@lists.freedesktop.org, shashank.sharma@amd.com, airlied@linux.ie,
 nouveau@lists.freedesktop.org, Felix.Kuehling@amd.com, sroland@vmware.com,
 nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org, ray.huang@amd.com,
 linux-graphics-maintainer@vmware.com, bskeggs@redhat.com, daniel@ffwll.ch,
 alexander.deucher@amd.com, sam@ravnborg.org, christian.koenig@amd.com,
 zackr@vmware.com, emil.velikov@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 06, 2021 at 11:08:55AM +0200, Thomas Zimmermann wrote:
> Implement mmap via struct drm_gem_object_functions.mmap for amdgpu,
> radeon and nouveau. This allows for using common DRM helpers for
> the mmap-related callbacks in struct file_operations and struct
> drm_driver. The drivers have their own vm_ops, which are now set
> automatically by the DRM core functions. The code in each driver's
> verify_access becomes part of the driver's new mmap implementation.

Is there anything left in there which isn't already handled by the gem
checks? Iirc there was some custom limit for ttm drivers once to allow
co-existing with ums drivers, but that's never really been a thing since
forever ...
-Daniel

> 
> With the GEM drivers converted, vmwgfx is the only user of
> ttm_bo_mmap() and related infrastructure. So move everything into
> vmwgfx and delete the rsp code from TTM.
> 
> This touches several drivers. Preferably everything would be merged
> at once via drm-misc-next.
> 
> Thomas Zimmermann (8):
>   drm/ttm: Don't override vm_ops callbacks, if set
>   drm/amdgpu: Remove unused function amdgpu_bo_fbdev_mmap()
>   drm/amdgpu: Implement mmap as GEM object function
>   drm/radeon: Implement mmap as GEM object function
>   drm/nouveau: Implement mmap as GEM object function
>   drm/vmwgfx: Inline ttm_bo_mmap() into vmwgfx driver
>   drm/vmwgfx: Inline vmw_verify_access()
>   drm/ttm: Remove ttm_bo_mmap() and friends
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 46 -------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |  2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 64 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 19 ------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 71 ---------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 -
>  drivers/gpu/drm/nouveau/nouveau_bo.c        | 10 ---
>  drivers/gpu/drm/nouveau/nouveau_drm.c       |  3 +-
>  drivers/gpu/drm/nouveau/nouveau_gem.c       | 36 +++++++++++
>  drivers/gpu/drm/nouveau/nouveau_ttm.c       | 49 --------------
>  drivers/gpu/drm/nouveau/nouveau_ttm.h       |  1 -
>  drivers/gpu/drm/radeon/radeon_drv.c         |  3 +-
>  drivers/gpu/drm/radeon/radeon_gem.c         | 52 +++++++++++++++
>  drivers/gpu/drm/radeon/radeon_ttm.c         | 65 -------------------
>  drivers/gpu/drm/radeon/radeon_ttm.h         |  1 -
>  drivers/gpu/drm/ttm/ttm_bo_vm.c             | 60 ++---------------
>  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c  |  9 ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c    | 51 ++++++++++++++-
>  include/drm/ttm/ttm_bo_api.h                | 13 ----
>  include/drm/ttm/ttm_device.h                | 15 -----
>  22 files changed, 212 insertions(+), 365 deletions(-)
> 
> --
> 2.30.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
