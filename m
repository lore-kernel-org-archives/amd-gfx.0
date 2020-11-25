Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A1C63777
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 10:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF3A2063A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 10:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EoM5B2Er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF3A2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797146E89B;
	Wed, 25 Nov 2020 10:36:50 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE526E894
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 10:36:48 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id u12so1411191wrt.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 02:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=g9bw44S73WrDoQxfEroK9pR79XThf+o8xyeh08n8iEQ=;
 b=EoM5B2ErHduIcOe4b1ax3ckV744PF44P7Mz2eOJAHOADOi3k6J/41s8g4lbcKG9ZvE
 lUkQUbNJfI43PYoiCuUzRKx3UMl+gMUPV6Dw0AahQyRolp+fi6M0Tan5kDKJvCvwCnIY
 nklZDKbecm9gn/zSmp01p63CZ3saFGZUWUV0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=g9bw44S73WrDoQxfEroK9pR79XThf+o8xyeh08n8iEQ=;
 b=KpF8O5NMWxpnjlt5j0SmTi6BPKwI7sRB9NTroNrJcoDVic5S8iGskjGlA7otHXUDyk
 DNvT2BfPNv/axWYK0njK2x53/UasmrxuPBzo70grQgzM6RNJjU1/Q2T5pWgOa9lnJMyf
 kvksFPq25l34V2fI2pw2tNlebRA2ZFvLUQG6cSzaF86JAgRxFNdr7sZJLSGbXi3uJoE4
 UQhapnZnkmiJ8WFH3YCR3VH1zUxGcVuenXcXUl31HUy9bYrIrBuaUuBp6HZUk4GRlmgV
 +ECeOguLhp12ngke+bKzsE3X6QnQIpy9KrKISgtkZtWQYP/5fZ5vnbxF/xLmJYVzuJHs
 RHvw==
X-Gm-Message-State: AOAM5323nsVzsb0PEGxzmxFOXi5MSlOzOm+3Qrx8YcAvjZWzlqOps9JS
 d2zwTXy23ub4brhZ2RTtcVhO6A==
X-Google-Smtp-Source: ABdhPJxp66R5JNEXeWnlvd15a4xmmHjfGqwrYPsFYmC7SA7le4mOGqbq/1H+O9hCfJHfYK6oI+kw5w==
X-Received: by 2002:adf:fed1:: with SMTP id q17mr3362900wrs.393.1606300607557; 
 Wed, 25 Nov 2020 02:36:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id r21sm4332017wrc.16.2020.11.25.02.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 02:36:46 -0800 (PST)
Date: Wed, 25 Nov 2020 11:36:45 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 4/7] drm/radeon: Pin buffers while they are vmap'ed
Message-ID: <20201125103645.GU401619@phenom.ffwll.local>
References: <94fa26eb-d899-8c83-9325-84532639d438@suse.de>
 <6319ba4d-f45f-77ec-8752-33f3cad443fd@amd.com>
 <d1508c4f-df3e-fa3c-3071-d8a58295e674@suse.de>
 <cbfa3e8d-81a3-5620-d4fc-72188cfb42ee@amd.com>
 <6d2ee787-0bf5-de1d-73af-7c87bad63cda@suse.de>
 <2431a0e1-7159-b3e7-e1ca-3e7f55c38d8a@amd.com>
 <b356ee3d-64bd-30c9-23f6-dea3a1b87bea@suse.de>
 <20201124140937.GK401619@phenom.ffwll.local>
 <278a4498-bdde-402a-1cea-668e9683f7eb@suse.de>
 <2f8a252a-5413-4b75-a367-f6233121e36e@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2f8a252a-5413-4b75-a367-f6233121e36e@amd.com>
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, alexander.deucher@amd.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 25, 2020 at 11:13:13AM +0100, Christian K=F6nig wrote:
> Am 25.11.20 um 09:37 schrieb Thomas Zimmermann:
> > Hi
> > =

> > Am 24.11.20 um 15:09 schrieb Daniel Vetter:
> > > On Tue, Nov 24, 2020 at 02:56:51PM +0100, Thomas Zimmermann wrote:
> > > > Hi
> > > > =

> > > > Am 24.11.20 um 14:36 schrieb Christian K=F6nig:
> > > > > Am 24.11.20 um 13:15 schrieb Thomas Zimmermann:
> > > > > > [SNIP]
> > > > > > > > > > First I wanted to put this into
> > > > > > > > > > drm_gem_ttm_vmap/vunmap(), but then wondered why
> > > > > > > > > > ttm_bo_vmap() doe not acquire the lock internally?
> > > > > > > > > > I'd expect that vmap/vunmap are close together and
> > > > > > > > > > do not overlap for the same BO.
> > > > > > > > > =

> > > > > > > > > We have use cases like the following during command submi=
ssion:
> > > > > > > > > =

> > > > > > > > > 1. lock
> > > > > > > > > 2. map
> > > > > > > > > 3. copy parts of the BO content somewhere else or patch
> > > > > > > > > it with additional information
> > > > > > > > > 4. unmap
> > > > > > > > > 5. submit BO to the hardware
> > > > > > > > > 6. add hardware fence to the BO to make sure it doesn't m=
ove
> > > > > > > > > 7. unlock
> > > > > > > > > =

> > > > > > > > > That use case won't be possible with vmap/vunmap if we
> > > > > > > > > move the lock/unlock into it and I hope to replace the
> > > > > > > > > kmap/kunmap functions with them in the near term.
> > > > > > > > > =

> > > > > > > > > > Otherwise, acquiring the reservation lock would
> > > > > > > > > > require another ref-counting variable or per-driver
> > > > > > > > > > code.
> > > > > > > > > =

> > > > > > > > > Hui, why that? Just put this into
> > > > > > > > > drm_gem_ttm_vmap/vunmap() helper as you initially
> > > > > > > > > planned.
> > > > > > > > =

> > > > > > > > Given your example above, step one would acquire the lock,
> > > > > > > > and step two would also acquire the lock as part of the vmap
> > > > > > > > implementation. Wouldn't this fail (At least during unmap or
> > > > > > > > unlock steps) ?
> > > > > > > =

> > > > > > > Oh, so you want to nest them? No, that is a rather bad no-go.
> > > > > > =

> > > > > > I don't want to nest/overlap them. My question was whether that
> > > > > > would be required. Apparently not.
> > > > > > =

> > > > > > While the console's BO is being set for scanout, it's protected=
 from
> > > > > > movement via the pin/unpin implementation, right?
> > > > > =

> > > > > Yes, correct.
> > > > > =

> > > > > > The driver does not acquire the resv lock for longer periods. I=
'm
> > > > > > asking because this would prevent any console-buffer updates wh=
ile
> > > > > > the console is being displayed.
> > > > > =

> > > > > Correct as well, we only hold the lock for things like command
> > > > > submission, pinning, unpinning etc etc....
> > > > > =

> > > > =

> > > > Thanks for answering my questions.
> > > > =

> > > > > > =

> > > > > > > =

> > > > > > > You need to make sure that the lock is only taken from the FB
> > > > > > > path which wants to vmap the object.
> > > > > > > =

> > > > > > > Why don't you lock the GEM object from the caller in the gene=
ric
> > > > > > > FB implementation?
> > > > > > =

> > > > > > With the current blitter code, it breaks abstraction. if vmap/v=
unmap
> > > > > > hold the lock implicitly, things would be easier.
> > > > > =

> > > > > Do you have a link to the code?
> > > > =

> > > > It's the damage blitter in the fbdev code. [1] While it flushes
> > > > the shadow
> > > > buffer into the BO, the BO has to be kept in place. I already
> > > > changed it to
> > > > lock struct drm_fb_helper.lock, but I don't think this is
> > > > enough. TTM could
> > > > still evict the BO concurrently.
> > > =

> > > So I'm not sure this is actually a problem: ttm could try to
> > > concurrently
> > > evict the buffer we pinned into vram, and then just skip to the next
> > > one.
> > > =

> > > Plus atm generic fbdev isn't used on any chip where we really care ab=
out
> > > that last few mb of vram being useable for command submission (well a=
tm
> > > there's no driver using it).
> > =

> > Well, this is the patchset for radeon. If it works out, amdgpu and
> > nouveau are natural next choices. Especially radeon and nouveau support
> > cards with low- to medium-sized VRAM. The MiBs wasted on fbdev certainly
> > matter.
> > =

> > > =

> > > Having the buffer pinned into system memory and trying to do a
> > > concurrent
> > > modeset that tries to pull it in is the hard failure mode. And holding
> > > fb_helper.lock fully prevents that.
> > > =

> > > So not really clear on what failure mode you're seeing here?
> > =

> > Imagine the fbdev BO is in VRAM, but not pinned. (Maybe Xorg or Wayland
> > is running.) The fbdev BO is a few MiBs and not in use, so TTM would
> > want to evict it if memory gets tight.
> > =

> > What I have in mind is a concurrent modeset that requires the memory. If
> > we do a concurrent damage blit without protecting against eviction,
> > things go boom. Same for concurrent 3d graphics with textures, model
> > data, etc.
> =

> Completely agree.
> =

> This needs proper lock protection of the memory mapped buffer. Relying on
> that some other code isn't run because we have some third part locks taken
> is not sufficient here.

We are still protected by the pin count in this scenario. Plus, with
current drivers we always pin the fbdev buffer into vram, so occasionally
failing to move it out isn't a regression.

So I'm still not seeing how this can go boom.

Now long term it'd be nice to cut everything over to dma_resv locking, but
the issue there is that beyond ttm, none of the helpers (and few of the
drivers) use dma_resv. So this is a fairly big uphill battle. Quick
interim fix seems like the right solution to me.
-Daniel

> =

> Regards,
> Christian.
> =

> > =

> > Best regards
> > Thomas
> > =

> > > =

> > > > There's no recursion taking place, so I guess the reservation
> > > > lock could be
> > > > acquired/release in drm_client_buffer_vmap/vunmap(), or a
> > > > separate pair of
> > > > DRM client functions could do the locking.
> > > =

> > > Given how this "do the right locking" is a can of worms (and I think
> > > it's
> > > worse than what you dug out already) I think the fb_helper.lock hack =
is
> > > perfectly good enough.
> > > =

> > > I'm also somewhat worried that starting to use dma_resv lock in gener=
ic
> > > code, while many helpers/drivers still have their hand-rolled locking,
> > > will make conversion over to dma_resv needlessly more complicated.
> > > -Daniel
> > > =

> > > > =

> > > > Best regards
> > > > Thomas
> > > > =

> > > > [1] https://cgit.freedesktop.org/drm/drm-tip/tree/drivers/gpu/drm/d=
rm_fb_helper.c?id=3Dac60f3f3090115d21f028bffa2dcfb67f695c4f2#n394
> > > > =

> > > > > =

> > > > > Please note that the reservation lock you need to take here is pa=
rt of
> > > > > the GEM object.
> > > > > =

> > > > > Usually we design things in the way that the code needs to take a=
 lock
> > > > > which protects an object, then do some operations with the object=
 and
> > > > > then release the lock again.
> > > > > =

> > > > > Having in the lock inside the operation can be done as well, but
> > > > > returning with it is kind of unusual design.
> > > > > =

> > > > > > Sorry for the noob questions. I'm still trying to understand the
> > > > > > implications of acquiring these locks.
> > > > > =

> > > > > Well this is the reservation lock of the GEM object we are
> > > > > talking about
> > > > > here. We need to take that for a couple of different operations,
> > > > > vmap/vunmap doesn't sound like a special case to me.
> > > > > =

> > > > > Regards,
> > > > > Christian.
> > > > > =

> > > > > > =

> > > > > > Best regards
> > > > > > Thomas
> > > > > =

> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > > =

> > > > -- =

> > > > Thomas Zimmermann
> > > > Graphics Driver Developer
> > > > SUSE Software Solutions Germany GmbH
> > > > Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> > > > (HRB 36809, AG N=FCrnberg)
> > > > Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
> > > =

> > > =

> > > =

> > > =

> > > =

> > > =

> > =

> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
