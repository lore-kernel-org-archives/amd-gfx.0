Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B569EC07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 10:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DADA611C0
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 10:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DADA611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A54126E20F;
	Wed, 14 Jul 2021 10:46:47 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CCD6E20A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 10:46:46 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id g16so2639057wrw.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 03:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=v3Q4IW+Tnq3LR7w7B7FUkJx1yRHZEB8PQOPTwq5AvqE=;
 b=UQu6+dHy2DlSeqHxHqVk+nxlr4GuM1J/w1hBASN82zf9NtxplXhDYsZTrtp4MHfPym
 H7MGWBUgvnpwxV1/WFIxOHEMMS1y6lLnVW0q15pXQF7btlSLo5kwb989YO/hg5cxAgFd
 zyESl6JKSeIX/ZIZE/HRavshdOUG/7GDK4kJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=v3Q4IW+Tnq3LR7w7B7FUkJx1yRHZEB8PQOPTwq5AvqE=;
 b=kVSWyURFOC5v1NVpZOSbK0Oh8P2nYghWPywAykoEa78+aHNPtfKW3MZH41xS/tSlV2
 Wn/KBpHxA4Qo9evOJlQJejFswPBigLEkjSfL0X4+VzwVK4cTYPnovcMzkWlPCDzRmcJk
 plsyDAUxVz4KAQre94ka1fRvwUOwKX3hMlGKNGQ5CbnFX+DeabgZxmE5Yz3yOS0EGUsP
 O4xULbEHDVoBCz3nG1aa4zplE1X0XT6t6VdDN+XQ/RCk6er+dI21NJMfbkXOcLasp4jp
 XOIVE7j9vUCScvVqY96MDYfNEnWXTlIrT6SyjBPHAiE+PeGWX9uwFO7ONZIMj1AW2ICv
 VZIA==
X-Gm-Message-State: AOAM532QimCJjk3NMF0U3MhOnZwBhK1TPHOKvlw2GbCOkSAdT8cDMqPE
 2UFhwevFPZjvG6APN2RTRnRHMA==
X-Google-Smtp-Source: ABdhPJzF41/KARPef2iFjEiO0xwrDnTBBFrwVALDxRtixjZAW78DbBi8+M1nIBlvaioJVMCxyAeSqQ==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr12283610wrw.235.1626259605080; 
 Wed, 14 Jul 2021 03:46:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id g138sm2071019wmg.32.2021.07.14.03.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jul 2021 03:46:44 -0700 (PDT)
Date: Wed, 14 Jul 2021 12:46:42 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/1] drm/ttm: Fix COW check
Message-ID: <YO7AklcvXYvFqLDd@phenom.ffwll.local>
References: <20210712220636.475675-1-Felix.Kuehling@amd.com>
 <YO6/8DWgD9d6tJcr@phenom.ffwll.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YO6/8DWgD9d6tJcr@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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
Cc: Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 14, 2021 at 12:44:00PM +0200, Daniel Vetter wrote:
> On Mon, Jul 12, 2021 at 06:06:36PM -0400, Felix Kuehling wrote:
> > KFD Thunk maps invisible VRAM BOs with PROT_NONE, MAP_PRIVATE.
> > is_cow_mapping returns true for these mappings. Add a check for
> > vm_flags & VM_WRITE to avoid mmap failures on private read-only or
> > PROT_NONE mappings.
> > 
> > v2: protect against mprotect making a mapping writable after the fact
> > v3: update driver-specific vm_operations_structs
> > 
> > Fixes: f91142c62161 ("drm/ttm: nuke VM_MIXEDMAP on BO mappings v3")
> > Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> So looking at vmf_insert_pfn_prot() and the comment there we can't have
> VM_PFNMAP and is_cow_mapping ever be true, or things break. On platforms
> without pte_special at least.
> 
> So I'm not sure this is a great idea, and definitely not for all drivers
> ...
> 
> Can we clear VM_MAYWRITE instead to force this to be a non-cow mapping
> instead?

Quick git grep says there's plenty of drivers which clear MAYWRITE, and
often with comments to block mprotect upfront. That feels like the cleaner
approach, and maybe limited to an overwrite in just amdgpu with a comment
explaining why it's needed? As in amdgpu mmap function which just clears
VM_MAYWRITE if it's a cow mapping and then calls into ttm mmap
implementation.
-Daniel

> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c  |  3 ++-
> >  drivers/gpu/drm/nouveau/nouveau_gem.c    |  3 ++-
> >  drivers/gpu/drm/radeon/radeon_gem.c      |  3 ++-
> >  drivers/gpu/drm/ttm/ttm_bo_vm.c          | 14 +++++++++++++-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c |  1 +
> >  include/drm/ttm/ttm_bo_api.h             |  4 ++++
> >  6 files changed, 24 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > index b3404c43a911..1aa750a6a5d2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -79,7 +79,8 @@ static const struct vm_operations_struct amdgpu_gem_vm_ops = {
> >  	.fault = amdgpu_gem_fault,
> >  	.open = ttm_bo_vm_open,
> >  	.close = ttm_bo_vm_close,
> > -	.access = ttm_bo_vm_access
> > +	.access = ttm_bo_vm_access,
> > +	.mprotect = ttm_bo_vm_mprotect
> >  };
> >  
> >  static void amdgpu_gem_object_free(struct drm_gem_object *gobj)
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
> > index 5b27845075a1..164ea564bb7a 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> > @@ -70,7 +70,8 @@ static const struct vm_operations_struct nouveau_ttm_vm_ops = {
> >  	.fault = nouveau_ttm_fault,
> >  	.open = ttm_bo_vm_open,
> >  	.close = ttm_bo_vm_close,
> > -	.access = ttm_bo_vm_access
> > +	.access = ttm_bo_vm_access,
> > +	.mprotect = ttm_bo_vm_mprotect
> >  };
> >  
> >  void
> > diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
> > index 458f92a70887..c19ad07eb7b5 100644
> > --- a/drivers/gpu/drm/radeon/radeon_gem.c
> > +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> > @@ -77,7 +77,8 @@ static const struct vm_operations_struct radeon_gem_vm_ops = {
> >  	.fault = radeon_gem_fault,
> >  	.open = ttm_bo_vm_open,
> >  	.close = ttm_bo_vm_close,
> > -	.access = ttm_bo_vm_access
> > +	.access = ttm_bo_vm_access,
> > +	.mprotect = ttm_bo_vm_mprotect
> >  };
> >  
> >  static void radeon_gem_object_free(struct drm_gem_object *gobj)
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > index f56be5bc0861..fb325bad5db6 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > @@ -542,17 +542,29 @@ int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >  EXPORT_SYMBOL(ttm_bo_vm_access);
> >  
> > +int ttm_bo_vm_mprotect(struct vm_area_struct *vma, unsigned long start,
> > +		       unsigned long end, unsigned long newflags)
> > +{
> > +	/* Enforce no COW since would have really strange behavior with it. */
> > +	if (is_cow_mapping(newflags) && (newflags & VM_WRITE))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(ttm_bo_vm_mprotect);
> > +
> >  static const struct vm_operations_struct ttm_bo_vm_ops = {
> >  	.fault = ttm_bo_vm_fault,
> >  	.open = ttm_bo_vm_open,
> >  	.close = ttm_bo_vm_close,
> >  	.access = ttm_bo_vm_access,
> > +	.mprotect = ttm_bo_vm_mprotect,
> >  };
> >  
> >  int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_buffer_object *bo)
> >  {
> >  	/* Enforce no COW since would have really strange behavior with it. */
> > -	if (is_cow_mapping(vma->vm_flags))
> > +	if (is_cow_mapping(vma->vm_flags) && (vma->vm_flags & VM_WRITE))
> >  		return -EINVAL;
> >  
> >  	ttm_bo_get(bo);
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> > index e6b1f98ec99f..e4bf7dc99320 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> > @@ -61,6 +61,7 @@ int vmw_mmap(struct file *filp, struct vm_area_struct *vma)
> >  		.fault = vmw_bo_vm_fault,
> >  		.open = ttm_bo_vm_open,
> >  		.close = ttm_bo_vm_close,
> > +		.mprotect = ttm_bo_vm_mprotect,
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  		.huge_fault = vmw_bo_vm_huge_fault,
> >  #endif
> > diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
> > index f681bbdbc698..40eb95875355 100644
> > --- a/include/drm/ttm/ttm_bo_api.h
> > +++ b/include/drm/ttm/ttm_bo_api.h
> > @@ -605,6 +605,10 @@ void ttm_bo_vm_close(struct vm_area_struct *vma);
> >  
> >  int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
> >  		     void *buf, int len, int write);
> > +
> > +int ttm_bo_vm_mprotect(struct vm_area_struct *vma, unsigned long start,
> > +		       unsigned long end, unsigned long newflags);
> > +
> >  bool ttm_bo_delayed_delete(struct ttm_device *bdev, bool remove_all);
> >  
> >  vm_fault_t ttm_bo_vm_dummy_page(struct vm_fault *vmf, pgprot_t prot);
> > -- 
> > 2.32.0
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
