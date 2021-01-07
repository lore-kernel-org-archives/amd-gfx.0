Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1728C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 18:04:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF9A23370
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 18:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF9A23370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43806E48C;
	Thu,  7 Jan 2021 18:04:45 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F1F6E4BA
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 18:04:45 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id n42so7085450ota.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jan 2021 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eLyXgWRSoofUa0NPDgI7e+KGuRahccA9SYiCL0diGDk=;
 b=Acadoadnt0+KY/VfHGcq4rNimtnM+p4qL3Tt4iYSXXxt19uNfZ+GMGxVDpoCSSMBoe
 OH0HosmiEeFt1ppD+v9R8e3UUja1ZoO+VUMw9Ig3PyBQsXK64SlAaCSNI6AkUcZFgQN7
 Wp5zq7h2x6icnXruoVDteB71AoElVa99MX31M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eLyXgWRSoofUa0NPDgI7e+KGuRahccA9SYiCL0diGDk=;
 b=W7xDgyU7LD04fbDg05rXwMEihd3YKAlBUD9ndA5l9rd8uI+xR9mnfA/D9xfhi7u2xJ
 8w1TALP8tC5dhEEslXxJ5ooWmdW/0lhpcA8Ps9siB2Y5gZaXYF3nw6HFAbtbGxt+KbLy
 tKdHysJ9mZCMSejztrQFmcXAUCpSKe02oa/bkpx0lWygaTzoQeaa60b+EZyIs/Sp3O4z
 h2bH2jEM7f4DahZSpGgb7oe9wFOfOSiMOdmJ+IOvLue421ifl5FhYrHElxEBHm6KfaOa
 gqh6ejRtpSQhYPpIc0gyC0XbxCuaT1szWENU/EeyN7gCAr0yebjVIVJr9D0BjUMD38sW
 lGPQ==
X-Gm-Message-State: AOAM531WqGnen5SlUTY25GUw+wxsqucsQr+VRGdaMG+fN0o2uQToHK1A
 +SPEYE8nvt0Ew3E2/vJ6jY7xiL6duYt636WuAMFd7A==
X-Google-Smtp-Source: ABdhPJwUTSITES/u+cYmw2eICdz5U6SGiNVjYorsZbLttMZamIOwEw/GAk0xiAtq3nCaMQffGe80pPReyb/x4XmBDfI=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr7548910otb.281.1610042684372; 
 Thu, 07 Jan 2021 10:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20210102140235.514039-1-bas@basnieuwenhuizen.nl>
 <CAEsyxyheUd-jyd7X=7HJcOWqcrHgwsTAFyVhW9rJhutEdb=6MQ@mail.gmail.com>
 <X/dLdN1z6/Viqy9v@phenom.ffwll.local>
 <CAEsyxyjaYkBzp_nPifhUpUJ=7vJO7MbeimeZM5H13Cta7bj9Ew@mail.gmail.com>
In-Reply-To: <CAEsyxyjaYkBzp_nPifhUpUJ=7vJO7MbeimeZM5H13Cta7bj9Ew@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 7 Jan 2021 19:04:33 +0100
Message-ID: <CAKMK7uFBrkQhV=-Hqr3EfqAPn2Vu+hM9PVKh290fw2jQJ5TPCA@mail.gmail.com>
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
Cc: zhan.liu@amd.com, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 7, 2021 at 7:00 PM Mario Kleiner <mario.kleiner.de@gmail.com> wrote:
>
> On Thu, Jan 7, 2021 at 6:57 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>>
>> On Sat, Jan 02, 2021 at 04:31:36PM +0100, Mario Kleiner wrote:
>> > On Sat, Jan 2, 2021 at 3:02 PM Bas Nieuwenhuizen
>> > <bas@basnieuwenhuizen.nl> wrote:
>> > >
>> > > With modifiers one can actually have different format_info structs
>> > > for the same format, which now matters for AMDGPU since we convert
>> > > implicit modifiers to explicit modifiers with multiple planes.
>> > >
>> > > I checked other drivers and it doesn't look like they end up triggering
>> > > this case so I think this is safe to relax.
>> > >
>> > > Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> > > Fixes: 816853f9dc40 ("drm/amd/display: Set new format info for converted metadata.")
>> > > ---
>> > >  drivers/gpu/drm/drm_plane.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
>> > > index e6231947f987..f5085990cfac 100644
>> > > --- a/drivers/gpu/drm/drm_plane.c
>> > > +++ b/drivers/gpu/drm/drm_plane.c
>> > > @@ -1163,7 +1163,7 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
>> > >         if (ret)
>> > >                 goto out;
>> > >
>> > > -       if (old_fb->format != fb->format) {
>> > > +       if (old_fb->format->format != fb->format->format) {
>> >
>> > This was btw. the original way before Ville made it more strict about
>> > 4 years ago, to catch issues related to tiling, and more complex
>> > layouts, like the dcc tiling/retiling introduced by your modifier
>> > patches. That's why I hope my alternative patch is a good solution for
>> > atomic drivers while keeping the strictness for potential legacy
>> > drivers.
>>
>> Yeah this doesn't work in full generality, because hw might need to do a
>> full modeset to do a full modeset to reallocate resources (like scanout
>> fifo space) if the format changes.
>>
>> But for atomic drivers that should be caught in ->atomic_check, which
>> should result in -EINVAL, so should do the right thing. So it should be
>> all good, but imo needs a comment to explain what's going on:
>>
>>         /*
>>          * Only check the FOURCC format code, excluding modifiers. This is
>>          * enough for all legacy drivers. Atomic drivers have their own
>>          * checks in their ->atomic_check implementation, which will
>>          * return -EINVAL if any hw or driver constraint is violated due
>>          * to modifier changes.
>>          */
>>
>> Also can you pls cc: intel-gfx to get this vetted by the intel-gfx ci?
>>
>> With that:
>>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>
> Ah, my "atomic expert", posting simultaneously with myself :). Happy new year. Opinions on my variant, just replied a minute ago?

Full disclosure, Ville wanted to do something similar since forever
I'm not a huge fan of removing limitations of legacy ioctls. Worst
case we break something, best case no gain in features since why don't
you just use atomic. Since this (amdgpu modifiers) broke something we
have to fix it, hence I'd go with the more minimal version from Bas
here.

But in general your patch should be correct too.
-Daniel

>
> thanks,
> -mario
>
>> >
>> > -mario
>> >
>> > >                 DRM_DEBUG_KMS("Page flip is not allowed to change frame buffer format.\n");
>> > >                 ret = -EINVAL;
>> > >                 goto out;
>> > > --
>> > > 2.29.2
>> > >
>>
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
