Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3563EC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 09:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA52A22DBF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 09:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA52A22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF75E6E9CB;
	Fri, 22 Jan 2021 09:42:58 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F566E9CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 09:42:57 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id e15so3767349wme.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 01:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8Ejb4CkfchJ5WI5RkS8CTWJ007Y6+mEL9SCYCrkVdNg=;
 b=ANjvUwOBwvfFxHC5edgan5cnVTlKD7CmI0wB+uwakuXPgAdk0t3M3EYyRGWwKJYQNw
 bvMMF7lLJCP0PkKpb8RHMbWuLB/aPMSwQj15dEHeu3EqcFWTh2CauYHyPcey8V6oJhGh
 7Lh+BWrYrgGcfML+w+2O86s9j2jh29wLDIIAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8Ejb4CkfchJ5WI5RkS8CTWJ007Y6+mEL9SCYCrkVdNg=;
 b=VownQh8MOnR9jn2BRzYGAM2fTRCriKtRkgGyqiA36lJcJPCEWYwp3E7zimMjXwgLw6
 Qd9DgpBTg/Bztrdc5cVbJCs5FWdtfAAwB8r6xjlsXOL+03big5Z/eZFCernlicpNmAJg
 n0o27W4i3BSeR5uqVIiM3jRwZP0/Kz0jSukGkEUiy0leC14m5JKLuksmYWEIf67Z73de
 iunUJtc80XWNzlCy6Jr45XPhyPUzDs95FuaDBlLzNeMokgE+BkPv8KU7DtcQUMnYYrrw
 AMVREN+Z80hbwNVd6j0VGxqvkQbydnO1qTsm7V9KEWbRccT9kEMNesmn8z9vk8hpoSJv
 ezrQ==
X-Gm-Message-State: AOAM531I2R1BxdqRsQtpFYiUFpbPka8XL9SUQbmIUjnrrPvQt4LzgMPK
 lHJiPXKrOSxTv143KI2hY5LFcg==
X-Google-Smtp-Source: ABdhPJy7uAxakNo0PR9sFL3AnSVuLkbokI+womraO4UWUYQhsR5mJflk3TXt9dv7GX9OtNDW5eNSrQ==
X-Received: by 2002:a1c:2c0b:: with SMTP id s11mr2971561wms.13.1611308576551; 
 Fri, 22 Jan 2021 01:42:56 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id b13sm11286241wrt.31.2021.01.22.01.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jan 2021 01:42:55 -0800 (PST)
Date: Fri, 22 Jan 2021 10:42:53 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH 0/3] Experimental freesync video mode optimization
Message-ID: <YAqeHZlDBrgALLo9@phenom.ffwll.local>
References: <20210119155029.18943-1-aurabindo.pillai@amd.com>
 <20210122103248.779e70bf@eldfell>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210122103248.779e70bf@eldfell>
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
Cc: stylon.wang@amd.com, thong.thai@amd.com, shashank.sharma@amd.com,
 dri-devel@lists.freedesktop.org, nicholas.kazlauskas@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, wayne.lin@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 22, 2021 at 10:32:48AM +0200, Pekka Paalanen wrote:
> On Tue, 19 Jan 2021 10:50:26 -0500
> Aurabindo Pillai <aurabindo.pillai@amd.com> wrote:
> 
> > Changes in V5
> > =============
> > 
> > * More info in commit messages on the rationale of changes being added
> > to the kernel.
> > * Minor fixes
> 
> Hi,
> 
> thank you for adding the explanations in the commit messages I asked
> for. It is now up to DRM maintainers to determine if this is
> conceptually fine.
> 
> I do see that apparently setting the opt-in option does not yet taint
> the kernel although Daniel Vetter suggested it might be a good idea. I
> guess tainting the kernel would make it easier to remove this feature
> in the future because it would be easier to dismiss people that claim a
> kernel regression due to the removal.

Reading the descriptions I'm honestly not sure why this isn't enabled by
default?

Maybe the explanations should also capture why this is maybe not a good
idea ...
-Daniel

> 
> 
> Thanks,
> pq
> 
> 
> > --
> > 
> > This patchset enables freesync video mode usecase where the userspace
> > can request a freesync compatible video mode such that switching to this
> > mode does not trigger blanking.
> > 
> > This feature is guarded by a module parameter which is disabled by
> > default. Enabling this paramters adds additional modes to the driver
> > modelist, and also enables the optimization to skip modeset when using
> > one of these modes.
> > 
> > --
> > 
> > Aurabindo Pillai (3):
> >   drm/amd/display: Add module parameter for freesync video mode
> >   drm/amd/display: Add freesync video modes based on preferred modes
> >   drm/amd/display: Skip modeset for front porch change
> > 
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  12 +
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 401 ++++++++++++++++--
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
> >  4 files changed, 382 insertions(+), 35 deletions(-)
> > 
> 



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
