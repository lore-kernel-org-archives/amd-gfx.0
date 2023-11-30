Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A6CC4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 11:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BB210E6DF;
	Thu, 30 Nov 2023 11:34:52 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEE710E504
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 11:34:50 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b41132c33aso128071b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1701344089; x=1701948889; darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XHw80n538+Gx5ghn40vIbarPIkmDFhTkXdjB2fzx/LU=;
 b=TvgH8inO0MW7ptFVPd5w1Qp9Gl9fv1cMJQW9jXY63e5EC5mn7pAA8bLv3dVIJYFF10
 GK8AJ3P+Nb9RXlDB0yngpYWDz+xt1UAgrUC1SnTI19mZKjQW7nGsdoRPse0i73Pj6yjC
 WuaBeSUawLmINqu8o1V7zh+jng55HknVB4SIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701344089; x=1701948889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XHw80n538+Gx5ghn40vIbarPIkmDFhTkXdjB2fzx/LU=;
 b=w4dKGiJ5ZfC6lcxjwC+wXkdG3b2v6CnowSmZ03TQPbMudg7pC/Ld3rT48EpwzadF+U
 jqmrb4dfJDT1AyFfSlpGpxXu+PdZXWLeKJBjFKAOjqdaDnkPj9ByUwtqoErYKafj0iWS
 HHULbsh+tEfXvXzi28ZoUIEulDw2Y1+gmz3PhyokAUHgZ0hS13DKevX3fA7E4Fyub1fW
 iqxbMTz5XwAUh1LF+PJEBFxv+6xtqbbh/AmficGTtzIlfA7UkMWp1YuYew8uhYXb7kVO
 mj6sm4pUz60nPL6iNtdKZUJJ3VmaA0FbEfSI0d5AK9+kKm+1g+y1VaIbj5dnRcJ4r8tl
 smcw==
X-Gm-Message-State: AOJu0Yxj1HC/wDAteGes3BncxWNSKe0AiYaIn/lr1ruy+vN4YwqaCVoJ
 9dE6dbMn8dpM00BIdy45bAxXW61XNCyznfmbXzxjqw==
X-Google-Smtp-Source: AGHT+IH0N/VIzZwe567QMp3cIDizl5ebBnGHUsjq9IIB8lLm8pqaq5ZetdamDtbtwXmfJNw703wAjffh1A9ZXlOIsCM=
X-Received: by 2002:a05:6870:168d:b0:1fa:132a:ad11 with SMTP id
 j13-20020a056870168d00b001fa132aad11mr23165211oae.2.1701344089322; Thu, 30
 Nov 2023 03:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20231116195812.906115-1-mwen@igalia.com>
 <bc60a7fd-8de7-4856-b5ed-e1172b9b79f7@amd.com>
In-Reply-To: <bc60a7fd-8de7-4856-b5ed-e1172b9b79f7@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 30 Nov 2023 12:34:37 +0100
Message-ID: <CAKMK7uH1BPhEm8vM=rFfAho06T-f+osjKX4ofOkjMazrhSouKw@mail.gmail.com>
Subject: Re: [PATCH v5 00/32] drm/amd/display: add AMD driver-specific
 properties for color mgmt
To: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: liviu.dudau@arm.com, dri-devel@lists.freedesktop.org, airlied@gmail.com,
 Sebastian Wick <sebastian.wick@redhat.com>, brian.starkey@arm.com,
 Shashank Sharma <Shashank.Sharma@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Hung <alex.hung@amd.com>, kernel-dev@igalia.com, sunpeng.li@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 Melissa Wen <mwen@igalia.com>, sungjoon.kim@amd.com,
 Pekka Paalanen <pekka.paalanen@collabora.com>, Simon Ser <contact@emersion.fr>,
 Xinhui.Pan@amd.com, Xaver Hugl <xaver.hugl@gmail.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, tzimmermann@suse.de,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Joshua Ashton <joshua@froggi.es>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 28 Nov 2023 at 23:11, Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2023-11-16 14:57, Melissa Wen wrote:
> > Hello,
> >
> > This series extends the current KMS color management API with AMD
> > driver-specific properties to enhance the color management support on
> > AMD Steam Deck. The key additions to the color pipeline include:
> >
>
> snip
>
> > Melissa Wen (18):
> >   drm/drm_mode_object: increase max objects to accommodate new color
> >     props
> >   drm/drm_property: make replace_property_blob_from_id a DRM helper
> >   drm/drm_plane: track color mgmt changes per plane
>
> If all patches are merged through amd-staging-drm-next I worry that
> conflicts creep in if any code around replace_property_blob_from_id
> changes in DRM.
>
> My plan is to merge DRM patches through drm-misc-next, as well
> as include them in the amd-staging-drm-next merge. They should then
> fall out at the next amd-staging-drm-next pull and (hopefully)
> ensure that there is no conflict.
>
> If no objections I'll go ahead with that later this week.

Double-merging tends to be the worst because git doesn't realize the
commits match, which actually makes the conflicts worse when they
happen (because the 3-way merge diff gets absolute confused by all the
changed context and misplaces everything to the max). So please don't,
_only_ every cherry-pick when a patch in -next is also needed in
-fixes, and we didn't put it into the right tree. But even that is a
bit tricky and should only be done by maintainers (using dim
cherry-pick if it's drm-misc) because the conflicts tend to be bad and
need to be sorted out with backmerges sooner than later.

For this case merge everything through one tree with the right acks,
pull to drm-next asap and then backmerge into the other tree. Here
probably amdgpu-next with drm-misc maintainer acks for the 3 core
patches. Or if amdgpu-next pull won't come for a while, put them into
drm-misc-next and just wait a week until it's in drm-next, then
forward amdgpu-next.

Cheers, Sima

> Harry
>
> >   drm/amd/display: add driver-specific property for plane degamma LUT
> >   drm/amd/display: explicitly define EOTF and inverse EOTF
> >   drm/amd/display: document AMDGPU pre-defined transfer functions
> >   drm/amd/display: add plane 3D LUT driver-specific properties
> >   drm/amd/display: add plane shaper LUT and TF driver-specific
> >     properties
> >   drm/amd/display: add CRTC gamma TF driver-specific property
> >   drm/amd/display: add comments to describe DM crtc color mgmt behavior
> >   drm/amd/display: encapsulate atomic regamma operation
> >   drm/amd/display: decouple steps for mapping CRTC degamma to DC plane
> >   drm/amd/display: reject atomic commit if setting both plane and CRTC
> >     degamma
> >   drm/amd/display: add plane shaper LUT support
> >   drm/amd/display: add plane shaper TF support
> >   drm/amd/display: add plane 3D LUT support
> >   drm/amd/display: add plane CTM driver-specific property
> >   drm/amd/display: add plane CTM support
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  91 ++
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  34 +-
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 108 +++
> >  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 818 ++++++++++++++++--
> >  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  72 ++
> >  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 232 ++++-
> >  .../gpu/drm/amd/display/include/fixed31_32.h  |  12 +
> >  drivers/gpu/drm/arm/malidp_crtc.c             |   2 +-
> >  drivers/gpu/drm/drm_atomic.c                  |   1 +
> >  drivers/gpu/drm/drm_atomic_state_helper.c     |   1 +
> >  drivers/gpu/drm/drm_atomic_uapi.c             |  43 +-
> >  drivers/gpu/drm/drm_property.c                |  49 ++
> >  include/drm/drm_mode_object.h                 |   2 +-
> >  include/drm/drm_plane.h                       |   7 +
> >  include/drm/drm_property.h                    |   6 +
> >  include/uapi/drm/drm_mode.h                   |   8 +
> >  16 files changed, 1377 insertions(+), 109 deletions(-)
> >
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
