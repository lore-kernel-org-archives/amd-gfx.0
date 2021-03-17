Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CD1C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 15:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB5F64EFC
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 15:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB5F64EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F8E89AAE;
	Wed, 17 Mar 2021 15:14:26 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 016E689AAE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 15:14:24 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id d16so32814264oic.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BodratDucff9ye3tU544b1WqnufWynTLN5XzgLW0phc=;
 b=C+Pk73brWe37fg7zxn1uL0THKajFF8LOrgWmIButK9aNBB10DeycOms1qzaIK574Si
 m69/lwxMKPBA0YY8LGXCyd85TsN/keMLjk1UvsHUYhZBBg3MObEBixUjuuRgqBl7TfaW
 wu4XwGILBclGCU8J6tR5sQk443QDdv+OxRwP29bZT1ETyuZkjVti1A1bdnrtoBuEzZ3l
 VREYRc5FqWq5stkxYRb6GkRqc6f/IXC4kTtybu89WJt1md/+StFVPFqZ4HdLMmaJ6g1v
 ArALppzlVBSSkz9fc9wL99IQGJSdEFEewAHDF+JcAQ+mr3wgfoft0pOHD88cia4vZmVP
 DRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BodratDucff9ye3tU544b1WqnufWynTLN5XzgLW0phc=;
 b=btqP7hcutBZUkYyLhp0F2+nztpM/8Ij4z004rVz4GpFprLUeuqEbcv5xZBf0ZR6Rxv
 /Vg0iI6BrJhWQGfqYyoOSE/9fwSxTTawUKBhfSIiPOWV9ZMra4Ws2DCta468Cv9zc/XH
 br2eHp1LIBaNjROhVtGn6zV9nHu8As5ABJb6a52CT1ajhUFPco4aCMlJsXBwvf50GFxX
 9+tYkncYixQXgLr0gaG8L3GOHjZvkGMGrsfk8AcYh1QPrWSO9M06ONN+Y7RIF16JOTPi
 l97SIh0nuShePaPXW6z0RwqXR+dDzKh7+0Tg8ToGUI4VpSg6YsVteIZ37fKEDpbC7jQk
 sAzA==
X-Gm-Message-State: AOAM530pS7wQqUt/ewQOx25aNIp2ZCQ8WIu/93aGx2dhbD3NlDBPMvkt
 sYDwR4e6qQm+RXozMLesyb8YNda9nwoMEZCDrn361N2K
X-Google-Smtp-Source: ABdhPJzjZzav+odz8+Vui+H8XARjAB2+061aO1C5XW7aH2uWRbmV47IhlfoZ1/d2fzTzyJbu9P7dyJTWgcQGCpo/oyA=
X-Received: by 2002:aca:4284:: with SMTP id p126mr3138735oia.123.1615994064345; 
 Wed, 17 Mar 2021 08:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210316215006.18769-1-contact@scrumplex.net>
 <7706e621-78ce-1330-b2f4-e6beacd022cb@amd.com>
In-Reply-To: <7706e621-78ce-1330-b2f4-e6beacd022cb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Mar 2021 11:14:13 -0400
Message-ID: <CADnq5_NTJuOWU=v_TWLm8r+USFsWfSBCvdaBjcb=As9tKpibPg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: check fb of primary plane
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Sefa Eyeoglu <contact@scrumplex.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 17, 2021 at 10:05 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2021-03-16 5:50 p.m., Sefa Eyeoglu wrote:
> > Sometimes the primary plane might not be initialized (yet), which
> > causes dm_check_crtc_cursor to divide by zero.
> > Apparently a weird state before a S3-suspend causes the aforementioned
> > divide-by-zero error when resuming from S3.  This was explained in
> > bug 212293 on Bugzilla.
> >
> > To avoid this divide-by-zero error we check if the primary plane's fb
> > isn't NULL.  If it's NULL the src_w and src_h attributes will be 0,
> > which would cause a divide-by-zero.
> >
> > This fixes Bugzilla report 212293
> > https://bugzilla.kernel.org/show_bug.cgi?id=212293>>
> > Fixes: 12f4849a1cfd69f3 ("drm/amd/display: check cursor scaling")
> > Signed-off-by: Sefa Eyeoglu <contact@scrumplex.net>
>
> Thanks for your patch.
>
> It is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Applied.  Thanks!

Alex

>
> Harry
>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 573cf17262da4e11..fbb1ac223ccbb62a 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -9267,7 +9267,8 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
> >
> >       new_cursor_state = drm_atomic_get_new_plane_state(state, crtc->cursor);
> >       new_primary_state = drm_atomic_get_new_plane_state(state, crtc->primary);
> > -     if (!new_cursor_state || !new_primary_state || !new_cursor_state->fb) {
> > +     if (!new_cursor_state || !new_primary_state ||
> > +             !new_cursor_state->fb || !new_primary_state->fb) {
> >               return 0;
> >       }
> >
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
