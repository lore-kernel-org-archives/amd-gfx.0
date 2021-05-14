Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A667C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 17:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DDD6144A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 17:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DDD6144A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 898EA6F3A6;
	Fri, 14 May 2021 17:18:03 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D75E6F39F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 16:37:29 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id j10so43873160lfb.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZAqWEj5OYEfJU5LjNXfyKI1/LKy7qS30rxLcl7Jaqiw=;
 b=RVoy1qL0AQ1q24JftQoIDkX2WOnIxVWMSOGhF9tgIxhUIR/2E+5M39qXORHoL8gDBq
 Ffs8Ge3BkdLMkhNeSSHB+MYXLQZdZmIO0WvDCcNFw0N9mcrpsCBXsupyVmqHSCw6WCPU
 Q3Y3P7+epAjQL2QofY0gLBS20rM30NG4VK7TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZAqWEj5OYEfJU5LjNXfyKI1/LKy7qS30rxLcl7Jaqiw=;
 b=KXZCyLbkD2VHGNzCYE7d1GtfUEMMOTCnehr54P4HKDlJ7Cpbf7e23hpEOa4JjjOdQE
 g3YgEVSMR6a75z9ArRf+WFgtotWUVlrZFleOFuoJl2Gix7zs1yZIgIcAUcsIgmZ+xqoI
 7EHTXtMdANHXOEI016dnrsk+Wfiu74SXyJpTBswPjp6KTBXE+re6yGxfU75PFbSlHJRi
 2lfz5sdWKtzKZ0ILiX5dKkLGS17E46trxHKlCjguSemaIQjMrSpwZvId68qxS5960spk
 /e+DDQ7KN5tjCYuw+O6hDJXrVLBqyjm6gV1J5giyGaWRTQMcW+V6JlY1qPsyJtwYGKzR
 Fzkg==
X-Gm-Message-State: AOAM533KXcVtmIfPBA7YPREXTu61jSakbGBfdmQ6Exv6vmKkBiIk70BG
 2YWADVH41mA3BfgA7ATGMfCctxbFkALVz1D2x6+LUA==
X-Google-Smtp-Source: ABdhPJy+bhbYEKAl3gCmY96UXvRAROUhw5fk0rGIL8X6T8xxoHb26DOEK0y2v4FdkiCJfLb9NEhH3OBbRIREwk2rgvk=
X-Received: by 2002:a05:6512:3b27:: with SMTP id
 f39mr11179411lfv.425.1621010248017; 
 Fri, 14 May 2021 09:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
 <857025a9-2ac0-ed37-bc9e-a2be9e1780a9@amd.com>
 <CAC0gqY77ztqBfi3g_JYPVEqmahXVJ+bGePMK40WaPmgm4m6gVw@mail.gmail.com>
In-Reply-To: <CAC0gqY77ztqBfi3g_JYPVEqmahXVJ+bGePMK40WaPmgm4m6gVw@mail.gmail.com>
From: Mark Yacoub <markyacoub@chromium.org>
Date: Fri, 14 May 2021 12:37:17 -0400
Message-ID: <CAJUqKUrM6jrUrZkcfF=R7vNeoj4KvwymwM4tMVy09ndsPci-9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
To: Mark Yacoub <markyacoub@google.com>
X-Mailman-Approved-At: Fri, 14 May 2021 17:18:02 +0000
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 "Tianci . Yin" <tianci.yin@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Nicholas Choi <nicholas.choi@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 14, 2021 at 12:31 PM Mark Yacoub <markyacoub@google.com> wrote:
>
> On Fri, May 14, 2021 at 11:28 AM Harry Wentland <harry.wentland@amd.com> wrote:
> >
> > On 2021-05-14 7:47 a.m., Rodrigo Siqueira wrote:
> > > A few weeks ago, we saw a two cursor issue in a ChromeOS system. We
> > > fixed it in the commit:
> > >
> > >  drm/amd/display: Fix two cursor duplication when using overlay
> > >  (read the commit message for more details)
> > >
> > > After this change, we noticed that some IGT subtests related to
> > > kms_plane and kms_plane_scaling started to fail. After investigating
> > > this issue, we noticed that all subtests that fail have a primary plane
> > > covering the overlay plane, which is currently rejected by amdgpu dm.
> > > Fail those IGT tests highlight that our verification was too broad and
> > > compromises the overlay usage in our drive. This patch fixes this issue
nit: s/drive/driver?
> > > by ensuring that we only reject commits where the primary plane is not
> > > fully covered by the overlay when the cursor hardware is enabled. With
> > > this fix, all IGT tests start to pass again, which means our overlay
> > > support works as expected.
> > >
> > > Cc: Tianci.Yin <tianci.yin@amd.com>
> > > Cc: Harry Wentland <harry.wentland@amd.com>
> > > Cc: Nicholas Choi <nicholas.choi@amd.com>
> > > Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> > > Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> > > Cc: Mark Yacoub <markyacoub@google.com>
> > > Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> > >
> > > Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index ccd67003b120..9c2537a17a7b 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -10067,7 +10067,7 @@ static int validate_overlay(struct drm_atomic_state *state)
> > >       int i;
> > >       struct drm_plane *plane;
> > >       struct drm_plane_state *old_plane_state, *new_plane_state;
> > > -     struct drm_plane_state *primary_state, *overlay_state = NULL;
> > > +     struct drm_plane_state *primary_state, *cursor_state, *overlay_state = NULL;
> > >
> > >       /* Check if primary plane is contained inside overlay */
> > >       for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
> > > @@ -10097,6 +10097,14 @@ static int validate_overlay(struct drm_atomic_state *state)
> > >       if (!primary_state->crtc)
> > >               return 0;
> > >
> > > +     /* check if cursor plane is enabled */
> > > +     cursor_state = drm_atomic_get_plane_state(state, overlay_state->crtc->cursor);
> > > +     if (IS_ERR(cursor_state))
> > > +             return PTR_ERR(cursor_state);
> > > +
> > > +     if (drm_atomic_plane_disabling(plane->state, cursor_state))
> > > +             return 0;
> > > +
> >
> > I thought this breaks Chrome's compositor since it can't handle an atomic commit rejection
> > based solely on whether a cursor is enabled or not.
For context: To use overlays (the old/current async way), Chrome tests
if an overlay strategy will work by doing an atomic commit with a TEST
flag to check if the combination would work. If it works, it flags
this planes configuration as valid. As it's valid, it performs an
atomic page flip (which could also include the cursor).
So to Harry's point, you would pass an atomic test but fail on an
atomic page flip with the exact same configuration that's been flagged
as valid. Failing a pageflip causes Chrome to crash (Reset the GPU
process cause something went horribly wrong when it shouldn't).
> >
> > Harry
> >
> > >       /* Perform the bounds check to ensure the overlay plane covers the primary */
> > >       if (primary_state->crtc_x < overlay_state->crtc_x ||
> > >           primary_state->crtc_y < overlay_state->crtc_y ||
> > >
> >
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
