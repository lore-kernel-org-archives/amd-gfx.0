Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F436C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBFC661132
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 01:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBFC661132
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E9136E0EF;
	Wed,  8 Sep 2021 01:42:02 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5A76E0EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 01:42:01 +0000 (UTC)
Received: by mail-qk1-x72c.google.com with SMTP id m21so659355qkm.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Sep 2021 18:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hSK5Rj9fhk7k5lEb8FasSRu6W53b7FNX92Uq7RkGjac=;
 b=P7b7qGQOoKz+y/oHyhHwUHHqPl4RpPKXtjWvtOVPkX/0Kt8th4fpR/8sIgWMbxU23y
 dDDwnkrScZn1AB3vHDcAQgVWQEDMHs8s7Wa1mYSwwWrHL3f1g8c9cBcGyUYOcgLteFz0
 AwrkaXIx7IgTs18wXyMSjAEt5SW4S/DWSxTflb1r+4ka0J6FrSZiiaLbs72ocjsWY1sN
 uloEn26GiG8Jimw3lsBszoOOlTxJJkIxd7DnbdR+oIi8llGlpgmkx+DMZsabuewnS/I5
 AoH7Ji0HxUkNqlDGhfcc4oeH+8sTVKyDG8DIsXbspmq4xvReAL17QSNB8OFUFKUA4nKu
 rOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hSK5Rj9fhk7k5lEb8FasSRu6W53b7FNX92Uq7RkGjac=;
 b=sBRnp97z6D4ObL6ZurbsRanVxqHVfg4r/b3aHAUPZdhifpSKF23HOkPaxEzrM5QoQM
 etPssACO/g1t0Uwu4aJMV+y7zANrR5SDPXeml+giEFxnJe1VSqmR4EjlNOxmEL/M0Xsu
 f2q0JDbXWUYShhYsO24aC6k93nGMmlYOsMWYfCZVLvtL3V7HM4fWtbWwFXYSFGYLgeV7
 EiWAM0TWigcbS08JeFGz1xmy26IsxtkvQzK2k2r4X5a+3QkElaa7jZwG5B17VesBvWYS
 EsdSVIB1TEV+vityac+9/4p/rEc0t+3YArWWnQ/mvsvkhJWAXyPbmOWCixHTr8eLZ1+H
 yaqg==
X-Gm-Message-State: AOAM532nggP1bLiC6BKdns7Knv7Lk2JDM+TAbgM7dden2gYLfHvhV7o+
 ofkAjTORw7/hbJGEAHCBaqmA9h51ICXGQLytUiRE5w==
X-Google-Smtp-Source: ABdhPJwmOjyq7e468JSNsyRjmlmBhxyxi28Go2QWUK+aN05lgZCiBnH406TWe69mqbnyreEIBMJYlQUdP2idg0rD9lM=
X-Received: by 2002:a05:620a:29d5:: with SMTP id
 s21mr1230354qkp.243.1631065320275; 
 Tue, 07 Sep 2021 18:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210907141058.90751-1-nicholas.kazlauskas@amd.com>
 <25922a3f-82e4-efb8-78e2-7292f000aa22@amd.com>
In-Reply-To: <25922a3f-82e4-efb8-78e2-7292f000aa22@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Wed, 8 Sep 2021 02:41:49 +0100
Message-ID: <CAHbf0-ExesNSHeE3WZZiqam7it8y28kJsH13SKZVJQxhSKYC9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add NULL checks for vblank workqueue
To: Harry Wentland <harry.wentland@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Roman Li <Roman.Li@amd.com>, 
 Wayne Lin <Wayne.Lin@amd.com>
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

Hi

I've just tested this out against Linus's tree and it seems to fix things

Out of interest does Tonga have GPU reset when things go wrong?

Thanks

Mike

On Tue, 7 Sept 2021 at 15:20, Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2021-09-07 10:10 a.m., Nicholas Kazlauskas wrote:
> > [Why]
> > If we're running a headless config with 0 links then the vblank
> > workqueue will be NULL - causing a NULL pointer exception during
> > any commit.
> >
> > [How]
> > Guard access to the workqueue if it's NULL and don't queue or flush
> > work if it is.
> >
> > Cc: Roman Li <Roman.Li@amd.com>
> > Cc: Wayne Lin <Wayne.Lin@amd.com>
> > Cc: Harry Wentland <Harry.Wentland@amd.com>
> > Reported-by: Mike Lothian <mike@fireburn.co.uk>
> > BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1700
> > Fixes: 91f86d4cce2 ("drm/amd/display: Use vblank control events for PSR enable/disable")
> > Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++++--------
> >  1 file changed, 18 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 8837259215d..46e08736f94 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -6185,21 +6185,23 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
> >               return 0;
> >
> >  #if defined(CONFIG_DRM_AMD_DC_DCN)
> > -     work = kzalloc(sizeof(*work), GFP_ATOMIC);
> > -     if (!work)
> > -             return -ENOMEM;
> > +     if (dm->vblank_control_workqueue) {
> > +             work = kzalloc(sizeof(*work), GFP_ATOMIC);
> > +             if (!work)
> > +                     return -ENOMEM;
> >
> > -     INIT_WORK(&work->work, vblank_control_worker);
> > -     work->dm = dm;
> > -     work->acrtc = acrtc;
> > -     work->enable = enable;
> > +             INIT_WORK(&work->work, vblank_control_worker);
> > +             work->dm = dm;
> > +             work->acrtc = acrtc;
> > +             work->enable = enable;
> >
> > -     if (acrtc_state->stream) {
> > -             dc_stream_retain(acrtc_state->stream);
> > -             work->stream = acrtc_state->stream;
> > -     }
> > +             if (acrtc_state->stream) {
> > +                     dc_stream_retain(acrtc_state->stream);
> > +                     work->stream = acrtc_state->stream;
> > +             }
> >
> > -     queue_work(dm->vblank_control_workqueue, &work->work);
> > +             queue_work(dm->vblank_control_workqueue, &work->work);
> > +     }
> >  #endif
> >
> >       return 0;
> > @@ -8809,7 +8811,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
> >                * If PSR or idle optimizations are enabled then flush out
> >                * any pending work before hardware programming.
> >                */
> > -             flush_workqueue(dm->vblank_control_workqueue);
> > +             if (dm->vblank_control_workqueue)
> > +                     flush_workqueue(dm->vblank_control_workqueue);
> >  #endif
> >
> >               bundle->stream_update.stream = acrtc_state->stream;
> > @@ -9144,7 +9147,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
> >               /* if there mode set or reset, disable eDP PSR */
> >               if (mode_set_reset_required) {
> >  #if defined(CONFIG_DRM_AMD_DC_DCN)
> > -                     flush_workqueue(dm->vblank_control_workqueue);
> > +                     if (dm->vblank_control_workqueue)
> > +                             flush_workqueue(dm->vblank_control_workqueue);
> >  #endif
> >                       amdgpu_dm_psr_disable_all(dm);
> >               }
> >
>
