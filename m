Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9408CC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 08:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6638820866
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 08:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="O9HUD1hO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6638820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BBC06E073;
	Fri,  7 Aug 2020 08:29:17 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816BA6E0EB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 08:29:16 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z18so860696wrm.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Aug 2020 01:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CRdvfCZQ25pKhMuyy5C8/o66fLnI2l+uFCdUehGQFlA=;
 b=O9HUD1hO5VeLLA2H4G79GWAQrOIwSM139rEtPFCdJBmkZxHv4DQE6S8qGcnKBJZSHG
 1CK06i8N6vHG/NoMtE6HMkq9Qv6rIdBdBDR11EO84YOyjbTN83KQBqB3zwGZLuXJhheO
 eOp239XGujA/7MJlhjtnRJWgZFtjnKh8o7UqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CRdvfCZQ25pKhMuyy5C8/o66fLnI2l+uFCdUehGQFlA=;
 b=LKgd1SRuv+oMJiUXC3PEo4IuXTzN7WOjJaCMaOh5oPrpfQw48JQrG94XJiMBi5BOQP
 vQVPtHSSxJXUcxJqEPq2IIXjN7bJU6beBh5xBL+18C+yHLJAGR3Tfz4KrbIDdHEeeeN5
 NYjin7a1ezm74tTAg+PkyLdIb3QH4TmfoP0+aOF21hsgXjx9ovRqvAUb968/kVA5rYZN
 DR12XKNOplt+sMOc7TfmKUR8ZuBLomnewYIyqGD9x2/INDzkNvHKxIV+zHrQcIwJA7AV
 tQ2zZMJNeMTTYsrN/FNmz2i2G9C0VaHwES1XbaYBAf3MCgXB2uLdPOZVXM4fcr67EU+r
 RDeA==
X-Gm-Message-State: AOAM530sxftwFCzUZx/gm1MH0LG9k/StAC+jSqYKzl/enTl0bv3N5WJS
 IJ27kXzdEZqcSZHX6+QiBXWvSgPtY88=
X-Google-Smtp-Source: ABdhPJwAaIEhb/S+GRkSr2fWh2aR0IRsR5H5lmX1+kHhyZi+uo3GpgotFZx/8fh1bZ8XhHzhQYGBdg==
X-Received: by 2002:adf:dc83:: with SMTP id r3mr11925338wrj.172.1596788955183; 
 Fri, 07 Aug 2020 01:29:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id m8sm9696008wro.75.2020.08.07.01.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 01:29:14 -0700 (PDT)
Date: Fri, 7 Aug 2020 10:29:12 +0200
From: daniel@ffwll.ch
To: 
Subject: Re: [PATCH 0/7] drm/amd/display: Drop DRM private objects from
 amdgpu_dm
Message-ID: <20200807082912.GK6419@phenom.ffwll.local>
References: <20200730203642.17553-1-nicholas.kazlauskas@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200730203642.17553-1-nicholas.kazlauskas@amd.com>
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 30, 2020 at 04:36:35PM -0400, Nicholas Kazlauskas wrote:
> Based on the analysis of the bug from [1] the best course of action seems
> to be swapping off of DRM private objects back to subclassing DRM atomic
> state instead.
> 
> This patch series implements this change, but not yet the other changes
> suggested in the threads from that bug - these will come later.
> 
> CCing dri-devel per Daniel's suggestion since this issue brought
> some interesting misuse of private objects.

I ended up reading around a bit, and it feels like the sub-objects might
make a reasonable private state structure perhaps. Like dc_stream_state,
at least when reading around in e.g. dc_remove_stream_from_ctx.

But would need to come up with a plan how to integrate this on the other
os side of DC I guess :-)

Anyway I'd say more evidence that dc_state needs to subclass
drm_atomic_state.

Another thing I wondered is whether we should rename drm_atomic_state to
drm_atomic_state_update, so it's clear it's the container with the updated
states, not a real state object thing itself.
-Daniel

> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=207383
> 
> Nicholas Kazlauskas (7):
>   drm/amd/display: Store tiling_flags and tmz_surface on dm_plane_state
>   drm/amd/display: Reset plane when tiling flags change
>   drm/amd/display: Avoid using unvalidated tiling_flags and tmz_surface
>     in prepare_planes
>   drm/amd/display: Use validated tiling_flags and tmz_surface in
>     commit_tail
>   drm/amd/display: Reset plane for anything that's not a FAST update
>   drm/amd/display: Drop dm_determine_update_type_for_commit
>   drm/amd/display: Replace DRM private objects with subclassed DRM
>     atomic state
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 967 ++++++------------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  13 +-
>  2 files changed, 343 insertions(+), 637 deletions(-)
> 
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
