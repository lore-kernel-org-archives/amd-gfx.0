Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398DAC433E6
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 17:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87BB52076E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 17:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BB52076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1583F6E49C;
	Thu,  7 Jan 2021 17:57:13 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 887716E49C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 17:57:12 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id 91so6513873wrj.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jan 2021 09:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=epnDB6nk5qLto816ToRrp/gD18gbPhIUw9cBxkZJabc=;
 b=NDTJLW1b0HAeNP9uHINtjAlWUGBpm9q0ttV+zqJgT/9dlkI6olK9T4F5UFs6qmAjjr
 0Z3VgIGiDoVnNoG1YZGmhJBvBmoPPc8E4z0qA0RMark48CbfO9VET2+VByj6QXnqF8eG
 L6kmiCl8xrBdKzFAxWStOS6G+ZMxJVqGEFris=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=epnDB6nk5qLto816ToRrp/gD18gbPhIUw9cBxkZJabc=;
 b=KPMURQCuQb1FDXLGTe44xBp94nlZ6e3Hflfg5FmNcyZlMOfUsa7UPTuo8yOnNEtUc1
 4tmMe/9EWMKqPzfKHyQubU+PMwdMbrmmmvyQZv7/R/qrFCZ84QzLW6mLgZbTdWnbaT51
 kfqFO8bx28rYCj49xgNDcRYP3OcojoASUZtbam9QUoencTVSJjkKhWTmjqY5cvbes1wq
 DzD8Z548mrpftjyKbcIn8zJ9zJbughg9lyUd8I94mqbmVd2TbV4cCplQmeu5UpIH+Jp2
 Ks2a2jGg6TpOuuD2zm8Y3UR7MwpRn8owAJTaPNFd+Nkwuasih1gEVrGFIj04gl5wA9Ll
 zSFQ==
X-Gm-Message-State: AOAM531ybeT0CvF0B9JF/crDrwwDfr5GDR9HNlu6STgf2PoZM7/KgVHf
 X+xAwQeBcn5zbxvXpKyIcPrTiA==
X-Google-Smtp-Source: ABdhPJzLvHs4BUy631eHKSoB2GxbOeOYOWJWFur9yMGlEwGTo0M3Z2GpbDMw9WwjhkRgstUKYitKMg==
X-Received: by 2002:a5d:560e:: with SMTP id l14mr10014595wrv.191.1610042231211; 
 Thu, 07 Jan 2021 09:57:11 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id u6sm10222800wrm.90.2021.01.07.09.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Jan 2021 09:57:10 -0800 (PST)
Date: Thu, 7 Jan 2021 18:57:08 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Mario Kleiner <mario.kleiner.de@gmail.com>
Subject: Re: [PATCH] drm: Check actual format for legacy pageflip.
Message-ID: <X/dLdN1z6/Viqy9v@phenom.ffwll.local>
References: <20210102140235.514039-1-bas@basnieuwenhuizen.nl>
 <CAEsyxyheUd-jyd7X=7HJcOWqcrHgwsTAFyVhW9rJhutEdb=6MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEsyxyheUd-jyd7X=7HJcOWqcrHgwsTAFyVhW9rJhutEdb=6MQ@mail.gmail.com>
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, zhan.liu@amd.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jan 02, 2021 at 04:31:36PM +0100, Mario Kleiner wrote:
> On Sat, Jan 2, 2021 at 3:02 PM Bas Nieuwenhuizen
> <bas@basnieuwenhuizen.nl> wrote:
> >
> > With modifiers one can actually have different format_info structs
> > for the same format, which now matters for AMDGPU since we convert
> > implicit modifiers to explicit modifiers with multiple planes.
> >
> > I checked other drivers and it doesn't look like they end up triggering
> > this case so I think this is safe to relax.
> >
> > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Fixes: 816853f9dc40 ("drm/amd/display: Set new format info for converted metadata.")
> > ---
> >  drivers/gpu/drm/drm_plane.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> > index e6231947f987..f5085990cfac 100644
> > --- a/drivers/gpu/drm/drm_plane.c
> > +++ b/drivers/gpu/drm/drm_plane.c
> > @@ -1163,7 +1163,7 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
> >         if (ret)
> >                 goto out;
> >
> > -       if (old_fb->format != fb->format) {
> > +       if (old_fb->format->format != fb->format->format) {
> 
> This was btw. the original way before Ville made it more strict about
> 4 years ago, to catch issues related to tiling, and more complex
> layouts, like the dcc tiling/retiling introduced by your modifier
> patches. That's why I hope my alternative patch is a good solution for
> atomic drivers while keeping the strictness for potential legacy
> drivers.

Yeah this doesn't work in full generality, because hw might need to do a
full modeset to do a full modeset to reallocate resources (like scanout
fifo space) if the format changes.

But for atomic drivers that should be caught in ->atomic_check, which
should result in -EINVAL, so should do the right thing. So it should be
all good, but imo needs a comment to explain what's going on:

	/*
	 * Only check the FOURCC format code, excluding modifiers. This is
	 * enough for all legacy drivers. Atomic drivers have their own
	 * checks in their ->atomic_check implementation, which will
	 * return -EINVAL if any hw or driver constraint is violated due
	 * to modifier changes.
	 */

Also can you pls cc: intel-gfx to get this vetted by the intel-gfx ci?

With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> -mario
> 
> >                 DRM_DEBUG_KMS("Page flip is not allowed to change frame buffer format.\n");
> >                 ret = -EINVAL;
> >                 goto out;
> > --
> > 2.29.2
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
