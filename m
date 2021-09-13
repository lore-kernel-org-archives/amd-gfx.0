Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E22C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 18:57:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868B560F24
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 18:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 868B560F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30EB76E218;
	Mon, 13 Sep 2021 18:57:15 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB1E46E218
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 18:57:13 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 c42-20020a05683034aa00b0051f4b99c40cso14781530otu.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 11:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0y+57WOMtY4jfwAcWz0HZXuUVg600fWDJP04M8QOiAY=;
 b=gpnN8hlKsrtyfre1V2BWf+rKLYGON/fSaGkgs9yqxDaVuTHnqOQTZSEqR5Gij0BLlO
 oH4u/Bd4ghBsHCjceR/lhF9G1HCY9TvX+GDjlSdhiwv2m68F0sb6306+qIT0W9cr1v5c
 aTpbV5Ip8rL2kt9BCzbfXw+7Oq70aT2cn1PEdpG46qhUY72/evFhnSP8qZWoxWn9aHac
 DvSXgyP+3PyyvPkDm65ZkMc0bRMimPIKAtPd4TNuKENqIhmN1z3CI2XxfS8htL/UWaMR
 fKw28ue1MSLHwN34NLp9x7IBfJt1AoipxsyAIV0Ple40xAdgMh4YyNnIq+vDfK93exTO
 y/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0y+57WOMtY4jfwAcWz0HZXuUVg600fWDJP04M8QOiAY=;
 b=AXVRjwgJkQ5Z/1x9Af96yS9rAYt+1law67azbZ2pUVZkmtVHZ2Mnej514lGuE3da6M
 W/mcd7vzypQzG5eFdy6mUmDqxxuUhMFozRJ7pco2Vqy2RvQJiEBz8EY9IW81fKyyug1/
 wl8K6fotHBRDQDy2lLrakI/77Q0Vs6OxukX/RLI07TeI+vH96QN6Su8McDy7N+q81TS2
 jRO0XUQJFzh8Uo5lMGXnaqftrDqC+2ClWsnVHDrnq7WpoJ1u62UUcngdCX2BfGB7FUzJ
 ZB1uHfELUibKADNuNH05yCq6VgjZjY+jGv3eg4FeLaKCKFRWqmhuDFYEblKAO1Tl3A4P
 z77g==
X-Gm-Message-State: AOAM530u0AEocGXHI77ti0DFG5SG+S3i88f6ODnDtXIgKmkRH9X5LaXA
 2DxL7Qf31Ev02KYUiZ9nWCSM5tb+Tj71cWIB7Mw=
X-Google-Smtp-Source: ABdhPJwEIQJ8Wn6JYlOxOPVCTIkDDJ1Saewd6r24WHq6+tphcrRH+FhMq88XwlLTKiA32+1KghFI1c/j6FOhBZ2wx54=
X-Received: by 2002:a05:6830:214c:: with SMTP id
 r12mr11191840otd.200.1631559433057; 
 Mon, 13 Sep 2021 11:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210907141058.90751-1-nicholas.kazlauskas@amd.com>
 <25922a3f-82e4-efb8-78e2-7292f000aa22@amd.com>
 <CAHbf0-ExesNSHeE3WZZiqam7it8y28kJsH13SKZVJQxhSKYC9Q@mail.gmail.com>
In-Reply-To: <CAHbf0-ExesNSHeE3WZZiqam7it8y28kJsH13SKZVJQxhSKYC9Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Sep 2021 14:57:02 -0400
Message-ID: <CADnq5_NgA6rgUtiKBGQ0XuJDjzxi4bKR2AKCLNNzg-__dEhvsA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add NULL checks for vblank workqueue
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Harry Wentland <harry.wentland@amd.com>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Roman Li <Roman.Li@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
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

On Tue, Sep 7, 2021 at 9:42 PM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> I've just tested this out against Linus's tree and it seems to fix things
>
> Out of interest does Tonga have GPU reset when things go wrong?

Yes, it does.

Alex

>
> Thanks
>
> Mike
>
> On Tue, 7 Sept 2021 at 15:20, Harry Wentland <harry.wentland@amd.com> wrote:
> >
> >
> >
> > On 2021-09-07 10:10 a.m., Nicholas Kazlauskas wrote:
> > > [Why]
> > > If we're running a headless config with 0 links then the vblank
> > > workqueue will be NULL - causing a NULL pointer exception during
> > > any commit.
> > >
> > > [How]
> > > Guard access to the workqueue if it's NULL and don't queue or flush
> > > work if it is.
> > >
> > > Cc: Roman Li <Roman.Li@amd.com>
> > > Cc: Wayne Lin <Wayne.Lin@amd.com>
> > > Cc: Harry Wentland <Harry.Wentland@amd.com>
> > > Reported-by: Mike Lothian <mike@fireburn.co.uk>
> > > BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1700
> > > Fixes: 91f86d4cce2 ("drm/amd/display: Use vblank control events for PSR enable/disable")
> > > Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> >
> > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >
> > Harry
> >
> > > ---
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++++--------
> > >  1 file changed, 18 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index 8837259215d..46e08736f94 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -6185,21 +6185,23 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
> > >               return 0;
> > >
> > >  #if defined(CONFIG_DRM_AMD_DC_DCN)
> > > -     work = kzalloc(sizeof(*work), GFP_ATOMIC);
> > > -     if (!work)
> > > -             return -ENOMEM;
> > > +     if (dm->vblank_control_workqueue) {
> > > +             work = kzalloc(sizeof(*work), GFP_ATOMIC);
> > > +             if (!work)
> > > +                     return -ENOMEM;
> > >
> > > -     INIT_WORK(&work->work, vblank_control_worker);
> > > -     work->dm = dm;
> > > -     work->acrtc = acrtc;
> > > -     work->enable = enable;
> > > +             INIT_WORK(&work->work, vblank_control_worker);
> > > +             work->dm = dm;
> > > +             work->acrtc = acrtc;
> > > +             work->enable = enable;
> > >
> > > -     if (acrtc_state->stream) {
> > > -             dc_stream_retain(acrtc_state->stream);
> > > -             work->stream = acrtc_state->stream;
> > > -     }
> > > +             if (acrtc_state->stream) {
> > > +                     dc_stream_retain(acrtc_state->stream);
> > > +                     work->stream = acrtc_state->stream;
> > > +             }
> > >
> > > -     queue_work(dm->vblank_control_workqueue, &work->work);
> > > +             queue_work(dm->vblank_control_workqueue, &work->work);
> > > +     }
> > >  #endif
> > >
> > >       return 0;
> > > @@ -8809,7 +8811,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
> > >                * If PSR or idle optimizations are enabled then flush out
> > >                * any pending work before hardware programming.
> > >                */
> > > -             flush_workqueue(dm->vblank_control_workqueue);
> > > +             if (dm->vblank_control_workqueue)
> > > +                     flush_workqueue(dm->vblank_control_workqueue);
> > >  #endif
> > >
> > >               bundle->stream_update.stream = acrtc_state->stream;
> > > @@ -9144,7 +9147,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
> > >               /* if there mode set or reset, disable eDP PSR */
> > >               if (mode_set_reset_required) {
> > >  #if defined(CONFIG_DRM_AMD_DC_DCN)
> > > -                     flush_workqueue(dm->vblank_control_workqueue);
> > > +                     if (dm->vblank_control_workqueue)
> > > +                             flush_workqueue(dm->vblank_control_workqueue);
> > >  #endif
> > >                       amdgpu_dm_psr_disable_all(dm);
> > >               }
> > >
> >
