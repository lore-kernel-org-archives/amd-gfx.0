Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD16C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 17:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8E010E758;
	Wed, 19 Jan 2022 17:24:26 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216C310E75C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 17:24:26 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id c2so6548993wml.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=eOH9iqU5IVX14/tYvkJqEjk8Qx7vTHtd1JM4aN1Uy+o=;
 b=DmDrtO1qA5+xS6RSFjC8YRAgWKLJSBrsCK3C1mYCeL3ScNiBJNJt+zzuegOEmgLjoP
 +/1qV59z4FrPlFKaNmWWmOAzeWqYXZefKd0ekBDSMLyaEC7lt9t07rqtIL/3zUc121jm
 +dcjCTcj0zrh3pRs67AwP1TQsb2jKMgygW7C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=eOH9iqU5IVX14/tYvkJqEjk8Qx7vTHtd1JM4aN1Uy+o=;
 b=2T5AQMqnUaSNtWHtP4AOYrPYZOC5OV6PDqOoj0c0cRqTyF2W3h1ioMz4TSPELDsQHd
 K7PdoiOhhI9pNUd23bIz3knnZJb2bFoLxSNgWEO2jx03XXDG2GsLGY4G5qLA4PSN5oYe
 ePRDz8VC12xTI8mSUSbVLjU8W8HKZA7LQiZ4x5cc08846Qd/241oBbpYrr3bQ7MgAk1J
 Faf5deO/H3y/Cq+h3KFVHa4riEZiJk7qpUI8kfGbbeZj5m+4zMpIJjfYoe/tnO9nWuRI
 x0Aw4wdoOEXvA1uBJxh5tlNDXz8vOXdONF6JMQMWaJ2zI7W3Vh11nd076uFmvSPtzocI
 WN4Q==
X-Gm-Message-State: AOAM533Er2JRECixP2zdk6uCcHoYJVwbmtYmpLfsEP+dxJyXyiBNdV64
 cZOLJhdZGpXJcl8kD1wAjSPlrQ==
X-Google-Smtp-Source: ABdhPJwmz4gHSPo9o9SV/Nix2goUKu/7MKdI00pmWvKG61VzYeY9XiHQLJbDl27v8A+WKNfPotxwNQ==
X-Received: by 2002:adf:e291:: with SMTP id v17mr29163539wri.479.1642613064738; 
 Wed, 19 Jan 2022 09:24:24 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f6sm428161wrj.26.2022.01.19.09.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 09:24:24 -0800 (PST)
Date: Wed, 19 Jan 2022 18:24:22 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 0/7] DRM kmap() fixes and kmap_local_page() conversions
Message-ID: <YehJRt+JngIsj+Gd@phenom.ffwll.local>
Mail-Followup-To: Ira Weiny <ira.weiny@intel.com>,
 David Airlie <airlied@linux.ie>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
References: <20211210232404.4098157-1-ira.weiny@intel.com>
 <20220119165356.GD209936@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119165356.GD209936@iweiny-DESK2.sc.intel.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
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
Cc: David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
 intel-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 19, 2022 at 08:53:56AM -0800, Ira Weiny wrote:
> On Fri, Dec 10, 2021 at 03:23:57PM -0800, 'Ira Weiny' wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > This series starts by converting the last easy kmap() uses to
> > kmap_local_page().
> > 
> > There is one more call to kmap() wrapped in ttm_bo_kmap_ttm().  Unfortunately,
> > ttm_bo_kmap_ttm() is called in a number of different ways including some which
> > are not thread local.  I have a patch to convert that call.  However, it is not
> > straight forward so it is not included in this series.
> > 
> > The final 2 patches fix bugs found while working on the ttm_bo_kmap_ttm()
> > conversion.
> 
> Gentile ping on this series?  Will it make this merge window?

I think this fell through the cracks and so no. Note that generally we
feature-freeze drm tree around -rc6 anyway for the upcoming merge window,
so you were cutting this all a bit close anyway. Also looks like the ttm
kmap caching question didn't get resolved?

Anyway if patches are stuck resend with RESEND and if people still don't
pick them up poke me and I'll apply as fallback.

Cheers, Daniel

> 
> Thanks,
> Ira
> 
> > 
> > 
> > Ira Weiny (7):
> > drm/i915: Replace kmap() with kmap_local_page()
> > drm/amd: Replace kmap() with kmap_local_page()
> > drm/gma: Remove calls to kmap()
> > drm/radeon: Replace kmap() with kmap_local_page()
> > drm/msm: Alter comment to use kmap_local_page()
> > drm/amdgpu: Ensure kunmap is called on error
> > drm/radeon: Ensure kunmap is called on error
> > 
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 ++++----
> > drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
> > drivers/gpu/drm/gma500/gma_display.c | 6 ++----
> > drivers/gpu/drm/gma500/mmu.c | 8 ++++----
> > drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 4 ++--
> > drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 8 ++++----
> > drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c | 4 ++--
> > drivers/gpu/drm/i915/gt/shmem_utils.c | 4 ++--
> > drivers/gpu/drm/i915/i915_gem.c | 8 ++++----
> > drivers/gpu/drm/i915/i915_gpu_error.c | 4 ++--
> > drivers/gpu/drm/msm/msm_gem_submit.c | 4 ++--
> > drivers/gpu/drm/radeon/radeon_ttm.c | 4 ++--
> > drivers/gpu/drm/radeon/radeon_uvd.c | 1 +
> > 13 files changed, 32 insertions(+), 32 deletions(-)
> > 
> > --
> > 2.31.1
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
