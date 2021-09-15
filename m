Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729B2C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 18:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1358E60E97
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 18:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1358E60E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10D36E9D5;
	Wed, 15 Sep 2021 18:22:15 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C7A16E9D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 18:22:15 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 o16-20020a9d2210000000b0051b1e56c98fso4768193ota.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KMkL0Na1bvBAspYFjJcYfpgdh40D2FivyKdNw6G36n4=;
 b=npaX80qfDCw/mkpH+tZs+p/a8ft2DWSc2AKGtdlgJumBstBS/6G5YiyT28WGkqhF7a
 cHS84ALecJVYe9irHhRkpGzg6baqIDP3xbXGi6LiOFbUyINPRIs7TIW/lToqmnppiIOB
 pFZFLPJfsWtR97hAtrDpWIKzX2BvB2BezzdEZolelI4QuzEDW+0YSzgLKdBkrLWwmJn4
 l2VDQPOsHcz59u1Kqzs0GsJhT8l6GEYyCdDgMjxn3RHh72wcAVgeZecet+H0DBd7guXy
 ZkFF69hC/O362E/yMGJX8T3tWdNNo4hjOW0uYBtMoRjQCph90LmdZvsCK/vdipuJ4+Ye
 Zgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KMkL0Na1bvBAspYFjJcYfpgdh40D2FivyKdNw6G36n4=;
 b=botcgvBLN2TXs9xshoqJ8ck7FBI2ruruvVe4af5XRGpO4c5RV/waWxxOJdlbyHlqr7
 MQ3fivKmKPCKrOCq2os8zt/5R4teDeAiCH5d9k6OPcqBYVwdBCxRHcmwc2mNshLgS5i5
 j1aJcBSX4xerMA2hn/kA55eaMoVbEfHBDfRksUbwbkANR5rJQYLlhBbca1Jse9phLrkP
 K4isftfGWfgigpYgWes3QB4PO8LUzRBJrwM+XXN+b3BjZaGf+UCedbRjlXrFACUGnf76
 N4arjyfPK+kMDIE+vJmF+C0jm/oW0w/l98oeaUsx+R2zintL6Zo0CvxXdDQCp+9UOfvA
 pwhw==
X-Gm-Message-State: AOAM531wSUtWj2gP8r5v4tWrtuC+oOWhuQzRXR1iIMrjvZUeltnJ0VDQ
 yoN7HNOaFpI7BvzFqqZNMbk6vx131jxLGHj0aYw=
X-Google-Smtp-Source: ABdhPJwsWCn4udQX5x0G1kShI0rzQf/xKYGBphMFZ3qdRsT/wVe4fcktfDpAqsad09WksBs4ci1qMtiEoRzAXlhMOQM=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr1245369otd.200.1631730134339; 
 Wed, 15 Sep 2021 11:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210914235948.893422-1-joshua@froggi.es>
 <20210914235948.893422-3-joshua@froggi.es>
 <d8cd6940-70ba-9c4d-38cb-4b1938f3c19b@amd.com>
In-Reply-To: <d8cd6940-70ba-9c4d-38cb-4b1938f3c19b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Sep 2021 14:22:03 -0400
Message-ID: <CADnq5_N6DF-xpCmV2mSjpX-yFmx=Uj-i8u3L=OndO6iCjjCX0A@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Add modifiers capable of DCC image
 stores for gfx10_3
To: Harry Wentland <harry.wentland@amd.com>
Cc: Joshua Ashton <joshua@froggi.es>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Sep 15, 2021 at 2:02 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-09-14 19:59, Joshua Ashton wrote:
> > Some games, ie. Doom Eternal, present from compute following compute
> > post-fx and would benefit from having DCC image stores available.
> >
> > DCN on gfx10_3 doesn't need INDEPENDENT_128B_BLOCKS = 0 so we can expose
> > these modifiers capable of DCC image stores.
> >
> > Signed-off-by: Joshua Ashton <joshua@froggi.es>
> > Reviewed-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>
> Series is
> Acked-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 2a24e43623cb..a4e33a4336a0 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -4817,6 +4817,16 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
> >                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> >                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> >
> > +     add_modifier(mods, size, capacity, AMD_FMT_MOD |
> > +                 AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> > +                 AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> > +                 AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> > +                 AMD_FMT_MOD_SET(PACKERS, pkrs) |
> > +                 AMD_FMT_MOD_SET(DCC, 1) |
> > +                 AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> > +                 AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> > +                 AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
> > +
> >       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> >                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> >                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> > @@ -4829,6 +4839,17 @@ add_gfx10_3_modifiers(const struct amdgpu_device *adev,
> >                   AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> >                   AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_64B));
> >
> > +     add_modifier(mods, size, capacity, AMD_FMT_MOD |
> > +                 AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> > +                 AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> > +                 AMD_FMT_MOD_SET(PIPE_XOR_BITS, pipe_xor_bits) |
> > +                 AMD_FMT_MOD_SET(PACKERS, pkrs) |
> > +                 AMD_FMT_MOD_SET(DCC, 1) |
> > +                 AMD_FMT_MOD_SET(DCC_RETILE, 1) |
> > +                 AMD_FMT_MOD_SET(DCC_CONSTANT_ENCODE, 1) |
> > +                 AMD_FMT_MOD_SET(DCC_INDEPENDENT_128B, 1) |
> > +                 AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, AMD_FMT_MOD_DCC_BLOCK_128B));
> > +
> >       add_modifier(mods, size, capacity, AMD_FMT_MOD |
> >                   AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_R_X) |
> >                   AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS) |
> >
>
