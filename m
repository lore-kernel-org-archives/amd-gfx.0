Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E1CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 12:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4E2206C3
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 12:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PlGnKZg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4E2206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1485C6E425;
	Mon, 10 Aug 2020 12:30:37 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD8F6E426
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 12:30:35 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id t14so8150586wmi.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YcraacnMVnVuyd5b/t/uB9+lQrAeCH0nRzWFxR29iT4=;
 b=PlGnKZg8i+L+2TslDrUoWT+r1WFAU/8Eyj6TmJkHPi8jPJUUwuFos7wKhHrLujesCE
 oNrOo8yQgCkzigx6la5HMZNStNkI0HWHxgKcL+LKV1b6iyEoal82Ax3SNLobzxh1SrYt
 C5Y1n0lVFEzlrlV9c8eRlVD0nULETMThc/hQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YcraacnMVnVuyd5b/t/uB9+lQrAeCH0nRzWFxR29iT4=;
 b=YcPQcPpC22bSG93mtlFkCVh1d/QcyFZZQ1N/d5uKjM2zUnr6LJfOckupyc8CCbcm1d
 fVLFwURY5MooDp5oATT2Wu8CU9LSJHOUsgbFi3iRDCyzRE4VPGb1rTzc3JKDEhp1w37u
 HHXIDzUAXpb28Gbwl0BmaWXriKdhsvC09jeH2piM7IPO65W+cUhJVMR1FoveY1T+h9Tn
 Fpq8xeG2BPkzCSWNB31/YqWOQCYm1IIopontiUCU67tEByrHROV1piy9mQnnaq9LrilX
 yUditT9E6rikfKwMBPF1a1UXAdEvuFt99U21C1COD5HHuJNDvt1FplwbXFyvhH7oc/0t
 wcaQ==
X-Gm-Message-State: AOAM530YHpcss85KNpfWd+WhL5qPaQUg/wUWPbtV/b6EZmjvDehta4ih
 OlkkEQZIf1JAPi1mJeGvJYy7WA==
X-Google-Smtp-Source: ABdhPJzlh2zMJDYJXB+sntlITTkCJG5pHJTDdM2Z+smRKBsk1elwfTzzVNOM2N2lmuLpMQ2EWO7sCw==
X-Received: by 2002:a1c:7313:: with SMTP id d19mr23696986wmb.147.1597062634172; 
 Mon, 10 Aug 2020 05:30:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id v11sm20808155wrr.10.2020.08.10.05.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 05:30:33 -0700 (PDT)
Date: Mon, 10 Aug 2020 14:30:31 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH 5/7] drm/amd/display: Reset plane for anything that's not
 a FAST update
Message-ID: <20200810123031.GK2352366@phenom.ffwll.local>
References: <20200730203642.17553-1-nicholas.kazlauskas@amd.com>
 <20200730203642.17553-6-nicholas.kazlauskas@amd.com>
 <20200807083424.GM6419@phenom.ffwll.local>
 <6790c248-d46c-d3e0-b87d-c73823556888@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6790c248-d46c-d3e0-b87d-c73823556888@amd.com>
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 dri-devel@lists.freedesktop.org, Hersen Wu <hersenxs.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, daniel@ffwll.ch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 07, 2020 at 10:26:51AM -0400, Kazlauskas, Nicholas wrote:
> On 2020-08-07 4:34 a.m., daniel@ffwll.ch wrote:
> > On Thu, Jul 30, 2020 at 04:36:40PM -0400, Nicholas Kazlauskas wrote:
> > > [Why]
> > > MEDIUM or FULL updates can require global validation or affect
> > > bandwidth. By treating these all simply as surface updates we aren't
> > > actually passing this through DC global validation.
> > > 
> > > [How]
> > > There's currently no way to pass surface updates through DC global
> > > validation, nor do I think it's a good idea to change the interface
> > > to accept these.
> > > 
> > > DC global validation itself is currently stateless, and we can move
> > > our update type checking to be stateless as well by duplicating DC
> > > surface checks in DM based on DRM properties.
> > > 
> > > We wanted to rely on DC automatically determining this since DC knows
> > > best, but DM is ultimately what fills in everything into DC plane
> > > state so it does need to know as well.
> > > 
> > > There are basically only three paths that we exercise in DM today:
> > > 
> > > 1) Cursor (async update)
> > > 2) Pageflip (fast update)
> > > 3) Full pipe programming (medium/full updates)
> > > 
> > > Which means that anything that's more than a pageflip really needs to
> > > go down path #3.
> > > 
> > > So this change duplicates all the surface update checks based on DRM
> > > state instead inside of should_reset_plane().
> > > 
> > > Next step is dropping dm_determine_update_type_for_commit and we no
> > > longer require the old DC state at all for global validation.
> > 
> > I think we do something similar in i915, where we have a "nothing except
> > base address changed" fast path, but for anything else we fully compute a
> > new state. Obviously you should try to keep global state synchronization
> > to a minimum for this step, so it's not entirely only 2 options.
> > 
> > Once we have the states, we compare them and figure out whether we can get
> > away with a fast modeset operation (maybe what you guys call medium
> > update). Anyway I think being slightly more aggressive with computing full
> > state, and then falling back to more optimized update again is a good
> > approach. Only risk is if we you have too much synchronization in your
> > locking (e.g. modern compositors do like to change tiling and stuff,
> > especially once you have modifiers enabled, so this shouldn't cause a sync
> > across crtc except when absolutely needed).
> > -Daniel
> 
> Sounds like the right approach then.
> 
> We can support tiling changes in the fast path, but the more optimized
> version of that last check is really linear <-> tiled. That requires global
> validation with DC to revalidate bandwidth and calculate requestor
> parameters for HW. So we'll have to stall for some of these changes
> unfortunately since we need the full HW state for validation.

Yeah I think that's perfectly ok, and probably worth it to still optimize
for tiled->tiled changes. If you can. tiled<->untiled only happens for
boot-splash, so no one cares, but with modifiers the idea is that tiling
changes (especially once we get into the different compression modes
amdgpu support, and which Bas' series tries to enable) are fairly common
and should be doable without any stalls anywhere.

Cheers, Daniel

> 
> Regards,
> Nicholas Kazlauskas
> 
> > 
> > > 
> > > Optimization can come later so we don't reset DC planes at all for
> > > MEDIUM udpates and avoid validation, but we might require some extra
> > > checks in DM to achieve this.
> > > 
> > > Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> > > Cc: Hersen Wu <hersenxs.wu@amd.com>
> > > Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > > ---
> > >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 25 +++++++++++++++++++
> > >   1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index 0d5f45742bb5..2cbb29199e61 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -8336,6 +8336,31 @@ static bool should_reset_plane(struct drm_atomic_state *state,
> > >   		if (old_other_state->crtc != new_other_state->crtc)
> > >   			return true;
> > > +		/* Src/dst size and scaling updates. */
> > > +		if (old_other_state->src_w != new_other_state->src_w ||
> > > +		    old_other_state->src_h != new_other_state->src_h ||
> > > +		    old_other_state->crtc_w != new_other_state->crtc_w ||
> > > +		    old_other_state->crtc_h != new_other_state->crtc_h)
> > > +			return true;
> > > +
> > > +		/* Rotation / mirroring updates. */
> > > +		if (old_other_state->rotation != new_other_state->rotation)
> > > +			return true;
> > > +
> > > +		/* Blending updates. */
> > > +		if (old_other_state->pixel_blend_mode !=
> > > +		    new_other_state->pixel_blend_mode)
> > > +			return true;
> > > +
> > > +		/* Alpha updates. */
> > > +		if (old_other_state->alpha != new_other_state->alpha)
> > > +			return true;
> > > +
> > > +		/* Colorspace changes. */
> > > +		if (old_other_state->color_range != new_other_state->color_range ||
> > > +		    old_other_state->color_encoding != new_other_state->color_encoding)
> > > +			return true;
> > > +
> > >   		/* Framebuffer checks fall at the end. */
> > >   		if (!old_other_state->fb || !new_other_state->fb)
> > >   			continue;
> > > -- 
> > > 2.25.1
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
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
