Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BD5C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 18:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EC7216C4
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 18:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EC7216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1575D6E03B;
	Mon,  4 Jan 2021 18:17:00 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1D56E02C
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 18:16:58 +0000 (UTC)
Received: by mail-io1-xd2e.google.com with SMTP id u26so23133346iof.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Jan 2021 10:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HRQlpPfYW2zzNDJvf0raq4/rBhWHnHE57OXwcFtdk50=;
 b=WnnCUkcbuUp4weXv1Lo6jDyBFBjxmCNij1gVTH9tANwqNYNhyI4fj2eiesJL9O5rge
 wzONlmCsP79Z6gdvJjTF2lPW/Yqm9OVyXgf1EqqaJDKwrhmIxL37ma+udHewLkJ+VndU
 6flzf2se2eOjrAy/o5/HIi8lutM5L3mbGiA/iRTqA6fYMsgUWTBGldDTCgY+N/PglHXE
 5QnfAF80cLNHf9GdR3Xoue/6hWs1ijJ5a+QXONmJgz7GFk3mjIhto01+BbEh4bsfD0BV
 xnjrBlzZ4+ink/CpgJjBXeOL5zRMEUkEnRvuzYRz+nQ+Zz687/Q9mdopIadtqGYDxkvO
 dxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HRQlpPfYW2zzNDJvf0raq4/rBhWHnHE57OXwcFtdk50=;
 b=H21jDs62BUbVx8/cWzFkk2oCZ+tfc4EVFrfG+uWK7oDp92HXG571jK/D+4+DbynjnW
 8pWERT+6k9JlBAY6vFwk+Y0SnCgjh4Zxx0Ks0tJzAuICG6fCDLcqp6gzi9b/16MwYft/
 DYDk0H7+ToWCTw7QPOFy+c774ME6i8nVVFjeBwjN2ZSH9qm4/31xbwdLR4IUM/Df6qAo
 VViINPiywTLlchBmQIJXh45oPKS2li35qmOo1WyiLd/MxXLMUfFLSJc3y38zgoodaFSL
 1tVA75rzGXZxBF1FgyrlSDP5PWZtzFXg4T/85IaPqAzKb8QXclKUztziuBvTFpp6gdKX
 2Nyg==
X-Gm-Message-State: AOAM5323T0+/RNfckyLGQ44d+zoHPPUYRJpHjZamtb2OqfCM8ReZHIwF
 bYV4fbRj3XqcifGU1dPfMTrIKLHVzHqWPsd7ck7jfQ==
X-Google-Smtp-Source: ABdhPJwlsbjJksZyW8hQYN8A5hTYFnyvTXAtyi17XbyIa9Vw5mY2y1aAL5G/N/0pO04YTgIIx8RJB3OiwRDL5ERCNo4=
X-Received: by 2002:a6b:5403:: with SMTP id i3mr60132716iob.136.1609784217833; 
 Mon, 04 Jan 2021 10:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20210102140235.514039-1-bas@basnieuwenhuizen.nl>
 <CAEsyxyheUd-jyd7X=7HJcOWqcrHgwsTAFyVhW9rJhutEdb=6MQ@mail.gmail.com>
In-Reply-To: <CAEsyxyheUd-jyd7X=7HJcOWqcrHgwsTAFyVhW9rJhutEdb=6MQ@mail.gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 4 Jan 2021 19:17:06 +0100
Message-ID: <CAP+8YyHJpE39aea8OhGuQNjaGjLq4vcK-hNL+pC_wL5qsHwv2A@mail.gmail.com>
Subject: Re: [PATCH] drm: Check actual format for legacy pageflip.
To: Mario Kleiner <mario.kleiner.de@gmail.com>
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Zhan Liu <zhan.liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Ville

On Sat, Jan 2, 2021 at 4:31 PM Mario Kleiner <mario.kleiner.de@gmail.com> wrote:
>
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
>
> -mario
>
> >                 DRM_DEBUG_KMS("Page flip is not allowed to change frame buffer format.\n");
> >                 ret = -EINVAL;
> >                 goto out;
> > --
> > 2.29.2
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
