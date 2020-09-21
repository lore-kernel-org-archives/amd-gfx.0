Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9A5C43463
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 09:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29A420773
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 09:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="birNdg/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29A420773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8D96E247;
	Mon, 21 Sep 2020 09:09:54 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F8E6E249
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 09:09:51 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id t10so11894329wrv.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 02:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fAVVSw+Lw5u8RkTPDPSBrKsahSYxK5N2+xaOm2dYak8=;
 b=birNdg/QmDDNh057o/PKfwu9uhW0Njxo9tc3KbomwzoIK4cbmh9wM25k3KXLCvajVY
 1ENc6rqGTtAEoXhkhoZuW5Xvcv0tWtdjLnxhvKqd7MPPysc9ImeYA2IXu5FdiwdAoF/c
 /3GZ4gCV/uHRHJMyf5e6msf+YR9QlbZPDMrNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fAVVSw+Lw5u8RkTPDPSBrKsahSYxK5N2+xaOm2dYak8=;
 b=REdob6P7oo5bI4Hzi6KEDHSShOD5XRsBFBMK8UExkevlo2s5zvS4e9XHYtHeAGy6kZ
 UWP6kW4yD/3KKAeF6/LAR7wPUvTwbORXt6G4wJGulmUwiJrfTTQjn6KBkwSl+DPwotff
 Ch0TUAfyOcNhxy7RfBgwHy0S2eht8Z0VM2ePjPm5gDWr9uowd7w8ZEuA4Z45Eii1i6l+
 /ZdlSv0ixX7bnPkOoBNkwOX5ii6FkpnrtGhEOoV8Zo3ovqVMU7Z8TY0d6EbTMyRg/qiH
 er1AkyxmaBBEnstFWX+VnCegrQJX3kxLODipNVxcUtpKxdms9Xp4OdXulAaS+crUcpwY
 H8Mw==
X-Gm-Message-State: AOAM531zM178+bKOHIn8cj/f7dLCCCINmwUayI7KGG2THNM+BkVGgB4S
 Xu+0gKelFStz3uIqxGRu2xsIBA==
X-Google-Smtp-Source: ABdhPJwsHMgqO6KuxTYCVHoQvSAn867Ob8+iM6WX67irriuvqbR20flip6bplkOd6Zg8lDELWmek0w==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr50795596wro.362.1600679390040; 
 Mon, 21 Sep 2020 02:09:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id k12sm19461209wrn.39.2020.09.21.02.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 02:09:49 -0700 (PDT)
Date: Mon, 21 Sep 2020 11:09:47 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] [PATCH 0/4] managed drm_device, absolute final
 leftover bits
Message-ID: <20200921090947.GI438822@phenom.ffwll.local>
References: <20200918132505.2316382-1-daniel.vetter@ffwll.ch>
 <CADnq5_NW_k6szxmLxvf+tca4-D7oUfkLg1W-P0Q8AjVPBK_=iQ@mail.gmail.com>
 <20200918171221.GB716636@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918171221.GB716636@intel.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 18, 2020 at 01:12:21PM -0400, Rodrigo Vivi wrote:
> On Fri, Sep 18, 2020 at 11:03:12AM -0400, Alex Deucher wrote:
> > On Fri, Sep 18, 2020 at 9:25 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > >
> > > Hi all,
> > >
> > > These are the leftovers of the leftovers of my initial drmm series to
> > > manage drm_device.
> > >
> > > Changes:
> > > - bugfixed i915 selftests
> > > - patch from Luben to finalize the admgpu conversion
> > >
> > > Alex & i915 maintainers, pls ack for merging this all through
> > > drm-misc-next since otherwise the final patch (and the resulting confusion
> > > with outdated docs) is held up another round.
> > 
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> 
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Entire series merged into drm-misc-next.
-Daniel

> 
> > 
> > >
> > > Cheers, Daniel
> > >
> > > Daniel Vetter (3):
> > >   drm/i915/selftest: Create mock_destroy_device
> > >   drm/i915/selftests: align more to real device lifetimes
> > >   drm/dev: Remove drm_dev_init
> > >
> > > Luben Tuikov (1):
> > >   drm/amdgpu: Convert to using devm_drm_dev_alloc() (v2)
> > >
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 16 ++----
> > >  drivers/gpu/drm/drm_drv.c                     | 41 ++--------------
> > >  drivers/gpu/drm/drm_internal.h                |  1 +
> > >  drivers/gpu/drm/drm_managed.c                 | 13 -----
> > >  .../gpu/drm/i915/gem/selftests/huge_pages.c   |  2 +-
> > >  .../drm/i915/gem/selftests/i915_gem_context.c |  2 +-
> > >  .../drm/i915/gem/selftests/i915_gem_dmabuf.c  |  2 +-
> > >  .../drm/i915/gem/selftests/i915_gem_object.c  |  2 +-
> > >  .../drm/i915/gem/selftests/i915_gem_phys.c    |  2 +-
> > >  drivers/gpu/drm/i915/gt/selftest_timeline.c   |  2 +-
> > >  .../gpu/drm/i915/selftests/i915_gem_evict.c   |  2 +-
> > >  drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  2 +-
> > >  drivers/gpu/drm/i915/selftests/i915_request.c |  2 +-
> > >  drivers/gpu/drm/i915/selftests/i915_vma.c     |  2 +-
> > >  .../drm/i915/selftests/intel_memory_region.c  |  2 +-
> > >  .../gpu/drm/i915/selftests/mock_gem_device.c  | 49 ++++++++++++-------
> > >  .../gpu/drm/i915/selftests/mock_gem_device.h  |  2 +
> > >  include/drm/drm_drv.h                         |  4 --
> > >  18 files changed, 51 insertions(+), 97 deletions(-)
> > >
> > > --
> > > 2.28.0
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
